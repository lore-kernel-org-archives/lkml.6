Return-Path: <kent.overstreet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527038328; cv=none;
        d=google.com; s=arc-20160816;
        b=e2x2idjs8CKDtVjZ/3noW+N8vZGAvfedxQE1wArgyYuYUlsyJMklA4Q3oQ60RukkU1
         YN5DkXWJYObZosrCFHNJgKKMwy7GLh1uCoMB3WboV5StNdkArkL5srxLqOS+Ohtd2y0G
         3JrmqFSp8bbdOT5znhmXr0+Z2v1Ap71Q2C99p7ZyQfstRD4kCc0UYV6FkYUq0o9WSsIl
         k5/BM2QpD/7SYWg+64wM2TVMM9Ilf049EQn9w5Th6mTAL7BO9qt7XPt07NvoIcsvJGwM
         q0xvywOoHtqps18E6T/rAxSP/fEKcN5dgo2lLMP6TzDjnu2Up0BqPyEXTtu2oiqjHo9I
         uiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=UaCf/IOnCDhTGRoAMSw1i3LiFrYD3u7d/3bKu7DVZTQ=;
        b=W6EZNn0b8E8+FJiDGtybPegpbA+M2lCE6BrinlMMzyY/UjtBI+yK+PjzoNoVnZzvqx
         rArJ9SaHj4huZ8Md1Sv0BzdJnLwghBgpByoD3xTlnnKhhZpbDr+xhfY93+6kGx9auDwj
         yjAMp2VX///5P2WYr7yeGRAq5ebF/YgJGMLfS6mWM7fouwsJyMAxqzbLLVkN0LqTzqNw
         MkjY+X4qORMUbd8S35tg1gFaDdZqhWyyPmtWBp8LgKzaW0o5t9tLcdBzsEm4qXJzzdM6
         qk83HXW0xz51Z5rmP/ORH7QFkyw1dxnFEqxGSZUjSBFOrM9gUj4ggOCXiGbepdXtc+++
         sNZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WfI0Cq2N;
       spf=pass (google.com: domain of kent.overstreet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kent.overstreet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WfI0Cq2N;
       spf=pass (google.com: domain of kent.overstreet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kent.overstreet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: ADUXVKJZ/4R9u2jcWUL+TjvgEkXS74lE9H3InRYLFlCCSrPnuPFDL8VD8BvioxRVl6juGzzPCM6vsg==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	linux-security-module@vger.kernel.org,
	selinux@tycho.nsa.gov,
	dev@openvswitch.org,
	shli@kernel.org,
	linux-raid@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 4/6] openvswitch: convert to genradix
Date: Tue, 22 May 2018 21:18:19 -0400
Message-Id: <20180523011821.12165-4-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523011821.12165-1-kent.overstreet@gmail.com>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601215741901107818?=
X-GMAIL-MSGID: =?utf-8?q?1601215741901107818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

the new generic radix trees have a simpler API and implementation, and
no limitations on number of elements, so all flex_array users are being
converted

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 net/openvswitch/flow.h         |  1 -
 net/openvswitch/flow_netlink.h |  1 -
 net/openvswitch/flow_table.c   | 45 ++++++++++------------------------
 net/openvswitch/flow_table.h   |  4 +--
 4 files changed, 15 insertions(+), 36 deletions(-)

diff --git a/net/openvswitch/flow.h b/net/openvswitch/flow.h
index c670dd24b8..4f06278166 100644
--- a/net/openvswitch/flow.h
+++ b/net/openvswitch/flow.h
@@ -30,7 +30,6 @@
 #include <linux/in6.h>
 #include <linux/jiffies.h>
 #include <linux/time.h>
-#include <linux/flex_array.h>
 #include <linux/cpumask.h>
 #include <net/inet_ecn.h>
 #include <net/ip_tunnels.h>
diff --git a/net/openvswitch/flow_netlink.h b/net/openvswitch/flow_netlink.h
index 6657606b2b..66f9553758 100644
--- a/net/openvswitch/flow_netlink.h
+++ b/net/openvswitch/flow_netlink.h
@@ -30,7 +30,6 @@
 #include <linux/in6.h>
 #include <linux/jiffies.h>
 #include <linux/time.h>
-#include <linux/flex_array.h>
 
 #include <net/inet_ecn.h>
 #include <net/ip_tunnels.h>
diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 80ea2a7185..284f44d832 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -111,27 +111,19 @@ int ovs_flow_tbl_count(const struct flow_table *table)
 	return table->count;
 }
 
