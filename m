Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5A5C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3F820C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcVBj09/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3F820C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeIYPLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:11:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39998 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeIYPLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:11:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id y8-v6so18833950wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fOZ6rfysb+Hiuh5cPbqLhry8YsLUdhlmW/oJcrqQRxA=;
        b=hcVBj09/LPgzagzXbG9tfUX8oRAsiwmFID99WPVrdOQGmbC1/0KZ9FWpIpwqpIRwUp
         s0EdWA/zagjvvwkOeDckhfYfza+coZ2FjWx/hC0xW5q2qvV+REWF/BYRpH/agpwbHgjp
         swl2HELI+DPy1jSvRSc+6SD4QrEnNdJPpCZXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fOZ6rfysb+Hiuh5cPbqLhry8YsLUdhlmW/oJcrqQRxA=;
        b=cmkI9+Lg8rv5X5f/eu84rAts5HlZ48j+eVaw5iwI3Y+q31Ycgkj5n+xEhXhSKTCmVy
         VN+jrOgyNku6X21UokEtD3wKvxvRMYI4gtux6RrJnG1LmydEa47QV+729CXYigiB8CDx
         0UFQqzO3QvSidq371dgUHt2tv7haUTCWw+VvoPZOQzAop67uj4OzhZ/a0JHmmiUVSr8j
         v3ac1sEoPf7vLcPv1AFKk1f6cvT9HBbR6EuNFDUxdqtCvYYM0iOUBXDyiSsDUvZG9Fnr
         x2BPsKf6uUUMtwmqCsuaoNL/a2MSRNR2r3dLhVU/ZWlqjlTkPOiNAbYQLXtw0p677sBB
         5qrA==
X-Gm-Message-State: ABuFfojXch6S0UbhKyDkzU/vruXW9MfwSfQAlilKAf8cV0bzlYoLsH7X
        NFXHW/9M6tB+s6UvCL9c6rVXng==
X-Google-Smtp-Source: ACcGV626nFqoIkfxnZMLcFwr/69sx3ju/W/3gsoTKroQryZiFvQWISxo5AubYpFvC6zc/q0+fBW2HA==
X-Received: by 2002:a5d:448d:: with SMTP id j13-v6mr40484wrq.236.1537866271365;
        Tue, 25 Sep 2018 02:04:31 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1523828wmg.14.2018.09.25.02.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:04:30 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/HISILICON SOC
        SUPPORT)
Subject: [PATCH 08/14] ARM64: dts: hisilicon: Add tsensor interrupt name
Date:   Tue, 25 Sep 2018 11:03:06 +0200
Message-Id: <1537866192-12320-9-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the interrupt names for the sensors, so the code can rely on them
instead of dealing with index which are prone to error.

The name comes from the Hisilicon documentation found on internet.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../bindings/thermal/hisilicon-thermal.txt         |  3 ++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          | 63 +++++++++++-----------
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  1 +
 3 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
index cef716a..3edfae3 100644
--- a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
@@ -7,6 +7,7 @@
   region.
 - interrupt: The interrupt number to the cpu. Defines the interrupt used
   by /SOCTHERM/tsensor.
+- interrupt-names: The interrupt names for the different sensors
 - clock-names: Input clock name, should be 'thermal_clk'.
 - clocks: phandles for clock specified in "clock-names" property.
 - #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
@@ -18,6 +19,7 @@ for Hi6220:
 		compatible = "hisilicon,tsensor";
 		reg = <0x0 0xf7030700 0x0 0x1000>;
 		interrupts = <0 7 0x4>;
+		interrupt-names = "tsensor_intr";
 		clocks = <&sys_ctrl HI6220_TSENSOR_CLK>;
 		clock-names = "thermal_clk";
 		#thermal-sensor-cells = <1>;
@@ -28,5 +30,6 @@ for Hi3660:
 		compatible = "hisilicon,hi3660-tsensor";
 		reg = <0x0 0xfff30000 0x0 0x1000>;
 		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tsensor_a73";
 		#thermal-sensor-cells = <1>;
 	};
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index f432b0a..bf8a479 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1081,46 +1081,47 @@
 			compatible = "hisilicon,hi3660-tsensor";
 			reg = <0x0 0xfff30000 0x0 0x1000>;
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tsensor_a73";
 			#thermal-sensor-cells = <1>;
 		};
 
-		thermal-zones {
+                thermal-zones {
 
-			cls0: cls0 {
-				polling-delay = <1000>;
-				polling-delay-passive = <100>;
-				sustainable-power = <4500>;
+                        cls0: cls0 {
+                                polling-delay = <1000>;
+                                polling-delay-passive = <100>;
+                                sustainable-power = <4500>;
 
-				/* sensor ID */
-				thermal-sensors = <&tsensor 1>;
+                                /* sensor ID */
+                                thermal-sensors = <&tsensor 1>;
 
-				trips {
-					threshold: trip-point@0 {
-						temperature = <65000>;
-						hysteresis = <1000>;
-						type = "passive";
-					};
+                                trips {
+                                        threshold: trip-point@0 {
+                                                temperature = <65000>;
+                                                hysteresis = <1000>;
+                                                type = "passive";
+                                        };
 
-					target: trip-point@1 {
-						temperature = <75000>;
-						hysteresis = <1000>;
-						type = "passive";
-					};
-				};
+                                        target: trip-point@1 {
+                                                temperature = <75000>;
+                                                hysteresis = <1000>;
+                                                type = "passive";
+                                        };
+                                };
 
-				cooling-maps {
+                                cooling-maps {
 					map0 {
-						trip = <&target>;
-						contribution = <1024>;
-						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-					};
+                                                trip = <&target>;
+                                                contribution = <1024>;
+                                                cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+                                        };
 					map1 {
-						trip = <&target>;
-						contribution = <512>;
-						cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-					};
-				};
-			};
-		};
+                                                trip = <&target>;
+                                                contribution = <512>;
+                                                cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+                                        };
+                                };
+                        };
+                };
 	};
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 247024d..9eae986 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -841,6 +841,7 @@
 			compatible = "hisilicon,tsensor";
 			reg = <0x0 0xf7030700 0x0 0x1000>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tsensor_intr";
 			clocks = <&sys_ctrl 22>;
 			clock-names = "thermal_clk";
 			#thermal-sensor-cells = <1>;
-- 
2.7.4

