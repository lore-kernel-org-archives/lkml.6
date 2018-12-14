Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89DAC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6E7214DE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789651;
	bh=WoRxcNLYpd4Uw8htAFhMVXgsMYfr1ONTOn6jCW5Yx0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q1RjBpwgF5nQFkim/HNX2gdhqJIZN9zefRAxm+YywkyoE9Wg9cQo2bXnl7UJ8AejV
	 US0SP0u8YOuccOUwAAleH+SGkKqF/SC3AauqRAkoQZNZo462X4aH7kEyQyDU5rb1+i
	 a347H1cl6H56ISswWD+iOGpS7un1RfrQK7vFLlbQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6E7214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbeLNMOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:14:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730579AbeLNMOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:14:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D213214F1;
        Fri, 14 Dec 2018 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789646;
        bh=WoRxcNLYpd4Uw8htAFhMVXgsMYfr1ONTOn6jCW5Yx0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qracclw+hB5QNB1GQaJ1w/wfFi8paimpAVPNV87SUOD94AKx9LbZyOLfHzIgYFL9X
         OvWIhc7FXVUlX/fHRuW+R28Cv+TicN5bHOJzrWbWk3UlF1N3BFSUu2sVcQ1DNiBbVp
         TOAQfI2pVeisr4VhtS6o7uV/JhnC3HSDCKpCs7X0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 22/88] USB: omap_udc: use devm_request_irq()
Date:   Fri, 14 Dec 2018 12:59:56 +0100
Message-Id: <20181214115703.977504001@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 9b7d39484ed3..b25eac2dcaf8 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2886,8 +2886,8 @@ static int omap_udc_probe(struct platform_device *pdev)
 		udc->clr_halt = UDC_RESET_EP;
 
 	/* USB general purpose IRQ:  ep0, state changes, dma, etc */
-	status = request_irq(pdev->resource[1].start, omap_udc_irq,
-			0, driver_name, udc);
+	status = devm_request_irq(&pdev->dev, pdev->resource[1].start,
+				  omap_udc_irq, 0, driver_name, udc);
 	if (status != 0) {
 		ERR("can't get irq %d, err %d\n",
 			(int) pdev->resource[1].start, status);
@@ -2895,20 +2895,20 @@ static int omap_udc_probe(struct platform_device *pdev)
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
@@ -2921,22 +2921,11 @@ static int omap_udc_probe(struct platform_device *pdev)
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
@@ -2980,12 +2969,6 @@ static int omap_udc_remove(struct platform_device *pdev)
 
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
2.19.1



