Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CBBC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2542086A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2542086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933331AbeGIPI4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:08:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38608 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932949AbeGIPIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:08:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 213ED275682
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     briannorris@chromium.org, kernel@collabora.com, heiko@sntech.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>
Subject: [PATCH] usb: dwc3: of-simple: reset host controller at suspend/resume
Date:   Mon,  9 Jul 2018 17:08:44 +0200
Message-Id: <20180709150844.32505-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we power off the SoC logic rail in S3, we can find that the Type-C
PHY can't initialize correctly after system resume. We need to toggle
the USB3-OTG reset before trying to initialize the PHY, or else it
times out.

    phy phy-ff800000.phy.9: phy poweron failed --> -110
    dwc3 fe900000.dwc3: failed to initialize core
    dwc3: probe of fe900000.dwc3 failed with error -110

Note that the RK3399 TRM suggests that we should keep the whole usb3
controller in reset for the duration of the Type-C PHY initialization.
However, it's hard to assert the reset in the current framework of
reset. We're still skeptical about that, and we haven't yet found a
case where this seems to have mattered. This approach is much easier, it
simply holds the USB3-OTG reset while device is supended.

The dwc3 core is going to reinitialize the controller at suspend/resume
anyway (including a "soft reset"), so it should be safe to do this.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Dear all,

Now that the usb3-phy otg port support for rk3399 has been merged [1] we
found that suspend/resume is broken. The problem is well known for
ChromeOS kernels, they solved it in a similar way adding a reset pulse on
resume in the specific usb glue layer (dwc3-rockchip). In mainline,
though, we use the dwc3-of-simple glue layer instead of a specific layer
for rockchip. The patch is based on the Brian Norris work but slightly
different, it holds the reset while device is suspended. It was tested
on a Samsung Chromebook Plus with usbc docking station attached by doing
different suspend/resume cycles and checking no usb devices has been
lost.

I am not sure this is the better way to solve this but I did not find
any other way, and, as I am not sure this can be generic, the reset is only
done on rockchip platforms.

Best regards,
 Enric

[1] bfdca1736ea76345071bbc5607d18928e54909ac ('arm64: dts: rockchip: add
    usb3-phy otg-port support for rk3399')

 drivers/usb/dwc3/dwc3-of-simple.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index dbeff5e6ad14..1d1ece99ed94 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -201,9 +201,30 @@ static int dwc3_of_simple_runtime_resume(struct device *dev)
 
 	return 0;
 }
+
+static int dwc3_of_simple_suspend(struct device *dev)
+{
+	struct dwc3_of_simple *simple = dev_get_drvdata(dev);
+
+	if (of_device_is_compatible(dev->of_node, "rockchip,rk3399-dwc3"))
+		reset_control_assert(simple->resets);
+
+	return 0;
+}
+
+static int dwc3_of_simple_resume(struct device *dev)
+{
+	struct dwc3_of_simple *simple = dev_get_drvdata(dev);
+
+	if (of_device_is_compatible(dev->of_node, "rockchip,rk3399-dwc3"))
+		reset_control_deassert(simple->resets);
+
+	return 0;
+}
 #endif
 
 static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dwc3_of_simple_suspend, dwc3_of_simple_resume)
 	SET_RUNTIME_PM_OPS(dwc3_of_simple_runtime_suspend,
 			dwc3_of_simple_runtime_resume, NULL)
 };
-- 
2.18.0

