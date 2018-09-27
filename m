Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF06BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26FE2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26FE2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeI0PlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:41:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56638 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeI0PlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:41:16 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5A5541113;
        Thu, 27 Sep 2018 09:23:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Wen Xu <wen.xu@gatech.edu>
Subject: [PATCH 4.14 53/64] ext4: avoid arithemetic overflow that can trigger a BUG
Date:   Thu, 27 Sep 2018 11:04:10 +0200
Message-Id: <20180927090257.308974696@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit bcd8e91f98c156f4b1ebcfacae675f9cfd962441 upstream.

A maliciously crafted file system can cause an overflow when the
results of a 64-bit calculation is stored into a 32-bit length
parameter.

https://bugzilla.kernel.org/show_bug.cgi?id=200623

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: Wen Xu <wen.xu@gatech.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ext4.h  |    3 +++
 fs/ext4/inode.c |    9 +++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -714,6 +714,9 @@ struct fsxattr {
 /* Max physical block we can address w/o extents */
 #define EXT4_MAX_BLOCK_FILE_PHYS	0xFFFFFFFF
 
+/* Max logical block we can support */
+#define EXT4_MAX_LOGICAL_BLOCK		0xFFFFFFFF
+
 /*
  * Structure of an inode on the disk
  */
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3407,11 +3407,16 @@ static int ext4_iomap_begin(struct inode
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	unsigned int blkbits = inode->i_blkbits;
-	unsigned long first_block = offset >> blkbits;
-	unsigned long last_block = (offset + length - 1) >> blkbits;
+	unsigned long first_block, last_block;
 	struct ext4_map_blocks map;
 	int ret;
 
+	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
+		return -EINVAL;
+	first_block = offset >> blkbits;
+	last_block = min_t(loff_t, (offset + length - 1) >> blkbits,
+			   EXT4_MAX_LOGICAL_BLOCK);
+
 	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
 		return -ERANGE;
 


