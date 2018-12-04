Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB21C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4189B2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnMefrXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4189B2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeLDLCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:02:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbeLDLCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:02:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5659214DE;
        Tue,  4 Dec 2018 11:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921369;
        bh=CwV9Ebrwd9WaJWd10ROva2jQyBq24CZzoWAwIWtYTR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bnMefrXH09aTQz4xAYKub6KdQbIyDSUB9LRWK2NchanD5D3lz2EF7Nsufi+qidcaT
         KR2/HfWvXCQ3xy/ic9gz71arAQUZ65YnFEjzN2hEyAuVE1s1nZhFIsOK/6KVKNfGfi
         GiM8IK1h+JABHO4jx+/ob/Kv3EOg5rdSQTriTXjg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunlei He <heyunlei@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 044/146] f2fs: check blkaddr more accuratly before issue a bio
Date:   Tue,  4 Dec 2018 11:48:50 +0100
Message-Id: <20181204103728.635385561@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 0833721ec3658a4e9d5e58b6fa82cf9edc431e59 upstream.

This patch check blkaddr more accuratly before issue a
write or read bio.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c |  2 ++
 fs/f2fs/data.c       |  5 +++--
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/segment.h    | 25 +++++++++++++++++++------
 4 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 41fce930f44c..1bd4cd8c79c6 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -69,6 +69,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 		.old_blkaddr = index,
 		.new_blkaddr = index,
 		.encrypted_page = NULL,
+		.is_meta = is_meta,
 	};
 
 	if (unlikely(!is_meta))
@@ -163,6 +164,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		.op_flags = sync ? (REQ_META | REQ_PRIO) : REQ_RAHEAD,
 		.encrypted_page = NULL,
 		.in_list = false,
+		.is_meta = (type != META_POR),
 	};
 	struct blk_plug plug;
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6fbb6d75318a..5913de3f661d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -369,6 +369,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	struct page *page = fio->encrypted_page ?
 			fio->encrypted_page : fio->page;
 
+	verify_block_addr(fio, fio->new_blkaddr);
 	trace_f2fs_submit_page_bio(page, fio);
 	f2fs_trace_ios(fio, 0);
 
@@ -413,8 +414,8 @@ next:
 	}
 
 	if (fio->old_blkaddr != NEW_ADDR)
-		verify_block_addr(sbi, fio->old_blkaddr);
-	verify_block_addr(sbi, fio->new_blkaddr);
+		verify_block_addr(fio, fio->old_blkaddr);
+	verify_block_addr(fio, fio->new_blkaddr);
 
 	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 54f8520ad7a2..aa7b033af1b0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -910,6 +910,7 @@ struct f2fs_io_info {
 	bool submitted;		/* indicate IO submission */
 	int need_lock;		/* indicate we need to lock cp_rwsem */
 	bool in_list;		/* indicate fio is in io_list */
+	bool is_meta;		/* indicate borrow meta inode mapping or not */
 	enum iostat_type io_type;	/* io type */
 };
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 4dfb5080098f..4b635e8c91b0 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -53,13 +53,19 @@
 	 ((secno) == CURSEG_I(sbi, CURSEG_COLD_NODE)->segno /		\
 	  (sbi)->segs_per_sec))	\
 
-#define MAIN_BLKADDR(sbi)	(SM_I(sbi)->main_blkaddr)
-#define SEG0_BLKADDR(sbi)	(SM_I(sbi)->seg0_blkaddr)
+#define MAIN_BLKADDR(sbi)						\
+	(SM_I(sbi) ? SM_I(sbi)->main_blkaddr : 				\
+		le32_to_cpu(F2FS_RAW_SUPER(sbi)->main_blkaddr))
+#define SEG0_BLKADDR(sbi)						\
+	(SM_I(sbi) ? SM_I(sbi)->seg0_blkaddr : 				\
+		le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment0_blkaddr))
 
 #define MAIN_SEGS(sbi)	(SM_I(sbi)->main_segments)
 #define MAIN_SECS(sbi)	((sbi)->total_sections)
 
-#define TOTAL_SEGS(sbi)	(SM_I(sbi)->segment_count)
+#define TOTAL_SEGS(sbi)							\
+	(SM_I(sbi) ? SM_I(sbi)->segment_count : 				\
+		le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count))
 #define TOTAL_BLKS(sbi)	(TOTAL_SEGS(sbi) << (sbi)->log_blocks_per_seg)
 
 #define MAX_BLKADDR(sbi)	(SEG0_BLKADDR(sbi) + TOTAL_BLKS(sbi))
@@ -619,10 +625,17 @@ static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
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
-- 
2.17.1



