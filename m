Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB337C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A200E20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107802;
	bh=K6kikIzlNiNm1GUuu9sCt6v+XWe8E75Al2mnTBYTrIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GV3SLRgtcGGLUHd07NcxBfE9q8NRSkowmTZSQhxbyG85Wd6rfP4ip85csS35B5oyL
	 2WuO8v3S717rIPrHIK1zZxp9CDORuIha+jnjh0wIsPyRsiyfkdqhwnJMYvKurw4w4+
	 UqZ62s5uSXZzBuD2V5SpwBTFUSWVVjE6bNkQJTqM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A200E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbeLFOre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:47:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730496AbeLFOra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:47:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C7920661;
        Thu,  6 Dec 2018 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107649;
        bh=K6kikIzlNiNm1GUuu9sCt6v+XWe8E75Al2mnTBYTrIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNddpbV11NXUWHpI0D7E9NFu2K9NXWRjiNVtD9mb1upTmIPPZDc5OYleh0kWXFdTk
         LkzjO+M+q1AU6L8gYnMqdXASZLlS2vTjrRHcDnZhHKmWs/g/4aTEWrZvX2dIkeD7sO
         iGm7EWuFzq1/UNmRabYXYg1aE+ADBh6RDG2psFCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunlei He <heyunlei@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 087/101] f2fs: check blkaddr more accuratly before issue a bio
Date:   Thu,  6 Dec 2018 15:39:26 +0100
Message-Id: <20181206143017.722302173@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunlei He <heyunlei@huawei.com>

commit 0833721ec3658a4e9d5e58b6fa82cf9edc431e59 upstream.

This patch check blkaddr more accuratly before issue a
write or read bio.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 4.9: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/checkpoint.c |    2 ++
 fs/f2fs/data.c       |    5 +++--
 fs/f2fs/f2fs.h       |    1 +
 fs/f2fs/segment.h    |   25 +++++++++++++++++++------
 4 files changed, 25 insertions(+), 8 deletions(-)

--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -69,6 +69,7 @@ static struct page *__get_meta_page(stru
 		.old_blkaddr = index,
 		.new_blkaddr = index,
 		.encrypted_page = NULL,
+		.is_meta = is_meta,
 	};
 
 	if (unlikely(!is_meta))
@@ -162,6 +163,7 @@ int ra_meta_pages(struct f2fs_sb_info *s
 		.op = REQ_OP_READ,
 		.op_flags = sync ? (READ_SYNC | REQ_META | REQ_PRIO) : REQ_RAHEAD,
 		.encrypted_page = NULL,
+		.is_meta = (type != META_POR),
 	};
 	struct blk_plug plug;
 
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -240,6 +240,7 @@ int f2fs_submit_page_bio(struct f2fs_io_
 	struct page *page = fio->encrypted_page ?
 			fio->encrypted_page : fio->page;
 
+	verify_block_addr(fio, fio->new_blkaddr);
 	trace_f2fs_submit_page_bio(page, fio);
 	f2fs_trace_ios(fio, 0);
 
@@ -267,8 +268,8 @@ void f2fs_submit_page_mbio(struct f2fs_i
 	io = is_read ? &sbi->read_io : &sbi->write_io[btype];
 
 	if (fio->old_blkaddr != NEW_ADDR)
-		verify_block_addr(sbi, fio->old_blkaddr);
-	verify_block_addr(sbi, fio->new_blkaddr);
+		verify_block_addr(fio, fio->old_blkaddr);
+	verify_block_addr(fio, fio->new_blkaddr);
 
 	down_write(&io->io_rwsem);
 
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -694,6 +694,7 @@ struct f2fs_io_info {
 	block_t old_blkaddr;	/* old block address before Cow */
 	struct page *page;	/* page to be written */
 	struct page *encrypted_page;	/* encrypted page */
+	bool is_meta;		/* indicate borrow meta inode mapping or not */
 };
 
 #define is_read_io(rw) (rw == READ)
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -49,13 +49,19 @@
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
@@ -591,10 +597,17 @@ static inline void check_seg_range(struc
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
+				(!is_read_io(fio->op) || fio->is_meta))
+		BUG_ON(blk_addr < SEG0_BLKADDR(sbi) ||
+				blk_addr >= MAIN_BLKADDR(sbi));
+	else
+		BUG_ON(blk_addr < MAIN_BLKADDR(sbi) ||
+				blk_addr >= MAX_BLKADDR(sbi));
 }
 
 /*


