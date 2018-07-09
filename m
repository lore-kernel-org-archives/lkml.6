Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E52C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF3A20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF3A20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbeGIOGP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:06:15 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.140]:21987 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932508AbeGIOGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:06:14 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 502563722D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 09:06:11 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id cWnOf1XA8RPojcWngfbBsD; Mon, 09 Jul 2018 09:06:10 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=42994 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fcWnN-0008MN-UJ; Mon, 09 Jul 2018 09:05:42 -0500
Date:   Mon, 9 Jul 2018 09:05:39 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] xfs_bmap_util: use swap macro
Message-ID: <20180709140539.GA17517@embeddedor.com>
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
X-Exim-ID: 1fcWnN-0008MN-UJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:42994
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
 fs/xfs/xfs_bmap_util.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 83b1e8c..4b0b16f 100644
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
@@ -1987,14 +1982,10 @@ xfs_swap_extents(
 
 	/* Swap the cow forks. */
 	if (xfs_sb_version_hasreflink(&mp->m_sb)) {
-		xfs_extnum_t	extnum;
-
 		ASSERT(ip->i_cformat == XFS_DINODE_FMT_EXTENTS);
 		ASSERT(tip->i_cformat == XFS_DINODE_FMT_EXTENTS);
 
-		extnum = ip->i_cnextents;
-		ip->i_cnextents = tip->i_cnextents;
-		tip->i_cnextents = extnum;
+		swap(ip->i_cnextents, tip->i_cnextents);
 
 		cowfp = ip->i_cowfp;
 		ip->i_cowfp = tip->i_cowfp;
-- 
2.7.4

