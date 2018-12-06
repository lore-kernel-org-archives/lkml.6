Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A99C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304D920989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WxNuUCnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304D920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbeLFNXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:23:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41132 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbeLFNXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:23:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so461104wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 05:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FDwQO14UGM5SUk/PNniHDmDivUIWcO7xrzPBHqSWB1I=;
        b=WxNuUCnT1Nf9o2TGbxbYI6fyfX7UiZEYTyUyDHBaCvdcgoEPT9pKUcO93f18YdNy1G
         LF6hI2nQXeRc02/cfQeU6odDZj7c8Yk1/6jLpT/YEbDCeYaLPYpLTnxrQLlD8GjmgCPJ
         2Hl2+V9JuTenZuY+s7r50Hcpw97U6He8dvIcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FDwQO14UGM5SUk/PNniHDmDivUIWcO7xrzPBHqSWB1I=;
        b=I+cyUk+7hfdVphkg+QSYcP6oEiNLgC0d73Pm164M8lMOwo0FcvF8VL0Or39n7lOhUM
         qNEIOHWbRVm67Gg6ysnbigFk4pNSxyFnqk28iiNi4vgqDnM5NrqEhnT8evrfMPSZdTyP
         JDmLqc+8AlYa0dvkSAuivvQLGtQ93Lf11aMt1a464Rp7vKi2ixLq8c9uNWoyEVcCOxaT
         E7kxx1LiDMBFvoIk5uKhAa0JKjXoHOmzIl15wZqePyeATOclmFau6bNOiAztAp6mD1u6
         bJKywIEZBqXnA7STHfslNG9LPxAhD8q6aSNr95a4TsjoIeOT0sPM9WeknrSqVb4MrT6E
         kWBw==
X-Gm-Message-State: AA+aEWZi56EBkAw0jF7T3E6YMzxzZka8ReLHfioLCPCLTWHB8aSwkp6Q
        JVB87TMQsbmKcKQZZFsUuAp8xQ==
X-Google-Smtp-Source: AFSGD/WziSFzlMmmeGbA3uX4wV4afbrHFCdKokYZ57bjESEqMLIfMQDgLMLjP2h1+kOtVwmk1vlqwA==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr24199502wrs.7.1544102595481;
        Thu, 06 Dec 2018 05:23:15 -0800 (PST)
Received: from localhost.localdomain (ip-161-243.sn-213-198.clouditalia.com. [213.198.161.243])
        by smtp.gmail.com with ESMTPSA id z13sm363769wrq.19.2018.12.06.05.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 05:23:14 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/3] arm64: dts: allwinner: a64: Add A64 CSI controller
Date:   Thu,  6 Dec 2018 18:53:05 +0530
Message-Id: <20181206132306.11843-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181206132306.11843-1-jagan@amarulasolutions.com>
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 CSI controller has similar features as like in
H3, So add support for A64 via H3 fallback.

Also updated CSI_SCLK to use 300MHz via assigned-clocks, since
the default clock 600MHz seems unable to drive the sensor(ov5640)
to capture the image.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Use CSI_SCLK to 300MHz 

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 384c417cb7a2..d7ab0006ebce 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -532,6 +532,12 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			csi_pins: csi-pins {
+				pins = "PE0", "PE2", "PE3", "PE4", "PE5", "PE6",
+				       "PE7", "PE8", "PE9", "PE10", "PE11";
+				function = "csi0";
+			};
+
 			i2c0_pins: i2c0_pins {
 				pins = "PH0", "PH1";
 				function = "i2c0";
@@ -899,6 +905,23 @@
 			status = "disabled";
 		};
 
+		csi: csi@1cb0000 {
+			compatible = "allwinner,sun50i-a64-csi",
+				     "allwinner,sun8i-h3-csi";
+			reg = <0x01cb0000 0x1000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CSI>,
+				 <&ccu CLK_CSI_SCLK>,
+				 <&ccu CLK_DRAM_CSI>;
+			clock-names = "bus", "mod", "ram";
+			resets = <&ccu RST_BUS_CSI>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&csi_pins>;
+			assigned-clocks = <&ccu CLK_CSI_SCLK>;
+			assigned-clock-rates = <300000000>;
+			status = "disabled";
+		};
+
 		hdmi: hdmi@1ee0000 {
 			compatible = "allwinner,sun50i-a64-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
-- 
2.18.0.321.gffc6fa0e3

