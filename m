Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AB8JxZotM5ekYQKQ4BoBb5sPxLTRA3n3g/XeKJKJBEAwmKikZYqFVeiWDAZK4OU5Utk48NAkwXy0
ARC-Seal: i=1; a=rsa-sha256; t=1527078844; cv=none;
        d=google.com; s=arc-20160816;
        b=NWyBzEtLkitVp+tP9sdMOj5tbkq08ZDNlfX2wBh4BtomdKa9R+fzICRwxhDA3zGVXT
         ntiT6PC5tBz2WQUDd3vdVl16QGlAmGICx31Wh5QMOBAh6G8gHL9O1KtoafKyepSVjuqf
         rTnbqY614icJfTFA/SZKoIoHdvYrWuO3YjA1rnsSrYGyNQcXx0LPhms0nU+J4guD0cd8
         PEEM2qrn6xlB5gWYpKuT9AIZEVK9uGy8cuLKfrxul0Ew69BSaq37y/zwXvHA0fZWQftb
         pQqh7vD770afHUnis9zrXiuugVlyWAdUtVTwY7/OsaKurZytQ4LM3sYINK8oYIxOSMSV
         8yMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=pVq97Uiq0a1oeN11rmCX4Cl78IJme5wVQuxjcZr4ztE=;
        b=wMoMtQjlmt/sxWbV3PLKnhEIgbXhLfIuNJ3zaSlb5uB5psFAcBFQLf2pBjIUV9wRY9
         SDdfqCm61Ch99ytYgt6Mdxj3jEw/hPzr0VbHvzt09AikQkvev8Qnpy2TSOIxT7A6myAR
         Go6i86cU6lqRwNhupAVEYPxC3yLPfp17AIF7NAWBVc7zKJIRshpO/5Jx5O9fujgaJ/vV
         b7ee7qM8ALs8gZG11lOjnUOJ87Wa9KUtseruxujEcUI8L4WubPXViaYmsrX0XuoWyUSH
         N7Oxms7ViBnIwMSI468B1IoEa/J2NXz0CZh9y2XcTJVUIuQ7tSrZMutb0a0JjAsE+s29
         o/zg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=WWMHc6lo;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=WWMHc6lo;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Wed, 23 May 2018 05:34:01 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org, gregkh@linuxfoundation.org,
	linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
	dev@openvswitch.org, shli@kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 4/6] openvswitch: convert to genradix
Message-ID: <20180523123401.GB19987@bombadil.infradead.org>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
 <20180523011821.12165-4-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523011821.12165-4-kent.overstreet@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601215741901107818?=
X-GMAIL-MSGID: =?utf-8?q?1601258226519321249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 09:18:19PM -0400, Kent Overstreet wrote:
> the new generic radix trees have a simpler API and implementation, and
> no limitations on number of elements, so all flex_array users are being
> converted

This doesn't really feel like it should be a flexarray / genradix user.
It just wants to allocate a lot of buckets and use them.  Maybe kvmalloc
is the right approach for this user of flexarray?

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

 net/openvswitch/flow.h         |  1 -
 net/openvswitch/flow_netlink.h |  1 -
 net/openvswitch/flow_table.c   | 49 +++++++++++-------------------------------
 net/openvswitch/flow_table.h   |  3 +--
 4 files changed, 13 insertions(+), 41 deletions(-)

diff --git a/net/openvswitch/flow.h b/net/openvswitch/flow.h
index c670dd24b8b7..4f06278166d9 100644
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
index 6657606b2b47..66f9553758a5 100644
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
index 80ea2a71852e..909372bd2621 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -111,29 +111,6 @@ int ovs_flow_tbl_count(const struct flow_table *table)
 	return table->count;
 }
 
