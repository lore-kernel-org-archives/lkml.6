Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAFEC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72430213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xgQU/RbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72430213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbeJKXJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:09:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48965213A2;
        Thu, 11 Oct 2018 15:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272488;
        bh=dhhkQ2gyFBJnGMjm/Doy0ZWh64KBnW2pi7po79ncd6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xgQU/RbJXOigA9xx0OdURUCnApzxjojzz0OZbZ+gY4X2LCROm9C6jMp3DDMATWHHy
         XZZ/vnYcQ8l8d/tX+yNhD2hFLOvY32t2Enp2RV9RllxE0HaH2F0+5RZsuW3t61ooG8
         BAp89iLTWpzVJEhgrzBm3UuLMMW1bkda/AFpXY18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>, stable@kernel.org,
        Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 3.18 113/120] ext4: always verify the magic number in xattr blocks
Date:   Thu, 11 Oct 2018 17:34:54 +0200
Message-Id: <20181011152554.468338532@linuxfoundation.org>
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
Cc: stable@kernel.org
[ghackmann@google.com: 3.18 backport: adjust context]
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/xattr.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -218,12 +218,12 @@ ext4_xattr_check_block(struct inode *ino
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
 	if (!ext4_xattr_block_csum_verify(inode, bh->b_blocknr, BHDR(bh)))
 		return -EIO;
 	error = ext4_xattr_check_names(BFIRST(bh), bh->b_data + bh->b_size,


