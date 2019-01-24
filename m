Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9C8C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EA6218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357890;
	bh=YvM5I61qdOFvQ1SYHdY8jLi2Eq3JDjFNAN3KYuJR5n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1U3EZ6850e+YRIQjT0mcNE5MTkgT16MiLb8Cq2fYOtR0shKxXzhAuJYx5po3Sdye5
	 lC6mVRbbc11wecdQpTYJosxwiFsHt/XM98vEtzGo+DJ/7iZz0GG1EGI4N8tym0/L2Q
	 K0cJbtF0bpobVptujYjCm7oywM9r1WrW019ate0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfAXTYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:24:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbfAXTYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:24:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB61218EA;
        Thu, 24 Jan 2019 19:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357884;
        bh=YvM5I61qdOFvQ1SYHdY8jLi2Eq3JDjFNAN3KYuJR5n0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EXweatpwWbUiTHgdmdUfUQ+yClaV0RT2/Rnb0z9a5u/t6zOUqCLkuysGjw33kAlp+
         FqJWPxWpapqMYZMo19TxWw0H3M6FjeW+8iwZHW5ptspQx4QvalBCUlvIo+tsq2ZDzN
         0MQPa61T+ekDPjB2kjYzWj45F/sx8B6JbIJZCAM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunlei He <heyunlei@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 022/104] f2fs: check blkaddr more accuratly before issue a bio
Date:   Thu, 24 Jan 2019 20:19:11 +0100
Message-Id: <20190124190157.504272919@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunlei He <heyunlei@huawei.com>

commit 0833721ec3658a4e9d5e58b6fa82cf9edc431e59 upstream.

This patch check blkaddr more accuratly before issue a
write or read bio.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 4.4:
 - CoW is not implemented so check f2fs_io_info::blk_addr instead of
   f2fs_io_info::{old,new}_blkaddr
 - Operation code is f2fs_io_info::rw instead of f2fs_io_info::op
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/checkpoint.c |    2 ++
 fs/f2fs/data.c       |    3 ++-
 fs/f2fs/f2fs.h       |    1 +
 fs/f2fs/segment.h    |   25 +++++++++++++++++++------
 4 files changed, 24 insertions(+), 7 deletions(-)

--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -58,6 +58,7 @@ static struct page *__get_meta_page(stru
 		.rw = READ_SYNC | REQ_META | REQ_PRIO,
 		.blk_addr = index,
 		.encrypted_page = NULL,
+		.is_meta = is_meta,
 	};
 
 	if (unlikely(!is_meta))
@@ -151,6 +152,7 @@ int ra_meta_pages(struct f2fs_sb_info *s
 		.type = META,
 		.rw = sync ? (READ_SYNC | REQ_META | REQ_PRIO) : READA,
 		.encrypted_page = NULL,
+		.is_meta = (type != META_POR),
 	};
 
 	if (unlikely(type == META_POR))
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -147,6 +147,7 @@ int f2fs_submit_page_bio(struct f2fs_io_
 	struct bio *bio;
 	struct page *page = fio->encrypted_page ? fio->encrypted_page : fio->page;
 
+	verify_block_addr(fio, fio->blk_addr);
 	trace_f2fs_submit_page_bio(page, fio);
 	f2fs_trace_ios(fio, 0);
 
@@ -172,7 +173,7 @@ void f2fs_submit_page_mbio(struct f2fs_i
 
 	io = is_read ? &sbi->read_io : &sbi->write_io[btype];
 
-	verify_block_addr(sbi, fio->blk_addr);
+	verify_block_addr(fio, fio->blk_addr);
 
 	down_write(&io->io_rwsem);
 
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -684,6 +684,7 @@ struct f2fs_io_info {
 	block_t blk_addr;	/* block address to be written */
 	struct page *page;	/* page to be written */
 	struct page *encrypted_page;	/* encrypted page */
+	bool is_meta;		/* indicate borrow meta inode mapping or not */
 };
 
 #define is_read_io(rw)	(((rw) & 1) == READ)
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -48,13 +48,19 @@
 	 (secno == CURSEG_I(sbi, CURSEG_COLD_NODE)->segno /		\
 	  sbi->segs_per_sec))	\
 
-#define MAIN_BLKADDR(sbi)	(SM_I(sbi)->main_blkaddr)
-#define SEG0_BLKADDR(sbi)	(SM_I(sbi)->seg0_blkaddr)
+#define MAIN_BLKADDR(sbi)						\
+	(SM_I(sbi) ? SM_I(sbi)->main_blkaddr : 				\
+		le32_to_cpu(F2FS_RAW_SUPER(sbi)->main_blkaddr))
+#define SEG0_BLKADDR(sbi)						\
+	(SM_I(sbi) ? SM_I(sbi)->seg0_blkaddr : 				\
+		le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment0_blkaddr))
 
 #define MAIN_SEGS(sbi)	(SM_I(sbi)->main_segments)
 #define MAIN_SECS(sbi)	(sbi->total_sections)
 
-#define TOTAL_SEGS(sbi)	(SM_I(sbi)->segment_count)
+#define TOTAL_SEGS(sbi)							\
+	(SM_I(sbi) ? SM_I(sbi)->segment_count : 				\
+		le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count))
 #define TOTAL_BLKS(sbi)	(TOTAL_SEGS(sbi) << sbi->log_blocks_per_seg)
 
 #define MAX_BLKADDR(sbi)	(SEG0_BLKADDR(sbi) + TOTAL_BLKS(sbi))
@@ -576,10 +582,17 @@ static inline void check_seg_range(struc
 	f2fs_bug_on(sbi, segno > TOTAL_SEGS(sbi) - 1);
 }
 
-static inline void verify_block_addr(struct f2fs_sb_info *sbi, block_t blk_addr)
+static inline void verify_block_addr(struct f2fs_io_info *fio, block_t blk_addr)
 {
-	BUG_ON(blk_addr < SEG0_BLKADDR(sbi)
-			|| blk_addr >= MAX_BLKADDR(sbi));
+	struct f2fs_sb_info *sbi = fio->sbi;
+
+	if (PAGE_TYPE_OF_BIO(fio->type) == META &&
+				(!is_read_io(fio->rw) || fio->is_meta))
+		BUG_ON(blk_addr < SEG0_BLKADDR(sbi) ||
+				blk_addr >= MAIN_BLKADDR(sbi));
+	else
+		BUG_ON(blk_addr < MAIN_BLKADDR(sbi) ||
+				blk_addr >= MAX_BLKADDR(sbi));
 }
 
 /*


