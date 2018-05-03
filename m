Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbeECVyw convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 17:54:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:53621 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751074AbeECVyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 17:54:51 -0400
Date: Thu, 3 May 2018 23:54:46 +0200
From: Jean Delvare <jdelvare@suse.de>
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Michel =?UTF-8?B?RMOk?= =?UTF-8?B?bnplcg==?=
        <michel@daenzer.net>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] swiotlb: Silent unwanted warning "buffer is full"
Message-ID: <20180503235446.6a3d3118@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DMA_ATTR_NO_WARN is passed to swiotlb_alloc_buffer(), it should be
passed further down to swiotlb_tbl_map_single(). Otherwise we escape
half of the warnings but still log the other half.

This is one of the multiple causes of spurious warnings reported at:
https://bugs.freedesktop.org/show_bug.cgi?id=104082

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 0176adb00406 ("swiotlb: refactor coherent buffer allocation")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Christian König <christian.koenig@amd.com>
Cc: Michel Dänzer <michel@daenzer.net>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: stable@vger.kernel.org # v4.16
---
 lib/swiotlb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-4.16.orig/lib/swiotlb.c	2018-05-02 15:06:49.677769532 +0200
+++ linux-4.16/lib/swiotlb.c	2018-05-03 15:04:27.136921225 +0200
@@ -727,7 +727,7 @@ swiotlb_alloc_buffer(struct device *dev,
 
 	phys_addr = swiotlb_tbl_map_single(dev,
 			swiotlb_phys_to_dma(dev, io_tlb_start),
-			0, size, DMA_FROM_DEVICE, 0);
+			0, size, DMA_FROM_DEVICE, attrs);
 	if (phys_addr == SWIOTLB_MAP_ERROR)
 		goto out_warn;
 


-- 
Jean Delvare
SUSE L3 Support
