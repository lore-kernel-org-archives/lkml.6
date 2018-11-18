Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AC3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 19:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09402075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 19:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09402075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeKSGUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:20:51 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:45758 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbeKSGUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:20:50 -0500
Received: from localhost.localdomain (85-76-71-135-nat.elisa-mobile.fi [85.76.71.135])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 592C52002F;
        Sun, 18 Nov 2018 21:59:36 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/4] USB: omap_udc: use devm_request_irq()
Date:   Sun, 18 Nov 2018 21:59:09 +0200
Message-Id: <20181118195912.14026-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code fails to release the third irq on the error path
(observed by reading the code), and we get also multiple WARNs with
failing gadget drivers due to duplicate IRQ releases. Fix by using
devm_request_irq().

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/usb/gadget/udc/omap_udc.c | 37 +++++++++----------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 3a16431da321..1c77218c82af 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2867,8 +2867,8 @@ static int omap_udc_probe(struct platform_device *pdev)
 		udc->clr_halt = UDC_RESET_EP;
 
 	/* USB general purpose IRQ:  ep0, state changes, dma, etc */
-	status = request_irq(pdev->resource[1].start, omap_udc_irq,
-			0, driver_name, udc);
+	status = devm_request_irq(&pdev->dev, pdev->resource[1].start,
+				  omap_udc_irq, 0, driver_name, udc);
 	if (status != 0) {
 		ERR("can't get irq %d, err %d\n",
 			(int) pdev->resource[1].start, status);
@@ -2876,20 +2876,20 @@ static int omap_udc_probe(struct platform_device *pdev)
 	}
 
 	/* USB "non-iso" IRQ (PIO for all but ep0) */
-	status = request_irq(pdev->resource[2].start, omap_udc_pio_irq,
-			0, "omap_udc pio", udc);
+	status = devm_request_irq(&pdev->dev, pdev->resource[2].start,
+				  omap_udc_pio_irq, 0, "omap_udc pio", udc);
 	if (status != 0) {
 		ERR("can't get irq %d, err %d\n",
 			(int) pdev->resource[2].start, status);
-		goto cleanup2;
+		goto cleanup1;
 	}
 #ifdef	USE_ISO
-	status = request_irq(pdev->resource[3].start, omap_udc_iso_irq,
-			0, "omap_udc iso", udc);
+	status = devm_request_irq(&pdev->dev, pdev->resource[3].start,
+				  omap_udc_iso_irq, 0, "omap_udc iso", udc);
 	if (status != 0) {
 		ERR("can't get irq %d, err %d\n",
 			(int) pdev->resource[3].start, status);
-		goto cleanup3;
+		goto cleanup1;
 	}
 #endif
 	if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
@@ -2902,22 +2902,11 @@ static int omap_udc_probe(struct platform_device *pdev)
 	create_proc_file();
 	status = usb_add_gadget_udc_release(&pdev->dev, &udc->gadget,
 			omap_udc_release);
-	if (status)
-		goto cleanup4;
-
-	return 0;
+	if (!status)
+		return 0;
 
-cleanup4:
 	remove_proc_file();
 
-#ifdef	USE_ISO
-cleanup3:
-	free_irq(pdev->resource[2].start, udc);
-#endif
-
-cleanup2:
-	free_irq(pdev->resource[1].start, udc);
-
 cleanup1:
 	kfree(udc);
 	udc = NULL;
@@ -2961,12 +2950,6 @@ static int omap_udc_remove(struct platform_device *pdev)
 
 	remove_proc_file();
 
-#ifdef	USE_ISO
-	free_irq(pdev->resource[3].start, udc);
-#endif
-	free_irq(pdev->resource[2].start, udc);
-	free_irq(pdev->resource[1].start, udc);
-
 	if (udc->dc_clk) {
 		if (udc->clk_requested)
 			omap_udc_enable_clock(0);
-- 
2.17.0

