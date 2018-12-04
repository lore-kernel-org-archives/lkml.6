Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB84C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780B220834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780B220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeLDWUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:20:11 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:50182 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDWUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:20:11 -0500
Received: from localhost.localdomain (85-76-96-200-nat.elisa-mobile.fi [85.76.96.200])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id D2487200A5;
        Wed,  5 Dec 2018 00:20:08 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] staging: octeon-usb: use a helper function to set the DMA mask
Date:   Wed,  5 Dec 2018 00:19:26 +0200
Message-Id: <20181204221926.19833-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a helper function to set the DMA mask.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index 9c766f5b812f..14982b6472a0 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -50,6 +50,7 @@
 #include <linux/module.h>
 #include <linux/usb/hcd.h>
 #include <linux/prefetch.h>
+#include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 
 #include <asm/octeon/octeon.h>
@@ -3606,8 +3607,9 @@ static int octeon_usb_probe(struct platform_device *pdev)
 	 * Set the DMA mask to 64bits so we get buffers already translated for
 	 * DMA.
 	 */
-	dev->coherent_dma_mask = ~0;
-	dev->dma_mask = &dev->coherent_dma_mask;
+	i = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (i)
+		return i;
 
 	/*
 	 * Only cn52XX and cn56XX have DWC_OTG USB hardware and the
-- 
2.17.0

