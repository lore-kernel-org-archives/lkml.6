Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeDCRXj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:23:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60296 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbeDCRXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:23:36 -0400
From: rao.shoaib@oracle.com
To: linux-kernel@vger.kernel.org
Cc: paulmck@linux.vnet.ibm.com, joe@perches.com, willy@infradead.org,
        brouer@redhat.com, linux-mm@kvack.org,
        Rao Shoaib <rao.shoaib@oracle.com>
Subject: [PATCH 0/2] Move kfree_rcu out of rcu code and use kfree_bulk
Date: Tue,  3 Apr 2018 10:22:51 -0700
Message-Id: <1522776173-7190-1-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=987
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030176
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

This patch moves kfree_call_rcu() out of rcu related code to
mm/slab_common and updates kfree_rcu() to use new bulk memory free
functions as they are more efficient.

This is a resubmission of the previous patch.

Changes since last submission
	Surrounded code with 'CONFIG_TREE_RCU || CONFIG_PREEMPT_RCU'
	to separate tinyurl definitions.

Diff of the changes:

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 6338fb6..102a93f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -55,8 +55,6 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func);
 #define        call_rcu        call_rcu_sched
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
-/* only for use by kfree_call_rcu() */
-void call_rcu_lazy(struct rcu_head *head, rcu_callback_t func);
 
 void call_rcu_bh(struct rcu_head *head, rcu_callback_t func);
 void call_rcu_sched(struct rcu_head *head, rcu_callback_t func);
@@ -210,6 +208,8 @@ do { \
 
 #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
 #include <linux/rcutree.h>
+/* only for use by kfree_call_rcu() */
+void call_rcu_lazy(struct rcu_head *head, rcu_callback_t func);
 #elif defined(CONFIG_TINY_RCU)
 #include <linux/rcutiny.h>
 #else
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 6e8afff..f126d08 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1526,6 +1526,7 @@ void kzfree(const void *p)
 }
 EXPORT_SYMBOL(kzfree);
 
+#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
 static DEFINE_PER_CPU(struct rcu_bulk_free, cpu_rbf);
 
 /* drain if atleast these many objects */
@@ -1696,6 +1697,7 @@ void kfree_call_rcu(struct rcu_head *head,
        __rcu_bulk_free(head, func);
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
+#endif

Previous Changes:

1) checkpatch.pl has been fixed, so kfree_rcu macro is much simpler

2) To handle preemption, preempt_enable()/preempt_disable() statements
   have been added to __rcu_bulk_free().

Rao Shoaib (2):
  Move kfree_call_rcu() to slab_common.c
  kfree_rcu() should use kfree_bulk() interface

 include/linux/mm.h       |   5 ++
 include/linux/rcupdate.h |  43 +-----------
 include/linux/rcutiny.h  |   8 ++-
 include/linux/rcutree.h  |   2 -
 include/linux/slab.h     |  42 ++++++++++++
 kernel/rcu/tree.c        |  24 +++----
 kernel/sysctl.c          |  40 +++++++++++
 mm/slab.h                |  23 +++++++
 mm/slab_common.c         | 174 +++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 304 insertions(+), 57 deletions(-)

-- 
2.7.4
