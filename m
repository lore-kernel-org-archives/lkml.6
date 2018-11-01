Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD70AC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AF020823
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="bAMB2Y/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86AF020823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeKAJMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:12:44 -0400
Received: from onstation.org ([52.200.56.107]:44736 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbeKAJMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:12:43 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 53749B16;
        Thu,  1 Nov 2018 00:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1541031132;
        bh=8BWQWQ+xr3McwXDoUVN3CB+hNGPKWAbseZvEW6eyT2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAMB2Y/Lbro5JxhZIq9EddvsglrnJaDjjPb4xZXSSL+1w/nEMoCntMVrsmnf614kt
         N4q8OzNKTHrCNoxkf3Xx58oTPfQ7X4mkSUVhZjcIhKcrpHcW8AETjeu79JXMgzM7pM
         hI1x5MtfKUtV3f4BU8mE9Y9Glg3ZoIGMTFUDQFXE=
From:   Brian Masney <masneyb@onstation.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        jonathan@marek.ca, masneyb@onstation.org
Subject: [PATCH v2 5/7] pinctrl: qcom: spmi-gpio: fix gpio-hog related boot issues
Date:   Wed, 31 Oct 2018 20:11:47 -0400
Message-Id: <20181101001149.13453-6-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181101001149.13453-1-masneyb@onstation.org>
References: <20181101001149.13453-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When attempting to setup up a gpio hog, device probing would repeatedly
fail with -EPROBE_DEFERED errors. It was caused by a circular dependency
between the gpio and pinctrl frameworks. If the gpio-ranges property is
present in device tree, then the gpio framework will handle the gpio pin
registration and eliminate the circular dependency.

See Christian Lamparter's commit a86caa9ba5d7 ("pinctrl: msm: fix
gpio-hog related boot issues") for a detailed commit message that
explains the issue in much more detail. The code comment in this commit
came from Christian's commit.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index a29efbe08f48..4c1ff9a1d156 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1028,10 +1028,23 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = gpiochip_add_pin_range(&state->chip, dev_name(dev), 0, 0, npins);
-	if (ret) {
-		dev_err(dev, "failed to add pin range\n");
-		goto err_range;
+	/*
+	 * For DeviceTree-supported systems, the gpio core checks the
+	 * pinctrl's device node for the "gpio-ranges" property.
+	 * If it is present, it takes care of adding the pin ranges
+	 * for the driver. In this case the driver can skip ahead.
+	 *
+	 * In order to remain compatible with older, existing DeviceTree
+	 * files which don't set the "gpio-ranges" property or systems that
+	 * utilize ACPI the driver has to call gpiochip_add_pin_range().
+	 */
+	if (!of_property_read_bool(dev->of_node, "gpio-ranges")) {
+		ret = gpiochip_add_pin_range(&state->chip, dev_name(dev), 0, 0,
+					     npins);
+		if (ret) {
+			dev_err(dev, "failed to add pin range\n");
+			goto err_range;
+		}
 	}
 
 	return 0;
-- 
2.17.2