-static struct flex_array *alloc_buckets(unsigned int n_buckets)
-{
-	struct flex_array *buckets;
-	int i, err;
-
-	buckets = flex_array_alloc(sizeof(struct hlist_head),
-				   n_buckets, GFP_KERNEL);
-	if (!buckets)
-		return NULL;
-
-	err = flex_array_prealloc(buckets, 0, n_buckets, GFP_KERNEL);
-	if (err) {
-		flex_array_free(buckets);
-		return NULL;
-	}
-
-	for (i = 0; i < n_buckets; i++)
-		INIT_HLIST_HEAD((struct hlist_head *)
-					flex_array_get(buckets, i));
-
-	return buckets;
-}
-
 static void flow_free(struct sw_flow *flow)
 {
 	int cpu;
@@ -168,31 +145,30 @@ void ovs_flow_free(struct sw_flow *flow, bool deferred)
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
+	kvfree(ti->buckets);
 	kfree(ti);
 }
 
 static struct table_instance *table_instance_alloc(int new_size)
 {
 	struct table_instance *ti = kmalloc(sizeof(*ti), GFP_KERNEL);
+	int i;
 
 	if (!ti)
 		return NULL;
 
-	ti->buckets = alloc_buckets(new_size);
-
+	ti->buckets = kvmalloc(sizeof(struct hlist_head) * new_size,
+			GFP_KERNEL);
 	if (!ti->buckets) {
 		kfree(ti);
 		return NULL;
 	}
+
+	for (i = 0; i < new_size; i++)
+		INIT_HLIST_HEAD(&ti->buckets[i]);
+
 	ti->n_buckets = new_size;
 	ti->node_ver = 0;
 	ti->keep_flows = false;
@@ -249,7 +225,7 @@ static void table_instance_destroy(struct table_instance *ti,
 
 	for (i = 0; i < ti->n_buckets; i++) {
 		struct sw_flow *flow;
-		struct hlist_head *head = flex_array_get(ti->buckets, i);
+		struct hlist_head *head = &ti->buckets[i];
 		struct hlist_node *n;
 		int ver = ti->node_ver;
 		int ufid_ver = ufid_ti->node_ver;
@@ -294,7 +270,7 @@ struct sw_flow *ovs_flow_tbl_dump_next(struct table_instance *ti,
 	ver = ti->node_ver;
 	while (*bucket < ti->n_buckets) {
 		i = 0;
-		head = flex_array_get(ti->buckets, *bucket);
+		head = &ti->buckets[*bucket];
 		hlist_for_each_entry_rcu(flow, head, flow_table.node[ver]) {
 			if (i < *last) {
 				i++;
@@ -313,8 +289,7 @@ struct sw_flow *ovs_flow_tbl_dump_next(struct table_instance *ti,
 static struct hlist_head *find_bucket(struct table_instance *ti, u32 hash)
 {
 	hash = jhash_1word(hash, ti->hash_seed);
-	return flex_array_get(ti->buckets,
-				(hash & (ti->n_buckets - 1)));
+	return &ti->buckets[hash & (ti->n_buckets - 1)];
 }
 
 static void table_instance_insert(struct table_instance *ti,
@@ -349,7 +324,7 @@ static void flow_table_copy_flows(struct table_instance *old,
 		struct sw_flow *flow;
 		struct hlist_head *head;
 
-		head = flex_array_get(old->buckets, i);
+		head = &old->buckets[i];
 
 		if (ufid)
 			hlist_for_each_entry(flow, head,
diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.h
index 2dd9900f533d..de5ec6cf5174 100644
--- a/net/openvswitch/flow_table.h
+++ b/net/openvswitch/flow_table.h
@@ -29,7 +29,6 @@
 #include <linux/in6.h>
 #include <linux/jiffies.h>
 #include <linux/time.h>
-#include <linux/flex_array.h>
 
 #include <net/inet_ecn.h>
 #include <net/ip_tunnels.h>
@@ -37,7 +36,7 @@
 #include "flow.h"
 
 struct table_instance {
-	struct flex_array *buckets;
+	struct hlist_head *buckets;
 	unsigned int n_buckets;
 	struct rcu_head rcu;
 	int node_ver;
