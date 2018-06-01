Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeFAEpX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:45:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:34017 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751058AbeFAEpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:45:18 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Jun 2018 14:44:09 +1000
Subject: [PATCH 02/18] rhashtable: split rhashtable.h
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152782824932.30340.8068908844678938422.stgit@noble>
In-Reply-To: <152782754287.30340.4395718227884933670.stgit@noble>
References: <152782754287.30340.4395718227884933670.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the use of rhashtables in net namespaces,
rhashtable.h is included in lots of the kernel,
so a small changes can required a large recompilation.
This makes development painful.

This patch splits out rhashtable-types.h which just includes
the major type declarations, and does not include (non-trivial)
inline code.  rhashtable.h is no longer included by anything
in the include/ directory.
Common include files only include rhashtable-types.h so a large
recompilation is only triggered when that changes.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 MAINTAINERS                                       |    2 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h        |    1 
 drivers/staging/lustre/lustre/fid/fid_request.c   |    2 
 drivers/staging/lustre/lustre/fld/fld_request.c   |    1 
 drivers/staging/lustre/lustre/include/lu_object.h |    1 
 include/linux/ipc.h                               |    2 
 include/linux/ipc_namespace.h                     |    2 
 include/linux/mroute_base.h                       |    2 
 include/linux/rhashtable-types.h                  |  139 +++++++++++++++++++++
 include/linux/rhashtable.h                        |  127 -------------------
 include/net/inet_frag.h                           |    2 
 include/net/netfilter/nf_flow_table.h             |    2 
 include/net/sctp/structs.h                        |    2 
 include/net/seg6.h                                |    2 
 include/net/seg6_hmac.h                           |    2 
 ipc/msg.c                                         |    1 
 ipc/sem.c                                         |    1 
 ipc/shm.c                                         |    1 
 ipc/util.c                                        |    1 
 lib/rhashtable.c                                  |    1 
 net/ipv4/inet_fragment.c                          |    1 
 net/ipv4/ipmr.c                                   |    1 
 net/ipv4/ipmr_base.c                              |    1 
 net/ipv6/ip6mr.c                                  |    1 
 net/ipv6/seg6.c                                   |    1 
 net/ipv6/seg6_hmac.c                              |    1 
 net/netfilter/nf_tables_api.c                     |    1 
 net/sctp/input.c                                  |    1 
 net/sctp/socket.c                                 |    1 
 29 files changed, 169 insertions(+), 134 deletions(-)
 create mode 100644 include/linux/rhashtable-types.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 66985d05bced..a3a4f44d3ce1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12012,7 +12012,9 @@ M:	Herbert Xu <herbert@gondor.apana.org.au>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	lib/rhashtable.c
+F:	lib/test_rhashtable.c
 F:	include/linux/rhashtable.h
+F:	include/linux/rhashtable-types.h
 
 RICOH R5C592 MEMORYSTICK DRIVER
 M:	Maxim Levitsky <maximlevitsky@gmail.com>
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 688f95440af2..66a7a02d616a 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -46,6 +46,7 @@
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/vmalloc.h>
+#include <linux/rhashtable.h>
 #include <linux/etherdevice.h>
 #include <linux/net_tstamp.h>
 #include <linux/ptp_clock_kernel.h>
diff --git a/drivers/staging/lustre/lustre/fid/fid_request.c b/drivers/staging/lustre/lustre/fid/fid_request.c
index c674652af03a..a9af68178eff 100644
--- a/drivers/staging/lustre/lustre/fid/fid_request.c
+++ b/drivers/staging/lustre/lustre/fid/fid_request.c
@@ -40,7 +40,7 @@
 #define DEBUG_SUBSYSTEM S_FID
 
 #include <linux/module.h>
-
+#include <linux/rhashtable.h>
 #include <obd.h>
 #include <obd_class.h>
 #include <obd_support.h>
diff --git a/drivers/staging/lustre/lustre/fld/fld_request.c b/drivers/staging/lustre/lustre/fld/fld_request.c
index 7b7ba93a4db6..292ff5756243 100644
--- a/drivers/staging/lustre/lustre/fld/fld_request.c
+++ b/drivers/staging/lustre/lustre/fld/fld_request.c
@@ -40,6 +40,7 @@
 #define DEBUG_SUBSYSTEM S_FLD
 
 #include <linux/module.h>
+#include <linux/rhashtable.h>
 #include <asm/div64.h>
 
 #include <obd.h>
