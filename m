Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17973C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D734620645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D734620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeJNXL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:57 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36027 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727715AbeJNXLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:55 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLh-0004cm-TV; Sun, 14 Oct 2018 16:30:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLa-0000jI-Dv; Sun, 14 Oct 2018 16:30:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Joe Jin" <joe.jin@oracle.com>,
        "John Sobecki" <john.sobecki@oracle.com>,
        "Rzeszutek Wilk" <konrad.wilk@oracle.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.153048413@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 335/366] xen-swiotlb: fix the check condition for
 xen_swiotlb_free_coherent
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/xen/swiotlb-xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -366,7 +366,7 @@ xen_swiotlb_free_coherent(struct device
 	 * physical address */
 	phys = xen_bus_to_phys(dev_addr);
 
-	if (((dev_addr + size - 1 > dma_mask)) ||
+	if (((dev_addr + size - 1 <= dma_mask)) ||
 	    range_straddles_page_boundary(phys, size))
 		xen_destroy_contiguous_region(phys, order);
 

