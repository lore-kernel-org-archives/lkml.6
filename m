Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03CAC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77AF2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394536AbfBMUMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:12:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfBMUMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:12:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E997481F18;
        Wed, 13 Feb 2019 20:12:17 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA04A60C54;
        Wed, 13 Feb 2019 20:12:17 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id CB2C93F7CB;
        Wed, 13 Feb 2019 20:12:17 +0000 (UTC)
Date:   Wed, 13 Feb 2019 15:12:17 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Abhi Das <adas@redhat.com>
Message-ID: <1807290709.884837.1550088737752.JavaMail.zimbra@redhat.com>
In-Reply-To: <1478866769.884638.1550088645315.JavaMail.zimbra@redhat.com>
Subject: [PATCH] Revert "gfs2: read journal in large chunks to locate the
 head"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.69, 10.4.195.7]
Thread-Topic: Revert "gfs2: read journal in large chunks to locate the head"
Thread-Index: /9koxbi64AnmSvfZJrg4L1oCz/qc9A==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 13 Feb 2019 20:12:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2a5f14f279f59143139bcd1606903f2f80a34241.

This patch causes xfstests generic/311 to fail. Reverting this for
now until we have a proper fix.

Signed-off-by: Abhi Das <adas@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
---
 fs/gfs2/glops.c      |   1 -
 fs/gfs2/log.c        |   4 +-
 fs/gfs2/lops.c       | 190 ++-------------------------------------------------
 fs/gfs2/lops.h       |   4 +-
 fs/gfs2/ops_fstype.c |   1 -
 fs/gfs2/recovery.c   | 123 +++++++++++++++++++++++++++++++++
 fs/gfs2/recovery.h   |   2 +
 fs/gfs2/super.c      |   1 -
 8 files changed, 134 insertions(+), 192 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index f15b4c57c4bd..78510ab91835 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -28,7 +28,6 @@
 #include "util.h"
 #include "trans.h"
 #include "dir.h"
-#include "lops.h"
 
 struct workqueue_struct *gfs2_freeze_wq;
 
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 5bfaf381921a..b8830fda51e8 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -733,7 +733,7 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 	lh->lh_crc = cpu_to_be32(crc);
 
 	gfs2_log_write(sdp, page, sb->s_blocksize, 0, addr);
-	gfs2_log_submit_bio(&sdp->sd_log_bio, REQ_OP_WRITE | op_flags);
+	gfs2_log_submit_bio(&sdp->sd_log_bio, REQ_OP_WRITE, op_flags);
 	log_flush_wait(sdp);
 }
 
@@ -810,7 +810,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 
 	gfs2_ordered_write(sdp);
 	lops_before_commit(sdp, tr);
