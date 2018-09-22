Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86245ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4147A2157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4147A2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391792AbeIVGMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:12:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44256 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392014AbeIVGKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:49 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdy-0008BX-6b; Sat, 22 Sep 2018 01:19:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000sH-6O; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Andreas Dilger" <adilger@dilger.ca>,
        "Theodore Ts'o" <tytso@mit.edu>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.343873544@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 32/63] ext4: always verify the magic number in xattr
 blocks
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 513f86d73855ce556ea9522b6bfd79f87356dc3a upstream.

If there an inode points to a block which is also some other type of
metadata block (such as a block allocation bitmap), the
buffer_verified flag can be set when it was validated as that other
metadata block type; however, it would make a really terrible external
attribute block.  The reason why we use the verified flag is to avoid
constantly reverifying the block.  However, it doesn't take much
overhead to make sure the magic number of the xattr block is correct,
and this will avoid potential crashes.

This addresses CVE-2018-10879.

https://bugzilla.kernel.org/show_bug.cgi?id=200001

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -213,12 +213,12 @@ ext4_xattr_check_block(struct inode *ino
 {
 	int error;
 
-	if (buffer_verified(bh))
-		return 0;
-
 	if (BHDR(bh)->h_magic != cpu_to_le32(EXT4_XATTR_MAGIC) ||
 	    BHDR(bh)->h_blocks != cpu_to_le32(1))
 		return -EIO;
+	if (buffer_verified(bh))
+		return 0;
+
 	if (!ext4_xattr_block_csum_verify(inode, bh))
 		return -EIO;
 	error = ext4_xattr_check_names(BFIRST(bh), bh->b_data + bh->b_size,

