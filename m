Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4777C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B772083D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B772083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732786AbeGKLm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:42:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:56996 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732600AbeGKLm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:42:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03857AD74;
        Wed, 11 Jul 2018 11:39:00 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mips/jazz: provide dma_mask/coherent_dma_mask for platform devices
Date:   Wed, 11 Jul 2018 13:38:52 +0200
Message-Id: <20180711113852.2734-2-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180711113852.2734-1-tbogendoerfer@suse.de>
References: <20180711113852.2734-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform devices for sonic and esp didn't have dma_masks.

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

