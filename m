Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEF9C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A068217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360921;
	bh=+8re4oe2b0d4tJI1NPuGvaEKmjssxm6ay2gqzgSVqJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LlTx97MbZwYW5hKmvGBMmKw9dywVNOQmyT8iBm1MGnKxxrOMdzkP0eyuCYQ4kPFCt
	 SplhYmyb+ueV+a2NNFyzfJiRfvE3EeK+F4zPNETGnpAK/TwXp1/UXdl552wclFE7tM
	 AD06i0KEys8suIe8yF0rWzvBRcGEmzWntyrWauIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbfAXTYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:24:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:49732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729581AbfAXTY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:24:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 455EB218FC;
        Thu, 24 Jan 2019 19:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357867;
        bh=+8re4oe2b0d4tJI1NPuGvaEKmjssxm6ay2gqzgSVqJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yJ6eNAA6rhVdoneIRE4VvtYSh7vjTug5XYMgfY/Zu2+3a77MxTaIR1bNcy9obkuxI
         6XVqOgrRoHoR+nopJbxHwIYvG2mKpNmBmQVqZm2JPKhnX97CQwYeOWitmnBBTgs/3b
         0WNkIzVztbHzd32w1wBr64FflYofeH0OUNjrwdZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 017/104] f2fs: fix to determine start_cp_addr by sbi->cur_cp_pack
Date:   Thu, 24 Jan 2019 20:19:06 +0100
Message-Id: <20190124190156.767796810@linuxfoundation.org>
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

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 8508e44ae98622f841f5ef29d0bf3d5db4e0c1cc upstream.

We don't guarantee cp_addr is fixed by cp_version.
This is to sync with f2fs-tools.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 4.4: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/checkpoint.c |    8 +++++++-
 fs/f2fs/f2fs.h       |   26 ++++++++++++++++----------
 2 files changed, 23 insertions(+), 11 deletions(-)

--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -710,6 +710,11 @@ int get_valid_checkpoint(struct f2fs_sb_
 	if (sanity_check_ckpt(sbi))
 		goto fail_no_cp;
 
+	if (cur_page == cp1)
+		sbi->cur_cp_pack = 1;
+	else
+		sbi->cur_cp_pack = 2;
+
 	if (cp_blks <= 1)
 		goto done;
 
@@ -1008,7 +1013,7 @@ static void do_checkpoint(struct f2fs_sb
 				le32_to_cpu(ckpt->checksum_offset)))
 				= cpu_to_le32(crc32);
 
-	start_blk = __start_cp_addr(sbi);
+	start_blk = __start_cp_next_addr(sbi);
 
 	/* need to wait for end_io results */
 	wait_on_all_pages_writeback(sbi);
@@ -1063,6 +1068,7 @@ static void do_checkpoint(struct f2fs_sb
 
 	clear_prefree_segments(sbi, cpc);
 	clear_sbi_flag(sbi, SBI_IS_DIRTY);
+	__set_cp_next_pack(sbi);
 }
 
 /*
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -731,6 +731,7 @@ struct f2fs_sb_info {
 
 	/* for checkpoint */
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
+	int cur_cp_pack;			/* remain current cp pack */
 	struct inode *meta_inode;		/* cache meta blocks */
 	struct mutex cp_mutex;			/* checkpoint procedure lock */
 	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
@@ -1140,22 +1141,27 @@ static inline void *__bitmap_ptr(struct
 
 static inline block_t __start_cp_addr(struct f2fs_sb_info *sbi)
 {
-	block_t start_addr;
-	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
-	unsigned long long ckpt_version = cur_cp_version(ckpt);
-
-	start_addr = le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_blkaddr);
+	block_t start_addr = le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_blkaddr);
 
-	/*
-	 * odd numbered checkpoint should at cp segment 0
-	 * and even segment must be at cp segment 1
-	 */
-	if (!(ckpt_version & 1))
+	if (sbi->cur_cp_pack == 2)
 		start_addr += sbi->blocks_per_seg;
+	return start_addr;
+}
 
+static inline block_t __start_cp_next_addr(struct f2fs_sb_info *sbi)
+{
+	block_t start_addr = le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_blkaddr);
+
+	if (sbi->cur_cp_pack == 1)
+		start_addr += sbi->blocks_per_seg;
 	return start_addr;
 }
 
+static inline void __set_cp_next_pack(struct f2fs_sb_info *sbi)
+{
+	sbi->cur_cp_pack = (sbi->cur_cp_pack == 1) ? 2 : 1;
+}
+
 static inline block_t __start_sum_addr(struct f2fs_sb_info *sbi)
 {
 	return le32_to_cpu(F2FS_CKPT(sbi)->cp_pack_start_sum);


