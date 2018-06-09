Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /7Y3ES/JG1szOwAAmS7hNA
	; Sat, 09 Jun 2018 12:34:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4BF01607BB; Sat,  9 Jun 2018 12:34:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C4E15602FC;
	Sat,  9 Jun 2018 12:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4E15602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753584AbeFIMed (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:34:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753388AbeFIMea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:34:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0AB4BB42D;
        Sat,  9 Jun 2018 12:34:29 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7C17210C6D4;
        Sat,  9 Jun 2018 12:34:23 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 20/30] fs: conver to bio_for_each_chunk_segment_all()
Date: Sat,  9 Jun 2018 20:30:04 +0800
Message-Id: <20180609123014.8861-21-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
References: <20180609123014.8861-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sat, 09 Jun 2018 12:34:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sat, 09 Jun 2018 12:34:29 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bio_for_each_segment_all() can't be used any more after multipage bvec is
enabled, so we have to convert to bio_for_each_chunk_segment_all().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/block_dev.c  | 6 ++++--
 fs/crypto/bio.c | 3 ++-
 fs/direct-io.c  | 4 +++-
 fs/iomap.c      | 3 ++-
 fs/mpage.c      | 3 ++-
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index bef6934b6189..6726f8297a7b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -197,6 +197,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	ssize_t ret;
 	blk_qc_t qc;
 	int i;
+	struct bvec_chunk_iter citer;
 
 	if ((pos | iov_iter_alignment(iter)) &
 	    (bdev_logical_block_size(bdev) - 1))
@@ -242,7 +243,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	}
 	__set_current_state(TASK_RUNNING);
 
-	bio_for_each_segment_all(bvec, &bio, i) {
+	bio_for_each_chunk_segment_all(bvec, &bio, i, citer) {
 		if (should_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
 		put_page(bvec->bv_page);
@@ -309,8 +310,9 @@ static void blkdev_bio_end_io(struct bio *bio)
 	} else {
 		struct bio_vec *bvec;
 		int i;
+		struct bvec_chunk_iter citer;
 
-		bio_for_each_segment_all(bvec, bio, i)
+		bio_for_each_chunk_segment_all(bvec, bio, i, citer)
 			put_page(bvec->bv_page);
 		bio_put(bio);
 	}
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 0d5e6a569d58..13bcbdbf3440 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -37,8 +37,9 @@ static void completion_pages(struct work_struct *work)
 	struct bio *bio = ctx->r.bio;
 	struct bio_vec *bv;
 	int i;
+	struct bvec_chunk_iter citer;
 
-	bio_for_each_segment_all(bv, bio, i) {
+	bio_for_each_chunk_segment_all(bv, bio, i, citer) {
 		struct page *page = bv->bv_page;
 		int ret = fscrypt_decrypt_page(page->mapping->host, page,
 				PAGE_SIZE, 0, page->index);
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 093fb54cd316..8f7fd985450a 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -551,7 +551,9 @@ static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
 	if (dio->is_async && dio->op == REQ_OP_READ && dio->should_dirty) {
 		bio_check_pages_dirty(bio);	/* transfers ownership */
 	} else {
-		bio_for_each_segment_all(bvec, bio, i) {
+		struct bvec_chunk_iter citer;
+
+		bio_for_each_chunk_segment_all(bvec, bio, i, citer) {
 			struct page *page = bvec->bv_page;
 
 			if (dio->op == REQ_OP_READ && !PageCompound(page) &&
diff --git a/fs/iomap.c b/fs/iomap.c
index 206539d369a8..dbc35c40a1c4 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -934,8 +934,9 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 	} else {
 		struct bio_vec *bvec;
 		int i;
+		struct bvec_chunk_iter citer;
 
-		bio_for_each_segment_all(bvec, bio, i)
+		bio_for_each_chunk_segment_all(bvec, bio, i, citer)
 			put_page(bvec->bv_page);
 		bio_put(bio);
 	}
diff --git a/fs/mpage.c b/fs/mpage.c
index b7e7f570733a..78b372607650 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -48,8 +48,9 @@ static void mpage_end_io(struct bio *bio)
 {
 	struct bio_vec *bv;
 	int i;
+	struct bvec_chunk_iter citer;
 
-	bio_for_each_segment_all(bv, bio, i) {
+	bio_for_each_chunk_segment_all(bv, bio, i, citer) {
 		struct page *page = bv->bv_page;
 		page_endio(page, op_is_write(bio_op(bio)),
 				blk_status_to_errno(bio->bi_status));
-- 
2.9.5
