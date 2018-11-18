Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE553C04EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 19:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D552075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 19:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D552075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeKSGUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:20:51 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:45764 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeKSGUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:20:50 -0500
Received: from localhost.localdomain (85-76-71-135-nat.elisa-mobile.fi [85.76.71.135])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id C8AF920032;
        Sun, 18 Nov 2018 21:59:36 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/4] USB: omap_udc: fix crashes on probe error and module removal
Date:   Sun, 18 Nov 2018 21:59:10 +0200
Message-Id: <20181118195912.14026-2-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181118195912.14026-1-aaro.koskinen@iki.fi>
References: <20181118195912.14026-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently crash if usb_add_gadget_udc_release() fails, since the
udc->done is not initialized until in the remove function. Furthermore, on
module removal the udc data is accessed although the release function
is already triggered by usb_del_gadget_udc() early in the function.
Fix by releasing the data manually.

The patch fixes omap_udc module probe with a failing gadged, and also
allows the removal of omap_udc. Tested by running "modprobe omap_udc;
modprobe -r omap_udc" in a loop.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/usb/gadget/udc/omap_udc.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 1c77218c82af..d98782ec254d 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2591,9 +2591,8 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 	return buf;
 }
 
-static void omap_udc_release(struct device *dev)
+static void omap_udc_release(void)
 {
-	complete(udc->done);
 	kfree(udc);
 	udc = NULL;
 }
@@ -2900,16 +2899,14 @@ static int omap_udc_probe(struct platform_device *pdev)
 	}
 
 	create_proc_file();
-	status = usb_add_gadget_udc_release(&pdev->dev, &udc->gadget,
-			omap_udc_release);
+	status = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
 	if (!status)
 		return 0;
 
 	remove_proc_file();
 
 cleanup1:
-	kfree(udc);
-	udc = NULL;
+	omap_udc_release();
 
 cleanup0:
 	if (!IS_ERR_OR_NULL(xceiv))
@@ -2930,8 +2927,6 @@ static int omap_udc_probe(struct platform_device *pdev)
 
 static int omap_udc_remove(struct platform_device *pdev)
 {
-	DECLARE_COMPLETION_ONSTACK(done);
-
 	if (!udc)
 		return -ENODEV;
 
@@ -2939,8 +2934,6 @@ static int omap_udc_remove(struct platform_device *pdev)
 	if (udc->driver)
 		return -EBUSY;
 
-	udc->done = &done;
-
 	pullup_disable(udc);
 	if (!IS_ERR_OR_NULL(udc->transceiver)) {
 		usb_put_phy(udc->transceiver);
@@ -2960,7 +2953,7 @@ static int omap_udc_remove(struct platform_device *pdev)
 	release_mem_region(pdev->resource[0].start,
 			pdev->resource[0].end - pdev->resource[0].start + 1);
 
-	wait_for_completion(&done);
+	omap_udc_release();
 
 	return 0;
 }
-- 
2.17.0

