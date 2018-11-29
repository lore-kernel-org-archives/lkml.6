Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8EBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9246208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLMzFvsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9246208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeK2REX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:04:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeK2REW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:04:22 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E292B21019;
        Thu, 29 Nov 2018 06:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471210;
        bh=DpzPbtrVPMoXuGHy1EnsP1vGzaKA8GeCgDpIEH4MeBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nLMzFvsxq2NYbLm+nR9A918aEws2wyDTxpd3bJN7mGPgXKs1sg7Q/dGUuK9TnqI5y
         Kx3GpwxUmotqxOgQsW06eu769YALqOCTJBqXYJmnTXQT1QXn8A8TBmxzc7E1i0hxd8
         jJGNG18jTMHIHoNfwjShp49rbJVSdOEd040baJyE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 54/68] iomap: readpages doesn't zero page tail beyond EOF
Date:   Thu, 29 Nov 2018 00:55:45 -0500
Message-Id: <20181129055559.159228-54-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 8c110d43c6bca4b24dd13272a9d4e0ba6f2ec957 ]

When we read the EOF page of the file via readpages, we need
to zero the region beyond EOF that we either do not read or
should not contain data so that mmap does not expose stale data to
user applications.

However, iomap_adjust_read_range() fails to detect EOF correctly,
and so fsx on 1k block size filesystems fails very quickly with
mapreads exposing data beyond EOF. There are two problems here.

Firstly, when calculating the end block of the EOF byte, we have
to round the size by one to avoid a block aligned EOF from reporting
a block too large. i.e. a size of 1024 bytes is 1 block, which in
index terms is block 0. Therefore we have to calculate the end block
from (isize - 1), not isize.

The second bug is determining if the current page spans EOF, and so
whether we need split it into two half, one for the IO, and the
other for zeroing. Unfortunately, the code that checks whether
we should split the block doesn't actually check if we span EOF, it
just checks if the read spans the /offset in the page/ that EOF
sits on. So it splits every read into two if EOF is not page
aligned, regardless of whether we are reading the EOF block or not.

Hence we need to restrict the "does the read span EOF" check to
just the page that spans EOF, not every page we read.

This patch results in correct EOF detection through readpages:

xfs_vm_readpages:     dev 259:0 ino 0x43 nr_pages 24
xfs_iomap_found:      dev 259:0 ino 0x43 size 0x66c00 offset 0x4f000 count 98304 type hole startoff 0x13c startblock 1368 blockcount 0x4
iomap_readpage_actor: orig pos 323584 pos 323584, length 4096, poff 0 plen 4096, isize 420864
xfs_iomap_found:      dev 259:0 ino 0x43 size 0x66c00 offset 0x50000 count 94208 type hole startoff 0x140 startblock 1497 blockcount 0x5c
iomap_readpage_actor: orig pos 327680 pos 327680, length 94208, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 331776 pos 331776, length 90112, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 335872 pos 335872, length 86016, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 339968 pos 339968, length 81920, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 344064 pos 344064, length 77824, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 348160 pos 348160, length 73728, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 352256 pos 352256, length 69632, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 356352 pos 356352, length 65536, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 360448 pos 360448, length 61440, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 364544 pos 364544, length 57344, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 368640 pos 368640, length 53248, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 372736 pos 372736, length 49152, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 376832 pos 376832, length 45056, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 380928 pos 380928, length 40960, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 385024 pos 385024, length 36864, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 389120 pos 389120, length 32768, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 393216 pos 393216, length 28672, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 397312 pos 397312, length 24576, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 401408 pos 401408, length 20480, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 405504 pos 405504, length 16384, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 409600 pos 409600, length 12288, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 413696 pos 413696, length 8192, poff 0 plen 4096, isize 420864
iomap_readpage_actor: orig pos 417792 pos 417792, length 4096, poff 0 plen 3072, isize 420864
iomap_readpage_actor: orig pos 420864 pos 420864, length 1024, poff 3072 plen 1024, isize 420864

As you can see, it now does full page reads until the last one which
is split correctly at the block aligned EOF, reading 3072 bytes and
zeroing the last 1024 bytes. The original version of the patch got
this right, but it got another case wrong.

The EOF detection crossing really needs to the the original length
as plen, while it starts at the end of the block, will be shortened
as up-to-date blocks are found on the page. This means "orig_pos +
plen" no longer points to the end of the page, and so will not
correctly detect EOF crossing. Hence we have to use the length
passed in to detect this partial page case:

xfs_filemap_fault:    dev 259:1 ino 0x43  write_fault 0
xfs_vm_readpage:      dev 259:1 ino 0x43 nr_pages 1
xfs_iomap_found:      dev 259:1 ino 0x43 size 0x2cc00 offset 0x2c000 count 4096 type hole startoff 0xb0 startblock 282 blockcount 0x4
iomap_readpage_actor: orig pos 180224 pos 181248, length 4096, poff 1024 plen 2048, isize 183296
xfs_iomap_found:      dev 259:1 ino 0x43 size 0x2cc00 offset 0x2cc00 count 1024 type hole startoff 0xb3 startblock 285 blockcount 0x1
iomap_readpage_actor: orig pos 183296 pos 183296, length 1024, poff 3072 plen 1024, isize 183296

Heere we see a trace where the first block on the EOF page is up to
date, hence poff = 1024 bytes. The offset into the page of EOF is
3072, so the range we want to read is 1024 - 3071, and the range we
want to zero is 3072 - 4095. You can see this is split correctly
now.

This fixes the stale data beyond EOF problem that fsx quickly
uncovers on 1k block size filesystems.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index e2e4a1154c90..cc080445b057 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -143,13 +143,14 @@ static void
 iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 		loff_t *pos, loff_t length, unsigned *offp, unsigned *lenp)
 {
+	loff_t orig_pos = *pos;
+	loff_t isize = i_size_read(inode);
 	unsigned block_bits = inode->i_blkbits;
 	unsigned block_size = (1 << block_bits);
 	unsigned poff = offset_in_page(*pos);
 	unsigned plen = min_t(loff_t, PAGE_SIZE - poff, length);
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
-	unsigned end = offset_in_page(i_size_read(inode)) >> block_bits;
 
 	/*
 	 * If the block size is smaller than the page size we need to check the
@@ -184,8 +185,12 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	 * handle both halves separately so that we properly zero data in the
 	 * page cache for blocks that are entirely outside of i_size.
 	 */
-	if (first <= end && last > end)
-		plen -= (last - end) * block_size;
+	if (orig_pos <= isize && orig_pos + length > isize) {
+		unsigned end = offset_in_page(isize - 1) >> block_bits;
+
+		if (first <= end && last > end)
+			plen -= (last - end) * block_size;
+	}
 
 	*offp = poff;
 	*lenp = plen;
-- 
2.17.1

