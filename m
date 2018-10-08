Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BB0C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F018820841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F018820841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeJHUll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:41:41 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.180]:32500 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeJHUll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:41:41 -0400
X-Greylist: delayed 13025 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Oct 2018 16:41:40 EDT
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BEbxz4P/994MeEDNp0afzt1sCL0HI5412k27pBvgKz+L/w=="
X-RZG-CLASS-ID: mo05
Received: from fs-work.as-domain.local
        by smtp.strato.de (RZmta 44.2 AUTH)
        with ESMTPSA id h039efu98DTsHlw
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 8 Oct 2018 15:29:54 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
To:     Peter.Chen@nxp.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: [RFC] usb: chipidea: Add minimal support for HSIC interface on i.MX6QDL
Date:   Mon,  8 Oct 2018 15:29:12 +0200
Message-Id: <1539005352-10909-1-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current mainline doesn't support USB hosts 2 and 3 which only use
HSIC mode and I was wondering how this would need to be implemented.

The topic has been discussed before: [1]
And there is some implementation in the vendor kernel: [2]

It seems like two things need to be done:

1. Switch the pinmux of the strobe signal to use a pullup after
   the core has been initialized.
2. Enable HSIC mode and HSIC clock

This patch only implements these basics in a minimal approach.
You need to have an additional pinmux setting "active" in the dt,
that sets the pullup.

It was tested with the SMSC LAN9730 USB Ethernet adapter on the
iMXceet Solo S board.

[1] https://patchwork.kernel.org/patch/3541771/
[2] http://git.freescale.com/git/cgit.cgi/imx/linux-imx.git/commit/?id=cf2d3ff6b217ef41f0e594daa9615e2

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 10 ++++++++++
 drivers/usb/chipidea/usbmisc_imx.c | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 19f5f5f..fef8bda 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -256,6 +256,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id;
 	const struct ci_hdrc_imx_platform_flag *imx_platform_flag;
 	struct device_node *np = pdev->dev.of_node;
+	struct pinctrl *pinctrl;
 
 	of_id = of_match_device(ci_hdrc_imx_dt_ids, &pdev->dev);
 	if (!of_id)
@@ -331,6 +332,15 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		pm_runtime_enable(&pdev->dev);
 	}
 
+	pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!IS_ERR(pinctrl)) {
+		struct pinctrl_state *state;
+
+		state = pinctrl_lookup_state(pinctrl, "active");
+		if (!IS_ERR(state))
+			pinctrl_select_state(pinctrl, state);
+	}
+
 	device_set_wakeup_capable(&pdev->dev, true);
 
 	return 0;
diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 34ad5bf..a6556c8 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -64,10 +64,16 @@
 #define MX6_BM_OVER_CUR_DIS		BIT(7)
 #define MX6_BM_OVER_CUR_POLARITY	BIT(8)
 #define MX6_BM_WAKEUP_ENABLE		BIT(10)
+#define MX6_BM_UTMI_ON_CLOCK		BIT(13)
 #define MX6_BM_ID_WAKEUP		BIT(16)
 #define MX6_BM_VBUS_WAKEUP		BIT(17)
 #define MX6SX_BM_DPDM_WAKEUP_EN		BIT(29)
 #define MX6_BM_WAKEUP_INTR		BIT(31)
+
+#define MX6_USB_HSIC_CTRL_OFFSET	0x10
+#define MX6_BM_HSIC_CLK_ON		BIT(11)
+#define MX6_BM_HSIC_EN			BIT(12)
+
 #define MX6_USB_OTG1_PHY_CTRL		0x18
 /* For imx6dql, it is host-only controller, for later imx6, it is otg's */
 #define MX6_USB_OTG2_PHY_CTRL		0x1c
@@ -351,6 +357,22 @@ static int usbmisc_imx6q_init(struct imx_usbmisc_data *data)
 	writel(reg | MX6_BM_NON_BURST_SETTING,
 			usbmisc->base + data->index * 4);
 
+	/*
+	 * Core 2 and 3 are host only and HSIC only,
+	 * so we enable HSIC by default to make them usable
+	 */
+	if (data->index == 2 || data->index == 3) {
+		reg = readl(usbmisc->base + data->index * 4);
+		writel(reg | MX6_BM_UTMI_ON_CLOCK,
+		       usbmisc->base + data->index * 4);
+
+		reg = readl(usbmisc->base + MX6_USB_HSIC_CTRL_OFFSET +
+			    (data->index - 2) * 4);
+		reg |= MX6_BM_HSIC_EN | MX6_BM_HSIC_CLK_ON;
+		writel(reg, usbmisc->base + MX6_USB_HSIC_CTRL_OFFSET +
+		       (data->index - 2) * 4);
+	}
+
 	spin_unlock_irqrestore(&usbmisc->lock, flags);
 
 	usbmisc_imx6q_set_wakeup(data, false);
-- 
2.7.4

