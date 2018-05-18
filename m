Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeERPpp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:45:45 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53649 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751112AbeERPpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:45:43 -0400
From: Vlad Buslov <vladbu@mellanox.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        Vlad Buslov <vladbu@mellanox.com>
Subject: [PATCH] net: sched: don't disable bh when accessing action idr
Date: Fri, 18 May 2018 18:45:24 +0300
Message-Id: <1526658324-6570-1-git-send-email-vladbu@mellanox.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Underlying implementation of action map has changed and doesn't require
disabling bh anymore. Replace all action idr spinlock usage with regular
calls that do not disable bh.

Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
---
 net/sched/act_api.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 72251241..3f4cf93 100644
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
