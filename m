Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295BFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8749214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="scZ9CSd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfAJNhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:37:18 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:51496 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbfAJNhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547127433; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y6x70HDfpOVTaqs0BzNGMeOkw6Plbds0nsWUN9mORg4=;
        b=scZ9CSd4sDdiB8vDl+Xw9oCDfWW0nUMZKMDNsJE1sdNVHBtAleF+jp71usGQGVFPlF2uEe
        DR8LA0vYE6IGNSawEbLoxQZuh18m+0EVeWuHu/xeVh7fR+UJGDq7zHYS0K2bSV7Ukgv7RA
        fwonRTbZXEOFjpZ8S4N1AYUuqyggjR8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/4] usb: musb: jz4740: Add support for devicetree
Date:   Thu, 10 Jan 2019 10:36:58 -0300
Message-Id: <20190110133700.4471-2-paul@crapouillou.net>
In-Reply-To: <20190110133700.4471-1-paul@crapouillou.net>
References: <20190110133700.4471-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing the driver from devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

v2: Add MODULE_DEVICE_TABLE and wrap inside CONFIG_OF

 drivers/usb/musb/jz4740.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index 04d8b2bc205a..a60627bf7be3 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/usb/usb_phy_generic.h>
 
@@ -188,11 +189,20 @@ static int jz4740_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id jz4740_musb_of_match[] = {
+	{ .compatible = "ingenic,jz4740-musb" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, jz4740_musb_of_match);
+#endif
+
 static struct platform_driver jz4740_driver = {
 	.probe		= jz4740_probe,
 	.remove		= jz4740_remove,
 	.driver		= {
 		.name	= "musb-jz4740",
+		.of_match_table = of_match_ptr(jz4740_musb_of_match),
 	},
 };
 
-- 
2.11.0

