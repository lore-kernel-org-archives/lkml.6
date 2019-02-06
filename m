Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3A1C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7940D217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="YIGF8EVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfBFBdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 20:33:47 -0500
Received: from onstation.org ([52.200.56.107]:57540 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728693AbfBFBdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 20:33:42 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 3785C7C2;
        Wed,  6 Feb 2019 01:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549416821;
        bh=6FBB/3U1w0UR9R8ArweL++cwCv+Lg1KQO8IIx/ZMlTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YIGF8EVTYT6Ojhgbruq7B7aofjpOA1gTDwW9gk/lQOJxtWBff33M6sdbLRNXWTRy9
         ceIesZM1tAbNYHmlMJAVrIAMpNoSqDvM+LCSTnCUG2H/GmcSQzgAxaQhc9FCI+5dvW
         yUi6TKLNczE/S6Z9thorJWNWOBgvLW7+lzORiPEc=
From:   Brian Masney <masneyb@onstation.org>
To:     dmitry.torokhov@gmail.com, andy.gross@linaro.org
Cc:     david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, jonathan@marek.ca
Subject: [PATCH v4 3/3] ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for vibrator
Date:   Tue,  5 Feb 2019 20:33:29 -0500
Message-Id: <20190206013329.18195-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190206013329.18195-1-masneyb@onstation.org>
References: <20190206013329.18195-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device device tree bindings for the vibrator found on
the LG Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v3:
- None

 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index b3b04736a159..1fd9f429f34a 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -5,6 +5,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/clock/qcom,mmcc-msm8974.h>
 
 / {
 	model = "LGE MSM 8974 HAMMERHEAD";
@@ -306,6 +307,36 @@
 				input-enable;
 			};
 		};
+
+		vibrator_pin: vibrator {
+			pwm {
+				pins = "gpio27";
+				function = "gp1_clk";
+
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			enable {
+				pins = "gpio60";
+				function = "gpio";
+			};
+		};
+	};
+
+	vibrator@fd8c3450 {
+		compatible = "qcom,msm8974-vibrator";
+		reg = <0xfd8c3450 0x400>;
+
+		vcc-supply = <&pm8941_l19>;
+
+		clocks = <&mmcc CAMSS_GP1_CLK>;
+		clock-names = "pwm";
+
+		enable-gpios = <&msmgpio 60 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&vibrator_pin>;
 	};
 
 	sdhci@f9824900 {
-- 
2.17.2

