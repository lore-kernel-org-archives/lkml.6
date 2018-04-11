Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx48ePq0dzmxcL9GRWa6mkh4COYlOCYNhagQ0ZqIzd86qj5M1ptIkCCO4uMmlEsvKRXmpdKqs
ARC-Seal: i=1; a=rsa-sha256; t=1523483822; cv=none;
        d=google.com; s=arc-20160816;
        b=zl/kgj8UvCUdkP4WPjR/y36hJBc7CJ1oNspRru7dS28X5xJQV2zKbegV0n92VAON6k
         9k1rf5PgqBJGR1BDYXo+A3fB95ltzFW9oBKwUNUicJ7NsCdtCwG7m8q3130YfRqBSSo0
         0CUZgiIzmnfQoNdYL4sYheQaA6xnonprXL5X/6IbN6n8JmGadD61sw+ylboIDtNCT+Gn
         Brd172wL2vj8Dk3SDW6DeW6a+hVDaU5oY0hy/RRVse3fq5CZ7/JloZNIA2sbNb+wSQV3
         SZAHSboh3Ef7PaWMg131VeAZymmmFADbNK4uEmveH9G8Ko4JAqNYGbmH1vAwZxY3wTXv
         zPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=AqrHDDFOqZKYSkJMc+bb7OUm9j4uZn3PXmbjePT3oJw=;
        b=x1QM5lxd7vXEsQDVop31JAhimhmPVvs7S1s603a7Hn+tySsaIjHv+gowqoKzqSjeYf
         peFz+4yG7KS0kVZCw0gnpyX39tjWUa7bZrChVVPvq0rR2V1GM94SsNkw/x6X3SasdBYN
         QHlCk81ioxJnKUqy/u6kCKByvRUIN7OAry2o2ufyyKjElL3ouTMziqkk6+pPeKfl53nb
         xHnLjFWDKyFTRN/o9jDn6wJhSApNns84F+0hTXtQ1FdUMKLhMyyQShxFFkX9herKU3hg
         2u8JRyMrNATx5mrt+ZW5vsNqHockApfLWNTgiYI4PBCzPDD9sGcdiO8WI+7hKxXkZGtb
         Gtqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Thu, 12 Apr 2018 07:54:49 +1000
Subject: [PATCH 14/20] staging: lustre: fold lu_object_new() into
 lu_object_find_at()
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152348368902.12394.3830171785672683813.stgit@noble>
In-Reply-To: <152348312863.12394.11915752362061083241.stgit@noble>
References: <152348312863.12394.11915752362061083241.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597488572476975844?=
X-GMAIL-MSGID: =?utf-8?q?1597488572476975844?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

lu_object_new() duplicates a lot of code that is in
lu_object_find_at().
There is no real need for a separate function, it is simpler just
to skip the bits of lu_object_find_at() that we don't
want in the LOC_F_NEW case.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/obdclass/lu_object.c |   44 +++++---------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
index bf505a9463a3..18019f41c7a8 100644
--- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
@@ -691,29 +691,6 @@ static void lu_object_limit(const struct lu_env *env, struct lu_device *dev)
 			      false);
 }
 
-static struct lu_object *lu_object_new(const struct lu_env *env,
-				       struct lu_device *dev,
-				       const struct lu_fid *f,
-				       const struct lu_object_conf *conf)
-{
-	struct lu_object	*o;
-	struct cfs_hash	      *hs;
-	struct cfs_hash_bd	    bd;
-
-	o = lu_object_alloc(env, dev, f, conf);
-	if (IS_ERR(o))
-		return o;
-
-	hs = dev->ld_site->ls_obj_hash;
-	cfs_hash_bd_get_and_lock(hs, (void *)f, &bd, 1);
-	cfs_hash_bd_add_locked(hs, &bd, &o->lo_header->loh_hash);
-	cfs_hash_bd_unlock(hs, &bd, 1);
-
-	lu_object_limit(env, dev);
-
-	return o;
-}
-
 /**
  * Much like lu_object_find(), but top level device of object is specifically
  * \a dev rather than top level device of the site. This interface allows
@@ -749,18 +726,18 @@ struct lu_object *lu_object_find_at(const struct lu_env *env,
 	 * just alloc and insert directly.
 	 *
 	 */
-	if (conf && conf->loc_flags & LOC_F_NEW)
-		return lu_object_new(env, dev, f, conf);
-
 	s  = dev->ld_site;
 	hs = s->ls_obj_hash;
-	cfs_hash_bd_get_and_lock(hs, (void *)f, &bd, 0);
-	o = htable_lookup(s, &bd, f, &version);
-	cfs_hash_bd_unlock(hs, &bd, 0);
 
-	if (!IS_ERR(o) || PTR_ERR(o) != -ENOENT)
-		return o;
+	cfs_hash_bd_get(hs, f, &bd);
+	if (!(conf && conf->loc_flags & LOC_F_NEW)) {
+		cfs_hash_bd_lock(hs, &bd, 0);
+		o = htable_lookup(s, &bd, f, &version);
+		cfs_hash_bd_unlock(hs, &bd, 0);
 
+		if (!IS_ERR(o) || PTR_ERR(o) != -ENOENT)
+			return o;
+	}
 	/*
 	 * Allocate new object. This may result in rather complicated
 	 * operations, including fld queries, inode loading, etc.
@@ -773,7 +750,10 @@ struct lu_object *lu_object_find_at(const struct lu_env *env,
 
 	cfs_hash_bd_lock(hs, &bd, 1);
 
-	shadow = htable_lookup(s, &bd, f, &version);
+	if (conf && conf->loc_flags & LOC_F_NEW)
+		shadow = ERR_PTR(-ENOENT);
+	else
+		shadow = htable_lookup(s, &bd, f, &version);
 	if (likely(PTR_ERR(shadow) == -ENOENT)) {
 		cfs_hash_bd_add_locked(hs, &bd, &o->lo_header->loh_hash);
 		cfs_hash_bd_unlock(hs, &bd, 1);
