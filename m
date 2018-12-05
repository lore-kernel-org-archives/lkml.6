Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936F5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56ACD2151B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C675ACXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56ACD2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbeLEJ4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:56:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730195AbeLEJ4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:56:03 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9702F20989;
        Wed,  5 Dec 2018 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003762;
        bh=eMQaOQ9A4oJfNb3WEA0+ZdLSve7xy/8YVEdknuTf1iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C675ACXDXAbUITscIbFcYAwTAzPSmrGm86/mJS7ruSk008rkMjAZnhDEGi2YR6lIu
         ex+a366QrlLSNsoqVDuZIrybEn9IcWHOEwHMAnQvRrcRa7Rvdb5qb876IZSeh7P0xt
         O3VpojNOZPFLfW7uHSKcs51aPLKl6Er7qEDdwBMI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 12/26] USB: omap_udc: fix crashes on probe error and module removal
Date:   Wed,  5 Dec 2018 04:54:16 -0500
Message-Id: <20181205095430.8019-12-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095430.8019-1-sashal@kernel.org>
References: <20181205095430.8019-1-sashal@kernel.org>
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
index b1f64608c373..a66031df2447 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2591,9 +2591,22 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 
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
@@ -2898,12 +2911,8 @@ static int omap_udc_probe(struct platform_device *pdev)
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
@@ -2930,36 +2939,15 @@ static int omap_udc_remove(struct platform_device *pdev)
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

