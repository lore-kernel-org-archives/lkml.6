Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx49D40egKEw/Jz2n/j07WqzBB4cLfgQRvBVyLoEKNMiRXalgL3QrSJJ+FkrPsJXhs9ALWBS5
ARC-Seal: i=1; a=rsa-sha256; t=1522297672; cv=none;
        d=google.com; s=arc-20160816;
        b=HYvmZMBApyUZMojoxYJhvgm5iGXRhvQv0nS1+KlYxTqE4MtkBTr0DZnLw4pmmP0ETH
         vPzDYZ1LLqraT2N5hwPu5nLfYVxgkdubnNETrwLCxGLb8uahtQWStnUL54TvKEDXy7uy
         Xsbi3CrYmVyGedAHZLZk6tiFOfeEXsF7JHc0Kkm0kqz2GafloeaSoIEzFe91Jqkm4DtN
         EiE4z30RiDU7JWtqqIeQL0cUAvJyTKt9ZFMQNYR4sHHX/pcpCOm6SiMGLAcAQhWwirP4
         aUMcuHKXyhZx3zUCd3tS/Y2FbfU6DJvE3XhSFjzxVC4oY+lRa80KAQmIf8ehReP9MT5v
         cmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=FEXOr13Lebf/9ZAggbwnXra3JTykMAfN9j6JtkCONvE=;
        b=yIGpkGMYZofq3u/W5gc/HWUBFBPzeXihpE3btG5G56I4kTl9+Ewt8NYsq5mJNXX15W
         mk1UckfcNKlbAgci3waC0dUPO8aTxXgjRyCIjamzlykEjASmuzvvHmqsDeruwTxPgmrb
         r3RG5iZQQZxsRQ6ygiZHjjyY8RI//m1EXEZ91xK2mCC88hrTzOZqm2GNHEiZaK6rDtUB
         tj0J/ec34pX+6nEyLlCeIIYhTfhbJarZDCv+S4JDnKO9jsuPvemaxJ0wyrfD1QBiAzZE
         TO/qhUTbuczVrwfbVnm96EprDRbM7oIeyN5AOnuHwj8n71WFfRtDyDnfSbCZM4MepgH9
         MIqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Thu, 29 Mar 2018 15:26:48 +1100
Subject: [PATCH 06/17] staging: lustre: tidy up ldlm_resource_putref()
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152229760841.27689.15144924642603768840.stgit@noble>
In-Reply-To: <152229732768.27689.4800156943561963977.stgit@noble>
References: <152229732768.27689.4800156943561963977.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244803594692900?=
X-GMAIL-MSGID: =?utf-8?q?1596244803594692900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

1/ the return value of ldlm_resource_putref() is never
  used, so change it to return 'void'.
2/ Move all of the code to run on the last putref to
   __ldlm_resource_putref_final().  This means a lock
   is taken in one function and dropped in another, but
   that isn't too uncommon, and will disappear in a future
   patch.
   Now that the code it together, it becomes apparent that
   we are dropping a ref on the namespace *before* the last
   use.  So keep the ref until after.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/include/lustre_dlm.h |    2 +-
 drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |   21 +++++++++-----------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/lustre/lustre/include/lustre_dlm.h b/drivers/staging/lustre/lustre/include/lustre_dlm.h
index 5a355fbab401..d668d86423a4 100644
--- a/drivers/staging/lustre/lustre/include/lustre_dlm.h
+++ b/drivers/staging/lustre/lustre/include/lustre_dlm.h
@@ -1190,7 +1190,7 @@ struct ldlm_resource *ldlm_resource_get(struct ldlm_namespace *ns,
 					struct ldlm_resource *parent,
 					const struct ldlm_res_id *,
 					enum ldlm_type type, int create);
-int ldlm_resource_putref(struct ldlm_resource *res);
+void ldlm_resource_putref(struct ldlm_resource *res);
 void ldlm_resource_add_lock(struct ldlm_resource *res,
 			    struct list_head *head,
 			    struct ldlm_lock *lock);
diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
index 4c44603ab6f9..8841a1bb2c0a 100644
--- a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
@@ -1195,6 +1195,7 @@ static void __ldlm_resource_putref_final(struct cfs_hash_bd *bd,
 					 struct ldlm_resource *res)
 {
 	struct ldlm_ns_bucket *nsb = res->lr_ns_bucket;
+	struct ldlm_namespace *ns = nsb->nsb_namespace;
 
 	if (!list_empty(&res->lr_granted)) {
 		ldlm_resource_dump(D_ERROR, res);
@@ -1206,15 +1207,18 @@ static void __ldlm_resource_putref_final(struct cfs_hash_bd *bd,
 		LBUG();
 	}
 
-	cfs_hash_bd_del_locked(nsb->nsb_namespace->ns_rs_hash,
+	cfs_hash_bd_del_locked(ns->ns_rs_hash,
 			       bd, &res->lr_hash);
 	lu_ref_fini(&res->lr_reference);
+	cfs_hash_bd_unlock(ns->ns_rs_hash, bd, 1);
+	if (ns->ns_lvbo && ns->ns_lvbo->lvbo_free)
+		ns->ns_lvbo->lvbo_free(res);
 	if (cfs_hash_bd_count_get(bd) == 0)
-		ldlm_namespace_put(nsb->nsb_namespace);
+		ldlm_namespace_put(ns);
+	kmem_cache_free(ldlm_resource_slab, res);
 }
 
-/* Returns 1 if the resource was freed, 0 if it remains. */
-int ldlm_resource_putref(struct ldlm_resource *res)
+void ldlm_resource_putref(struct ldlm_resource *res)
 {
 	struct ldlm_namespace *ns = ldlm_res_to_ns(res);
 	struct cfs_hash_bd   bd;
@@ -1224,15 +1228,8 @@ int ldlm_resource_putref(struct ldlm_resource *res)
 	       res, atomic_read(&res->lr_refcount) - 1);
 
 	cfs_hash_bd_get(ns->ns_rs_hash, &res->lr_name, &bd);
-	if (cfs_hash_bd_dec_and_lock(ns->ns_rs_hash, &bd, &res->lr_refcount)) {
+	if (cfs_hash_bd_dec_and_lock(ns->ns_rs_hash, &bd, &res->lr_refcount))
 		__ldlm_resource_putref_final(&bd, res);
-		cfs_hash_bd_unlock(ns->ns_rs_hash, &bd, 1);
-		if (ns->ns_lvbo && ns->ns_lvbo->lvbo_free)
-			ns->ns_lvbo->lvbo_free(res);
-		kmem_cache_free(ldlm_resource_slab, res);
-		return 1;
-	}
-	return 0;
 }
 EXPORT_SYMBOL(ldlm_resource_putref);
 