diff --git a/drivers/staging/lustre/lustre/include/lu_object.h b/drivers/staging/lustre/lustre/include/lu_object.h
index 1b5284d2416c..205463c47bda 100644
--- a/drivers/staging/lustre/lustre/include/lu_object.h
+++ b/drivers/staging/lustre/lustre/include/lu_object.h
@@ -37,6 +37,7 @@
 #include <stdarg.h>
 #include <linux/percpu_counter.h>
 #include <linux/libcfs/libcfs.h>
+#include <linux/rhashtable-types.h>
 #include <uapi/linux/lustre/lustre_idl.h>
 #include <lu_ref.h>
 
diff --git a/include/linux/ipc.h b/include/linux/ipc.h
index 6cc2df7f7ac9..e1c9eea6015b 100644
--- a/include/linux/ipc.h
+++ b/include/linux/ipc.h
@@ -4,7 +4,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/uidgid.h>
-#include <linux/rhashtable.h>
+#include <linux/rhashtable-types.h>
 #include <uapi/linux/ipc.h>
 #include <linux/refcount.h>
 
diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index b5630c8eb2f3..6cea726612b7 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -9,7 +9,7 @@
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
 #include <linux/refcount.h>
-#include <linux/rhashtable.h>
+#include <linux/rhashtable-types.h>
 
 struct user_namespace;
 
diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index d617fe45543e..fd673be398ff 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -2,7 +2,7 @@
 #define __LINUX_MROUTE_BASE_H
 
 #include <linux/netdevice.h>
-#include <linux/rhashtable.h>
+#include <linux/rhashtable-types.h>
 #include <linux/spinlock.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
new file mode 100644
index 000000000000..9740063ff13b
--- /dev/null
+++ b/include/linux/rhashtable-types.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Resizable, Scalable, Concurrent Hash Table
+ *
+ * Simple structures that might be needed in include
+ * files.
+ */
+
+#ifndef _LINUX_RHASHTABLE_TYPES_H
+#define _LINUX_RHASHTABLE_TYPES_H
+
+#include <linux/atomic.h>
+#include <linux/compiler.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
+
+struct rhash_head {
+	struct rhash_head __rcu		*next;
+};
+
+struct rhlist_head {
+	struct rhash_head		rhead;
+	struct rhlist_head __rcu	*next;
+};
+
+struct bucket_table;
+
+/**
+ * struct rhashtable_compare_arg - Key for the function rhashtable_compare
+ * @ht: Hash table
+ * @key: Key to compare against
+ */
+struct rhashtable_compare_arg {
+	struct rhashtable *ht;
+	const void *key;
+};
+
+typedef u32 (*rht_hashfn_t)(const void *data, u32 len, u32 seed);
+typedef u32 (*rht_obj_hashfn_t)(const void *data, u32 len, u32 seed);
+typedef int (*rht_obj_cmpfn_t)(struct rhashtable_compare_arg *arg,
+			       const void *obj);
+
+/**
+ * struct rhashtable_params - Hash table construction parameters
+ * @nelem_hint: Hint on number of elements, should be 75% of desired size
+ * @key_len: Length of key
+ * @key_offset: Offset of key in struct to be hashed
+ * @head_offset: Offset of rhash_head in struct to be hashed
+ * @max_size: Maximum size while expanding
+ * @min_size: Minimum size while shrinking
+ * @locks_mul: Number of bucket locks to allocate per cpu (default: 32)
+ * @automatic_shrinking: Enable automatic shrinking of tables
+ * @nulls_base: Base value to generate nulls marker
+ * @hashfn: Hash function (default: jhash2 if !(key_len % 4), or jhash)
+ * @obj_hashfn: Function to hash object
+ * @obj_cmpfn: Function to compare key with object
+ */
+struct rhashtable_params {
+	u16			nelem_hint;
+	u16			key_len;
+	u16			key_offset;
+	u16			head_offset;
+	unsigned int		max_size;
+	u16			min_size;
+	bool			automatic_shrinking;
+	u8			locks_mul;
+	u32			nulls_base;
+	rht_hashfn_t		hashfn;
+	rht_obj_hashfn_t	obj_hashfn;
+	rht_obj_cmpfn_t		obj_cmpfn;
+};
+
+/**
+ * struct rhashtable - Hash table handle
+ * @tbl: Bucket table
+ * @key_len: Key length for hashfn
+ * @max_elems: Maximum number of elements in table
+ * @p: Configuration parameters
+ * @rhlist: True if this is an rhltable
+ * @run_work: Deferred worker to expand/shrink asynchronously
+ * @mutex: Mutex to protect current/future table swapping
+ * @lock: Spin lock to protect walker list
+ * @nelems: Number of elements in table
+ */
+struct rhashtable {
+	struct bucket_table __rcu	*tbl;
+	unsigned int			key_len;
+	unsigned int			max_elems;
+	struct rhashtable_params	p;
+	bool				rhlist;
+	struct work_struct		run_work;
+	struct mutex                    mutex;
+	spinlock_t			lock;
+	atomic_t			nelems;
+};
+
+/**
+ * struct rhltable - Hash table with duplicate objects in a list
+ * @ht: Underlying rhtable
+ */
+struct rhltable {
+	struct rhashtable ht;
+};
+
+/**
+ * struct rhashtable_walker - Hash table walker
+ * @list: List entry on list of walkers
+ * @tbl: The table that we were walking over
+ */
+struct rhashtable_walker {
+	struct list_head list;
+	struct bucket_table *tbl;
+};
+
+/**
+ * struct rhashtable_iter - Hash table iterator
+ * @ht: Table to iterate through
+ * @p: Current pointer
+ * @list: Current hash list pointer
+ * @walker: Associated rhashtable walker
+ * @slot: Current slot
+ * @skip: Number of entries to skip in slot
+ */
+struct rhashtable_iter {
+	struct rhashtable *ht;
+	struct rhash_head *p;
+	struct rhlist_head *list;
+	struct rhashtable_walker walker;
+	unsigned int slot;
+	unsigned int skip;
+	bool end_of_table;
+};
+
+int rhashtable_init(struct rhashtable *ht,
+		    const struct rhashtable_params *params);
+int rhltable_init(struct rhltable *hlt,
+		  const struct rhashtable_params *params);
+
+#endif /* _LINUX_RHASHTABLE_TYPES_H */
diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 4e1f535c2034..48754ab07cdf 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Resizable, Scalable, Concurrent Hash Table
  *
