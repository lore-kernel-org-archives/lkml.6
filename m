Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2E8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F1820841
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jQoikPTQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jQoikPTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F1820841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeJJMrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 08:47:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54268 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJMrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 08:47:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BC31F60C60; Wed, 10 Oct 2018 05:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539149193;
        bh=NC+BDq+xQJhrKWG7HrxA/5M1u7d5fglnmIwaMBzsnQ0=;
        h=From:To:Cc:Subject:Date:From;
        b=jQoikPTQZx736nSc4kVB2saHS05MSSt0iQ9W6KM9bu1/WIn8/cLcIYlB66faf7sgg
         jrnM/PnaijdDBP+fnOHokDDD//73M825/tWAisQWUiMa9rOQHt8oqX6Z+NQKAmY1bl
         D/P91CNoHKN+54L3Y+gFHrRk2YHG3XNnAiWgding=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1805D60866;
        Wed, 10 Oct 2018 05:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539149193;
        bh=NC+BDq+xQJhrKWG7HrxA/5M1u7d5fglnmIwaMBzsnQ0=;
        h=From:To:Cc:Subject:Date:From;
        b=jQoikPTQZx736nSc4kVB2saHS05MSSt0iQ9W6KM9bu1/WIn8/cLcIYlB66faf7sgg
         jrnM/PnaijdDBP+fnOHokDDD//73M825/tWAisQWUiMa9rOQHt8oqX6Z+NQKAmY1bl
         D/P91CNoHKN+54L3Y+gFHrRk2YHG3XNnAiWgding=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1805D60866
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] f2fs: fix data corruption issue with hardware encryption
Date:   Wed, 10 Oct 2018 10:56:22 +0530
Message-Id: <1539149182-12729-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct IO can be used in case of hardware encryption. The following
scenario results into data corruption issue in this path -

Thread A -                          Thread B-
-> write file#1 in direct IO
                                    -> GC gets kicked in
                                    -> GC submitted bio on meta mapping
				       for file#1, but pending completion
-> write file#1 again with new data
   in direct IO
                                    -> GC bio gets completed now
                                    -> GC writes old data to the new
                                       location and thus file#1 is
				       corrupted.

Fix this by submitting and waiting for pending io on meta mapping
for direct IO case in f2fs_map_blocks().

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/data.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9ef6f1f..7b2fef0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1028,6 +1028,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		map->m_pblk = ei.blk + pgofs - ei.fofs;
 		map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
 		map->m_flags = F2FS_MAP_MAPPED;
+		/* for HW encryption, but to avoid potential issue in future */
+		if (flag == F2FS_GET_BLOCK_DIO) {
+			blkaddr = map->m_pblk;
+			for (; blkaddr < map->m_pblk + map->m_len; blkaddr++)
+				f2fs_wait_on_block_writeback(sbi, blkaddr);
+		}
 		if (map->m_next_extent)
 			*map->m_next_extent = pgofs + map->m_len;
 		goto out;
@@ -1188,6 +1194,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	goto next_dnode;
 
 sync_out:
+	/* for hardware encryption, but to avoid potential issue in future */
+	if (flag == F2FS_GET_BLOCK_DIO && map->m_flags & F2FS_MAP_MAPPED) {
+		blkaddr = map->m_pblk;
+		for (; blkaddr < map->m_pblk + map->m_len; blkaddr++)
+			f2fs_wait_on_block_writeback(sbi, blkaddr);
+	}
 	if (flag == F2FS_GET_BLOCK_PRECACHE) {
 		if (map->m_flags & F2FS_MAP_MAPPED) {
 			unsigned int ofs = start_pgofs - map->m_lblk;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

