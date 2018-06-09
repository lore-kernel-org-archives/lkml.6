Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ttMSAkvJG1tHPQAAmS7hNA
	; Sat, 09 Jun 2018 12:35:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EAB4D608BF; Sat,  9 Jun 2018 12:35:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 52341608BA;
	Sat,  9 Jun 2018 12:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52341608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932209AbeFIMfD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:35:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932102AbeFIMfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:35:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4AF18406E8CB;
        Sat,  9 Jun 2018 12:34:59 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD88D2166BB2;
        Sat,  9 Jun 2018 12:34:53 +0000 (UTC)
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
Subject: [PATCH V6 23/30] f2fs: conver to bio_for_each_chunk_segment_all
Date: Sat,  9 Jun 2018 20:30:07 +0800
Message-Id: <20180609123014.8861-24-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
References: <20180609123014.8861-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 09 Jun 2018 12:34:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 09 Jun 2018 12:34:59 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bio_for_each_page_all() can't be used any more after multipage bvec is
enabled, so we have to convert to bio_for_each_chunk_segment_all().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/f2fs/data.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 02237d4d91f5..00ee386b902c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -54,6 +54,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_chunk_iter citer;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(F2FS_P_SB(bio_first_page_all(bio)), FAULT_IO)) {
@@ -71,7 +72,7 @@ static void f2fs_read_end_io(struct bio *bio)
 		}
 	}
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_chunk_segment_all(bvec, bio, i, citer) {
 		struct page *page = bvec->bv_page;
 
 		if (!bio->bi_status) {
@@ -91,8 +92,9 @@ static void f2fs_write_end_io(struct bio *bio)
 	struct f2fs_sb_info *sbi = bio->bi_private;
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_chunk_iter citer;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_chunk_segment_all(bvec, bio, i, citer) {
 		struct page *page = bvec->bv_page;
 		enum count_type type = WB_DATA_TYPE(page);
 
@@ -267,6 +269,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
 	struct bio_vec *bvec;
 	struct page *target;
 	int i;
+	struct bvec_chunk_iter citer;
 
 	if (!io->bio)
 		return false;
@@ -274,7 +277,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
 	if (!inode && !ino)
 		return true;
 
-	bio_for_each_segment_all(bvec, io->bio, i) {
+	bio_for_each_chunk_segment_all(bvec, io->bio, i, citer) {
 
 		if (bvec->bv_page->mapping)
 			target = bvec->bv_page;
-- 
2.9.5
