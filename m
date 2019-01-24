Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121C9C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F8B217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360838;
	bh=EvqM6neG0NZVH/lnBNAX0yCUQCR4f40AF/zzRNPZagQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0AE/maZl8ajxccC2qof1FcjIu8BUj7hSz2JzDIVRrP1CdSqtKsgmRrloWNCcYRahC
	 rHrQrnIT/JD3GO4ttjVuKA7tg9piV5GsMpeyNVyuandzPOpgZjmmWzKhwjiT7ohJrZ
	 lyybu70VtNa2pUkzOuXB45CfZzymSduTzZVw5wlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfAXUN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:13:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730390AbfAXTZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:25:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF5A218FD;
        Thu, 24 Jan 2019 19:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357929;
        bh=EvqM6neG0NZVH/lnBNAX0yCUQCR4f40AF/zzRNPZagQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m7Rsdq0jgjfl1DKu3ffixBaFjh2XIyl406q698Tpnmz+4fm9LV3DmdywI3cQz0T8A
         dJ3ld9BlSEP3QniET4r7xyD5x2LcKBV4CCySwmM51bJaen1AoiASAzZedGNSgIHeUW
         o8kno/at+0xvOzy2xTEBm2A4QYhEw3w3BMe14GDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 037/104] f2fs: fix validation of the block count in sanity_check_raw_super
Date:   Thu, 24 Jan 2019 20:19:26 +0100
Message-Id: <20190124190159.275850593@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

commit 88960068f25fcc3759455d85460234dcc9d43fef upstream.

Treat "block_count" from struct f2fs_super_block as 64-bit little endian
value in sanity_check_raw_super() because struct f2fs_super_block
declares "block_count" as "__le64".

This fixes a bug where the superblock validation fails on big endian
devices with the following error:
  F2FS-fs (sda1): Wrong segment_count / block_count (61439 > 0)
  F2FS-fs (sda1): Can't find valid F2FS filesystem in 1th superblock
  F2FS-fs (sda1): Wrong segment_count / block_count (61439 > 0)
  F2FS-fs (sda1): Can't find valid F2FS filesystem in 2th superblock
As result of this the partition cannot be mounted.

With this patch applied the superblock validation works fine and the
partition can be mounted again:
  F2FS-fs (sda1): Mounted with checkpoint version = 7c84

My little endian x86-64 hardware was able to mount the partition without
this fix.
To confirm that mounting f2fs filesystems works on big endian machines
again I tested this on a 32-bit MIPS big endian (lantiq) device.

Fixes: 0cfe75c5b01199 ("f2fs: enhance sanity_check_raw_super() to avoid potential overflows")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/super.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1081,10 +1081,10 @@ static int sanity_check_raw_super(struct
 		return 1;
 	}
 
-	if (segment_count > (le32_to_cpu(raw_super->block_count) >> 9)) {
+	if (segment_count > (le64_to_cpu(raw_super->block_count) >> 9)) {
 		f2fs_msg(sb, KERN_INFO,
-			"Wrong segment_count / block_count (%u > %u)",
-			segment_count, le32_to_cpu(raw_super->block_count));
+			"Wrong segment_count / block_count (%u > %llu)",
+			segment_count, le64_to_cpu(raw_super->block_count));
 		return 1;
 	}
 


