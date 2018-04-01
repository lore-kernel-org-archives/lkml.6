Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754485AbeDAUm4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:42:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753947AbeDAUmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:42:53 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 26/45] C++: Can't have variable/member names the same as
 typedef names
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:42:51 +0100
Message-ID: <152261537173.30503.11418276856826787681.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Type names in C++ share a namespace with variable names and member names,
so struct member names can't have the same name as their type.  Suffix
types with _t.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/backing-dev-defs.h |    4 +-
 include/linux/blkdev.h           |   86 +++++++++++++++++++-------------------
 include/linux/elevator.h         |   82 ++++++++++++++++++------------------
 include/linux/sysctl.h           |    6 +--
 4 files changed, 89 insertions(+), 89 deletions(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index bfe86b54f6c1..f412919a4c9a 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -33,7 +33,7 @@ enum wb_congested_state {
 	WB_sync_congested,	/* The sync queue is getting full */
 };
 
-typedef int (congested_fn)(void *, int);
+typedef int (congested_fn_t)(void *, int);
 
 enum wb_stat_item {
 	WB_RECLAIMABLE,
@@ -168,7 +168,7 @@ struct backing_dev_info {
 	struct list_head bdi_list;
 	unsigned long ra_pages;	/* max readahead in PAGE_SIZE units */
 	unsigned long io_pages;	/* max allowed IO size */
-	congested_fn *congested_fn; /* Function pointer if device is md/dm */
+	congested_fn_t *congested_fn; /* Function pointer if device is md/dm */
 	void *congested_data;	/* Pointer to aux data for congested func */
 
 	const char *name;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed63f3b69c12..e0486f768473 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -58,7 +58,7 @@ struct blk_stat_callback;
  */
 #define BLKCG_MAX_POLS		3
 
-typedef void (rq_end_io_fn)(struct request *, blk_status_t);
+typedef void (rq_end_io_fn_t)(struct request *, blk_status_t);
 
 #define BLK_RL_SYNCFULL		(1U << 0)
 #define BLK_RL_ASYNCFULL	(1U << 1)
@@ -199,7 +199,7 @@ struct request {
 		struct {
 			unsigned int		seq;
 			struct list_head	list;
-			rq_end_io_fn		*saved_end_io;
+			rq_end_io_fn_t		*saved_end_io;
 		} flush;
 	};
 
@@ -259,7 +259,7 @@ struct request {
 	/*
 	 * completion callback.
 	 */
-	rq_end_io_fn *end_io;
+	rq_end_io_fn_t *end_io;
 	void *end_io_data;
 
 	/* for bidi */
@@ -313,19 +313,19 @@ static inline unsigned short req_get_ioprio(struct request *req)
 
 struct blk_queue_ctx;
 
-typedef void (request_fn_proc) (struct request_queue *q);
-typedef blk_qc_t (make_request_fn) (struct request_queue *q, struct bio *bio);
-typedef bool (poll_q_fn) (struct request_queue *q, blk_qc_t);
-typedef int (prep_rq_fn) (struct request_queue *, struct request *);
-typedef void (unprep_rq_fn) (struct request_queue *, struct request *);
+typedef void (request_fn_proc_t) (struct request_queue *q);
+typedef blk_qc_t (make_request_fn_t) (struct request_queue *q, struct bio *bio);
+typedef bool (poll_q_fn_t) (struct request_queue *q, blk_qc_t);
+typedef int (prep_rq_fn_t) (struct request_queue *, struct request *);
+typedef void (unprep_rq_fn_t) (struct request_queue *, struct request *);
 
 struct bio_vec;
-typedef void (softirq_done_fn)(struct request *);
-typedef int (dma_drain_needed_fn)(struct request *);
-typedef int (lld_busy_fn) (struct request_queue *q);
-typedef int (bsg_job_fn) (struct bsg_job *);
-typedef int (init_rq_fn)(struct request_queue *, struct request *, gfp_t);
-typedef void (exit_rq_fn)(struct request_queue *, struct request *);
+typedef void (softirq_done_fn_t)(struct request *);
+typedef int (dma_drain_needed_fn_t)(struct request *);
+typedef int (lld_busy_fn_t) (struct request_queue *q);
+typedef int (bsg_job_fn_t) (struct bsg_job *);
+typedef int (init_rq_fn_t)(struct request_queue *, struct request *, gfp_t);
+typedef void (exit_rq_fn_t)(struct request_queue *, struct request *);
 
 enum blk_eh_timer_return {
 	BLK_EH_NOT_HANDLED,
@@ -333,7 +333,7 @@ enum blk_eh_timer_return {
 	BLK_EH_RESET_TIMER,
 };
 
-typedef enum blk_eh_timer_return (rq_timed_out_fn)(struct request *);
+typedef enum blk_eh_timer_return (rq_timed_out_fn_t)(struct request *);
 
 enum blk_queue_state {
 	Queue_down,
@@ -456,19 +456,19 @@ struct request_queue {
 	 */
 	struct request_list	root_rl;
 
-	request_fn_proc		*request_fn;
-	make_request_fn		*make_request_fn;
-	poll_q_fn		*poll_fn;
-	prep_rq_fn		*prep_rq_fn;
-	unprep_rq_fn		*unprep_rq_fn;
-	softirq_done_fn		*softirq_done_fn;
-	rq_timed_out_fn		*rq_timed_out_fn;
-	dma_drain_needed_fn	*dma_drain_needed;
-	lld_busy_fn		*lld_busy_fn;
+	request_fn_proc_t	*request_fn;
+	make_request_fn_t	*make_request_fn;
+	poll_q_fn_t		*poll_fn;
+	prep_rq_fn_t		*prep_rq_fn;
+	unprep_rq_fn_t		*unprep_rq_fn;
+	softirq_done_fn_t	*softirq_done_fn;
+	rq_timed_out_fn_t	*rq_timed_out_fn;
+	dma_drain_needed_fn_t	*dma_drain_needed;
+	lld_busy_fn_t		*lld_busy_fn;
 	/* Called just after a request is allocated */
-	init_rq_fn		*init_rq_fn;
+	init_rq_fn_t		*init_rq_fn;
 	/* Called just before a request is freed */
-	exit_rq_fn		*exit_rq_fn;
+	exit_rq_fn_t		*exit_rq_fn;
 	/* Called from inside blk_get_request() */
 	void (*initialize_rq_fn)(struct request *rq);
 
@@ -635,7 +635,7 @@ struct request_queue {
 	atomic_t		mq_freeze_depth;
 
 #if defined(CONFIG_BLK_DEV_BSG)
-	bsg_job_fn		*bsg_job_fn;
+	bsg_job_fn_t		*bsg_job_fn;
 	struct bsg_class_device bsg_dev;
 #endif
 
@@ -1067,7 +1067,7 @@ extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
 extern void blk_execute_rq(struct request_queue *, struct gendisk *,
 			  struct request *, int);
 extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
-				  struct request *, int, rq_end_io_fn *);
+				  struct request *, int, rq_end_io_fn_t *);
 
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
@@ -1235,12 +1235,12 @@ extern void blk_unprep_request(struct request *);
 /*
  * Access functions for manipulating queue properties
  */
-extern struct request_queue *blk_init_queue_node(request_fn_proc *rfn,
+extern struct request_queue *blk_init_queue_node(request_fn_proc_t *rfn,
 					spinlock_t *lock, int node_id);
-extern struct request_queue *blk_init_queue(request_fn_proc *, spinlock_t *);
+extern struct request_queue *blk_init_queue(request_fn_proc_t *, spinlock_t *);
 extern int blk_init_allocated_queue(struct request_queue *);
 extern void blk_cleanup_queue(struct request_queue *);
-extern void blk_queue_make_request(struct request_queue *, make_request_fn *);
+extern void blk_queue_make_request(struct request_queue *, make_request_fn_t *);
 extern void blk_queue_bounce_limit(struct request_queue *, u64);
 extern void blk_queue_max_hw_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
@@ -1275,17 +1275,17 @@ extern void blk_queue_stack_limits(struct request_queue *t, struct request_queue
 extern void blk_queue_dma_pad(struct request_queue *, unsigned int);
 extern void blk_queue_update_dma_pad(struct request_queue *, unsigned int);
 extern int blk_queue_dma_drain(struct request_queue *q,
-			       dma_drain_needed_fn *dma_drain_needed,
+			       dma_drain_needed_fn_t *dma_drain_needed,
 			       void *buf, unsigned int size);
-extern void blk_queue_lld_busy(struct request_queue *q, lld_busy_fn *fn);
+extern void blk_queue_lld_busy(struct request_queue *q, lld_busy_fn_t *fn);
 extern void blk_queue_segment_boundary(struct request_queue *, unsigned long);
 extern void blk_queue_virt_boundary(struct request_queue *, unsigned long);
-extern void blk_queue_prep_rq(struct request_queue *, prep_rq_fn *pfn);
-extern void blk_queue_unprep_rq(struct request_queue *, unprep_rq_fn *ufn);
+extern void blk_queue_prep_rq(struct request_queue *, prep_rq_fn_t *pfn);
+extern void blk_queue_unprep_rq(struct request_queue *, unprep_rq_fn_t *ufn);
 extern void blk_queue_dma_alignment(struct request_queue *, int);
 extern void blk_queue_update_dma_alignment(struct request_queue *, int);
-extern void blk_queue_softirq_done(struct request_queue *, softirq_done_fn *);
-extern void blk_queue_rq_timed_out(struct request_queue *, rq_timed_out_fn *);
+extern void blk_queue_softirq_done(struct request_queue *, softirq_done_fn_t *);
+extern void blk_queue_rq_timed_out(struct request_queue *, rq_timed_out_fn_t *);
 extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
 extern void blk_queue_flush_queueable(struct request_queue *q, bool queueable);
 extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
@@ -1369,13 +1369,13 @@ struct blk_plug {
 #define BLK_PLUG_FLUSH_SIZE (128 * 1024)
 
 struct blk_plug_cb;
-typedef void (*blk_plug_cb_fn)(struct blk_plug_cb *, bool);
+typedef void (*blk_plug_cb_fn_t)(struct blk_plug_cb *, bool);
 struct blk_plug_cb {
 	struct list_head list;
-	blk_plug_cb_fn callback;
+	blk_plug_cb_fn_t callback;
 	void *data;
 };
-extern struct blk_plug_cb *blk_check_plugged(blk_plug_cb_fn unplug,
+extern struct blk_plug_cb *blk_check_plugged(blk_plug_cb_fn_t unplug,
 					     void *data, int size);
 extern void blk_start_plug(struct blk_plug *);
 extern void blk_finish_plug(struct blk_plug *);
@@ -1884,11 +1884,11 @@ struct blk_integrity_iter {
 	const char		*disk_name;
 };
 
-typedef blk_status_t (integrity_processing_fn) (struct blk_integrity_iter *);
+typedef blk_status_t (integrity_processing_fn_t) (struct blk_integrity_iter *);
 
 struct blk_integrity_profile {
-	integrity_processing_fn		*generate_fn;
-	integrity_processing_fn		*verify_fn;
+	integrity_processing_fn_t	*generate_fn;
+	integrity_processing_fn_t	*verify_fn;
 	const char			*name;
 };
 
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 6d9e230dffd2..87702b83acb6 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -23,72 +23,72 @@ enum elv_merge {
 	ELEVATOR_DISCARD_MERGE	= 3,
 };
 
-typedef enum elv_merge (elevator_merge_fn) (struct request_queue *, struct request **,
+typedef enum elv_merge (elevator_merge_fn_t) (struct request_queue *, struct request **,
 				 struct bio *);
 
-typedef void (elevator_merge_req_fn) (struct request_queue *, struct request *, struct request *);
+typedef void (elevator_merge_req_fn_t) (struct request_queue *, struct request *, struct request *);
 
-typedef void (elevator_merged_fn) (struct request_queue *, struct request *, enum elv_merge);
+typedef void (elevator_merged_fn_t) (struct request_queue *, struct request *, enum elv_merge);
 
-typedef int (elevator_allow_bio_merge_fn) (struct request_queue *,
+typedef int (elevator_allow_bio_merge_fn_t) (struct request_queue *,
 					   struct request *, struct bio *);
 
-typedef int (elevator_allow_rq_merge_fn) (struct request_queue *,
+typedef int (elevator_allow_rq_merge_fn_t) (struct request_queue *,
 					  struct request *, struct request *);
 
-typedef void (elevator_bio_merged_fn) (struct request_queue *,
+typedef void (elevator_bio_merged_fn_t) (struct request_queue *,
 						struct request *, struct bio *);
 
-typedef int (elevator_dispatch_fn) (struct request_queue *, int);
+typedef int (elevator_dispatch_fn_t) (struct request_queue *, int);
 
-typedef void (elevator_add_req_fn) (struct request_queue *, struct request *);
-typedef struct request *(elevator_request_list_fn) (struct request_queue *, struct request *);
-typedef void (elevator_completed_req_fn) (struct request_queue *, struct request *);
-typedef int (elevator_may_queue_fn) (struct request_queue *, unsigned int);
+typedef void (elevator_add_req_fn_t) (struct request_queue *, struct request *);
+typedef struct request *(elevator_request_list_fn_t) (struct request_queue *, struct request *);
+typedef void (elevator_completed_req_fn_t) (struct request_queue *, struct request *);
+typedef int (elevator_may_queue_fn_t) (struct request_queue *, unsigned int);
 
-typedef void (elevator_init_icq_fn) (struct io_cq *);
-typedef void (elevator_exit_icq_fn) (struct io_cq *);
-typedef int (elevator_set_req_fn) (struct request_queue *, struct request *,
+typedef void (elevator_init_icq_fn_t) (struct io_cq *);
+typedef void (elevator_exit_icq_fn_t) (struct io_cq *);
+typedef int (elevator_set_req_fn_t) (struct request_queue *, struct request *,
 				   struct bio *, gfp_t);
-typedef void (elevator_put_req_fn) (struct request *);
-typedef void (elevator_activate_req_fn) (struct request_queue *, struct request *);
-typedef void (elevator_deactivate_req_fn) (struct request_queue *, struct request *);
+typedef void (elevator_put_req_fn_t) (struct request *);
+typedef void (elevator_activate_req_fn_t) (struct request_queue *, struct request *);
+typedef void (elevator_deactivate_req_fn_t) (struct request_queue *, struct request *);
 
-typedef int (elevator_init_fn) (struct request_queue *,
+typedef int (elevator_init_fn_t) (struct request_queue *,
 				struct elevator_type *e);
-typedef void (elevator_exit_fn) (struct elevator_queue *);
-typedef void (elevator_registered_fn) (struct request_queue *);
+typedef void (elevator_exit_fn_t) (struct elevator_queue *);
+typedef void (elevator_registered_fn_t) (struct request_queue *);
 
 struct elevator_ops
 {
-	elevator_merge_fn *elevator_merge_fn;
-	elevator_merged_fn *elevator_merged_fn;
-	elevator_merge_req_fn *elevator_merge_req_fn;
-	elevator_allow_bio_merge_fn *elevator_allow_bio_merge_fn;
-	elevator_allow_rq_merge_fn *elevator_allow_rq_merge_fn;
-	elevator_bio_merged_fn *elevator_bio_merged_fn;
+	elevator_merge_fn_t *elevator_merge_fn;
+	elevator_merged_fn_t *elevator_merged_fn;
+	elevator_merge_req_fn_t *elevator_merge_req_fn;
+	elevator_allow_bio_merge_fn_t *elevator_allow_bio_merge_fn;
+	elevator_allow_rq_merge_fn_t *elevator_allow_rq_merge_fn;
+	elevator_bio_merged_fn_t *elevator_bio_merged_fn;
 
-	elevator_dispatch_fn *elevator_dispatch_fn;
-	elevator_add_req_fn *elevator_add_req_fn;
-	elevator_activate_req_fn *elevator_activate_req_fn;
-	elevator_deactivate_req_fn *elevator_deactivate_req_fn;
+	elevator_dispatch_fn_t *elevator_dispatch_fn;
+	elevator_add_req_fn_t *elevator_add_req_fn;
+	elevator_activate_req_fn_t *elevator_activate_req_fn;
+	elevator_deactivate_req_fn_t *elevator_deactivate_req_fn;
 
-	elevator_completed_req_fn *elevator_completed_req_fn;
+	elevator_completed_req_fn_t *elevator_completed_req_fn;
 
-	elevator_request_list_fn *elevator_former_req_fn;
-	elevator_request_list_fn *elevator_latter_req_fn;
+	elevator_request_list_fn_t *elevator_former_req_fn;
+	elevator_request_list_fn_t *elevator_latter_req_fn;
 
-	elevator_init_icq_fn *elevator_init_icq_fn;	/* see iocontext.h */
-	elevator_exit_icq_fn *elevator_exit_icq_fn;	/* ditto */
+	elevator_init_icq_fn_t *elevator_init_icq_fn;	/* see iocontext.h */
+	elevator_exit_icq_fn_t *elevator_exit_icq_fn;	/* ditto */
 
-	elevator_set_req_fn *elevator_set_req_fn;
-	elevator_put_req_fn *elevator_put_req_fn;
+	elevator_set_req_fn_t *elevator_set_req_fn;
+	elevator_put_req_fn_t *elevator_put_req_fn;
 
-	elevator_may_queue_fn *elevator_may_queue_fn;
+	elevator_may_queue_fn_t *elevator_may_queue_fn;
 
-	elevator_init_fn *elevator_init_fn;
-	elevator_exit_fn *elevator_exit_fn;
-	elevator_registered_fn *elevator_registered_fn;
+	elevator_init_fn_t *elevator_init_fn;
+	elevator_exit_fn_t *elevator_exit_fn;
+	elevator_registered_fn_t *elevator_registered_fn;
 };
 
 struct blk_mq_alloc_data;
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index b769ecfcc3bd..3c551fda1853 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -37,8 +37,8 @@ struct ctl_table_root;
 struct ctl_table_header;
 struct ctl_dir;
 
-typedef int proc_handler (struct ctl_table *ctl, int write,
-			  void __user *buffer, size_t *lenp, loff_t *ppos);
+typedef int (*proc_handler_t)(struct ctl_table *ctl, int write,
+			      void __user *buffer, size_t *lenp, loff_t *ppos);
 
 extern int proc_dostring(struct ctl_table *, int,
 			 void __user *, size_t *, loff_t *);
@@ -117,7 +117,7 @@ struct ctl_table
 	int maxlen;
 	umode_t mode;
 	struct ctl_table *child;	/* Deprecated */
-	proc_handler *proc_handler;	/* Callback for text formatting */
+	proc_handler_t proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
 	void *extra1;
 	void *extra2;
