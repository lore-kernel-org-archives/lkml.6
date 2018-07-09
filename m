Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D15C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDB420835
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDB420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933262AbeGIQYg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:24:36 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.46]:14520 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933119AbeGIQYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:24:35 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 0BBCF360762
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 11:13:21 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id cYmPf86TPRPojcYmhfhkSL; Mon, 09 Jul 2018 11:13:20 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=46304 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fcYmO-001IZF-KJ; Mon, 09 Jul 2018 11:12:48 -0500
Date:   Mon, 9 Jul 2018 11:12:47 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] xfs_attr_leaf: use swap macro in xfs_attr3_leaf_rebalance
Message-ID: <20180709161247.GA4746@embeddedor.com>
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
X-Exim-ID: 1fcYmO-001IZF-KJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:46304
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
 fs/xfs/libxfs/xfs_attr_leaf.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 76e9004..ec0bf96 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -1570,17 +1570,10 @@ xfs_attr3_leaf_rebalance(
 	 */
 	swap = 0;
 	if (xfs_attr3_leaf_order(blk1->bp, &ichdr1, blk2->bp, &ichdr2)) {
-		struct xfs_da_state_blk	*tmp_blk;
-		struct xfs_attr3_icleaf_hdr tmp_ichdr;
+		swap(blk1, blk2);
 
-		tmp_blk = blk1;
-		blk1 = blk2;
-		blk2 = tmp_blk;
-
-		/* struct copies to swap them rather than reconverting */
-		tmp_ichdr = ichdr1;
-		ichdr1 = ichdr2;
-		ichdr2 = tmp_ichdr;
+		/* swap structures rather than reconverting them */
+		swap(ichdr1, ichdr2);
 
 		leaf1 = blk1->bp->b_addr;
 		leaf2 = blk2->bp->b_addr;
-- 
2.7.4

