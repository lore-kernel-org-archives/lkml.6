Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZqoJhtCYGTvvR1WgDTkhnbugT2MPlBYoiLKqr59GCEBVbP0FK7FzU6zUFX9jQIVz9Z7HPL6
ARC-Seal: i=1; a=rsa-sha256; t=1525146810; cv=none;
        d=google.com; s=arc-20160816;
        b=WAam8zzoM8c44P6oB/cmN7vv3AzqIkOQlrfxP0S89Ar9Il/zNbfMpOJfXJ7wFNVu2J
         kUJVw/IUBRCnh6CZNld60bVyFL+6lixkrBjFZ8D7J05P0Whb1CphKKxwPMMvDMR2Eh20
         Jc07D7rYsmMtt3UauuMfTuoxr36UG6Ez3EzGp07nIUml+oWdkKO7Irc22U+Ml/0z8OFq
         bS5Lmy0ngofW4cudxbd4ZJYcaSferZDKom+jWTk3Hxdug0ETaQmfRNjpcP6S5hMhr9fO
         TI2rWy7v4H0F9wwq7QMSPZGJHB10p1SyI7HZOcgm/IpOOyiQqRwjFssv3z7bX7S1y7O/
         zekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=BtOYFDE5mqZysnSSWYo+8LSAUNHEZN1iubJY4vWLekM=;
        b=hpjSeUlibgZvpaAkIidRSQd+BaxFJV2lFDzk8JznaGIyOw4HFs3D/OhKK3WNCxFT3H
         +KYm36IFT6gIjRB/yHHeCeA5jvYH4U7Xdgu+tPFIMYyDUBkmc0YRKUyn/BvFeLIrxwaC
         dcpYJvsuqmqXSZfwA8rJsR85SXxOjb7bAhWx68s2dVM6AlV97OP+l+r42MVZ53HCM6/w
         CqA8fLUHZ0e9NpqUumKRK+Ma4pKLE5qj01bU1938DGwfLlLusml9tf+NRARh3Nq5eco5
         TlItotEHghEf0z/VGGPJLSNZOvIf2OJAAPo+/Ep0uq3/0yetM2lR6KmXbu5VKFHYGeN5
         UgJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Tue, 01 May 2018 13:52:39 +1000
Subject: [PATCH 04/10] staging: lustre: lu_object: move retry logic inside
 htable_lookup
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152514675897.17843.15112214060540196720.stgit@noble>
In-Reply-To: <152514658325.17843.11455067361317157487.stgit@noble>
References: <152514658325.17843.11455067361317157487.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232342096971957?=
X-GMAIL-MSGID: =?utf-8?q?1599232342096971957?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The current retry logic, to wait when a 'dying' object is found,
spans multiple functions.  The process is attached to a waitqueue
and set TASK_UNINTERRUPTIBLE in htable_lookup, and this status
is passed back through lu_object_find_try() to lu_object_find_at()
where schedule() is called and the process is removed from the queue.

This can be simplified by moving all the logic (including
hashtable locking) inside htable_lookup(), which now never returns
EAGAIN.

Note that htable_lookup() is called with the hash bucket lock
held, and will drop and retake it if it needs to schedule.

I made this a 'goto' loop rather than a 'while(1)' loop as the
diff is easier to read.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/obdclass/lu_object.c |   73 +++++++-------------
 1 file changed, 27 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
index 2bf089817157..93daa52e2535 100644
--- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
@@ -586,16 +586,21 @@ EXPORT_SYMBOL(lu_object_print);
 static struct lu_object *htable_lookup(struct lu_site *s,
 				       struct cfs_hash_bd *bd,
 				       const struct lu_fid *f,
-				       wait_queue_entry_t *waiter,
 				       __u64 *version)
 {
+	struct cfs_hash		*hs = s->ls_obj_hash;
 	struct lu_site_bkt_data *bkt;
 	struct lu_object_header *h;
 	struct hlist_node	*hnode;
-	__u64  ver = cfs_hash_bd_version_get(bd);
+	__u64 ver;
+	wait_queue_entry_t waiter;
 
-	if (*version == ver)
+retry:
+	ver = cfs_hash_bd_version_get(bd);
+
+	if (*version == ver) {
 		return ERR_PTR(-ENOENT);
+	}
 
 	*version = ver;
 	bkt = cfs_hash_bd_extra_get(s->ls_obj_hash, bd);
@@ -625,11 +630,15 @@ static struct lu_object *htable_lookup(struct lu_site *s,
 	 * drained), and moreover, lookup has to wait until object is freed.
 	 */
 
-	init_waitqueue_entry(waiter, current);
-	add_wait_queue(&bkt->lsb_marche_funebre, waiter);
+	init_waitqueue_entry(&waiter, current);
+	add_wait_queue(&bkt->lsb_marche_funebre, &waiter);
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_DEATH_RACE);
-	return ERR_PTR(-EAGAIN);
+	cfs_hash_bd_unlock(hs, bd, 1);
+	schedule();
+	remove_wait_queue(&bkt->lsb_marche_funebre, &waiter);
+	cfs_hash_bd_lock(hs, bd, 1);
+	goto retry;
 }
 
 /**
@@ -693,13 +702,14 @@ static struct lu_object *lu_object_new(const struct lu_env *env,
 }
 
 /**
- * Core logic of lu_object_find*() functions.
+ * Much like lu_object_find(), but top level device of object is specifically
+ * \a dev rather than top level device of the site. This interface allows
+ * objects of different "stacking" to be created within the same site.
  */
