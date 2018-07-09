Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8FDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD34208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD34208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933070AbeGIVDC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:03:02 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.253]:38313 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932956AbeGIVDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:03:01 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id EED202DE9FC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 16:03:00 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id cdJEf1rW2kBj6cdJEfPApm; Mon, 09 Jul 2018 16:03:00 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=50580 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fcdJE-003KU4-Fi; Mon, 09 Jul 2018 16:03:00 -0500
Date:   Mon, 9 Jul 2018 16:02:59 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] xfs_bmap_util: use swap macro
Message-ID: <20180709210259.GA18992@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fcdJE-003KU4-Fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:50580
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the swap macro and remove some unnecessary variables.
This makes the code easier to read and maintain. Also, reduces the
stack usage.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2
 - Use swap in a couple more of places.

 fs/xfs/xfs_bmap_util.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 83b1e8c..a657d0a 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1691,7 +1691,6 @@ xfs_swap_extent_forks(
 	int			*src_log_flags,
 	int			*target_log_flags)
 {
-	struct xfs_ifork	tempifp, *ifp, *tifp;
 	xfs_filblks_t		aforkblks = 0;
 	xfs_filblks_t		taforkblks = 0;
 	xfs_extnum_t		junk;
@@ -1733,11 +1732,7 @@ xfs_swap_extent_forks(
 	/*
 	 * Swap the data forks of the inodes
 	 */
-	ifp = &ip->i_df;
-	tifp = &tip->i_df;
-	tempifp = *ifp;		/* struct copy */
-	*ifp = *tifp;		/* struct copy */
-	*tifp = tempifp;	/* struct copy */
+	swap(ip->i_df, tip->i_df);
 
 	/*
 	 * Fix the on-disk inode values
@@ -1746,13 +1741,8 @@ xfs_swap_extent_forks(
 	ip->i_d.di_nblocks = tip->i_d.di_nblocks - taforkblks + aforkblks;
 	tip->i_d.di_nblocks = tmp + taforkblks - aforkblks;
 
-	tmp = (uint64_t) ip->i_d.di_nextents;
-	ip->i_d.di_nextents = tip->i_d.di_nextents;
-	tip->i_d.di_nextents = tmp;
-
-	tmp = (uint64_t) ip->i_d.di_format;
-	ip->i_d.di_format = tip->i_d.di_format;
-	tip->i_d.di_format = tmp;
+	swap(ip->i_d.di_nextents, tip->i_d.di_nextents);
+	swap(ip->i_d.di_format, tip->i_d.di_format);
 
 	/*
 	 * The extents in the source inode could still contain speculative
@@ -1846,7 +1836,6 @@ xfs_swap_extents(
 	int			src_log_flags, target_log_flags;
 	int			error = 0;
 	int			lock_flags;
-	struct xfs_ifork	*cowfp;
 	uint64_t		f;
 	int			resblks = 0;
 
@@ -1987,18 +1976,11 @@ xfs_swap_extents(
 
 	/* Swap the cow forks. */
 	if (xfs_sb_version_hasreflink(&mp->m_sb)) {
-		xfs_extnum_t	extnum;
-
 		ASSERT(ip->i_cformat == XFS_DINODE_FMT_EXTENTS);
 		ASSERT(tip->i_cformat == XFS_DINODE_FMT_EXTENTS);
 
-		extnum = ip->i_cnextents;
-		ip->i_cnextents = tip->i_cnextents;
-		tip->i_cnextents = extnum;
-
-		cowfp = ip->i_cowfp;
-		ip->i_cowfp = tip->i_cowfp;
-		tip->i_cowfp = cowfp;
+		swap(ip->i_cnextents, tip->i_cnextents);
+		swap(ip->i_cowfp, tip->i_cowfp);
 
 		if (ip->i_cowfp && ip->i_cowfp->if_bytes)
 			xfs_inode_set_cowblocks_tag(ip);
-- 
2.7.4

