Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C323C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE56221456
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE56221456
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932237AbeFXPoO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:44:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932106AbeFXPoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:44:12 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C396A2C;
        Sun, 24 Jun 2018 15:44:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Theodore Tso <tytso@mit.edu>,
        Joe Habermann <joe.habermann@quantum.com>
Subject: [PATCH 4.17 17/70] ext4: update mtime in ext4_punch_hole even if no blocks are released
Date:   Sun, 24 Jun 2018 23:22:09 +0800
Message-Id: <20180624142741.564453712@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
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

From: Lukas Czerner <lczerner@redhat.com>

commit eee597ac931305eff3d3fd1d61d6aae553bc0984 upstream.

Currently in ext4_punch_hole we're going to skip the mtime update if
there are no actual blocks to release. However we've actually modified
the file by zeroing the partial block so the mtime should be updated.

Moreover the sync and datasync handling is skipped as well, which is
also wrong. Fix it.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: Joe Habermann <joe.habermann@quantum.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |   40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4298,28 +4298,28 @@ int ext4_punch_hole(struct inode *inode,
 		EXT4_BLOCK_SIZE_BITS(sb);
 	stop_block = (offset + length) >> EXT4_BLOCK_SIZE_BITS(sb);
 
-	/* If there are no blocks to remove, return now */
-	if (first_block >= stop_block)
-		goto out_stop;
-
-	down_write(&EXT4_I(inode)->i_data_sem);
-	ext4_discard_preallocations(inode);
-
-	ret = ext4_es_remove_extent(inode, first_block,
-				    stop_block - first_block);
-	if (ret) {
-		up_write(&EXT4_I(inode)->i_data_sem);
-		goto out_stop;
-	}
+	/* If there are blocks to remove, do it */
+	if (stop_block > first_block) {
+
+		down_write(&EXT4_I(inode)->i_data_sem);
+		ext4_discard_preallocations(inode);
 
-	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		ret = ext4_ext_remove_space(inode, first_block,
-					    stop_block - 1);
-	else
-		ret = ext4_ind_remove_space(handle, inode, first_block,
-					    stop_block);
+		ret = ext4_es_remove_extent(inode, first_block,
+					    stop_block - first_block);
+		if (ret) {
+			up_write(&EXT4_I(inode)->i_data_sem);
+			goto out_stop;
+		}
+
+		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+			ret = ext4_ext_remove_space(inode, first_block,
+						    stop_block - 1);
+		else
+			ret = ext4_ind_remove_space(handle, inode, first_block,
+						    stop_block);
 
-	up_write(&EXT4_I(inode)->i_data_sem);
+		up_write(&EXT4_I(inode)->i_data_sem);
+	}
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 


