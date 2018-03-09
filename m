Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeCIB3n (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 20:29:43 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51577 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbeCIB3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 20:29:42 -0500
X-Google-Smtp-Source: AG47ELu6G0IwbziABQDEBhohjtADJPjOD4GKDg63E1o4EOre5Se71cvmkd15c1gBVEvl2MqOmY2Ueg==
X-ME-Sender: <xms:guOhWvm0v7DN_K2z7KxpL_n4buTU_FxcJ_PY0K6uzfybWHewcD27Gg>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] rcu: Use the proper lockdep annotation in dump_blkd_tasks()
Date: Fri,  9 Mar 2018 09:32:18 +0800
Message-Id: <20180309013224.23890-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reported this:

| kernel/rcu/tree_plugin.h:814:9: warning: incorrect type in argument 1 (different modifiers)
| kernel/rcu/tree_plugin.h:814:9:    expected struct lockdep_map const *lock
| kernel/rcu/tree_plugin.h:814:9:    got struct lockdep_map [noderef] *<noident>

This is caused by using vanilla lockdep annotations on rcu_node::lock,
and that requires accessing ->lock of rcu_node directly. However we need
to keep rcu_node::lock __private to avoid breaking its extra ordering
guarantee. And we have a dedicated lockdep annotation for
rcu_node::lock, so use it.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9accacffd138..ea33f57abae5 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -811,7 +811,7 @@ static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 	int i;
 	struct list_head *lhp;
 
-	lockdep_assert_held(&rnp->lock);
+	raw_lockdep_assert_held_rcu_node(rnp);
 	pr_info("%s: grp: %d-%d level: %d ->qamask %#lx ->gp_tasks %p ->boost_tasks %p ->exp_tasks %p &->blkd_tasks: %p offset: %u\n", __func__, rnp->grplo, rnp->grphi, rnp->level, rnp->qsmask, rnp->gp_tasks, rnp->boost_tasks, rnp->exp_tasks, &rnp->blkd_tasks, (unsigned int)offsetof(typeof(*rnp), blkd_tasks));
 	pr_cont("\t->blkd_tasks");
 	i = 0;
-- 
2.16.2
