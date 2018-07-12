Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D00DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A8920BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A8920BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbeGLNwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:52:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:50154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726782AbeGLNwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:52:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38447ACC7;
        Thu, 12 Jul 2018 13:43:02 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips/jazz: provide missing dma_mask/coherent_dma_mask
Date:   Thu, 12 Jul 2018 15:42:55 +0200
Message-Id: <20180712134255.30748-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 205e1b7f51e4 ("dma-mapping: warn when there is no coherent_dma_mask")
introduced a warning, if a device is missing a coherent_dma_mask.
ESP and sonic are using dma mapping functions, so they need dma masks.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/jazz/setup.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/mips/jazz/setup.c b/arch/mips/jazz/setup.c
index 448fd41792e4..1b5e121c3f0d 100644
--- a/arch/mips/jazz/setup.c
+++ b/arch/mips/jazz/setup.c
@@ -16,6 +16,7 @@
 #include <linux/screen_info.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/jazz.h>
 #include <asm/jazzdma.h>
@@ -136,10 +137,16 @@ static struct resource jazz_esp_rsrc[] = {
 	}
 };
 
+static u64 jazz_esp_dma_mask = DMA_BIT_MASK(32);
+
 static struct platform_device jazz_esp_pdev = {
 	.name		= "jazz_esp",
 	.num_resources	= ARRAY_SIZE(jazz_esp_rsrc),
-	.resource	= jazz_esp_rsrc
+	.resource	= jazz_esp_rsrc,
+	.dev = {
+		.dma_mask	   = &jazz_esp_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	}
 };
 
 static struct resource jazz_sonic_rsrc[] = {
@@ -155,10 +162,16 @@ static struct resource jazz_sonic_rsrc[] = {
 	}
 };
 
+static u64 jazz_sonic_dma_mask = DMA_BIT_MASK(32);
+
 static struct platform_device jazz_sonic_pdev = {
 	.name		= "jazzsonic",
 	.num_resources	= ARRAY_SIZE(jazz_sonic_rsrc),
-	.resource	= jazz_sonic_rsrc
+	.resource	= jazz_sonic_rsrc,
+	.dev = {
+		.dma_mask	   = &jazz_sonic_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	}
 };
 
 static struct resource jazz_cmos_rsrc[] = {
-- 
2.13.7

