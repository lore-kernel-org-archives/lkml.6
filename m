Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E81C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651E5217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="uaemarzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfBFBdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 20:33:42 -0500
Received: from onstation.org ([52.200.56.107]:57514 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbfBFBdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 20:33:41 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 5FEF716D;
        Wed,  6 Feb 2019 01:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549416820;
        bh=sw/i34QmxDYqfCCnL7RYab+sbSITGFMKWEJ3JuU2+wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uaemarzYNG9DF5dqrur07yX4mULezbmpNUy8+wNOJ/e54enSZPbAit9DPh9I7zUP/
         y4qhnYzXUDBn9f/yNc3sxGlnM5D330XuYcQD+vvDM3InoA8xNR7IYyhqPYk8YOnOHn
         LTBnDVdNxZxt3nIfCGSoGfsjKVd6D3iRP6QJ6nPY=
From:   Brian Masney <masneyb@onstation.org>
To:     dmitry.torokhov@gmail.com, andy.gross@linaro.org
Cc:     david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, jonathan@marek.ca
Subject: [PATCH v4 1/3] dt-bindings: Input: new bindings for MSM vibrator
Date:   Tue,  5 Feb 2019 20:33:27 -0500
Message-Id: <20190206013329.18195-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190206013329.18195-1-masneyb@onstation.org>
References: <20190206013329.18195-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree bindings for the vibrator found on
various Qualcomm MSM SOCs.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since v3:
- None

 .../bindings/input/msm-vibrator.txt           | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/msm-vibrator.txt

diff --git a/Documentation/devicetree/bindings/input/msm-vibrator.txt b/Documentation/devicetree/bindings/input/msm-vibrator.txt
new file mode 100644
index 000000000000..8dcf014ef2e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/msm-vibrator.txt
@@ -0,0 +1,36 @@
+* Device tree bindings for the Qualcomm MSM vibrator
+
+Required properties:
+
+  - compatible: Should be one of
+		"qcom,msm8226-vibrator"
+		"qcom,msm8974-vibrator"
+  - reg: the base address and length of the IO memory for the registers.
+  - pinctrl-names: set to default.
+  - pinctrl-0: phandles pointing to pin configuration nodes. See
+               Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+  - clock-names: set to pwm
+  - clocks: phandle of the clock. See
+            Documentation/devicetree/bindings/clock/clock-bindings.txt
+  - enable-gpios: GPIO that enables the vibrator.
+
+Optional properties:
+
+  - vcc-supply: phandle to the regulator that provides power to the sensor.
+
+Example from a LG Nexus 5 (hammerhead) phone:
+
+vibrator@fd8c3450 {
+	reg = <0xfd8c3450 0x400>;
+	compatible = "qcom,msm8974-vibrator";
+
+	vcc-supply = <&pm8941_l19>;
+
+	clocks = <&mmcc CAMSS_GP1_CLK>;
+	clock-names = "pwm";
+
+	enable-gpios = <&msmgpio 60 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&vibrator_pin>;
+};
-- 
2.17.2

