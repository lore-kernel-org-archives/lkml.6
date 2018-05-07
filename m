Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZrmt2UA7og7fMBNUAiZ1aHd+4/hhBfBqhu2h+W9le1Tx4zP/oC9Dw5psHNEqG5ElU2tmRjl
ARC-Seal: i=1; a=rsa-sha256; t=1525654558; cv=none;
        d=google.com; s=arc-20160816;
        b=qK91xJFney4ltkyXKIT9KKc6YyUr1vv494G3nPQUvTXT3zXTrEE3aYkZ7/BcyYOxQ/
         1ICTGosu/w/XH45X60o/+n85sF1o7/hTng7gPx2uefNPfI7a8ug/vlHNNyrVeCOBN0LN
         2WmF1YpU4W+76iZC7pQaW+DxDW9Xpo5fX29xNh9XbRigbNa19QacVcDCpJoxyX3Wdvki
         6PaqrqK274jlmgd3TTXGbOhlTagiWLyPwKcn0sFLitNjSALtnB7abXoABD0OxoZPWKh2
         c9WiaXG77/l9wfd0lMHUmjAUv7XheEuAKR9yLVSkteaknAaSdyMPaZYLkXvuOvIRhhz/
         u//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=CSsrwDkhjHKZAyJ7bDBT09e8Wgzyzf40DOTGrvYbJJQ=;
        b=i17gPVZIXUXNdyNUAFjE6LDhF++ZIJk7EhsUBwYiU3kzzHu0b9uTrPZcGnQu1CqtXj
         I++OHET+KF+JCV4xulVXwMOdf9g6Qqas22Mg/QNm6hsFc+ska1Ftzxv3Od3weUwBeNit
         4YFevdMyxC13BFzohNcnlqTbEG3Vc9A+gVkWfEnHKnjG+2NVTUO8SupmqdA1YcnJf4I4
         k7H7PfAI8Pr30vbTNgnvJiwaq5p2a2S4/jL6LKjJDTwNx8K4hAZ8a9IXJ247yeBhyrId
         C/jJyXOi/HSH09GKrrhVVwiFPwbkyRBvZVcrWJFikPtvmiCxXqAfB3JBeYwEDhgEfTQD
         J33A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 07 May 2018 10:54:48 +1000
Subject: [PATCH 05/10] staging: lustre: fold lu_object_new() into
 lu_object_find_at()
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152565448814.30131.1410451753531304804.stgit@noble>
In-Reply-To: <152565436690.30131.2229703651041382739.stgit@noble>
References: <152565436690.30131.2229703651041382739.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599764754993439206?=
X-GMAIL-MSGID: =?utf-8?q?1599764754993439206?=
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
index 0c9419a6d5d6..7981c7d8ecc1 100644
--- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
@@ -682,29 +682,6 @@ static void lu_object_limit(const struct lu_env *env, struct lu_device *dev)
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
@@ -740,18 +717,18 @@ struct lu_object *lu_object_find_at(const struct lu_env *env,
 	 * just alloc and insert directly.
 	 *
 	 */
-	if (conf && conf->loc_flags & LOC_F_NEW)
-		return lu_object_new(env, dev, f, conf);
-
 	s  = dev->ld_site;
 	hs = s->ls_obj_hash;
-	cfs_hash_bd_get_and_lock(hs, (void *)f, &bd, 1);
-	o = htable_lookup(s, &bd, f, &version);
-	cfs_hash_bd_unlock(hs, &bd, 1);
 
-	if (!IS_ERR(o) || PTR_ERR(o) != -ENOENT)
-		return o;
+	cfs_hash_bd_get(hs, f, &bd);
+	if (!(conf && conf->loc_flags & LOC_F_NEW)) {
+		cfs_hash_bd_lock(hs, &bd, 1);
+		o = htable_lookup(s, &bd, f, &version);
+		cfs_hash_bd_unlock(hs, &bd, 1);
 
+		if (!IS_ERR(o) || PTR_ERR(o) != -ENOENT)
+			return o;
+	}
 	/*
 	 * Allocate new object. This may result in rather complicated
 	 * operations, including fld queries, inode loading, etc.
@@ -764,7 +741,10 @@ struct lu_object *lu_object_find_at(const struct lu_env *env,
 
 	cfs_hash_bd_lock(hs, &bd, 1);
 
-	shadow = htable_lookup(s, &bd, f, &version);
+	if (conf && conf->loc_flags & LOC_F_NEW)
+		shadow = ERR_PTR(-ENOENT);
+	else
+		shadow = htable_lookup(s, &bd, f, &version);
 	if (likely(PTR_ERR(shadow) == -ENOENT)) {
 		cfs_hash_bd_add_locked(hs, &bd, &o->lo_header->loh_hash);
 		cfs_hash_bd_unlock(hs, &bd, 1);
