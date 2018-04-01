Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754579AbeDAUnp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:43:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753901AbeDAUnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:43:41 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 34/45] C++: Fix up use of LIST_POISON*
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:43:39 +0100
Message-ID: <152261541968.30503.6809876330515224199.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implicitly casting void* to a non-void pointer is frowned upon in C++,
though -fpermissive causes it to be accepted.  Fix up LIST_POISON1/2
somewhat to handle this a bit better.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/list.h       |    8 ++++----
 include/linux/list_bl.h    |    4 ++--
 include/linux/list_nulls.h |    2 +-
 include/linux/poison.h     |    6 ++++--
 include/linux/rculist.h    |    4 ++--
 include/linux/rculist_bl.h |    2 +-
 6 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 4b129df4d46b..6aa933e4b109 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -123,8 +123,8 @@ static inline void __list_del_entry(struct list_head *entry)
 static inline void list_del(struct list_head *entry)
 {
 	__list_del_entry(entry);
-	entry->next = LIST_POISON1;
-	entry->prev = LIST_POISON2;
+	entry->next = static_cast<struct list_head *>(LIST_POISON1);
+	entry->prev = static_cast<struct list_head *>(LIST_POISON2);
 }
 
 /**
@@ -654,8 +654,8 @@ static inline void __hlist_del(struct hlist_node *n)
 static inline void hlist_del(struct hlist_node *n)
 {
 	__hlist_del(n);
-	n->next = LIST_POISON1;
-	n->pprev = LIST_POISON2;
+	n->next = HLIST_POISON1;
+	n->pprev = HLIST_POISON2;
 }
 
 static inline void hlist_del_init(struct hlist_node *n)
diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index 3fc2cc57ba1b..474c87c2e72e 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -105,8 +105,8 @@ static inline void __hlist_bl_del(struct hlist_bl_node *n)
 static inline void hlist_bl_del(struct hlist_bl_node *n)
 {
 	__hlist_bl_del(n);
-	n->next = LIST_POISON1;
-	n->pprev = LIST_POISON2;
+	n->next = ((struct hlist_bl_node *) (0x100 + POISON_POINTER_DELTA));
+	n->pprev = ((struct hlist_bl_node **) (0x200 + POISON_POINTER_DELTA));
 }
 
 static inline void hlist_bl_del_init(struct hlist_bl_node *n)
diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
index 3ef96743db8d..6c471fd62c9c 100644
--- a/include/linux/list_nulls.h
+++ b/include/linux/list_nulls.h
@@ -91,7 +91,7 @@ static inline void __hlist_nulls_del(struct hlist_nulls_node *n)
 static inline void hlist_nulls_del(struct hlist_nulls_node *n)
 {
 	__hlist_nulls_del(n);
-	n->pprev = LIST_POISON2;
+	n->pprev = (struct hlist_nulls_node **)LIST_POISON2;
 }
 
 /**
diff --git a/include/linux/poison.h b/include/linux/poison.h
index 15927ebc22f2..21544c2bf1a7 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -20,8 +20,10 @@
  * under normal circumstances, used to verify that nobody uses
  * non-initialized list entries.
  */
-#define LIST_POISON1  ((void *) 0x100 + POISON_POINTER_DELTA)
-#define LIST_POISON2  ((void *) 0x200 + POISON_POINTER_DELTA)
+#define LIST_POISON1  ((struct list_head *) (0x100 + POISON_POINTER_DELTA))
+#define LIST_POISON2  ((struct list_head *) (0x200 + POISON_POINTER_DELTA))
+#define HLIST_POISON1  ((struct hlist_node *) (0x100 + POISON_POINTER_DELTA))
+#define HLIST_POISON2  ((struct hlist_node **) (0x200 + POISON_POINTER_DELTA))
 
 /********** include/linux/timer.h **********/
 /*
diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 127f534fec94..d7b6a0a697c8 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -425,7 +425,7 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
 static inline void hlist_del_rcu(struct hlist_node *n)
 {
 	__hlist_del(n);
-	n->pprev = LIST_POISON2;
+	n->pprev = HLIST_POISON2;
 }
 
 /**
@@ -445,7 +445,7 @@ static inline void hlist_replace_rcu(struct hlist_node *old,
 	rcu_assign_pointer(*(struct hlist_node __rcu **)new->pprev, new);
 	if (next)
 		new->next->pprev = &new->next;
-	old->pprev = LIST_POISON2;
+	old->pprev = HLIST_POISON2;
 }
 
 /*
diff --git a/include/linux/rculist_bl.h b/include/linux/rculist_bl.h
index 66e73ec1aa99..e5a2c59deb6d 100644
--- a/include/linux/rculist_bl.h
+++ b/include/linux/rculist_bl.h
@@ -74,7 +74,7 @@ static inline void hlist_bl_del_init_rcu(struct hlist_bl_node *n)
 static inline void hlist_bl_del_rcu(struct hlist_bl_node *n)
 {
 	__hlist_bl_del(n);
-	n->pprev = LIST_POISON2;
+	n->pprev = ((struct hlist_bl_node **) (0x200 + POISON_POINTER_DELTA));
 }
 
 /**
