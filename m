Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx4/Jw1CiB0oIyB8ornLnAqY3cBYB+UsJSRu6pbdnQpMHVzN+byffvE78AVIe6r41psgKx4xL
ARC-Seal: i=1; a=rsa-sha256; t=1523483775; cv=none;
        d=google.com; s=arc-20160816;
        b=uS7deupz96r6cGyQlw0WAjG8gfb0nKUgxl9WwCcnVMjEIjn9EUcH/vZh/qmL/Pw8iw
         HXtdxQURqDhH4+IoD60/KGeeR7YpQhpMrsQgZRdNoE1RPUZWduVRe5dM7PGEZb2zqDFF
         o2nzDVHrcobpuRC49sp/WPZZ4NYfiQY8vkbHeFYb94PBmCRDkmzxkURt+uZyZ/5Q+Z49
         /aUt/SexlRvWlTlGcdkrVRkzPhLvI50474f9mBAJN8oXEJ0M/7KPoCeM3rIp2DOjhn+F
         90SXg/oLgKhXYRKU262AFSWIUivO7SYm77GWKLW2yGfEF0rlWQWOoeBaGzxWzrOq/Dd2
         qrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=cBqREfc/iHsN6J4K/7fZVV0t//V1964+HypZwF0XPjw=;
        b=FaTJnsXvL0lEPDMlVeeP+0Vv4Nbsk04O5HNUHPPyJyjXgauWcIBFiKN9O7+1YtABoJ
         N+uBsScvwwCIOAw55ebO4JlbZ9/S2L/q6pHr1xXhywQJ23NLzFfDY2ClgwdVEKijZaLd
         269efu0XGdwsF18kBsQzBQGDerAG0fLg70cCW4d1inhDiPgYSICvFOW9qpsqgsYb8gW7
         1y1Qw+5hc/KjdNn4DTvXyq5FdEt+PlvgUuMUDPI1B1Q1fWGfNu9zfwEYfH6HkvFrzVSN
         MmaKqzUJmm/xQQbAbSN4ySzlhbP1C1oOQFqnurjgf7Y3jQHcNeYBkjpGNxiSwxrdc7uW
         b0fw==
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
Subject: [PATCH 08/20] staging: lustre: simplify ldlm_ns_hash_defs[]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152348368879.12394.7087606958943793717.stgit@noble>
In-Reply-To: <152348312863.12394.11915752362061083241.stgit@noble>
References: <152348312863.12394.11915752362061083241.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597488523663485388?=
X-GMAIL-MSGID: =?utf-8?q?1597488523663485388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As the ldlm_ns_types are dense, we can use the type as
the index to the array, rather than searching through
the array for a match.
We can also discard nsd_hops as all hash tables now
use the same hops.
This makes the table smaller and the code simpler.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |   62 ++++++--------------
 1 file changed, 20 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
index a14cc12303ab..4288a81fd62b 100644
--- a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
@@ -545,55 +545,35 @@ static struct cfs_hash_ops ldlm_ns_hash_ops = {
 	.hs_put		= ldlm_res_hop_put
 };
 
