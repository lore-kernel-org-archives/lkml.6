Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B111C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312C22085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNTELrLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312C22085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388146AbeKFGyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:54:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41300 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbeKFGyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:54:52 -0500
Received: by mail-pg1-f193.google.com with SMTP id k13so4805917pga.8;
        Mon, 05 Nov 2018 13:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ngQKXqCKv/9kmuh/X+ZGBLfcht+OoCCEYDevLC20Jmo=;
        b=LNTELrLw6WDDt03v3ckiKHBZbTHajvVKFoIbuYf3f0ZGEe/EfzdA38irFVnbNRpTsd
         PVVrGZNZlRM6I1laYeZXW1DOEmSeQfezOTsg47F5w9dq3EklP0Blp/yoSd8uq2ZG9sJV
         dVPfhTayTTA3ZiL6epWzr3Y7YEhXOAeEhGr9fKWRtCDhHYfClErl4cvj1Ufax0FSjT1K
         s1IiagsbpGF+TlXmniontFC4wMQqfu9Qg7XRs13lHxkZ687BeMwZIJ56Hw9f1J8XLPR7
         nY3oiWb+I3wT8Qv/MEaGmxCkTlYS8AbgZ4CT7WF7PfNZcIxNgQ2kHeoHSH9AZSp0GrfJ
         uARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ngQKXqCKv/9kmuh/X+ZGBLfcht+OoCCEYDevLC20Jmo=;
        b=LnJFSji0zbFD5uX97Ht8XXOLkwBrnzZNeNP30+TfXr8PExDFz3BkXBYPvo0eoxPUGN
         xbsGXjgoKxrItdG7+Et+LlFqHjXYUDo93//mhdEN9nCY39x7XeaMKzmH9t/TYBZ/YzCy
         f7jxVVo5zJXlCUbB8xuGd/efkNMTFN119R+vwzQ3iKdJw2ojQB1THsBiEV3Jr2v6kwNW
         kmodQLYv/iBNHanKtIqQzaA6f/t9UWCW1ILe5n9YbkA4bRWpNtP/5+QFefiXCnaYloBW
         siN/tnTT9jYkJXy2zbgT86FlhA5DYccX71dFiPtwaTrNCE/hHzc4V0NNc2QfkUZwY/BT
         HYIw==
X-Gm-Message-State: AGRZ1gKxeRwqTd7KBIETLl/G/mwj/L3b6IEf8xXCSkxuhDykHQuTCbHT
        oAS6yzCzEjtlptRTzeqZVIh3E0uhCLg=
X-Google-Smtp-Source: AJdET5e0UFugRIKAfjsvOFfjIM7qrU1DMaY9uI0lwr5d7Mv1oNvkHccoRjRTIjjyEg/BL6HEuDlvdA==
X-Received: by 2002:a63:a441:: with SMTP id c1-v6mr21712527pgp.49.1541453589982;
        Mon, 05 Nov 2018 13:33:09 -0800 (PST)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id m129-v6sm14328440pfm.78.2018.11.05.13.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 13:33:09 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH V3 4/6] usb: ohci-platform: Add support for Broadcom STB SoC's
Date:   Mon,  5 Nov 2018 16:31:31 -0500
Message-Id: <1541453493-34981-5-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1541453493-34981-1-git-send-email-alcooperx@gmail.com>
References: <1541453493-34981-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Broadcom STB SoC's to the ohci platform driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/host/ohci-platform.c | 34 ++++++++++++++++++++++++++++------
 include/linux/usb/ohci_pdriver.h |  1 +
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 65a1c3fdc88c..f425168238e6 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -99,12 +100,23 @@ static int ohci_platform_probe(struct platform_device *dev)
 	if (usb_disabled())
 		return -ENODEV;
 
-	/*
-	 * Use reasonable defaults so platforms don't have to provide these
-	 * with DT probing on ARM.
-	 */
-	if (!pdata)
-		pdata = &ohci_platform_defaults;
+	if (!pdata) {
+		const struct usb_ohci_pdata *match_pdata;
+
+		match_pdata = of_device_get_match_data(&dev->dev);
+		if (match_pdata) {
+			pdata = devm_kmemdup(&dev->dev, match_pdata,
+					     sizeof(*pdata), GFP_KERNEL);
+			if (!pdata)
+				return -ENOMEM;
+		} else {
+			/*
+			 * Use reasonable defaults so platforms don't have
+			 * to provide these with DT probing on ARM.
+			 */
+			pdata = &ohci_platform_defaults;
+		}
+	}
 
 	err = dma_coerce_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
 	if (err)
@@ -177,6 +189,8 @@ static int ohci_platform_probe(struct platform_device *dev)
 		ohci->flags |= OHCI_QUIRK_FRAME_NO;
 	if (pdata->num_ports)
 		ohci->num_ports = pdata->num_ports;
+	if (pdata->suspend_without_phy_exit)
+		hcd->suspend_without_phy_exit = 1;
 
 #ifndef CONFIG_USB_OHCI_BIG_ENDIAN_MMIO
 	if (ohci->flags & OHCI_QUIRK_BE_MMIO) {
@@ -305,10 +319,18 @@ static int ohci_platform_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
+static const struct usb_ohci_pdata ohci_plat_brcm_bcm7445_ohci = {
+	.power_on =		ohci_platform_power_on,
+	.power_suspend =	ohci_platform_power_off,
+	.power_off =		ohci_platform_power_off,
+	.suspend_without_phy_exit = 1,
+};
+
 static const struct of_device_id ohci_platform_ids[] = {
 	{ .compatible = "generic-ohci", },
 	{ .compatible = "cavium,octeon-6335-ohci", },
 	{ .compatible = "ti,ohci-omap3", },
+	{ .compatible = "brcm,bcm7445-ohci", &ohci_plat_brcm_bcm7445_ohci},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ohci_platform_ids);
diff --git a/include/linux/usb/ohci_pdriver.h b/include/linux/usb/ohci_pdriver.h
index 7eb16cf587ee..16b24ea1e3bb 100644
--- a/include/linux/usb/ohci_pdriver.h
+++ b/include/linux/usb/ohci_pdriver.h
@@ -35,6 +35,7 @@ struct usb_ohci_pdata {
 	unsigned	big_endian_desc:1;
 	unsigned	big_endian_mmio:1;
 	unsigned	no_big_frame_no:1;
+	unsigned	suspend_without_phy_exit:1;
 	unsigned int	num_ports;
 
 	/* Turn on all power and clocks */
-- 
1.9.0.138.g2de3478

