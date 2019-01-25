Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1F9C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354AB218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfAYM5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:57:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44692 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfAYM5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:57:01 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id 6394D26025D
From:   =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        =?utf-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [RFC] etnaviv: Fix gpu->memory_base address
Date:   Fri, 25 Jan 2019 07:56:52 -0500
Message-Id: <20190125125652.18425-1-gael.portay@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When used on a 2GB memory IMX6 device, the driver configures etnaviv
memory_base address to:

	dma_mask - SZ_2G + 1

which is 2GB as the dma_mask has all bits on. This results in the gpu
having a narrow linear memory window of only 256MB. This patch changes
the behavior to configure etnaviv memory_base to:

	gpu->memory_base = PHYS_OFFSET

which leaves the device with a linear window of 2G in our case.

CC: Peter Senna Tschudin <peter.senna@collabora.com>
CC: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
---
Hi all,

I am looking for a proper function to get the end of the physical
memory. We have tried memblock_end_of_DRAM at first. That function
returns the value we are expecting, but it is not defined for drivers
compiled as modules.

        ERROR: "memblock_end_of_DRAM" [drivers/gpu/drm/etnaviv/etnaviv.ko] undefined!

The reason why we need this is very specific to the etnaviv driver.

Etnaviv tries to guess the base address for the GPU memory so it overlaps the
CMA area (located at the end of the memory).

See comment below from the driver[1]:

        /*
         * Set the GPU linear window to be at the end of the DMA window, where
         * the CMA area is likely to reside. This ensures that we are able to
         * map the command buffers while having the linear window overlap as
         * much RAM as possible, so we can optimize mappings for other buffers.
         *
         * For 3D cores only do this if MC2.0 is present, as with MC1.0 it leads
         * to different views of the memory on the individual engines.
         */
        if (!(gpu->identity.features & chipFeatures_PIPE_3D) ||
            (gpu->identity.minor_features0 & chipMinorFeatures0_MC20)) {
                u32 dma_mask = (u32)dma_get_required_mask(gpu->dev);
                if (dma_mask < PHYS_OFFSET + SZ_2G)
                        gpu->memory_base = PHYS_OFFSET;
                else
                        gpu->memory_base = dma_mask - SZ_2G + 1;
        (...)
        }

As you can see in the code above, etnaviv calls dma_get_required_mask() to get
the end of the physical memory.

Unfortunalty, the function dma_get_required_mask() returns 0xffffffff (i.e.
4GB-1) while we have actually 2GB of memory on the device.

Etnaviv deduces a GPU memory base address that starts at 2GB. As a consequence,
the overlap between the physical and the GPU memory is only 256MB. We were
expecting a GPU memory base address that starts at the memory physical offset
(PHYS_OFFSET, 256MB) and a 2GB-long overlap.

This is the consequence of using a function that does not returns the real
amount of memory.

Is there another function I can use to get the real amount of available memory?

Kind Regards,
Gael

[1]: https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/etnaviv/etnaviv_gpu.c#L729-L733

 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 6904535475de..add80ce73df4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -10,6 +10,7 @@
 #include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/thermal.h>
+#include <linux/memblock.h>
 
 #include "etnaviv_cmdbuf.h"
 #include "etnaviv_dump.h"
@@ -726,11 +727,11 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 	 */
 	if (!(gpu->identity.features & chipFeatures_PIPE_3D) ||
 	    (gpu->identity.minor_features0 & chipMinorFeatures0_MC20)) {
-		u32 dma_mask = (u32)dma_get_required_mask(gpu->dev);
-		if (dma_mask < PHYS_OFFSET + SZ_2G)
+		u32 max_memory = min((u32) dma_get_required_mask(gpu->dev), memblock_end_of_DRAM());
+		if (max_memory <= SZ_2G + PHYS_OFFSET)
 			gpu->memory_base = PHYS_OFFSET;
 		else
-			gpu->memory_base = dma_mask - SZ_2G + 1;
+			gpu->memory_base = max_memory - SZ_2G;
 	} else if (PHYS_OFFSET >= SZ_2G) {
 		dev_info(gpu->dev, "Need to move linear window on MC1.0, disabling TS\n");
 		gpu->memory_base = PHYS_OFFSET;
-- 
2.20.1

