Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A3DC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45812098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zarzqwNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45812098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbeJKXJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbeJKXJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:09:04 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB52B21477;
        Thu, 11 Oct 2018 15:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272480;
        bh=rHTzn3bqPP6lsaBb1GmhpFNEBMvuyLlYki36YnihEyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zarzqwNqL04xVxhgj9YJIpBURA2upvt4Xkqj+Mj1m4BaI7VLE5h79DVJdbjq+aiRu
         gjnzP+GAeABo+9FbOeRMlVGwuVvZ3MF7dvmIFvtMG8SW/xLmu9OLxDFxu1PdPMnttF
         Gl66AyaxtL6mbnRTEngNp36q3czsEvBudDkrNfBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 3.18 110/120] ext4: always check block group bounds in ext4_init_block_bitmap()
Date:   Thu, 11 Oct 2018 17:34:51 +0200
Message-Id: <20181011152554.347528234@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 819b23f1c501b17b9694325471789e6b5cc2d0d2 upstream.

Regardless of whether the flex_bg feature is set, we should always
check to make sure the bits we are setting in the block bitmap are
within the block group bounds.

https://bugzilla.kernel.org/show_bug.cgi?id=199865

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/balloc.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -184,7 +184,6 @@ static int ext4_init_block_bitmap(struct
 	unsigned int bit, bit_max;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_fsblk_t start, tmp;
-	int flex_bg = 0;
 	struct ext4_group_info *grp;
 
 	J_ASSERT_BH(bh, buffer_locked(bh));
@@ -217,22 +216,19 @@ static int ext4_init_block_bitmap(struct
 
 	start = ext4_group_first_block_no(sb, block_group);
 
-	if (EXT4_HAS_INCOMPAT_FEATURE(sb, EXT4_FEATURE_INCOMPAT_FLEX_BG))
-		flex_bg = 1;
-
 	/* Set bits for block and inode bitmaps, and inode table */
 	tmp = ext4_block_bitmap(sb, gdp);
-	if (!flex_bg || ext4_block_in_group(sb, tmp, block_group))
+	if (ext4_block_in_group(sb, tmp, block_group))
 		ext4_set_bit(EXT4_B2C(sbi, tmp - start), bh->b_data);
 
 	tmp = ext4_inode_bitmap(sb, gdp);
-	if (!flex_bg || ext4_block_in_group(sb, tmp, block_group))
+	if (ext4_block_in_group(sb, tmp, block_group))
 		ext4_set_bit(EXT4_B2C(sbi, tmp - start), bh->b_data);
 
 	tmp = ext4_inode_table(sb, gdp);
 	for (; tmp < ext4_inode_table(sb, gdp) +
 		     sbi->s_itb_per_group; tmp++) {
-		if (!flex_bg || ext4_block_in_group(sb, tmp, block_group))
+		if (ext4_block_in_group(sb, tmp, block_group))
 			ext4_set_bit(EXT4_B2C(sbi, tmp - start), bh->b_data);
 	}
 


