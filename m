Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754571AbeEWIxm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:53:42 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:39049 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754540AbeEWIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:53:38 -0400
From: Vlad Buslov <vladbu@mellanox.com>
To: jiri@resnulli.us
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        Vlad Buslov <vladbu@mellanox.com>
Subject: [PATCH net-next v3] net: sched: don't disable bh when accessing action idr
Date: Wed, 23 May 2018 11:52:54 +0300
Message-Id: <1527065574-11299-1-git-send-email-vladbu@mellanox.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <20180523073239.GC3155@nanopsycho>
References: <20180523073239.GC3155@nanopsycho>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial net_device implementation used ingress_lock spinlock to synchronize
ingress path of device. This lock was used in both process and bh context.
In some code paths action map lock was obtained while holding ingress_lock.
Commit e1e992e52faa ("[NET_SCHED] protect action config/dump from irqs")
modified actions to always disable bh, while using action map lock, in
order to prevent deadlock on ingress_lock in softirq. This lock was removed
in commit 555353cfa1ae ("netdev: The ingress_lock member is no longer
needed.").

Another reason to disable bh was filters delete code, that released actions
in rcu callback. This code was changed to release actions from workqueue
context in patch set "net_sched: close the race between call_rcu() and
cleanup_net()".

With these changes it is no longer necessary to continue disable bh while
accessing action map.

Replace all action idr spinlock usage with regular calls that do not
disable bh.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
---
Changes from V2 to V3:
 - Expanded commit message.

Changes from V1 to V2:
 - Expanded commit message.

 net/sched/act_api.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 72251241665a..3f4cf930f809 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -77,9 +77,9 @@ static void free_tcf(struct tc_action *p)
 
 static void tcf_idr_remove(struct tcf_idrinfo *idrinfo, struct tc_action *p)
 {
-	spin_lock_bh(&idrinfo->lock);
+	spin_lock(&idrinfo->lock);
 	idr_remove(&idrinfo->action_idr, p->tcfa_index);
-	spin_unlock_bh(&idrinfo->lock);
+	spin_unlock(&idrinfo->lock);
 	gen_kill_estimator(&p->tcfa_rate_est);
 	free_tcf(p);
 }
@@ -156,7 +156,7 @@ static int tcf_dump_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
 	struct tc_action *p;
 	unsigned long id = 1;
 
-	spin_lock_bh(&idrinfo->lock);
+	spin_lock(&idrinfo->lock);
 
 	s_i = cb->args[0];
 
@@ -191,7 +191,7 @@ static int tcf_dump_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
 	if (index >= 0)
 		cb->args[0] = index + 1;
 
-	spin_unlock_bh(&idrinfo->lock);
+	spin_unlock(&idrinfo->lock);
 	if (n_i) {
 		if (act_flags & TCA_FLAG_LARGE_DUMP_ON)
 			cb->args[1] = n_i;
@@ -261,9 +261,9 @@ static struct tc_action *tcf_idr_lookup(u32 index, struct tcf_idrinfo *idrinfo)
 {
 	struct tc_action *p = NULL;
 
-	spin_lock_bh(&idrinfo->lock);
+	spin_lock(&idrinfo->lock);
 	p = idr_find(&idrinfo->action_idr, index);
-	spin_unlock_bh(&idrinfo->lock);
+	spin_unlock(&idrinfo->lock);
 
 	return p;
 }
@@ -323,7 +323,7 @@ int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
 	}
 	spin_lock_init(&p->tcfa_lock);
 	idr_preload(GFP_KERNEL);
-	spin_lock_bh(&idrinfo->lock);
+	spin_lock(&idrinfo->lock);
 	/* user doesn't specify an index */
 	if (!index) {
 		index = 1;
@@ -331,7 +331,7 @@ int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
 	} else {
 		err = idr_alloc_u32(idr, NULL, &index, index, GFP_ATOMIC);
 	}
-	spin_unlock_bh(&idrinfo->lock);
+	spin_unlock(&idrinfo->lock);
 	idr_preload_end();
 	if (err)
 		goto err3;
@@ -369,9 +369,9 @@ void tcf_idr_insert(struct tc_action_net *tn, struct tc_action *a)
 {
 	struct tcf_idrinfo *idrinfo = tn->idrinfo;
 
-	spin_lock_bh(&idrinfo->lock);
+	spin_lock(&idrinfo->lock);
 	idr_replace(&idrinfo->action_idr, a, a->tcfa_index);
-	spin_unlock_bh(&idrinfo->lock);
+	spin_unlock(&idrinfo->lock);
 }
 EXPORT_SYMBOL(tcf_idr_insert);
 
-- 
2.7.5
