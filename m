Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx4+lhtCH4MeKoO2Lwdb70X2xPZABIikbH2FzXOFIiPXXN/HXROT+ahxQK3/Z6ADGI59ELiWU
ARC-Seal: i=1; a=rsa-sha256; t=1523483753; cv=none;
        d=google.com; s=arc-20160816;
        b=ZiIjIhPD3/P8DMAToiqI+8XrY3fVerNiYzvXkeIYORMEYttW7nZG89ladUskbxxNdl
         2BO3zjMDpnhGj08oJEspAwLH2a8HorRFdnkR3HJ4GQzxwVCupIVbFFuRwEgFFjkFeATX
         /aJorEPMrb3OGjJAquYC0pPp4hGAuQserUr5rn9gWCJtQPRkCoPO5tKEt0bGVQBbPsFx
         rS1Fi+/ZvR0CwvY+tlxTDWTwS0/r3pupEJcdnRbdBUm8o2/B3dyQvfWCLDlzaXF8R+PE
         hYLrKb7nMDw1wm95U4YRZLBqqBCzh3IHualkXkExO/5BO12PKAOydLS5CKfnbY41WXTj
         W54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=nEq8US5kFQ7rY6wTm+IDsouzom6tNGwfSxIn2WsWK88=;
        b=dRNcjOdJINAXOzNAp60EqI4y9tyTBoqZFbfiM2ilbU9HmlZOR60y2IIv4abRdSlXCN
         VzA2bMsU7skNC0PnuZlHWIRmx9pcVfPLO5nFc6a5BBIFSfuZE543Z/WwC6sJW013YjsH
         ++i5Hrl/69M/rEWQEVm/MGRguKDrvhxpn2etrCQBLMgxh3I/Pk6/PHuxxGYThrtetcGt
         Nisxlhej0uBGrV/LrnvILqhkanprCCTkAXCe0cDA0/1tGVwnfnGCJumgyVEnNdPbnJgf
         TXoTpyrGOSCYNAknN9oCz4ju0Tg3UKIWQ73CIZUpIkOeXo6Z6f1SD3grUUhfMYGIJidW
         08OQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Thu, 12 Apr 2018 07:54:48 +1000
Subject: [PATCH 05/20] staging: lustre: separate buckets from ldlm hash table
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152348368868.12394.16648347374686334362.stgit@noble>
In-Reply-To: <152348312863.12394.11915752362061083241.stgit@noble>
References: <152348312863.12394.11915752362061083241.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597488500193761809?=
X-GMAIL-MSGID: =?utf-8?q?1597488500193761809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ldlm maintains a per-namespace hashtable of resources.
With these hash tables it stores per-bucket 'struct adaptive_timeout'
structures.

Presumably having a single struct for the whole table results in too
much contention while having one per resource results in very little
adaption.

A future patch will change ldlm to use rhashtable which does not
support per-bucket data, so we need to manage the data separately.

There is no need for the multiple adaptive_timeout to align with the
hash chains, and trying to do this has resulted in a rather complex
hash function.
The purpose of ldlm_res_hop_fid_hash() appears to be to keep
resources with the same fid in the same hash bucket, so they use
the same adaptive timeout.  However it fails at doing this
because it puts the fid-specific bits in the wrong part of the hash.
If that is not the purpose, then I can see no point to the
complexitiy.

This patch creates a completely separate array of adaptive timeouts
(and other less interesting data) and uses a hash of the fid to index
that, meaning that a simple hash can be used for the hash table.

In the previous code, two namespace uses the same value for
nsd_all_bits and nsd_bkt_bits.  This results in zero bits being
used to choose a bucket - so there is only one bucket.
This looks odd and would confuse hash_32(), so I've adjusted the
numbers so there is always at least 1 bit (2 buckets).

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/include/lustre_dlm.h |    2 +
 drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |   53 ++++++++------------
 2 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/lustre/lustre/include/lustre_dlm.h b/drivers/staging/lustre/lustre/include/lustre_dlm.h