-struct ldlm_ns_hash_def {
-	enum ldlm_ns_type nsd_type;
+static struct {
 	/** hash bucket bits */
 	unsigned int	nsd_bkt_bits;
 	/** hash bits */
 	unsigned int	nsd_all_bits;
-	/** hash operations */
-	struct cfs_hash_ops *nsd_hops;
-};
-
-static struct ldlm_ns_hash_def ldlm_ns_hash_defs[] = {
-	{
-		.nsd_type       = LDLM_NS_TYPE_MDC,
+} ldlm_ns_hash_defs[] = {
+	[LDLM_NS_TYPE_MDC] = {
 		.nsd_bkt_bits   = 11,
 		.nsd_all_bits   = 16,
-		.nsd_hops       = &ldlm_ns_hash_ops,
 	},
-	{
-		.nsd_type       = LDLM_NS_TYPE_MDT,
+	[LDLM_NS_TYPE_MDT] = {
 		.nsd_bkt_bits   = 14,
 		.nsd_all_bits   = 21,
-		.nsd_hops       = &ldlm_ns_hash_ops,
 	},
-	{
-		.nsd_type       = LDLM_NS_TYPE_OSC,
+	[LDLM_NS_TYPE_OSC] = {
 		.nsd_bkt_bits   = 8,
 		.nsd_all_bits   = 12,
-		.nsd_hops       = &ldlm_ns_hash_ops,
 	},
-	{
-		.nsd_type       = LDLM_NS_TYPE_OST,
+	[LDLM_NS_TYPE_OST] = {
 		.nsd_bkt_bits   = 11,
 		.nsd_all_bits   = 17,
-		.nsd_hops       = &ldlm_ns_hash_ops,
 	},
-	{
-		.nsd_type       = LDLM_NS_TYPE_MGC,
+	[LDLM_NS_TYPE_MGC] = {
 		.nsd_bkt_bits   = 3,
 		.nsd_all_bits   = 4,
-		.nsd_hops       = &ldlm_ns_hash_ops,
 	},
-	{
-		.nsd_type       = LDLM_NS_TYPE_MGT,
+	[LDLM_NS_TYPE_MGT] = {
 		.nsd_bkt_bits   = 3,
 		.nsd_all_bits   = 4,
-		.nsd_hops       = &ldlm_ns_hash_ops,
-	},
-	{
-		.nsd_type       = LDLM_NS_TYPE_UNKNOWN,
 	},
 };
 
@@ -617,7 +597,6 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_device *obd, char *name,
 					  enum ldlm_ns_type ns_type)
 {
 	struct ldlm_namespace *ns = NULL;
-	struct ldlm_ns_hash_def    *nsd;
 	int		    idx;
 	int		    rc;
 
@@ -629,15 +608,10 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_device *obd, char *name,
 		return NULL;
 	}
 
-	for (idx = 0;; idx++) {
-		nsd = &ldlm_ns_hash_defs[idx];
-		if (nsd->nsd_type == LDLM_NS_TYPE_UNKNOWN) {
-			CERROR("Unknown type %d for ns %s\n", ns_type, name);
-			goto out_ref;
-		}
-
-		if (nsd->nsd_type == ns_type)
-			break;
+	if (ns_type >= ARRAY_SIZE(ldlm_ns_hash_defs) ||
+	    ldlm_ns_hash_defs[ns_type].nsd_bkt_bits == 0) {
+		CERROR("Unknown type %d for ns %s\n", ns_type, name);
+		goto out_ref;
 	}
 
 	ns = kzalloc(sizeof(*ns), GFP_NOFS);
@@ -645,18 +619,22 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_device *obd, char *name,
 		goto out_ref;
 
 	ns->ns_rs_hash = cfs_hash_create(name,
-					 nsd->nsd_all_bits, nsd->nsd_all_bits,
-					 nsd->nsd_bkt_bits, 0,
+					 ldlm_ns_hash_defs[ns_type].nsd_all_bits,
+					 ldlm_ns_hash_defs[ns_type].nsd_all_bits,
+					 ldlm_ns_hash_defs[ns_type].nsd_bkt_bits,
+					 0,
 					 CFS_HASH_MIN_THETA,
 					 CFS_HASH_MAX_THETA,
-					 nsd->nsd_hops,
+					 &ldlm_ns_hash_ops,
 					 CFS_HASH_DEPTH |
 					 CFS_HASH_BIGNAME |
 					 CFS_HASH_SPIN_BKTLOCK |
 					 CFS_HASH_NO_ITEMREF);
 	if (!ns->ns_rs_hash)
 		goto out_ns;
-	ns->ns_bucket_bits = nsd->nsd_all_bits - nsd->nsd_bkt_bits;
+	ns->ns_bucket_bits = ldlm_ns_hash_defs[ns_type].nsd_all_bits -
+			      ldlm_ns_hash_defs[ns_type].nsd_bkt_bits;
+
 	ns->ns_rs_buckets = kvmalloc_array(1 << ns->ns_bucket_bits,
 					   sizeof(ns->ns_rs_buckets[0]),
 					   GFP_KERNEL);
