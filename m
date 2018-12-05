Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F93BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6746E20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="omo4q3LF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6746E20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeLEJjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:39:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbeLEJjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:39:53 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF9682084C;
        Wed,  5 Dec 2018 09:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002792;
        bh=y4DE3IR68f42m4RDyPhOYQAemIUZk9HAykC6mgYmevw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omo4q3LFT+qgSGacwmSlltWXJUSOuo5+Tl1W4f06SAYoWlt8xcPI7tNResCloh+XB
         Gp5RQ8ItGA+JzwvH4O72lOpqGNYR06Ufs6NN5JZUR4biqOTujos7ddnUgviQ5kG2M8
         RzEPWGjn2rIC2kpzywInJQ5Pk2KoSEnT3lGyqQ10=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 069/123] USB: omap_udc: fix crashes on probe error and module removal
Date:   Wed,  5 Dec 2018 04:35:01 -0500
Message-Id: <20181205093555.5386-69-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>

[ Upstream commit 99f700366fcea1aa2fa3c49c99f371670c3c62f8 ]

We currently crash if usb_add_gadget_udc_release() fails, since the
udc->done is not initialized until in the remove function.
Furthermore, on module removal the udc data is accessed although
the release function is already triggered by usb_del_gadget_udc()
early in the function.

Fix by rewriting the release and remove functions, basically moving
all the cleanup into the release function, and doing the completion
only in the module removal case.

The patch fixes omap_udc module probe with a failing gadged, and also
allows the removal of omap_udc. Tested by running "modprobe omap_udc;
modprobe -r omap_udc" in a loop.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/omap_udc.c | 50 ++++++++++++-------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 1c77218c82af..240ccba44592 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2593,9 +2593,22 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 
 static void omap_udc_release(struct device *dev)
 {
-	complete(udc->done);
+	pullup_disable(udc);
+	if (!IS_ERR_OR_NULL(udc->transceiver)) {
+		usb_put_phy(udc->transceiver);
+		udc->transceiver = NULL;
+	}
+	omap_writew(0, UDC_SYSCON1);
+	remove_proc_file();
+	if (udc->dc_clk) {
+		if (udc->clk_requested)
+			omap_udc_enable_clock(0);
+		clk_put(udc->hhc_clk);
+		clk_put(udc->dc_clk);
+	}
+	if (udc->done)
+		complete(udc->done);
 	kfree(udc);
-	udc = NULL;
 }
 
 static int
@@ -2900,12 +2913,8 @@ static int omap_udc_probe(struct platform_device *pdev)
 	}
 
 	create_proc_file();
-	status = usb_add_gadget_udc_release(&pdev->dev, &udc->gadget,
-			omap_udc_release);
-	if (!status)
-		return 0;
-
-	remove_proc_file();
+	return usb_add_gadget_udc_release(&pdev->dev, &udc->gadget,
+					  omap_udc_release);
 
 cleanup1:
 	kfree(udc);
@@ -2932,36 +2941,15 @@ static int omap_udc_remove(struct platform_device *pdev)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 
-	if (!udc)
-		return -ENODEV;
-
-	usb_del_gadget_udc(&udc->gadget);
-	if (udc->driver)
-		return -EBUSY;
-
 	udc->done = &done;
 
-	pullup_disable(udc);
-	if (!IS_ERR_OR_NULL(udc->transceiver)) {
-		usb_put_phy(udc->transceiver);
-		udc->transceiver = NULL;
-	}
-	omap_writew(0, UDC_SYSCON1);
-
-	remove_proc_file();
+	usb_del_gadget_udc(&udc->gadget);
 
-	if (udc->dc_clk) {
-		if (udc->clk_requested)
-			omap_udc_enable_clock(0);
-		clk_put(udc->hhc_clk);
-		clk_put(udc->dc_clk);
-	}
+	wait_for_completion(&done);
 
 	release_mem_region(pdev->resource[0].start,
 			pdev->resource[0].end - pdev->resource[0].start + 1);
 
-	wait_for_completion(&done);
-
 	return 0;
 }
 
-- 
2.17.1

