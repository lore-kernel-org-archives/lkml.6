Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCD2C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E762098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeD489cS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E762098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeJKXD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJKXDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:03:55 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A09720841;
        Thu, 11 Oct 2018 15:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272172;
        bh=VADZ6fKqm+LP+LGnSGYmrQxP6SSPA2CjKaq4g1XgkYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jeD489cS6E6rd5faNQqlZXiFLKJ9MZWh9bRvcC7L7vECRQqt09J4zJPcDqJGEsCV3
         L4kw/CJJSJTWxtQX+M5CfSmOgoR/kLs9kMyvA46I6PZTwN+nnAacGyS5q9MApu9RUs
         zUvhK/2S6LsLNIMDq4D0TXBcXLvqJt5dQPolFZC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 3.18 015/120] ext4: fix online resizes handling of a too-small final block group
Date:   Thu, 11 Oct 2018 17:33:16 +0200
Message-Id: <20181011152550.159067499@linuxfoundation.org>
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

commit f0a459dec5495a3580f8d784555e6f8f3bf7f263 upstream.

Avoid growing the file system to an extent so that the last block
group is too small to hold all of the metadata that must be stored in
the block group.

This problem can be triggered with the following reproducer:

umount /mnt
mke2fs -F -m0 -b 4096 -t ext4 -O resize_inode,^has_journal \
	-E resize=1073741824 /tmp/foo.img 128M
mount /tmp/foo.img /mnt
truncate --size 1708M /tmp/foo.img
resize2fs /dev/loop0 295400
umount /mnt
e2fsck -fy /tmp/foo.img

Reported-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/resize.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1957,6 +1957,26 @@ retry:
 		}
 	}
 
+	/*
+	 * Make sure the last group has enough space so that it's
+	 * guaranteed to have enough space for all metadata blocks
+	 * that it might need to hold.  (We might not need to store
+	 * the inode table blocks in the last block group, but there
+	 * will be cases where this might be needed.)
+	 */
+	if ((ext4_group_first_block_no(sb, n_group) +
+	     ext4_group_overhead_blocks(sb, n_group) + 2 +
+	     sbi->s_itb_per_group + sbi->s_cluster_ratio) >= n_blocks_count) {
+		n_blocks_count = ext4_group_first_block_no(sb, n_group);
+		n_group--;
+		n_blocks_count_retry = 0;
+		if (resize_inode) {
+			iput(resize_inode);
+			resize_inode = NULL;
+		}
+		goto retry;
+	}
+
 	/* extend the last group */
 	if (n_group == o_group)
 		add = n_blocks_count - o_blocks_count;


