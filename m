Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77102C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EA020665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864972;
	bh=7DPFpsJ4dLmi+ANTA59keEKGdwbYGNgBLfj2o/AJmec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gxaZmTwsioff4eB/7PT4uQuZlj1bx1DgCqfBfHV+zbzaTzdRX5MVMgvXkEAdhGYHk
	 VqbgYWLo7n/ZosjihMwTnbyzxKDi2W7FuKN2qYyre8YPIWFSAMXOsGo+Ed5Iw5lz0e
	 nBtv4438wdxGu3gOtnjbeXMsfEdZVBJ75+LGX808=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfAGMml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:42:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfAGMme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:42:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9899A20449;
        Mon,  7 Jan 2019 12:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864954;
        bh=7DPFpsJ4dLmi+ANTA59keEKGdwbYGNgBLfj2o/AJmec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPnoldy8b/hDlQi/PoVbaFAxzfchHnazmoC7ESNTMrxNqvchdAGDvqw8PXaaJUnc5
         Zw5B5yS6MpjoSRdwFgVUYxYblEKGP/LW4DwurMt8UPrvfv/pdk6fvtbCILXB270gQf
         8HytCx4YX0BX24qP4oGQAQkHEHmXs8mBNlKb2Ft4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.20 107/145] f2fs: fix validation of the block count in sanity_check_raw_super
Date:   Mon,  7 Jan 2019 13:32:24 +0100
Message-Id: <20190107104451.226625957@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/super.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2493,10 +2493,10 @@ static int sanity_check_raw_super(struct
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
 