index d668d86423a4..395d50160dcc 100644
--- a/drivers/staging/lustre/lustre/include/lustre_dlm.h
+++ b/drivers/staging/lustre/lustre/include/lustre_dlm.h
@@ -364,6 +364,8 @@ struct ldlm_namespace {
 
 	/** Resource hash table for namespace. */
 	struct cfs_hash		*ns_rs_hash;
+	struct ldlm_ns_bucket	*ns_rs_buckets;
+	unsigned int		ns_bucket_bits;
 
 	/** serialize */
 	spinlock_t		ns_lock;
diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
index 6c615b6e9bdc..927544f01adc 100644
--- a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
@@ -476,10 +476,8 @@ static unsigned int ldlm_res_hop_hash(struct cfs_hash *hs,
 	return val & mask;
 }
 
-static unsigned int ldlm_res_hop_fid_hash(struct cfs_hash *hs,
-					  const void *key, unsigned int mask)
+static unsigned int ldlm_res_hop_fid_hash(const struct ldlm_res_id *id, unsigned int bits)
 {
-	const struct ldlm_res_id *id = key;
 	struct lu_fid       fid;
 	__u32	       hash;
 	__u32	       val;
@@ -492,18 +490,11 @@ static unsigned int ldlm_res_hop_fid_hash(struct cfs_hash *hs,
 	hash += (hash >> 4) + (hash << 12); /* mixing oid and seq */
 	if (id->name[LUSTRE_RES_ID_HSH_OFF] != 0) {
 		val = id->name[LUSTRE_RES_ID_HSH_OFF];
-		hash += (val >> 5) + (val << 11);
 	} else {
 		val = fid_oid(&fid);
 	}
-	hash = hash_long(hash, hs->hs_bkt_bits);
-	/* give me another random factor */
-	hash -= hash_long((unsigned long)hs, val % 11 + 3);
-
-	hash <<= hs->hs_cur_bits - hs->hs_bkt_bits;
-	hash |= ldlm_res_hop_hash(hs, key, CFS_HASH_NBKT(hs) - 1);
-
-	return hash & mask;
+	hash += (val >> 5) + (val << 11);
+	return hash_32(hash, bits);
 }
 
 static void *ldlm_res_hop_key(struct hlist_node *hnode)
@@ -555,16 +546,6 @@ static struct cfs_hash_ops ldlm_ns_hash_ops = {
 	.hs_put		= ldlm_res_hop_put
 };
 
-static struct cfs_hash_ops ldlm_ns_fid_hash_ops = {
-	.hs_hash	= ldlm_res_hop_fid_hash,
-	.hs_key		= ldlm_res_hop_key,
-	.hs_keycmp      = ldlm_res_hop_keycmp,
-	.hs_keycpy      = NULL,
-	.hs_object      = ldlm_res_hop_object,
-	.hs_get		= ldlm_res_hop_get_locked,
-	.hs_put		= ldlm_res_hop_put
-};
-
 struct ldlm_ns_hash_def {
 	enum ldlm_ns_type nsd_type;
 	/** hash bucket bits */
@@ -580,13 +561,13 @@ static struct ldlm_ns_hash_def ldlm_ns_hash_defs[] = {
 		.nsd_type       = LDLM_NS_TYPE_MDC,
 		.nsd_bkt_bits   = 11,
 		.nsd_all_bits   = 16,
-		.nsd_hops       = &ldlm_ns_fid_hash_ops,
+		.nsd_hops       = &ldlm_ns_hash_ops,
 	},
 	{
 		.nsd_type       = LDLM_NS_TYPE_MDT,
 		.nsd_bkt_bits   = 14,
 		.nsd_all_bits   = 21,
-		.nsd_hops       = &ldlm_ns_fid_hash_ops,
+		.nsd_hops       = &ldlm_ns_hash_ops,
 	},
 	{
 		.nsd_type       = LDLM_NS_TYPE_OSC,
@@ -602,13 +583,13 @@ static struct ldlm_ns_hash_def ldlm_ns_hash_defs[] = {
 	},
 	{
 		.nsd_type       = LDLM_NS_TYPE_MGC,
-		.nsd_bkt_bits   = 4,
+		.nsd_bkt_bits   = 3,
 		.nsd_all_bits   = 4,
 		.nsd_hops       = &ldlm_ns_hash_ops,
 	},
 	{
 		.nsd_type       = LDLM_NS_TYPE_MGT,
-		.nsd_bkt_bits   = 4,
+		.nsd_bkt_bits   = 3,
 		.nsd_all_bits   = 4,
 		.nsd_hops       = &ldlm_ns_hash_ops,
 	},
@@ -637,9 +618,7 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_device *obd, char *name,
 					  enum ldlm_ns_type ns_type)
 {
 	struct ldlm_namespace *ns = NULL;
-	struct ldlm_ns_bucket *nsb;
 	struct ldlm_ns_hash_def    *nsd;
-	struct cfs_hash_bd	  bd;
 	int		    idx;
 	int		    rc;
 
@@ -668,7 +647,7 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_device *obd, char *name,
 
 	ns->ns_rs_hash = cfs_hash_create(name,
 					 nsd->nsd_all_bits, nsd->nsd_all_bits,
-					 nsd->nsd_bkt_bits, sizeof(*nsb),
+					 nsd->nsd_bkt_bits, 0,
 					 CFS_HASH_MIN_THETA,
 					 CFS_HASH_MAX_THETA,
 					 nsd->nsd_hops,
@@ -678,9 +657,15 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_device *obd, char *name,
 					 CFS_HASH_NO_ITEMREF);
 	if (!ns->ns_rs_hash)
 		goto out_ns;
+	ns->ns_bucket_bits = nsd->nsd_all_bits - nsd->nsd_bkt_bits;
+	ns->ns_rs_buckets = kvmalloc_array(1 << ns->ns_bucket_bits,
+					   sizeof(ns->ns_rs_buckets[0]),
+					   GFP_KERNEL);
+	if (!ns->ns_rs_buckets)
+		goto out_hash;
 
-	cfs_hash_for_each_bucket(ns->ns_rs_hash, &bd, idx) {
-		nsb = cfs_hash_bd_extra_get(ns->ns_rs_hash, &bd);
+	for (idx = 0; idx < (1 << ns->ns_bucket_bits); idx++) {
+		struct ldlm_ns_bucket *nsb = &ns->ns_rs_buckets[idx];
 		at_init(&nsb->nsb_at_estimate, ldlm_enqueue_min, 0);
 		nsb->nsb_namespace = ns;
 	}
@@ -730,6 +715,7 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_device *obd, char *name,
 	ldlm_namespace_sysfs_unregister(ns);
 	ldlm_namespace_cleanup(ns, 0);
 out_hash:
+	kvfree(ns->ns_rs_buckets);
 	cfs_hash_putref(ns->ns_rs_hash);
 out_ns:
 	kfree(ns);
@@ -993,6 +979,7 @@ void ldlm_namespace_free_post(struct ldlm_namespace *ns)
 	ldlm_namespace_debugfs_unregister(ns);
 	ldlm_namespace_sysfs_unregister(ns);
 	cfs_hash_putref(ns->ns_rs_hash);
+	kvfree(ns->ns_rs_buckets);
 	/* Namespace \a ns should be not on list at this time, otherwise
 	 * this will cause issues related to using freed \a ns in poold
 	 * thread.
@@ -1098,6 +1085,7 @@ ldlm_resource_get(struct ldlm_namespace *ns, struct ldlm_resource *parent,
 	__u64		 version;
 	int		      ns_refcount = 0;
 	int rc;
+	int hash;
 
 	LASSERT(!parent);
 	LASSERT(ns->ns_rs_hash);
@@ -1122,7 +1110,8 @@ ldlm_resource_get(struct ldlm_namespace *ns, struct ldlm_resource *parent,
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
-	res->lr_ns_bucket  = cfs_hash_bd_extra_get(ns->ns_rs_hash, &bd);
+	hash = ldlm_res_hop_fid_hash(name, ns->ns_bucket_bits);
+	res->lr_ns_bucket  = &ns->ns_rs_buckets[hash];
 	res->lr_name       = *name;
 	res->lr_type       = type;
 
