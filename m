Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939777AbeE1QMl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936606AbeE1KN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:13:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 142/185] zorro: Set up z->dev.dma_mask for the DMA API
Date: Mon, 28 May 2018 12:03:03 +0200
Message-Id: <20180528100107.637680151@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Schmitz <schmitzmic@gmail.com>

[ Upstream commit 55496d3fe2acd1a365c43cbd613a20ecd4d74395 ]

The generic DMA API uses dev->dma_mask to check the DMA addressable
memory bitmask, and warns if no mask is set or even allocated.

Set z->dev.dma_coherent_mask on Zorro bus scan, and make z->dev.dma_mask
to point to z->dev.dma_coherent_mask so device drivers that need DMA have
everything set up to avoid warnings from dma_alloc_coherent(). Drivers can
still use dma_set_mask_and_coherent() to explicitly set their DMA bit mask.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
[geert: Handle Zorro II with 24-bit address space]
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/zorro/zorro.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/zorro/zorro.c
+++ b/drivers/zorro/zorro.c
@@ -16,6 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/string.h>
 #include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
 #include <linux/slab.h>
 
 #include <asm/byteorder.h>
@@ -185,6 +186,17 @@ static int __init amiga_zorro_probe(stru
 		z->dev.parent = &bus->dev;
 		z->dev.bus = &zorro_bus_type;
 		z->dev.id = i;
+		switch (z->rom.er_Type & ERT_TYPEMASK) {
+		case ERT_ZORROIII:
+			z->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+			break;
+
+		case ERT_ZORROII:
+		default:
+			z->dev.coherent_dma_mask = DMA_BIT_MASK(24);
+			break;
+		}
+		z->dev.dma_mask = &z->dev.coherent_dma_mask;
 	}
 
 	/* ... then register them */