-static struct lu_object *lu_object_find_try(const struct lu_env *env,
-					    struct lu_device *dev,
-					    const struct lu_fid *f,
-					    const struct lu_object_conf *conf,
-					    wait_queue_entry_t *waiter)
+struct lu_object *lu_object_find_at(const struct lu_env *env,
+				    struct lu_device *dev,
+				    const struct lu_fid *f,
+				    const struct lu_object_conf *conf)
 {
 	struct lu_object      *o;
 	struct lu_object      *shadow;
@@ -725,17 +735,16 @@ static struct lu_object *lu_object_find_try(const struct lu_env *env,
 	 * It is unnecessary to perform lookup-alloc-lookup-insert, instead,
 	 * just alloc and insert directly.
 	 *
-	 * If dying object is found during index search, add @waiter to the
-	 * site wait-queue and return ERR_PTR(-EAGAIN).
 	 */
 	if (conf && conf->loc_flags & LOC_F_NEW)
 		return lu_object_new(env, dev, f, conf);
 
 	s  = dev->ld_site;
 	hs = s->ls_obj_hash;
-	cfs_hash_bd_get_and_lock(hs, (void *)f, &bd, 1);
-	o = htable_lookup(s, &bd, f, waiter, &version);
-	cfs_hash_bd_unlock(hs, &bd, 1);
+	cfs_hash_bd_get_and_lock(hs, (void *)f, &bd, 0);
+	o = htable_lookup(s, &bd, f, &version);
+	cfs_hash_bd_unlock(hs, &bd, 0);
+
 	if (!IS_ERR(o) || PTR_ERR(o) != -ENOENT)
 		return o;
 
@@ -751,7 +760,7 @@ static struct lu_object *lu_object_find_try(const struct lu_env *env,
 
 	cfs_hash_bd_lock(hs, &bd, 1);
 
-	shadow = htable_lookup(s, &bd, f, waiter, &version);
+	shadow = htable_lookup(s, &bd, f, &version);
 	if (likely(PTR_ERR(shadow) == -ENOENT)) {
 		cfs_hash_bd_add_locked(hs, &bd, &o->lo_header->loh_hash);
 		cfs_hash_bd_unlock(hs, &bd, 1);
@@ -766,34 +775,6 @@ static struct lu_object *lu_object_find_try(const struct lu_env *env,
 	lu_object_free(env, o);
 	return shadow;
 }
-
-/**
- * Much like lu_object_find(), but top level device of object is specifically
- * \a dev rather than top level device of the site. This interface allows
- * objects of different "stacking" to be created within the same site.
- */
-struct lu_object *lu_object_find_at(const struct lu_env *env,
-				    struct lu_device *dev,
-				    const struct lu_fid *f,
-				    const struct lu_object_conf *conf)
-{
-	wait_queue_head_t	*wq;
-	struct lu_object	*obj;
-	wait_queue_entry_t	   wait;
-
-	while (1) {
-		obj = lu_object_find_try(env, dev, f, conf, &wait);
-		if (obj != ERR_PTR(-EAGAIN))
-			return obj;
-		/*
-		 * lu_object_find_try() already added waiter into the
-		 * wait queue.
-		 */
-		schedule();
-		wq = lu_site_wq_from_fid(dev->ld_site, (void *)f);
-		remove_wait_queue(wq, &wait);
-	}
-}
 EXPORT_SYMBOL(lu_object_find_at);
 
 /**