@@ -17,16 +18,14 @@
 #ifndef _LINUX_RHASHTABLE_H
 #define _LINUX_RHASHTABLE_H
 
-#include <linux/atomic.h>
-#include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/jhash.h>
 #include <linux/list_nulls.h>
 #include <linux/workqueue.h>
-#include <linux/mutex.h>
 #include <linux/rculist.h>
 
+#include <linux/rhashtable-types.h>
 /*
  * The end of the chain is marked with a special nulls marks which has
  * the following format:
@@ -64,15 +63,6 @@
  */
 #define RHT_ELASTICITY	16u
 
-struct rhash_head {
-	struct rhash_head __rcu		*next;
-};
-
-struct rhlist_head {
-	struct rhash_head		rhead;
-	struct rhlist_head __rcu	*next;
-};
-
 /**
  * struct bucket_table - Table of hash buckets
  * @size: Number of hash buckets
@@ -102,114 +92,6 @@ struct bucket_table {
 	struct rhash_head __rcu *buckets[] ____cacheline_aligned_in_smp;
 };
 
-/**
- * struct rhashtable_compare_arg - Key for the function rhashtable_compare
- * @ht: Hash table
- * @key: Key to compare against
- */
-struct rhashtable_compare_arg {
-	struct rhashtable *ht;
-	const void *key;
-};
-
-typedef u32 (*rht_hashfn_t)(const void *data, u32 len, u32 seed);
-typedef u32 (*rht_obj_hashfn_t)(const void *data, u32 len, u32 seed);
-typedef int (*rht_obj_cmpfn_t)(struct rhashtable_compare_arg *arg,
-			       const void *obj);
-
-struct rhashtable;
-
-/**
- * struct rhashtable_params - Hash table construction parameters
- * @nelem_hint: Hint on number of elements, should be 75% of desired size
- * @key_len: Length of key
- * @key_offset: Offset of key in struct to be hashed
- * @head_offset: Offset of rhash_head in struct to be hashed
- * @max_size: Maximum size while expanding
- * @min_size: Minimum size while shrinking
- * @locks_mul: Number of bucket locks to allocate per cpu (default: 32)
- * @automatic_shrinking: Enable automatic shrinking of tables
- * @nulls_base: Base value to generate nulls marker
- * @hashfn: Hash function (default: jhash2 if !(key_len % 4), or jhash)
- * @obj_hashfn: Function to hash object
- * @obj_cmpfn: Function to compare key with object
- */
-struct rhashtable_params {
-	u16			nelem_hint;
-	u16			key_len;
-	u16			key_offset;
-	u16			head_offset;
-	unsigned int		max_size;
-	u16			min_size;
-	bool			automatic_shrinking;
-	u8			locks_mul;
-	u32			nulls_base;
-	rht_hashfn_t		hashfn;
-	rht_obj_hashfn_t	obj_hashfn;
-	rht_obj_cmpfn_t		obj_cmpfn;
-};
-
-/**
- * struct rhashtable - Hash table handle
- * @tbl: Bucket table
- * @key_len: Key length for hashfn
- * @max_elems: Maximum number of elements in table
- * @p: Configuration parameters
- * @rhlist: True if this is an rhltable
- * @run_work: Deferred worker to expand/shrink asynchronously
- * @mutex: Mutex to protect current/future table swapping
- * @lock: Spin lock to protect walker list
- * @nelems: Number of elements in table
- */
-struct rhashtable {
-	struct bucket_table __rcu	*tbl;
-	unsigned int			key_len;
-	unsigned int			max_elems;
-	struct rhashtable_params	p;
-	bool				rhlist;
-	struct work_struct		run_work;
-	struct mutex                    mutex;
-	spinlock_t			lock;
-	atomic_t			nelems;
-};
-
-/**
- * struct rhltable - Hash table with duplicate objects in a list
- * @ht: Underlying rhtable
- */
-struct rhltable {
-	struct rhashtable ht;
-};
-
-/**
- * struct rhashtable_walker - Hash table walker
- * @list: List entry on list of walkers
- * @tbl: The table that we were walking over
- */
-struct rhashtable_walker {
-	struct list_head list;
-	struct bucket_table *tbl;
-};
-
-/**
- * struct rhashtable_iter - Hash table iterator
- * @ht: Table to iterate through
- * @p: Current pointer
- * @list: Current hash list pointer
- * @walker: Associated rhashtable walker
- * @slot: Current slot
- * @skip: Number of entries to skip in slot
- */
-struct rhashtable_iter {
-	struct rhashtable *ht;
-	struct rhash_head *p;
-	struct rhlist_head *list;
-	struct rhashtable_walker walker;
-	unsigned int slot;
-	unsigned int skip;
-	bool end_of_table;
-};
-
 static inline unsigned long rht_marker(const struct rhashtable *ht, u32 hash)
 {
 	return NULLS_MARKER(ht->p.nulls_base + hash);
@@ -376,11 +258,6 @@ static inline int lockdep_rht_bucket_is_held(const struct bucket_table *tbl,
 }
 #endif /* CONFIG_PROVE_LOCKING */
 
-int rhashtable_init(struct rhashtable *ht,
-		    const struct rhashtable_params *params);
-int rhltable_init(struct rhltable *hlt,
-		  const struct rhashtable_params *params);
-
 void *rhashtable_insert_slow(struct rhashtable *ht, const void *key,
 			     struct rhash_head *obj);
 
diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index ed07e3786d98..f4272a29dc44 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -2,7 +2,7 @@
 #ifndef __NET_FRAG_H__
 #define __NET_FRAG_H__
 
-#include <linux/rhashtable.h>
+#include <linux/rhashtable-types.h>
 
 struct netns_frags {
 	/* sysctls */
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 833752dd0c58..3bb75491482f 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -4,7 +4,7 @@
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <linux/netdevice.h>
-#include <linux/rhashtable.h>
+#include <linux/rhashtable-types.h>
 #include <linux/rcupdate.h>
 #include <net/dst.h>
 
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index a0ec462bc1a9..e5ac430c8717 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -48,7 +48,7 @@
 #define __sctp_structs_h__
 
 #include <linux/ktime.h>
-#include <linux/rhashtable.h>
+#include <linux/rhashtable-types.h>
 #include <linux/socket.h>	/* linux/in.h needs this!!    */
 #include <linux/in.h>		/* We get struct sockaddr_in. */
 #include <linux/in6.h>		/* We get struct in6_addr     */
diff --git a/include/net/seg6.h b/include/net/seg6.h
index 099bad59dc90..85ee569c8306 100644
--- a/include/net/seg6.h
+++ b/include/net/seg6.h
@@ -18,7 +18,7 @@
 #include <linux/ipv6.h>
 #include <net/lwtunnel.h>
 #include <linux/seg6.h>
-#include <linux/rhashtable.h>
+#include <linux/rhashtable-types.h>
 
 static inline void update_csum_diff4(struct sk_buff *skb, __be32 from,
 				     __be32 to)
diff --git a/include/net/seg6_hmac.h b/include/net/seg6_hmac.h
index 69c3a106056b..7fda469e2758 100644
--- a/include/net/seg6_hmac.h
+++ b/include/net/seg6_hmac.h
@@ -22,7 +22,7 @@
 #include <linux/route.h>
 #include <net/seg6.h>
 #include <linux/seg6_hmac.h>
-#include <linux/rhashtable.h>
+#include <linux/rhashtable-types.h>
 
 #define SEG6_HMAC_MAX_DIGESTSIZE	160
 #define SEG6_HMAC_RING_SIZE		256
diff --git a/ipc/msg.c b/ipc/msg.c
index 56fd1c73eedc..8fa2cac6830a 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -38,6 +38,7 @@
 #include <linux/rwsem.h>
 #include <linux/nsproxy.h>
 #include <linux/ipc_namespace.h>
+#include <linux/rhashtable.h>
 
 #include <asm/current.h>
 #include <linux/uaccess.h>
diff --git a/ipc/sem.c b/ipc/sem.c
index 06be75d9217a..f0c4a0ed91c7 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -84,6 +84,7 @@
 #include <linux/nsproxy.h>
 #include <linux/ipc_namespace.h>
 #include <linux/sched/wake_q.h>
+#include <linux/rhashtable.h>
 
 #include <linux/uaccess.h>
 #include "util.h"
diff --git a/ipc/shm.c b/ipc/shm.c
index d73269381ec7..5824a7f3253e 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -43,6 +43,7 @@
 #include <linux/nsproxy.h>
 #include <linux/mount.h>
 #include <linux/ipc_namespace.h>
+#include <linux/rhashtable.h>
 
 #include <linux/uaccess.h>
 
diff --git a/ipc/util.c b/ipc/util.c
index 4e81182fa0ac..fdffff41f65b 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -63,6 +63,7 @@
 #include <linux/rwsem.h>
 #include <linux/memory.h>
 #include <linux/ipc_namespace.h>
+#include <linux/rhashtable.h>
 
 #include <asm/unistd.h>
 
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 9427b5766134..c9fafea7dc6e 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -28,6 +28,7 @@
 #include <linux/rhashtable.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/rhashtable.h>
 
 #define HASH_DEFAULT_SIZE	64UL
 #define HASH_MIN_SIZE		4U
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index c9e35b81d093..316518f87294 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -20,6 +20,7 @@
 #include <linux/skbuff.h>
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
+#include <linux/rhashtable.h>
 
 #include <net/sock.h>
 #include <net/inet_frag.h>
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 2fb4de3f7f66..adbc3d3a560b 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -60,6 +60,7 @@
 #include <linux/netfilter_ipv4.h>
 #include <linux/compat.h>
 #include <linux/export.h>
+#include <linux/rhashtable.h>
 #include <net/ip_tunnels.h>
 #include <net/checksum.h>
 #include <net/netlink.h>
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 30221701614c..4f39b27b5084 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -2,6 +2,7 @@
  * Common logic shared by IPv4 [ipmr] and IPv6 [ip6mr] implementation
  */
 
+#include <linux/rhashtable.h>
 #include <linux/mroute_base.h>
 
 /* Sets everything common except 'dev', since that is done under locking */
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 298fd8b6ed17..dfb339f79bde 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -32,6 +32,7 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/compat.h>
+#include <linux/rhashtable.h>
 #include <net/protocol.h>
 #include <linux/skbuff.h>
 #include <net/raw.h>
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 7f5621d09571..e24a91c7892a 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -17,6 +17,7 @@
 #include <linux/net.h>
 #include <linux/in6.h>
 #include <linux/slab.h>
+#include <linux/rhashtable.h>
 
 #include <net/ipv6.h>
 #include <net/protocol.h>
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index 33fb35cbfac1..b1791129a875 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -22,6 +22,7 @@
 #include <linux/icmpv6.h>
 #include <linux/mroute6.h>
 #include <linux/slab.h>
+#include <linux/rhashtable.h>
 
 #include <linux/netfilter.h>
 #include <linux/netfilter_ipv6.h>
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 91e80aa852d6..85077c2f3379 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -14,6 +14,7 @@
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 #include <linux/vmalloc.h>
+#include <linux/rhashtable.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nf_tables.h>
diff --git a/net/sctp/input.c b/net/sctp/input.c
index ba8a6e6c36fa..9bbc5f92c941 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -56,6 +56,7 @@
 #include <net/sctp/sm.h>
 #include <net/sctp/checksum.h>
 #include <net/net_namespace.h>
+#include <linux/rhashtable.h>
 
 /* Forward declarations for internal helpers. */
 static int sctp_rcv_ootb(struct sk_buff *);
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index ae7e7c606f72..0adce7b22675 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -66,6 +66,7 @@
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/compat.h>
+#include <linux/rhashtable.h>
 
 #include <net/ip.h>
 #include <net/icmp.h>
