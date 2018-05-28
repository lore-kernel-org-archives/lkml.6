Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937155AbeE1K2T (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937121AbeE1K2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:28:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        John Sobecki <john.sobecki@oracle.com>,
        Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.9 013/329] xen-swiotlb: fix the check condition for xen_swiotlb_free_coherent
Date: Mon, 28 May 2018 11:59:02 +0200
Message-Id: <20180528100243.366804351@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Jin <joe.jin@oracle.com>

commit 4855c92dbb7b3b85c23e88ab7ca04f99b9677b41 upstream.

When run raidconfig from Dom0 we found that the Xen DMA heap is reduced,
but Dom Heap is increased by the same size. Tracing raidconfig we found
that the related ioctl() in megaraid_sas will call dma_alloc_coherent()
to apply memory. If the memory allocated by Dom0 is not in the DMA area,
it will exchange memory with Xen to meet the requiment. Later drivers
call dma_free_coherent() to free the memory, on xen_swiotlb_free_coherent()
the check condition (dev_addr + size - 1 <= dma_mask) is always false,
it prevents calling xen_destroy_contiguous_region() to return the memory
to the Xen DMA heap.

This issue introduced by commit 6810df88dcfc2 "xen-swiotlb: When doing
coherent alloc/dealloc check before swizzling the MFNs.".

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Tested-by: John Sobecki <john.sobecki@oracle.com>
Reviewed-by: Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/swiotlb-xen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -359,7 +359,7 @@ xen_swiotlb_free_coherent(struct device
 	 * physical address */
 	phys = xen_bus_to_phys(dev_addr);
 
-	if (((dev_addr + size - 1 > dma_mask)) ||
+	if (((dev_addr + size - 1 <= dma_mask)) ||
 	    range_straddles_page_boundary(phys, size))
 		xen_destroy_contiguous_region(phys, order);
 
