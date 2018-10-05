Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387FDC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AE7208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+wmyFM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AE7208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeJEXTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbeJEXRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:17:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB6D3214C4;
        Fri,  5 Oct 2018 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756262;
        bh=CuSYQY+NGBF6Tt9rTB4HPgsw54aEyH+ksAL1a8nBTXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+wmyFM4uWPczkMM8UTw+Fr2R6J3dpMcOt+QPKHF/VrvcOXbDjzLFSsJMDTgvTerM
         mD2HhIzsUahBULfYNkvwy3HNqK+GLxaISinB6LipUqSm5aDJDEnjcCeVwLkKa3agV9
         VOWYbq5ucezdAKBYYPT82O/R6xVjyX5WXKA0NNIs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 04/11] mfd: omap-usb-host: Fix dts probe of children
Date:   Fri,  5 Oct 2018 12:17:29 -0400
Message-Id: <20181005161736.20765-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161736.20765-1-sashal@kernel.org>
References: <20181005161736.20765-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 10492ee8ed9188d6d420e1f79b2b9bdbc0624e65 ]

It currently only works if the parent bus uses "simple-bus". We
currently try to probe children with non-existing compatible values.
And we're missing .probe.

I noticed this while testing devices configured to probe using ti-sysc
interconnect target module driver. For that we also may want to rebind
the driver, so let's remove __init and __exit.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Acked-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mfd/omap-usb-host.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 1d924d1533c0..b9dc2fcd8f26 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -548,8 +548,8 @@ static int usbhs_omap_get_dt_pdata(struct device *dev,
 }
 
 static const struct of_device_id usbhs_child_match_table[] = {
-	{ .compatible = "ti,omap-ehci", },
-	{ .compatible = "ti,omap-ohci", },
+	{ .compatible = "ti,ehci-omap", },
+	{ .compatible = "ti,ohci-omap3", },
 	{ }
 };
 
@@ -875,6 +875,7 @@ static struct platform_driver usbhs_omap_driver = {
 		.pm		= &usbhsomap_dev_pm_ops,
 		.of_match_table = usbhs_omap_dt_ids,
 	},
+	.probe		= usbhs_omap_probe,
 	.remove		= usbhs_omap_remove,
 };
 
@@ -884,9 +885,9 @@ MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("usb host common core driver for omap EHCI and OHCI");
 
-static int __init omap_usbhs_drvinit(void)
+static int omap_usbhs_drvinit(void)
 {
-	return platform_driver_probe(&usbhs_omap_driver, usbhs_omap_probe);
+	return platform_driver_register(&usbhs_omap_driver);
 }
 
 /*
@@ -898,7 +899,7 @@ static int __init omap_usbhs_drvinit(void)
  */
 fs_initcall_sync(omap_usbhs_drvinit);
 
-static void __exit omap_usbhs_drvexit(void)
+static void omap_usbhs_drvexit(void)
 {
 	platform_driver_unregister(&usbhs_omap_driver);
 }
-- 
2.17.1

