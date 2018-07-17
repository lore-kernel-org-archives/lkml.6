Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EA9ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA2A205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA2A205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbeGQQpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:45:23 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.119]:49647 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729508AbeGQQpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:45:23 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 30C68133C0B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 11:12:00 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fSZVf0stXPvAdfSZof66wn; Tue, 17 Jul 2018 11:11:59 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=46576 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ffSZV-002jyk-0c; Tue, 17 Jul 2018 11:11:29 -0500
Date:   Tue, 17 Jul 2018 11:11:27 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] xfs: use swap macro in xfs_dir2_leafn_rebalance
Message-ID: <20180717161127.GA16337@embeddedor.com>
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
X-Exim-ID: 1ffSZV-002jyk-0c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:46576
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the swap macro and remove unnecessary variable *tmp*. This
makes the code easier to read and maintain. Also, slightly refactor some
code.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/xfs/libxfs/xfs_dir2_node.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_dir2_node.c b/fs/xfs/libxfs/xfs_dir2_node.c
index 2daf874..f1bb343 100644
--- a/fs/xfs/libxfs/xfs_dir2_node.c
+++ b/fs/xfs/libxfs/xfs_dir2_node.c
@@ -1012,7 +1012,7 @@ xfs_dir2_leafn_rebalance(
 	int			oldstale;	/* old count of stale leaves */
 #endif
 	int			oldsum;		/* old total leaf count */
-	int			swap;		/* swapped leaf blocks */
+	int			swap_blocks;	/* swapped leaf blocks */
 	struct xfs_dir2_leaf_entry *ents1;
 	struct xfs_dir2_leaf_entry *ents2;
 	struct xfs_dir3_icleaf_hdr hdr1;
@@ -1023,13 +1023,10 @@ xfs_dir2_leafn_rebalance(
 	/*
 	 * If the block order is wrong, swap the arguments.
 	 */
-	if ((swap = xfs_dir2_leafn_order(dp, blk1->bp, blk2->bp))) {
-		xfs_da_state_blk_t	*tmp;	/* temp for block swap */
+	swap_blocks = xfs_dir2_leafn_order(dp, blk1->bp, blk2->bp);
+	if (swap_blocks)
+		swap(blk1, blk2);
 
-		tmp = blk1;
-		blk1 = blk2;
-		blk2 = tmp;
-	}
 	leaf1 = blk1->bp->b_addr;
 	leaf2 = blk2->bp->b_addr;
 	dp->d_ops->leaf_hdr_from_disk(&hdr1, leaf1);
@@ -1093,11 +1090,11 @@ xfs_dir2_leafn_rebalance(
 	 * Mark whether we're inserting into the old or new leaf.
 	 */
 	if (hdr1.count < hdr2.count)
-		state->inleaf = swap;
+		state->inleaf = swap_blocks;
 	else if (hdr1.count > hdr2.count)
-		state->inleaf = !swap;
+		state->inleaf = !swap_blocks;
 	else
-		state->inleaf = swap ^ (blk1->index <= hdr1.count);
+		state->inleaf = swap_blocks ^ (blk1->index <= hdr1.count);
 	/*
 	 * Adjust the expected index for insertion.
 	 */
-- 
2.7.4

