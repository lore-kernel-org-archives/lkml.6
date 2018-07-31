Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5410CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0751D20862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0751D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbeGaHzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:55:52 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:38434 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbeGaHzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:55:52 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 8896472C799AAD5A6714;
        Tue, 31 Jul 2018 14:17:10 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6V6H0qJ062846;
        Tue, 31 Jul 2018 14:17:00 +0800 (GMT-8)
        (envelope-from liu.song11@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018073114170409-2670241 ;
          Tue, 31 Jul 2018 14:17:04 +0800 
From:   Liu Song <liu.song11@zte.com.cn>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        liu.song11@zte.com.cn, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: [PATCH] Improve code readability
Date:   Tue, 31 Jul 2018 14:15:15 +0800
Message-Id: <1533017715-122171-1-git-send-email-liu.song11@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-31 14:17:04,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-31 14:16:56,
        Serialize complete at 2018-07-31 14:16:56
X-MAIL: mse01.zte.com.cn w6V6H0qJ062846
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge the duplicated complex conditions to improve code readability.

Signed-off-by: Liu Song <liu.song11@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 fs/ext4/inode.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7d6c100..c2bc1fd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4946,17 +4946,15 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	} else if (!ext4_has_inline_data(inode)) {
-		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-			if ((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
-			    (S_ISLNK(inode->i_mode) &&
-			     !ext4_inode_is_fast_symlink(inode))))
+		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+		   (S_ISLNK(inode->i_mode) &&
+		    !ext4_inode_is_fast_symlink(inode))) {
+			if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 				/* Validate extent which is part of inode */
 				ret = ext4_ext_check_inode(inode);
-		} else if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
-			   (S_ISLNK(inode->i_mode) &&
-			    !ext4_inode_is_fast_symlink(inode))) {
+			else
 			/* Validate block references which are part of inode */
-			ret = ext4_ind_check_inode(inode);
+				ret = ext4_ind_check_inode(inode);
 		}
 	}
 	if (ret)
-- 
1.8.3.1