-	gfs2_log_submit_bio(&sdp->sd_log_bio, REQ_OP_WRITE);
+	gfs2_log_submit_bio(&sdp->sd_log_bio, REQ_OP_WRITE, 0);
 
 	if (sdp->sd_log_head != sdp->sd_log_flush_head) {
 		log_flush_wait(sdp);
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 94dcab655bc0..2295042bc625 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -17,9 +17,7 @@
 #include <linux/bio.h>
 #include <linux/fs.h>
 #include <linux/list_sort.h>
-#include <linux/blkdev.h>
 
-#include "bmap.h"
 #include "dir.h"
 #include "gfs2.h"
 #include "incore.h"
@@ -195,6 +193,7 @@ static void gfs2_end_log_write_bh(struct gfs2_sbd *sdp, struct bio_vec *bvec,
 /**
  * gfs2_end_log_write - end of i/o to the log
  * @bio: The bio
+ * @error: Status of i/o request
  *
  * Each bio_vec contains either data from the pagecache or data
  * relating to the log itself. Here we iterate over the bio_vec
@@ -231,19 +230,20 @@ static void gfs2_end_log_write(struct bio *bio)
 /**
  * gfs2_log_submit_bio - Submit any pending log bio
  * @biop: Address of the bio pointer
- * @opf: REQ_OP | op_flags
+ * @op: REQ_OP
+ * @op_flags: req_flag_bits
  *
  * Submit any pending part-built or full bio to the block device. If
  * there is no pending bio, then this is a no-op.
  */
 
-void gfs2_log_submit_bio(struct bio **biop, int opf)
+void gfs2_log_submit_bio(struct bio **biop, int op, int op_flags)
 {
 	struct bio *bio = *biop;
 	if (bio) {
 		struct gfs2_sbd *sdp = bio->bi_private;
 		atomic_inc(&sdp->sd_log_in_flight);
-		bio->bi_opf = opf;
+		bio_set_op_attrs(bio, op, op_flags);
 		submit_bio(bio);
 		*biop = NULL;
 	}
@@ -304,7 +304,7 @@ static struct bio *gfs2_log_get_bio(struct gfs2_sbd *sdp, u64 blkno,
 		nblk >>= sdp->sd_fsb2bb_shift;
 		if (blkno == nblk && !flush)
 			return bio;
-		gfs2_log_submit_bio(biop, op);
+		gfs2_log_submit_bio(biop, op, 0);
 	}
 
 	*biop = gfs2_log_alloc_bio(sdp, blkno, end_io);
@@ -375,184 +375,6 @@ void gfs2_log_write_page(struct gfs2_sbd *sdp, struct page *page)
 		       gfs2_log_bmap(sdp));
 }
 
-/**
- * gfs2_end_log_read - end I/O callback for reads from the log
- * @bio: The bio
- *
- * Simply unlock the pages in the bio. The main thread will wait on them and
- * process them in order as necessary.
- */
-
-static void gfs2_end_log_read(struct bio *bio)
-{
-	struct page *page;
-	struct bio_vec *bvec;
-	int i;
-
-	bio_for_each_segment_all(bvec, bio, i) {
-		page = bvec->bv_page;
-		if (bio->bi_status) {
-			int err = blk_status_to_errno(bio->bi_status);
-
-			SetPageError(page);
-			mapping_set_error(page->mapping, err);
-		}
-		unlock_page(page);
-	}
-
-	bio_put(bio);
-}
-
-/**
- * gfs2_jhead_pg_srch - Look for the journal head in a given page.
- * @jd: The journal descriptor
- * @page: The page to look in
- *
- * Returns: 1 if found, 0 otherwise.
- */
-
-static bool gfs2_jhead_pg_srch(struct gfs2_jdesc *jd,
-			      struct gfs2_log_header_host *head,
-			      struct page *page)
-{
-	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
-	struct gfs2_log_header_host uninitialized_var(lh);
-	void *kaddr = kmap_atomic(page);
-	unsigned int offset;
-	bool ret = false;
-
-	for (offset = 0; offset < PAGE_SIZE; offset += sdp->sd_sb.sb_bsize) {
-		if (!__get_log_header(sdp, kaddr + offset, 0, &lh)) {
-			if (lh.lh_sequence > head->lh_sequence)
-				*head = lh;
-			else {
-				ret = true;
-				break;
-			}
-		}
-	}
-	kunmap_atomic(kaddr);
-	return ret;
-}
-
-/**
- * gfs2_jhead_process_page - Search/cleanup a page
- * @jd: The journal descriptor
- * @index: Index of the page to look into
- * @done: If set, perform only cleanup, else search and set if found.
- *
- * Find the page with 'index' in the journal's mapping. Search the page for
- * the journal head if requested (cleanup == false). Release refs on the
- * page so the page cache can reclaim it (put_page() twice). We grabbed a
- * reference on this page two times, first when we did a find_or_create_page()
- * to obtain the page to add it to the bio and second when we do a
- * find_get_page() here to get the page to wait on while I/O on it is being
- * completed.
- * This function is also used to free up a page we might've grabbed but not
- * used. Maybe we added it to a bio, but not submitted it for I/O. Or we
- * submitted the I/O, but we already found the jhead so we only need to drop
- * our references to the page.
- */
-
-static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
-				    struct gfs2_log_header_host *head,
-				    bool *done)
-{
-	struct page *page;
-
-	page = find_get_page(jd->jd_inode->i_mapping, index);
-	wait_on_page_locked(page);
-
-	if (PageError(page))
-		*done = true;
-
-	if (!*done)
-		*done = gfs2_jhead_pg_srch(jd, head, page);
-
-	put_page(page); /* Once for find_get_page */
-	put_page(page); /* Once more for find_or_create_page */
-}
-
-/**
- * gfs2_find_jhead - find the head of a log
- * @jd: The journal descriptor
- * @head: The log descriptor for the head of the log is returned here
- *
- * Do a search of a journal by reading it in large chunks using bios and find
- * the valid log entry with the highest sequence number.  (i.e. the log head)
- *
- * Returns: 0 on success, errno otherwise
- */
-
-int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
-{
-	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
-	struct address_space *mapping = jd->jd_inode->i_mapping;
-	struct gfs2_journal_extent *je;
-	u32 block, read_idx = 0, submit_idx = 0, index = 0;
-	int shift = PAGE_SHIFT - sdp->sd_sb.sb_bsize_shift;
-	int blocks_per_page = 1 << shift, sz, ret = 0;
-	struct bio *bio = NULL;
-	struct page *page;
-	bool done = false;
-	errseq_t since;
-
-	memset(head, 0, sizeof(*head));
-	if (list_empty(&jd->extent_list))
-		gfs2_map_journal_extents(sdp, jd);
-
-	since = filemap_sample_wb_err(mapping);
-	list_for_each_entry(je, &jd->extent_list, list) {
-		for (block = 0; block < je->blocks; block += blocks_per_page) {
-			index = (je->lblock + block) >> shift;
-
-			page = find_or_create_page(mapping, index, GFP_NOFS);
-			if (!page) {
-				ret = -ENOMEM;
-				done = true;
-				goto out;
-			}
-
-			if (bio) {
-				sz = bio_add_page(bio, page, PAGE_SIZE, 0);
-				if (sz == PAGE_SIZE)
-					goto page_added;
-				submit_idx = index;
-				submit_bio(bio);
-				bio = NULL;
-			}
-
-			bio = gfs2_log_alloc_bio(sdp,
-						 je->dblock + (index << shift),
-						 gfs2_end_log_read);
-			bio->bi_opf = REQ_OP_READ;
-			sz = bio_add_page(bio, page, PAGE_SIZE, 0);
-			gfs2_assert_warn(sdp, sz == PAGE_SIZE);
-
-page_added:
-			if (submit_idx <= read_idx + BIO_MAX_PAGES) {
-				/* Keep at least one bio in flight */
-				continue;
-			}
-
-			gfs2_jhead_process_page(jd, read_idx++, head, &done);
-			if (done)
-				goto out;  /* found */
-		}
-	}
-
-out:
-	if (bio)
-		submit_bio(bio);
-	while (read_idx <= index)
-		gfs2_jhead_process_page(jd, read_idx++, head, &done);
-
-	if (!ret)
-		ret = filemap_check_wb_err(mapping, since);
-
-	return ret;
-}
-
 static struct page *gfs2_get_log_desc(struct gfs2_sbd *sdp, u32 ld_type,
 				      u32 ld_length, u32 ld_data1)
 {
diff --git a/fs/gfs2/lops.h b/fs/gfs2/lops.h
index 331160fc568b..711c4d89c063 100644
--- a/fs/gfs2/lops.h
+++ b/fs/gfs2/lops.h
@@ -30,10 +30,8 @@ extern u64 gfs2_log_bmap(struct gfs2_sbd *sdp);
 extern void gfs2_log_write(struct gfs2_sbd *sdp, struct page *page,
 			   unsigned size, unsigned offset, u64 blkno);
 extern void gfs2_log_write_page(struct gfs2_sbd *sdp, struct page *page);
-extern void gfs2_log_submit_bio(struct bio **biop, int opf);
+extern void gfs2_log_submit_bio(struct bio **biop, int op, int op_flags);
 extern void gfs2_pin(struct gfs2_sbd *sdp, struct buffer_head *bh);
-extern int gfs2_find_jhead(struct gfs2_jdesc *jd,
-			   struct gfs2_log_header_host *head);
 
 static inline unsigned int buf_limit(struct gfs2_sbd *sdp)
 {
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 1179763f6370..b041cb8ae383 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -41,7 +41,6 @@
 #include "dir.h"
 #include "meta_io.h"
 #include "trace_gfs2.h"
-#include "lops.h"
 
 #define DO 0
 #define UNDO 1
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 7389e445a7a7..2dac43065382 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -181,6 +181,129 @@ static int get_log_header(struct gfs2_jdesc *jd, unsigned int blk,
 	return error;
 }
 
+/**
+ * find_good_lh - find a good log header
+ * @jd: the journal
+ * @blk: the segment to start searching from
+ * @lh: the log header to fill in
+ * @forward: if true search forward in the log, else search backward
+ *
+ * Call get_log_header() to get a log header for a segment, but if the
+ * segment is bad, either scan forward or backward until we find a good one.
+ *
+ * Returns: errno
+ */
+
+static int find_good_lh(struct gfs2_jdesc *jd, unsigned int *blk,
+			struct gfs2_log_header_host *head)
+{
+	unsigned int orig_blk = *blk;
+	int error;
+
+	for (;;) {
+		error = get_log_header(jd, *blk, head);
+		if (error <= 0)
+			return error;
+
+		if (++*blk == jd->jd_blocks)
+			*blk = 0;
+
+		if (*blk == orig_blk) {
+			gfs2_consist_inode(GFS2_I(jd->jd_inode));
+			return -EIO;
+		}
+	}
+}
+
+/**
+ * jhead_scan - make sure we've found the head of the log
+ * @jd: the journal
+ * @head: this is filled in with the log descriptor of the head
+ *
+ * At this point, seg and lh should be either the head of the log or just
+ * before.  Scan forward until we find the head.
+ *
+ * Returns: errno
+ */
+
+static int jhead_scan(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
+{
+	unsigned int blk = head->lh_blkno;
+	struct gfs2_log_header_host lh;
+	int error;
+
+	for (;;) {
+		if (++blk == jd->jd_blocks)
+			blk = 0;
+
+		error = get_log_header(jd, blk, &lh);
+		if (error < 0)
+			return error;
+		if (error == 1)
+			continue;
+
+		if (lh.lh_sequence == head->lh_sequence) {
+			gfs2_consist_inode(GFS2_I(jd->jd_inode));
+			return -EIO;
+		}
+		if (lh.lh_sequence < head->lh_sequence)
+			break;
+
+		*head = lh;
+	}
+
+	return 0;
+}
+
+/**
+ * gfs2_find_jhead - find the head of a log
+ * @jd: the journal
+ * @head: the log descriptor for the head of the log is returned here
+ *
+ * Do a binary search of a journal and find the valid log entry with the
+ * highest sequence number.  (i.e. the log head)
+ *
+ * Returns: errno
+ */
+
+int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
+{
+	struct gfs2_log_header_host lh_1, lh_m;
+	u32 blk_1, blk_2, blk_m;
+	int error;
+
+	blk_1 = 0;
+	blk_2 = jd->jd_blocks - 1;
+
+	for (;;) {
+		blk_m = (blk_1 + blk_2) / 2;
+
+		error = find_good_lh(jd, &blk_1, &lh_1);
+		if (error)
+			return error;
+
+		error = find_good_lh(jd, &blk_m, &lh_m);
+		if (error)
+			return error;
+
+		if (blk_1 == blk_m || blk_m == blk_2)
+			break;
+
+		if (lh_1.lh_sequence <= lh_m.lh_sequence)
+			blk_1 = blk_m;
+		else
+			blk_2 = blk_m;
+	}
+
+	error = jhead_scan(jd, &lh_1);
+	if (error)
+		return error;
+
+	*head = lh_1;
+
+	return error;
+}
+
 /**
  * foreach_descriptor - go through the active part of the log
  * @jd: the journal
diff --git a/fs/gfs2/recovery.h b/fs/gfs2/recovery.h
index 99575ab81202..11d81248be85 100644
--- a/fs/gfs2/recovery.h
+++ b/fs/gfs2/recovery.h
@@ -27,6 +27,8 @@ extern int gfs2_revoke_add(struct gfs2_jdesc *jd, u64 blkno, unsigned int where)
 extern int gfs2_revoke_check(struct gfs2_jdesc *jd, u64 blkno, unsigned int where);
 extern void gfs2_revoke_clean(struct gfs2_jdesc *jd);
 
+extern int gfs2_find_jhead(struct gfs2_jdesc *jd,
+		    struct gfs2_log_header_host *head);
 extern int gfs2_recover_journal(struct gfs2_jdesc *gfs2_jd, bool wait);
 extern void gfs2_recover_func(struct work_struct *work);
 extern int __get_log_header(struct gfs2_sbd *sdp,
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index d4b11c903971..ca71163ff7cf 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -45,7 +45,6 @@
 #include "util.h"
 #include "sys.h"
 #include "xattr.h"
-#include "lops.h"
 
 #define args_neq(a1, a2, x) ((a1)->ar_##x != (a2)->ar_##x)
 
