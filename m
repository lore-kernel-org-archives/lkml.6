Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA83C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CB120B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbfAaQYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:24:30 -0500
Received: from 8bytes.org ([81.169.241.247]:36306 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388296AbfAaQYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:24:30 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C031D22D; Thu, 31 Jan 2019 17:24:28 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] swiotlb: Return error from swiotlb_init_with_tbl()
Date:   Thu, 31 Jan 2019 17:24:24 +0100
Message-Id: <20190131162424.10477-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The only reason why swiotlb_init_with_tbl() can fail is an
allocation failure in the memblock_alloc() function. But
this function just calls panic() in case it can't fulfill
the request and never returns an error, therefore
swiotlb_init_with_tbl() also never actually returns an
error.

There are three call-sites of this function in the kernel.
All of them check for an error being returned, and two of
them call panic() itself in case the function returns an
error. The third call-site handles the error case and
doesn't crash the system. This is in the swiotlb_init()
function.

Since there is a call-site which handles an error and does
not crash the system, change the function to return
allocation failures to the caller.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 kernel/dma/swiotlb.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c873f9cc2146..4619d078c67c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -203,12 +203,15 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
 	 * between io_tlb_start and io_tlb_end.
 	 */
-	io_tlb_list = memblock_alloc(
+	io_tlb_list = memblock_alloc_nopanic(
 				PAGE_ALIGN(io_tlb_nslabs * sizeof(int)),
 				PAGE_SIZE);
-	io_tlb_orig_addr = memblock_alloc(
+	io_tlb_orig_addr = memblock_alloc_nopanic(
 				PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)),
 				PAGE_SIZE);
+	if (io_tlb_list == NULL || io_tlb_orig_addr == NULL)
+		goto out_fail;
+
 	for (i = 0; i < io_tlb_nslabs; i++) {
 		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
 		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
@@ -219,7 +222,26 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 		swiotlb_print_info();
 
 	swiotlb_set_max_segment(io_tlb_nslabs << IO_TLB_SHIFT);
+
 	return 0;
+
+out_fail:
+	if (io_tlb_list)
+		memblock_free(io_tlb_list,
+			      PAGE_ALIGN(io_tlb_nslabs * sizeof(int)));
+
+	if (io_tlb_orig_addr)
+		memblock_free(io_tlb_orig_addr,
+			      PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)));
+
+	io_tlb_list      = NULL;
+	io_tlb_orig_addr = NULL;
+	io_tlb_end       = 0;
+	io_tlb_start     = 0;
+	io_tlb_nslabs    = 0;
+	max_segment      = 0;
+
+	return -ENOMEM;
 }
 
 /*
-- 
2.16.4

