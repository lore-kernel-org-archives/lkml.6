Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73849C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45105214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896694;
	bh=OmrxOwhBaQ2kcWwufdkK2F4eOWx4fhIo+qX2SLD3/mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KRYqvDRfnDVM/bV9hcsts8WkKuda07WDViVFRLnycWQr8TmexjFSXrcOmfAznT1/I
	 iSHhF7uVF7nx0gPVbGnY3ZLZJUUu0urt9X40A1TrPvJg1WA2MA4zzDtyA/fubgRyvx
	 yL9cX2nnsrYu/Q+TZge61Qp0F5keo2bfEvgH5yUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388283AbfBKOvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:51:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730340AbfBKOva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:51:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3642720700;
        Mon, 11 Feb 2019 14:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896688;
        bh=OmrxOwhBaQ2kcWwufdkK2F4eOWx4fhIo+qX2SLD3/mI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7j7znDTOVNg4fSuPUZQH4UlJeQTSeJ2uaiR8TqZOcUruIcAXw8g4iqBwCfJPybTK
         4PO3B1Bwa9ypUexUnzb9Prv+JAU1QwQaOC54mSA9jI1H2kMukh8hvcGFWUFGBAldv4
         RaZQOJgGym8Y4SBf4uts5b0dXJKWKKgbfTfAs3wo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 251/313] xfs: fix overflow in xfs_attr3_leaf_verify
Date:   Mon, 11 Feb 2019 15:18:51 +0100
Message-Id: <20190211141910.105064373@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 837514f7a4ca4aca06aec5caa5ff56d33ef06976 upstream.

generic/070 on 64k block size filesystems is failing with a verifier
corruption on writeback or an attribute leaf block:

[   94.973083] XFS (pmem0): Metadata corruption detected at xfs_attr3_leaf_verify+0x246/0x260, xfs_attr3_leaf block 0x811480
[   94.975623] XFS (pmem0): Unmount and run xfs_repair
[   94.976720] XFS (pmem0): First 128 bytes of corrupted metadata buffer:
[   94.978270] 000000004b2e7b45: 00 00 00 00 00 00 00 00 3b ee 00 00 00 00 00 00  ........;.......
[   94.980268] 000000006b1db90b: 00 00 00 00 00 81 14 80 00 00 00 00 00 00 00 00  ................
[   94.982251] 00000000433f2407: 22 7b 5c 82 2d 5c 47 4c bb 31 1c 37 fa a9 ce d6  "{\.-\GL.1.7....
[   94.984157] 0000000010dc7dfb: 00 00 00 00 00 81 04 8a 00 0a 18 e8 dd 94 01 00  ................
[   94.986215] 00000000d5a19229: 00 a0 dc f4 fe 98 01 68 f0 d8 07 e0 00 00 00 00  .......h........
[   94.988171] 00000000521df36c: 0c 2d 32 e2 fe 20 01 00 0c 2d 58 65 fe 0c 01 00  .-2.. ...-Xe....
[   94.990162] 000000008477ae06: 0c 2d 5b 66 fe 8c 01 00 0c 2d 71 35 fe 7c 01 00  .-[f.....-q5.|..
[   94.992139] 00000000a4a6bca6: 0c 2d 72 37 fc d4 01 00 0c 2d d8 b8 f0 90 01 00  .-r7.....-......
[   94.994789] XFS (pmem0): xfs_do_force_shutdown(0x8) called from line 1453 of file fs/xfs/xfs_buf.c. Return address = ffffffff815365f3

This is failing this check:

                end = ichdr.freemap[i].base + ichdr.freemap[i].size;
                if (end < ichdr.freemap[i].base)
>>>>>                   return __this_address;
                if (end > mp->m_attr_geo->blksize)
                        return __this_address;

And from the buffer output above, the freemap array is:

	freemap[0].base = 0x00a0
	freemap[0].size = 0xdcf4	end = 0xdd94
	freemap[1].base = 0xfe98
	freemap[1].size = 0x0168	end = 0x10000
	freemap[2].base = 0xf0d8
	freemap[2].size = 0x07e0	end = 0xf8b8

These all look valid - the block size is 0x10000 and so from the
last check in the above verifier fragment we know that the end
of freemap[1] is valid. The problem is that end is declared as:

	uint16_t	end;

And (uint16_t)0x10000 = 0. So we have a verifier bug here, not a
corruption. Fix the verifier to use uint32_t types for the check and
hence avoid the overflow.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=201577
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_attr_leaf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 6fc5425b1474..2652d00842d6 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -243,7 +243,7 @@ xfs_attr3_leaf_verify(
 	struct xfs_mount		*mp = bp->b_target->bt_mount;
 	struct xfs_attr_leafblock	*leaf = bp->b_addr;
 	struct xfs_attr_leaf_entry	*entries;
-	uint16_t			end;
+	uint32_t			end;	/* must be 32bit - see below */
 	int				i;
 
 	xfs_attr3_leaf_hdr_from_disk(mp->m_attr_geo, &ichdr, leaf);
@@ -293,6 +293,11 @@ xfs_attr3_leaf_verify(
 	/*
 	 * Quickly check the freemap information.  Attribute data has to be
 	 * aligned to 4-byte boundaries, and likewise for the free space.
+	 *
+	 * Note that for 64k block size filesystems, the freemap entries cannot
+	 * overflow as they are only be16 fields. However, when checking end
+	 * pointer of the freemap, we have to be careful to detect overflows and
+	 * so use uint32_t for those checks.
 	 */
 	for (i = 0; i < XFS_ATTR_LEAF_MAPSIZE; i++) {
 		if (ichdr.freemap[i].base > mp->m_attr_geo->blksize)
@@ -303,7 +308,9 @@ xfs_attr3_leaf_verify(
 			return __this_address;
 		if (ichdr.freemap[i].size & 0x3)
 			return __this_address;
-		end = ichdr.freemap[i].base + ichdr.freemap[i].size;
+
+		/* be care of 16 bit overflows here */
+		end = (uint32_t)ichdr.freemap[i].base + ichdr.freemap[i].size;
 		if (end < ichdr.freemap[i].base)
 			return __this_address;
 		if (end > mp->m_attr_geo->blksize)
-- 
2.19.1



