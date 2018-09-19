Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79972ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C612098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="QBbxVxSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C612098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbeISUsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:48:02 -0400
Received: from onstation.org ([52.200.56.107]:45528 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731665AbeISUsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:48:01 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 0ECCA1558;
        Wed, 19 Sep 2018 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1537369779;
        bh=KukguwkhfWnfQqiqpyOy5gR+xxKYIL6vH26R2ui8/4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBbxVxSmluzR1jTfCZS+Ad0zkH8JHkWczsFG5BxsdQGmDk49vCy+wsI1xKKjjUZvp
         t5g5uy+bHRGRP7tQNS1r1wm+hxkeMiSHNppNd4tXHZxyXzLd2AimHhQ2m+o4W28czj
         MWqhEjoM/yjTB+6yNCttWXc78H+xdsaNVw9fW8X8=
From:   Brian Masney <masneyb@onstation.org>
To:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sebastian.reichel@collabora.co.uk, masneyb@onstation.org
Subject: [PATCH 1/3] dt-bindings: pwm: msm-vibrator: new bindings for MSM vibrator driver
Date:   Wed, 19 Sep 2018 11:09:10 -0400
Message-Id: <20180919150912.8948-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919150912.8948-1-masneyb@onstation.org>
References: <20180919150912.8948-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree bindings for the pwm-msm-vibrator.c
driver that supports the vibrator found on various Qualcomm MSM SOCs.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../bindings/pwm/pwm-msm-vibrator.txt         | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-msm-vibrator.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-msm-vibrator.txt b/Documentation/devicetree/bindings/pwm/pwm-msm-vibrator.txt
new file mode 100644
index 000000000000..4638a25345f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-msm-vibrator.txt
@@ -0,0 +1,38 @@
+* PWM driver for the vibrator found on various MSM SOCs.
+
+Required properties:
+
+  - compatible: Should be one of
+		"qcom,msm8226-pwm-vibrator"
+		"qcom,msm8974-pwm-vibrator"
+  - reg: the base address and length of the IO memory for the registers.
+  - #pwm-cells: set to 3.
+  - pinctrl-names: set to default.
+  - pinctrl-0: phandles pointing to pin configuration nodes. See
+               Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+  - clock-names: set to pwm
+  - clocks: phandle of the clock used by the PWM module. See
+            Documentation/devicetree/bindings/clock/clock-bindings.txt
+  - enable-gpios: GPIO that enables the vibrator.
+
+Optional properties:
+
+  - vcc-supply: phandle to the regulator that provides power to the sensor.
+
+Example from a LG Nexus 5 (hammerhead) phone:
+
+msm_pwm_vibrator_enable: msm_pwm_vibrator@fd8c3450 {
+	reg = <0xfd8c3450 0x400>;
+	compatible = "qcom,msm8974-pwm-vibrator";
+	#pwm-cells = <3>;
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
2.17.1

