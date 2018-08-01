Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39823C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED277208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED277208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeHATov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:44:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405943AbeHATIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:40 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 88F3E1153;
        Wed,  1 Aug 2018 17:05:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 232/336] f2fs: check cap_resource only for data blocks
Date:   Wed,  1 Aug 2018 18:49:27 +0200
Message-Id: <20180801165037.947498195@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit a90a0884ac75f825157470a1c17e707d487bceb6 ]

This patch changes the rule to check cap_resource for data blocks, not inode
or node blocks in order to avoid selinux denial.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/f2fs.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1602,7 +1602,7 @@ static inline bool f2fs_has_xattr_block(
 }
 
 static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
-					struct inode *inode)
+					struct inode *inode, bool cap)
 {
 	if (!inode)
 		return true;
@@ -1615,7 +1615,7 @@ static inline bool __allow_reserved_bloc
 	if (!gid_eq(F2FS_OPTION(sbi).s_resgid, GLOBAL_ROOT_GID) &&
 					in_group_p(F2FS_OPTION(sbi).s_resgid))
 		return true;
-	if (capable(CAP_SYS_RESOURCE))
+	if (cap && capable(CAP_SYS_RESOURCE))
 		return true;
 	return false;
 }
@@ -1650,7 +1650,7 @@ static inline int inc_valid_block_count(
 	avail_user_block_count = sbi->user_block_count -
 					sbi->current_reserved_blocks;
 
-	if (!__allow_reserved_blocks(sbi, inode))
+	if (!__allow_reserved_blocks(sbi, inode, true))
 		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
 
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
@@ -1857,7 +1857,7 @@ static inline int inc_valid_node_count(s
 	valid_block_count = sbi->total_valid_block_count +
 					sbi->current_reserved_blocks + 1;
 
-	if (!__allow_reserved_blocks(sbi, inode))
+	if (!__allow_reserved_blocks(sbi, inode, false))
 		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
 
 	if (unlikely(valid_block_count > sbi->user_block_count)) {


