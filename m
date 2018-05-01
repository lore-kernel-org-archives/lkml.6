Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZo+UJLdcnucyYjq7I2LlLRE9QTE2CVH3LRIyUl/Z2NuEtiE2CfZHk78xdb411sFPntLCf8I
ARC-Seal: i=1; a=rsa-sha256; t=1525146795; cv=none;
        d=google.com; s=arc-20160816;
        b=YkoTIkUE3X8FXLtmn0HfgyJ2BYIT1oR1uVZAll+o0jyoijoLfidxnDFzQb82r7op+1
         H+0+gZKN3fNRNiiQETTHLqK9vV/4iT1KabWmcG9c1tMFAWMLhbH2Bgs3kafN1iT5SoLO
         +AhtX37yT8HKGESg6miKCsBgVMhMLoINiBPomAU+B30gYlERjT6JeWlpg56hXfafTw15
         hc2YsusBgBOhNQPdDgXPT2/LLEvbBWm6BDGFIGfEOv/MxRsbZG+pYTXhxQwzsonFu8yl
         VvawMFh9zky1MTEYG4Na/U1WQd7irXKJ4QhAESodf3JLZItLOgVUQjwgjwGV25AYT3rl
         AfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=Db1slQnVTbwgari4gmCxcTFtU9Z0R/kqYAJj7aGX5PE=;
        b=knQKCH1i2aE3LzUnHrwbQ5S9z+AoShvmvmGIA/DixDJFh7/II+KKVAxtzLW5qS41Qc
         cP+9b1R6qi3+gnIQpAkDN79JNnlfarNVFmHRkucqQWrJ0mW72Mxntz+qRYP7p6GTpxyV
         zBoy2Zal13W32kmgU+JJUcuD60z1ZzosYSzvZ5nDXSM4UqgUcNusXr/OEo7Yajxdk0Rz
         oxvV4SwYEFn9xlaldPL/Jey9IFQj1Un8XbTaTUw4a989n0o/wAxy5eEnj/xfJwpkq/g3
         hW1dacCElqkeyKKwbipoyKTOr7zr3BswoLdYGWH+clyEKjJyhXub9ftGnlazB+gn75k3
         fNng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Tue, 01 May 2018 13:52:38 +1000
Subject: [PATCH 02/10] staging: lustre: make struct lu_site_bkt_data private
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152514675889.17843.8198702967686860985.stgit@noble>
In-Reply-To: <152514658325.17843.11455067361317157487.stgit@noble>
References: <152514658325.17843.11455067361317157487.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232325950422032?=
X-GMAIL-MSGID: =?utf-8?q?1599232325950422032?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This data structure only needs to be public so that
various modules can access a wait queue to wait for object
destruction.
If we provide a function to get the wait queue, rather than the
whole bucket, the structure can be made private.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/include/lu_object.h  |   36 +-------------
 drivers/staging/lustre/lustre/llite/lcommon_cl.c   |    8 ++-
 drivers/staging/lustre/lustre/lov/lov_object.c     |    8 ++-
 drivers/staging/lustre/lustre/obdclass/lu_object.c |   50 +++++++++++++++++---
 4 files changed, 54 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/lustre/lustre/include/lu_object.h b/drivers/staging/lustre/lustre/include/lu_object.h
index c3b0ed518819..f29bbca5af65 100644
--- a/drivers/staging/lustre/lustre/include/lu_object.h
+++ b/drivers/staging/lustre/lustre/include/lu_object.h
@@ -549,31 +549,7 @@ struct lu_object_header {
 };
 
 struct fld;
