Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B53AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EC4214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SEU3cD/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfAJABu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:01:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40923 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfAJABt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:01:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so9453002wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/ZE0qkZUqxgI4JnoiR2IYSBVxq7qTxELnI9TqLZdU2Y=;
        b=SEU3cD/l7LwiQdrMqY0xwiVIBYsLKKhJzQ0jQqZ3SYhK6b1+rJih9rAPWLpIWbW9QM
         s6lfKr/XhCmSBTPElE94yMb24QcBF+HZwm+vCZtFZNs5PVTSEHVxJE4+AUvDeLGYqGhM
         Pk/6aNxdOjH1IeGyVsbdurFHqPhpVe+40+Xvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/ZE0qkZUqxgI4JnoiR2IYSBVxq7qTxELnI9TqLZdU2Y=;
        b=pVmECZZShTc6mZaHI0z7WO9THYwabgB951smTqu+x1WSoPkpJ4Re01sfHjOJy6RpzE
         neJWCwP/QtUjuudKpr0mpA5fp4xIM+cEqIFHfWD/qg8qc/ZRNFKcluVtqJ0ErJZiPu1Y
         sPrewphSyBsvanqxDQwD59ic+AJqZSGFrLSOccIPhFNFkhrh9HRkt4AU2hbKENiFbQmy
         frcdhzLqAIBz5Ywt3ewRHNIXYjk+f/I/+eOvrNivxLm2XUHKhxQNkmTRgruV7CeXPEMj
         4ocPa19LILaoEt1Zel+QS1O0zHGX88lipCG7g8NYH0tzmKv9gS9aimye0C0mGiVtFhJc
         WEIQ==
X-Gm-Message-State: AJcUukdNTfB6vR5DvNz1A8yjBU+XTgNW7aluHg+wR54mfS9uJWv1AaLf
        C8vDA40Cel/IysahKWwC9n/JBrmcCMk=
X-Google-Smtp-Source: ALg8bN4rTwZ3JIx+gIP/hSyRkknpeUIs+AFjwxsB5RKRshYU6RVKSlGqB3ZfHEbzl78aoYTT/FsaFg==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr7150347wrn.27.1547078506825;
        Wed, 09 Jan 2019 16:01:46 -0800 (PST)
Received: from localhost ([49.248.171.190])
        by smtp.gmail.com with ESMTPSA id y13sm5251318wme.2.2019.01.09.16.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 16:01:46 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v1 7/7] arm64: dts: sdm845: wireup the thermal trip points to cpufreq
Date:   Thu, 10 Jan 2019 05:30:56 +0530
Message-Id: <6c5b26e65be18222587724e066fc2e39b9f60397.1547078153.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the big and little cpus are in the same frequency domain, use all
of them for mitigation in the cooling-map. At the lower trip points we
restrict ourselves to throttling only a few OPPs. At higher trip
temperatures, allow ourselves to be throttled to any extent.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 145 +++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 29e823b0caf4..cd6402a9aa64 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -99,6 +100,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				compatible = "cache";
@@ -114,6 +116,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_100>;
 			L2_100: l2-cache {
 				compatible = "cache";
@@ -126,6 +129,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_200>;
 			L2_200: l2-cache {
 				compatible = "cache";
@@ -138,6 +142,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_300>;
 			L2_300: l2-cache {
 				compatible = "cache";
@@ -150,6 +155,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x400>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_400>;
 			L2_400: l2-cache {
 				compatible = "cache";
@@ -162,6 +168,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x500>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_500>;
 			L2_500: l2-cache {
 				compatible = "cache";
@@ -174,6 +181,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x600>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_600>;
 			L2_600: l2-cache {
 				compatible = "cache";
@@ -186,6 +194,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x700>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_700>;
 			L2_700: l2-cache {
 				compatible = "cache";
@@ -1703,6 +1712,23 @@
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
+							 <&CPU1 THERMAL_NO_LIMIT 4>,
+							 <&CPU2 THERMAL_NO_LIMIT 4>,
+							 <&CPU3 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu_crit0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu1-thermal {
@@ -1724,6 +1750,23 @@
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
+							 <&CPU1 THERMAL_NO_LIMIT 4>,
+							 <&CPU2 THERMAL_NO_LIMIT 4>,
+							 <&CPU3 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu_crit1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu2-thermal {
@@ -1745,6 +1788,23 @@
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert2>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
+							 <&CPU1 THERMAL_NO_LIMIT 4>,
+							 <&CPU2 THERMAL_NO_LIMIT 4>,
+							 <&CPU3 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu_crit2>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu3-thermal {
@@ -1766,6 +1826,23 @@
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert3>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
+							 <&CPU1 THERMAL_NO_LIMIT 4>,
+							 <&CPU2 THERMAL_NO_LIMIT 4>,
+							 <&CPU3 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu_crit3>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu4-thermal {
@@ -1787,6 +1864,23 @@
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert4>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT 4>,
+							 <&CPU5 THERMAL_NO_LIMIT 4>,
+							 <&CPU6 THERMAL_NO_LIMIT 4>,
+							 <&CPU7 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu_crit4>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu5-thermal {
@@ -1808,6 +1902,23 @@
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert5>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT 4>,
+							 <&CPU5 THERMAL_NO_LIMIT 4>,
+							 <&CPU6 THERMAL_NO_LIMIT 4>,
+							 <&CPU7 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu_crit5>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu6-thermal {
@@ -1829,6 +1940,23 @@
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert6>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT 4>,
+							 <&CPU5 THERMAL_NO_LIMIT 4>,
+							 <&CPU6 THERMAL_NO_LIMIT 4>,
+							 <&CPU7 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu_crit6>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu7-thermal {
@@ -1850,6 +1978,23 @@
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert7>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT 4>,
+							 <&CPU5 THERMAL_NO_LIMIT 4>,
+							 <&CPU6 THERMAL_NO_LIMIT 4>,
+							 <&CPU7 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu_crit7>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 	};
 };
-- 
2.17.1

