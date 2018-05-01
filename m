Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755132AbeEANYP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:24:15 -0400
Received: from mail.netline.ch ([148.251.143.178]:36780 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbeEANYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:24:14 -0400
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] swiotlb: Fix inversed DMA_ATTR_NO_WARN test
Date: Tue,  1 May 2018 15:24:11 +0200
Message-Id: <20180501132411.2311-1-michel@daenzer.net>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michel Dänzer <michel.daenzer@amd.com>

The result was printing the warning only when we were explicitly asked
not to.

Cc: stable@vger.kernel.org
Fixes: 0176adb004065d6815a8e67946752df4cd947c5b "swiotlb: refactor
 coherent buffer allocation"
Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
---
 lib/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index c43ec2271469..e9ac21540628 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -750,7 +750,7 @@ swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	swiotlb_tbl_unmap_single(dev, phys_addr, size, DMA_TO_DEVICE,
 			DMA_ATTR_SKIP_CPU_SYNC);
 out_warn:
-	if ((attrs & DMA_ATTR_NO_WARN) && printk_ratelimit()) {
+	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit()) {
 		dev_warn(dev,
 			"swiotlb: coherent allocation failed, size=%zu\n",
 			size);
-- 
2.17.0