-
-struct lu_site_bkt_data {
-	/**
-	 * number of object in this bucket on the lsb_lru list.
-	 */
-	long			lsb_lru_len;
-	/**
-	 * LRU list, updated on each access to object. Protected by
-	 * bucket lock of lu_site::ls_obj_hash.
-	 *
-	 * "Cold" end of LRU is lu_site::ls_lru.next. Accessed object are
-	 * moved to the lu_site::ls_lru.prev (this is due to the non-existence
-	 * of list_for_each_entry_safe_reverse()).
-	 */
-	struct list_head		lsb_lru;
-	/**
-	 * Wait-queue signaled when an object in this site is ultimately
-	 * destroyed (lu_object_free()). It is used by lu_object_find() to
-	 * wait before re-trying when object in the process of destruction is
-	 * found in the hash table.
-	 *
-	 * \see htable_lookup().
-	 */
-	wait_queue_head_t	       lsb_marche_funebre;
-};
+struct lu_site_bkt_data;
 
 enum {
 	LU_SS_CREATED	 = 0,
@@ -642,14 +618,8 @@ struct lu_site {
 	struct percpu_counter	 ls_lru_len_counter;
 };
 
-static inline struct lu_site_bkt_data *
-lu_site_bkt_from_fid(struct lu_site *site, struct lu_fid *fid)
-{
-	struct cfs_hash_bd bd;
-
-	cfs_hash_bd_get(site->ls_obj_hash, fid, &bd);
-	return cfs_hash_bd_extra_get(site->ls_obj_hash, &bd);
-}
+wait_queue_head_t *
+lu_site_wq_from_fid(struct lu_site *site, struct lu_fid *fid);
 
 static inline struct seq_server_site *lu_site2seq(const struct lu_site *s)
 {
diff --git a/drivers/staging/lustre/lustre/llite/lcommon_cl.c b/drivers/staging/lustre/lustre/llite/lcommon_cl.c
index df5c0c0ae703..d5b42fb1d601 100644
--- a/drivers/staging/lustre/lustre/llite/lcommon_cl.c
+++ b/drivers/staging/lustre/lustre/llite/lcommon_cl.c
@@ -211,12 +211,12 @@ static void cl_object_put_last(struct lu_env *env, struct cl_object *obj)
 
 	if (unlikely(atomic_read(&header->loh_ref) != 1)) {
 		struct lu_site *site = obj->co_lu.lo_dev->ld_site;
-		struct lu_site_bkt_data *bkt;
+		wait_queue_head_t *wq;
 
-		bkt = lu_site_bkt_from_fid(site, &header->loh_fid);
+		wq = lu_site_wq_from_fid(site, &header->loh_fid);
 
 		init_waitqueue_entry(&waiter, current);
-		add_wait_queue(&bkt->lsb_marche_funebre, &waiter);
+		add_wait_queue(wq, &waiter);
 
 		while (1) {
 			set_current_state(TASK_UNINTERRUPTIBLE);
@@ -226,7 +226,7 @@ static void cl_object_put_last(struct lu_env *env, struct cl_object *obj)
 		}
 
 		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&bkt->lsb_marche_funebre, &waiter);
+		remove_wait_queue(wq, &waiter);
 	}
 
 	cl_object_put(env, obj);
diff --git a/drivers/staging/lustre/lustre/lov/lov_object.c b/drivers/staging/lustre/lustre/lov/lov_object.c
index f7c69680cb7d..adc90f310fd7 100644
--- a/drivers/staging/lustre/lustre/lov/lov_object.c
+++ b/drivers/staging/lustre/lustre/lov/lov_object.c
@@ -370,7 +370,7 @@ static void lov_subobject_kill(const struct lu_env *env, struct lov_object *lov,
 	struct cl_object	*sub;
 	struct lov_layout_raid0 *r0;
 	struct lu_site	  *site;
-	struct lu_site_bkt_data *bkt;
+	wait_queue_head_t *wq;
 	wait_queue_entry_t	  *waiter;
 
 	r0  = &lov->u.raid0;
@@ -378,7 +378,7 @@ static void lov_subobject_kill(const struct lu_env *env, struct lov_object *lov,
 
 	sub  = lovsub2cl(los);
 	site = sub->co_lu.lo_dev->ld_site;
-	bkt  = lu_site_bkt_from_fid(site, &sub->co_lu.lo_header->loh_fid);
+	wq   = lu_site_wq_from_fid(site, &sub->co_lu.lo_header->loh_fid);
 
 	cl_object_kill(env, sub);
 	/* release a reference to the sub-object and ... */
@@ -391,7 +391,7 @@ static void lov_subobject_kill(const struct lu_env *env, struct lov_object *lov,
 	if (r0->lo_sub[idx] == los) {
 		waiter = &lov_env_info(env)->lti_waiter;
 		init_waitqueue_entry(waiter, current);
-		add_wait_queue(&bkt->lsb_marche_funebre, waiter);
+		add_wait_queue(wq, waiter);
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		while (1) {
 			/* this wait-queue is signaled at the end of
@@ -408,7 +408,7 @@ static void lov_subobject_kill(const struct lu_env *env, struct lov_object *lov,
 				break;
 			}
 		}
-		remove_wait_queue(&bkt->lsb_marche_funebre, waiter);
+		remove_wait_queue(wq, waiter);
 	}
 	LASSERT(!r0->lo_sub[idx]);
 }
diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
index 3de7dc0497c4..2a8a25d6edb5 100644
--- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
@@ -56,6 +56,31 @@
 #include <lu_ref.h>
 #include <linux/list.h>
 
+struct lu_site_bkt_data {
+	/**
+	 * number of object in this bucket on the lsb_lru list.
+	 */
+	long			lsb_lru_len;
+	/**
+	 * LRU list, updated on each access to object. Protected by
+	 * bucket lock of lu_site::ls_obj_hash.
+	 *
+	 * "Cold" end of LRU is lu_site::ls_lru.next. Accessed object are
+	 * moved to the lu_site::ls_lru.prev (this is due to the non-existence
+	 * of list_for_each_entry_safe_reverse()).
+	 */
+	struct list_head		lsb_lru;
+	/**
+	 * Wait-queue signaled when an object in this site is ultimately
+	 * destroyed (lu_object_free()). It is used by lu_object_find() to
+	 * wait before re-trying when object in the process of destruction is
+	 * found in the hash table.
+	 *
+	 * \see htable_lookup().
+	 */
+	wait_queue_head_t	       lsb_marche_funebre;
+};
+
 enum {
 	LU_CACHE_PERCENT_MAX	 = 50,
 	LU_CACHE_PERCENT_DEFAULT = 20
@@ -88,6 +113,17 @@ MODULE_PARM_DESC(lu_cache_nr, "Maximum number of objects in lu_object cache");
 static void lu_object_free(const struct lu_env *env, struct lu_object *o);
 static __u32 ls_stats_read(struct lprocfs_stats *stats, int idx);
 
+wait_queue_head_t *
+lu_site_wq_from_fid(struct lu_site *site, struct lu_fid *fid)
+{
+	struct cfs_hash_bd bd;
+	struct lu_site_bkt_data *bkt;
+
+	cfs_hash_bd_get(site->ls_obj_hash, fid, &bd);
+	bkt = cfs_hash_bd_extra_get(site->ls_obj_hash, &bd);
+	return &bkt->lsb_marche_funebre;
+}
+
 /**
  * Decrease reference counter on object. If last reference is freed, return
  * object to the cache, unless lu_object_is_dying(o) holds. In the latter
@@ -288,7 +324,7 @@ static struct lu_object *lu_object_alloc(const struct lu_env *env,
  */
 static void lu_object_free(const struct lu_env *env, struct lu_object *o)
 {
-	struct lu_site_bkt_data *bkt;
+	wait_queue_head_t *wq;
 	struct lu_site	  *site;
 	struct lu_object	*scan;
 	struct list_head	      *layers;
@@ -296,7 +332,7 @@ static void lu_object_free(const struct lu_env *env, struct lu_object *o)
 
 	site   = o->lo_dev->ld_site;
 	layers = &o->lo_header->loh_layers;
-	bkt    = lu_site_bkt_from_fid(site, &o->lo_header->loh_fid);
+	wq     = lu_site_wq_from_fid(site, &o->lo_header->loh_fid);
 	/*
 	 * First call ->loo_object_delete() method to release all resources.
 	 */
@@ -324,8 +360,8 @@ static void lu_object_free(const struct lu_env *env, struct lu_object *o)
 		o->lo_ops->loo_object_free(env, o);
 	}
 
-	if (waitqueue_active(&bkt->lsb_marche_funebre))
-		wake_up_all(&bkt->lsb_marche_funebre);
+	if (waitqueue_active(wq))
+		wake_up_all(wq);
 }
 
 /**
@@ -749,7 +785,7 @@ struct lu_object *lu_object_find_at(const struct lu_env *env,
 				    const struct lu_fid *f,
 				    const struct lu_object_conf *conf)
 {
-	struct lu_site_bkt_data *bkt;
+	wait_queue_head_t	*wq;
 	struct lu_object	*obj;
 	wait_queue_entry_t	   wait;
 
@@ -762,8 +798,8 @@ struct lu_object *lu_object_find_at(const struct lu_env *env,
 		 * wait queue.
 		 */
 		schedule();
-		bkt = lu_site_bkt_from_fid(dev->ld_site, (void *)f);
-		remove_wait_queue(&bkt->lsb_marche_funebre, &wait);
+		wq = lu_site_wq_from_fid(dev->ld_site, (void *)f);
+		remove_wait_queue(wq, &wait);
 	}
 }
 EXPORT_SYMBOL(lu_object_find_at);