-static struct flex_array *alloc_buckets(unsigned int n_buckets)
+static int alloc_buckets(struct table_instance *ti, unsigned int n_buckets)
 {
-	struct flex_array *buckets;
-	int i, err;
+	int i;
 
-	buckets = flex_array_alloc(sizeof(struct hlist_head),
-				   n_buckets, GFP_KERNEL);
-	if (!buckets)
-		return NULL;
+	genradix_init(&ti->buckets);
 
-	err = flex_array_prealloc(buckets, 0, n_buckets, GFP_KERNEL);
-	if (err) {
-		flex_array_free(buckets);
-		return NULL;
-	}
+	if (genradix_prealloc(&ti->buckets, n_buckets, GFP_KERNEL))
+		return -ENOMEM;
 
 	for (i = 0; i < n_buckets; i++)
-		INIT_HLIST_HEAD((struct hlist_head *)
-					flex_array_get(buckets, i));
+		INIT_HLIST_HEAD(genradix_ptr(&ti->buckets, i));
 
-	return buckets;
+	return 0;
 }
 
 static void flow_free(struct sw_flow *flow)
@@ -168,15 +160,9 @@ void ovs_flow_free(struct sw_flow *flow, bool deferred)
 		flow_free(flow);
 }
 
-static void free_buckets(struct flex_array *buckets)
-{
-	flex_array_free(buckets);
-}
-
-
 static void __table_instance_destroy(struct table_instance *ti)
 {
-	free_buckets(ti->buckets);
+	genradix_free(&ti->buckets);
 	kfree(ti);
 }
 
@@ -187,9 +173,7 @@ static struct table_instance *table_instance_alloc(int new_size)
 	if (!ti)
 		return NULL;
 
-	ti->buckets = alloc_buckets(new_size);
-
-	if (!ti->buckets) {
+	if (alloc_buckets(ti, new_size)) {
 		kfree(ti);
 		return NULL;
 	}
@@ -249,7 +233,7 @@ static void table_instance_destroy(struct table_instance *ti,
 
 	for (i = 0; i < ti->n_buckets; i++) {
 		struct sw_flow *flow;
-		struct hlist_head *head = flex_array_get(ti->buckets, i);
+		struct hlist_head *head = genradix_ptr(&ti->buckets, i);
 		struct hlist_node *n;
 		int ver = ti->node_ver;
 		int ufid_ver = ufid_ti->node_ver;
@@ -294,7 +278,7 @@ struct sw_flow *ovs_flow_tbl_dump_next(struct table_instance *ti,
 	ver = ti->node_ver;
 	while (*bucket < ti->n_buckets) {
 		i = 0;
-		head = flex_array_get(ti->buckets, *bucket);
+		head = genradix_ptr(&ti->buckets, *bucket);
 		hlist_for_each_entry_rcu(flow, head, flow_table.node[ver]) {
 			if (i < *last) {
 				i++;
@@ -313,8 +297,7 @@ struct sw_flow *ovs_flow_tbl_dump_next(struct table_instance *ti,
 static struct hlist_head *find_bucket(struct table_instance *ti, u32 hash)
 {
 	hash = jhash_1word(hash, ti->hash_seed);
-	return flex_array_get(ti->buckets,
-				(hash & (ti->n_buckets - 1)));
+	return genradix_ptr(&ti->buckets, hash & (ti->n_buckets - 1));
 }
 
 static void table_instance_insert(struct table_instance *ti,
@@ -347,9 +330,7 @@ static void flow_table_copy_flows(struct table_instance *old,
 	/* Insert in new table. */
 	for (i = 0; i < old->n_buckets; i++) {
 		struct sw_flow *flow;
-		struct hlist_head *head;
-
-		head = flex_array_get(old->buckets, i);
+		struct hlist_head *head = genradix_ptr(&old->buckets, i);
 
 		if (ufid)
 			hlist_for_each_entry(flow, head,
diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.h
index 2dd9900f53..57fe93570a 100644
--- a/net/openvswitch/flow_table.h
+++ b/net/openvswitch/flow_table.h
@@ -29,7 +29,7 @@
 #include <linux/in6.h>
 #include <linux/jiffies.h>
 #include <linux/time.h>
-#include <linux/flex_array.h>
+#include <linux/generic-radix-tree.h>
 
 #include <net/inet_ecn.h>
 #include <net/ip_tunnels.h>
@@ -37,7 +37,7 @@
 #include "flow.h"
 
 struct table_instance {
-	struct flex_array *buckets;
+	GENRADIX(struct hlist_head) buckets;
 	unsigned int n_buckets;
 	struct rcu_head rcu;
 	int node_ver;
-- 
2.17.0
