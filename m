Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412E7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F3A20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F3A20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbeHAUSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:18:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404201AbeHATDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:35 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 53EA0125F;
        Wed,  1 Aug 2018 17:09:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.17 305/336] ext4: check for allocation block validity with block group locked
Date:   Wed,  1 Aug 2018 18:50:40 +0200
Message-Id: <20180801165040.722153415@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit 8d5a803c6a6ce4ec258e31f76059ea5153ba46ef upstream.

With commit 044e6e3d74a3: "ext4: don't update checksum of new
initialized bitmaps" the buffer valid bit will get set without
actually setting up the checksum for the allocation bitmap, since the
checksum will get calculated once we actually allocate an inode or
block.

If we are doing this, then we need to (re-)check the verified bit
after we take the block group lock.  Otherwise, we could race with
another process reading and verifying the bitmap, which would then
complain about the checksum being invalid.

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1780137

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/balloc.c |    3 +++
 fs/ext4/ialloc.c |    3 +++
 2 files changed, 6 insertions(+)

--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -379,6 +379,8 @@ static int ext4_validate_block_bitmap(st
 		return -EFSCORRUPTED;
 
 	ext4_lock_group(sb, block_group);
+	if (buffer_verified(bh))
+		goto verified;
 	if (unlikely(!ext4_block_bitmap_csum_verify(sb, block_group,
 			desc, bh))) {
 		ext4_unlock_group(sb, block_group);
@@ -401,6 +403,7 @@ static int ext4_validate_block_bitmap(st
 		return -EFSCORRUPTED;
 	}
 	set_buffer_verified(bh);
+verified:
 	ext4_unlock_group(sb, block_group);
 	return 0;
 }
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -91,6 +91,8 @@ static int ext4_validate_inode_bitmap(st
 		return -EFSCORRUPTED;
 
 	ext4_lock_group(sb, block_group);
+	if (buffer_verified(bh))
+		goto verified;
 	blk = ext4_inode_bitmap(sb, desc);
 	if (!ext4_inode_bitmap_csum_verify(sb, block_group, desc, bh,
 					   EXT4_INODES_PER_GROUP(sb) / 8)) {
@@ -108,6 +110,7 @@ static int ext4_validate_inode_bitmap(st
 		return -EFSBADCRC;
 	}
 	set_buffer_verified(bh);
+verified:
 	ext4_unlock_group(sb, block_group);
 	return 0;
 }


