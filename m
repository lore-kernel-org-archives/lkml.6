Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F566C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367E820878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QULMlWas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367E820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeLEJju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:39:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbeLEJjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:39:49 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1933D20851;
        Wed,  5 Dec 2018 09:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002788;
        bh=/n7UNaky7BxLd26DHMk6CiDStwxZAIYF7bRuZ4o+k98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QULMlWasAaTSnANtVPnj3+ja20qbojc5brOv2VN09ujv72lgryh0q1qPs7TqjsvRJ
         ySuf+9l4497gTl05XlgW/p2ANsdqlkWNKZBTp0xFsj2cJQbPTbkjMlPh5k8qOx/t0R
         IzPM+rgxTvj0dQQe9YdGIGeRGmMZjizoQQvbEGsw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 068/123] USB: omap_udc: use devm_request_irq()
Date:   Wed,  5 Dec 2018 04:35:00 -0500
Message-Id: <20181205093555.5386-68-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>

[ Upstream commit 286afdde1640d8ea8916a0f05e811441fbbf4b9d ]

The current code fails to release the third irq on the error path
(observed by reading the code), and we get also multiple WARNs with
failing gadget drivers due to duplicate IRQ releases. Fix by using
devm_request_irq().

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.17.1

