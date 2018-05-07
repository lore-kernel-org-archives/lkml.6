Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZoPXINYkOEWxB5YMdMe2XR9n8E7I4AhoFs/8XMv5loj8kCrZ1dDE8QZO33+TGeUeOQoKkDS
ARC-Seal: i=1; a=rsa-sha256; t=1525654551; cv=none;
        d=google.com; s=arc-20160816;
        b=DqdQKl+rZ1v/A2dDjoJgK2jZIkpHtf682gVN51vKAflwNBlxJF2nIwbIVPB8UJbFa6
         EeCY5b7HNlmrbFh/0K0iL6uOGELm8Uxq7vAeTCZx866GFPSoyjr2AYWdoyQlsFGSR1pU
         RnESh3+qKUIizB0Jb7SQlHKgVWQnCzLDUP5CkuiGQFf7bqkVIbOGBCTAeg2BmQKJGuHE
         e+ZK1iLsRsRnc6GI1A7dKzVeEka6v9PMotbX+MfBqUaxri0onYysqvbhif4aFa+jEO0m
         mjRpRRePD/NSl7uztpuL7HtYL1TKitJ7AioOC5xbHWXZSuD8bsrdrLJ0RhMx1nUE24X0
         C1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=4T+WQJVTz+MP7rSzhnQpZUVmZBp2Ib3E706OL7HJoKI=;
        b=R8Rv6eG4v57tmpvYCy5+06gBeiWGi3W4A97609fuHxiGIY5jc0ttfjj5jL08emKqEQ
         qVBDaG7iW3ujNWJtm4+DUc8JyjsG0dk7OHCMfBKSwBJa1zq9f2QAOKLyM23mHSf4f4Is
         Ia47u3SS9EQe71PgtGesU+jW8LIi1rj1iRPSJrqz/OFuWQkAXocYu0q/tVbBHh1WkgJY
         hwDAZBp7AR7imFHV16ZHo7qCELPfPhiR/INhi73qCCNJNYL6v/siWwUTHMOU0jfAXvjS
         IpNEAEu4MjeNwIHvXwqREf/7h2JbwhIWbUDM9+ZdJn+Mbp9g6YuqBCNvOlpUu0mOwX76
         ecew==
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
Subject: [PATCH 04/10] staging: lustre: lu_object: move retry logic inside
 htable_lookup
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152565448811.30131.18427155547615728371.stgit@noble>
In-Reply-To: <152565436690.30131.2229703651041382739.stgit@noble>
References: <152565436690.30131.2229703651041382739.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599764746935488075?=
X-GMAIL-MSGID: =?utf-8?q?1599764746935488075?=
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
 drivers/staging/lustre/lustre/obdclass/lu_object.c |   70 ++++++++------------
 1 file changed, 27 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
index bf5b309edeae..0c9419a6d5d6 100644
--- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
@@ -584,16 +584,24 @@ void lu_object_print(const struct lu_env *env, void *cookie,
 }
 EXPORT_SYMBOL(lu_object_print);
 
+/*
+ * NOTE: htable_lookup() is called with the relevant
+ * hash bucket locked, but might drop and re-acquire the lock.
+ */
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
+
+retry:
+	ver = cfs_hash_bd_version_get(bd);
 
 	if (*version == ver)
 		return ERR_PTR(-ENOENT);
@@ -626,11 +634,15 @@ static struct lu_object *htable_lookup(struct lu_site *s,
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
@@ -694,13 +706,14 @@ static struct lu_object *lu_object_new(const struct lu_env *env,
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
@@ -726,8 +739,6 @@ static struct lu_object *lu_object_find_try(const struct lu_env *env,
 	 * It is unnecessary to perform lookup-alloc-lookup-insert, instead,
 	 * just alloc and insert directly.
 	 *
-	 * If dying object is found during index search, add @waiter to the
-	 * site wait-queue and return ERR_PTR(-EAGAIN).
 	 */
 	if (conf && conf->loc_flags & LOC_F_NEW)
 		return lu_object_new(env, dev, f, conf);
@@ -735,8 +746,9 @@ static struct lu_object *lu_object_find_try(const struct lu_env *env,
 	s  = dev->ld_site;
 	hs = s->ls_obj_hash;
 	cfs_hash_bd_get_and_lock(hs, (void *)f, &bd, 1);
-	o = htable_lookup(s, &bd, f, waiter, &version);
+	o = htable_lookup(s, &bd, f, &version);
 	cfs_hash_bd_unlock(hs, &bd, 1);
+
 	if (!IS_ERR(o) || PTR_ERR(o) != -ENOENT)
 		return o;
 
@@ -752,7 +764,7 @@ static struct lu_object *lu_object_find_try(const struct lu_env *env,
 
 	cfs_hash_bd_lock(hs, &bd, 1);
 
-	shadow = htable_lookup(s, &bd, f, waiter, &version);
+	shadow = htable_lookup(s, &bd, f, &version);
 	if (likely(PTR_ERR(shadow) == -ENOENT)) {
 		cfs_hash_bd_add_locked(hs, &bd, &o->lo_header->loh_hash);
 		cfs_hash_bd_unlock(hs, &bd, 1);
@@ -767,34 +779,6 @@ static struct lu_object *lu_object_find_try(const struct lu_env *env,
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
