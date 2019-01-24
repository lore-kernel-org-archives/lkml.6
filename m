Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D49C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0566521902
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357867;
	bh=imzGFppaAiU/ddaF2uMXeYU5rW4Xn/bv5Ql/TibHlCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qgySWoCT7SnOzR81sPCngBz9Ktt99Ii50XypL0Rk9D6kBP6webDBu3M5NffHPxK6t
	 IoFiA1ETJgkXz7SZCscXAQQZLnineO5AXiU7Lnr/69zwmR+PD1kIfykmEhaksHTwLR
	 oQbNAmZKg11HL6haYE7auHn6yFFjQAjJeyS9OFtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfAXTYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:24:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730071AbfAXTYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:24:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03325218FD;
        Thu, 24 Jan 2019 19:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357862;
        bh=imzGFppaAiU/ddaF2uMXeYU5rW4Xn/bv5Ql/TibHlCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N8US2vVglcIWQbWMN04gijW0PIYn1ZC1b3a9MkQcXW8ABMHW6Nai+h5zSRQ7j96x0
         DRcyVn2pCJ4evBip3iywnyCucBGiZ866h0FCwp5U0rqmdwg2WpwvBiUP/zWHJp4iph
         /oMT32eZVgtthkgYaEe36UxICQDK4Y15kO2dWLkk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiezhu Yang <kernelpatch@126.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 015/104] f2fs: introduce get_checkpoint_version for cleanup
Date:   Thu, 24 Jan 2019 20:19:04 +0100
Message-Id: <20190124190156.520397225@linuxfoundation.org>
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

From: Tiezhu Yang <kernelpatch@126.com>

commit fc0065adb202518e25fb929cda7d5887a456f774 upstream.

There exists almost same codes when get the value of pre_version
and cur_version in function validate_checkpoint, this patch adds
get_checkpoint_version to clean up redundant codes.

Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 4.4: f2fs_crc_valid() doesn't take an f2fs_sb_info pointer]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/checkpoint.c |   66 +++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -601,45 +601,55 @@ static void write_orphan_inodes(struct f
 	}
 }
 
-static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
-				block_t cp_addr, unsigned long long *version)
+static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
+		struct f2fs_checkpoint **cp_block, struct page **cp_page,
+		unsigned long long *version)
 {
-	struct page *cp_page_1, *cp_page_2 = NULL;
 	unsigned long blk_size = sbi->blocksize;
-	struct f2fs_checkpoint *cp_block;
-	unsigned long long cur_version = 0, pre_version = 0;
-	size_t crc_offset;
+	size_t crc_offset = 0;
 	__u32 crc = 0;
 
-	/* Read the 1st cp block in this CP pack */
-	cp_page_1 = get_meta_page(sbi, cp_addr);
+	*cp_page = get_meta_page(sbi, cp_addr);
+	*cp_block = (struct f2fs_checkpoint *)page_address(*cp_page);
 
-	/* get the version number */
-	cp_block = (struct f2fs_checkpoint *)page_address(cp_page_1);
-	crc_offset = le32_to_cpu(cp_block->checksum_offset);
-	if (crc_offset >= blk_size)
-		goto invalid_cp1;
+	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
+	if (crc_offset >= blk_size) {
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"invalid crc_offset: %zu", crc_offset);
+		return -EINVAL;
+	}
 
-	crc = le32_to_cpu(*((__le32 *)((unsigned char *)cp_block + crc_offset)));
-	if (!f2fs_crc_valid(crc, cp_block, crc_offset))
-		goto invalid_cp1;
+	crc = le32_to_cpu(*((__le32 *)((unsigned char *)*cp_block
+							+ crc_offset)));
+	if (!f2fs_crc_valid(crc, *cp_block, crc_offset)) {
+		f2fs_msg(sbi->sb, KERN_WARNING, "invalid crc value");
+		return -EINVAL;
+	}
 
-	pre_version = cur_cp_version(cp_block);
+	*version = cur_cp_version(*cp_block);
+	return 0;
+}
 
-	/* Read the 2nd cp block in this CP pack */
-	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
-	cp_page_2 = get_meta_page(sbi, cp_addr);
+static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
+				block_t cp_addr, unsigned long long *version)
+{
+	struct page *cp_page_1 = NULL, *cp_page_2 = NULL;
+	struct f2fs_checkpoint *cp_block = NULL;
+	unsigned long long cur_version = 0, pre_version = 0;
+	int err;
 
-	cp_block = (struct f2fs_checkpoint *)page_address(cp_page_2);
-	crc_offset = le32_to_cpu(cp_block->checksum_offset);
-	if (crc_offset >= blk_size)
-		goto invalid_cp2;
+	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
+					&cp_page_1, version);
+	if (err)
+		goto invalid_cp1;
+	pre_version = *version;
 
-	crc = le32_to_cpu(*((__le32 *)((unsigned char *)cp_block + crc_offset)));
-	if (!f2fs_crc_valid(crc, cp_block, crc_offset))
+	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
+	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
+					&cp_page_2, version);
+	if (err)
 		goto invalid_cp2;
-
-	cur_version = cur_cp_version(cp_block);
+	cur_version = *version;
 
 	if (cur_version == pre_version) {
 		*version = cur_version;


