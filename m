Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CA7C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB37206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB37206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbeJBUSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:18:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35388 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732352AbeJBUSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:18:12 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 44FD9B2F;
        Tue,  2 Oct 2018 13:34:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bryan Gurney <bgurney@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>, Jan Kara <jack@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 118/137] isofs: reject hardware sector size > 2048 bytes
Date:   Tue,  2 Oct 2018 06:25:19 -0700
Message-Id: <20181002132506.789967068@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
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

From: Eric Sandeen <sandeen@redhat.com>

[ Upstream commit 09a4e0be5826aa66c4ce9954841f110ffe63ef4f ]

The largest block size supported by isofs is ISOFS_BLOCK_SIZE (2048), but
isofs_fill_super calls sb_min_blocksize and sets the blocksize to the
device's logical block size if it's larger than what we ended up with after
option parsing.

If for some reason we try to mount a hard 4k device as an isofs filesystem,
we'll set opt.blocksize to 4096, and when we try to read the superblock
we found via:

        block = iso_blknum << (ISOFS_BLOCK_BITS - s->s_blocksize_bits)

with s_blocksize_bits greater than ISOFS_BLOCK_BITS, we'll have a negative
shift and the bread will fail somewhat cryptically:

  isofs_fill_super: bread failed, dev=sda, iso_blknum=17, block=-2147483648

It seems best to just catch and clearly reject mounts of such a device.

Reported-by: Bryan Gurney <bgurney@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/isofs/inode.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -24,6 +24,7 @@
 #include <linux/mpage.h>
 #include <linux/user_namespace.h>
 #include <linux/seq_file.h>
+#include <linux/blkdev.h>
 
 #include "isofs.h"
 #include "zisofs.h"
@@ -653,6 +654,12 @@ static int isofs_fill_super(struct super
 	/*
 	 * What if bugger tells us to go beyond page size?
 	 */
+	if (bdev_logical_block_size(s->s_bdev) > 2048) {
+		printk(KERN_WARNING
+		       "ISOFS: unsupported/invalid hardware sector size %d\n",
+			bdev_logical_block_size(s->s_bdev));
+		goto out_freesbi;
+	}
 	opt.blocksize = sb_min_blocksize(s, opt.blocksize);
 
 	sbi->s_high_sierra = 0; /* default is iso9660 */


