Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733E3C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394DB20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KAIVvxYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394DB20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeLLKST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:18:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34960 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbeLLKSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:18:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so5288054wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8mNwIcZt5Lt2n8wj4VXXXoeux1aENwpBV0Y6Q1/l4rk=;
        b=KAIVvxYG7SHFmcDvNIucb0RamOZIUfDB7Z7dq0cmWNz59LBeTh/QBjfzHJtTq2pO46
         XTXCmlsZpOBzj0w1zUXH5EXQHQSvvBE6YBLHPZ8IqLWV65fil32PwxW5R+keFYV3v7CZ
         5NY4KNEOfapmpRdk1fCBy37XAl2pF+mcd+Tu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8mNwIcZt5Lt2n8wj4VXXXoeux1aENwpBV0Y6Q1/l4rk=;
        b=Q/21K4sLRMQykKvenIouoGIidWu+dGm9v1yEcWdwT5PZH5k/mKrSxBdMxC3N+jl0rZ
         242gSkeNhALqhpExAZNkaeGlc61rmYc57Zq1QrDRV+XbBIsiyf8X4sUlAcY2/mFQH9m2
         uJ9b7U73LI9EmtABvPhRfGXKHsPIWtgxmh0x9vGdul0Ik9LDTfFDaC3YPzRecTKs3moc
         OojiENtv5j3VgqC4MNke7GVelt1AMdQE65cbIWv1Nc9O8sem6k2ED3Ma89geo3+dH+U4
         CNdKIznAztRFQq85JLDwTN2Xq73PRVb1dn1xWAoUohfdlZQXUfjrV6gCovENDqomofsM
         bsXQ==
X-Gm-Message-State: AA+aEWY2tGnYWYS0by+a3TuNoPPfH5ARnkz+3xBk2DZGTCUXjom3vM0m
        x7tszD+XUnPSNmbmHRgZjLeHOVEFxWU=
X-Google-Smtp-Source: AFSGD/WLxmOOato7dJWuftCn8771cJE+uI0oGSdZ5vL5oun0r0EUzlxDddBH+3rFDVEuati2vRqfjQ==
X-Received: by 2002:a1c:8f95:: with SMTP id r143mr5519629wmd.65.1544609896321;
        Wed, 12 Dec 2018 02:18:16 -0800 (PST)
Received: from localhost ([49.248.93.253])
        by smtp.gmail.com with ESMTPSA id w8sm17862512wrv.7.2018.12.12.02.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:18:15 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        andy.gross@linaro.org, mka@chromium.org,
        khasim.mohammed@linaro.org, devicetree@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 2/2] arm64: dts: pms405: Export PMIC temperature to thermal framework
Date:   Wed, 12 Dec 2018 15:47:55 +0530
Message-Id: <cb62259c6487f347f6a73fcc8c6ea88289c16928.1544599950.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1544599950.git.amit.kucheria@linaro.org>
References: <cover.1544599950.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1544599950.git.amit.kucheria@linaro.org>
References: <cover.1544599950.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMS405 PMIC has an ADC that exposes the on-die temperature that we
wire up to spmi-temp-alarm thermal driver. This allows the PMIC
temperature to be exposed to Linux through the thermal framework.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 79 ++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index ad2b62dfc9f6..1bb836d1e8aa 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -3,6 +3,32 @@
 
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	thermal-zones {
+		pms405 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&pms405_temp>;
+
+			trips {
+				pms405_alert0: pms405-alert0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				pms405_crit: pms405-crit {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
 
 &spmi_bus {
 	pms405_0: pms405@0 {
@@ -45,6 +71,59 @@
 			};
 		};
 
+		pms405_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
+			io-channels = <&pms405_adc ADC5_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pms405_adc: adc@3100 {
+			compatible = "qcom,pms405-adc", "qcom,spmi-adc-rev2";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			ref_gnd {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			vref_1p25 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			vph_pwr {
+				reg = <ADC5_VPH_PWR>;
+				qcom,pre-scaling = <1 3>;
+			};
+
+			die_temp {
+				reg = <ADC5_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			xo_therm_100k_pu {
+				reg = <ADC5_XO_THERM_100K_PU>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			amux_thm1_100k_pu {
+				reg = <ADC5_AMUX_THM1_100K_PU>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			amux_thm3_100k_pu {
+				reg = <ADC5_AMUX_THM3_100K_PU>;
+				qcom,pre-scaling = <1 1>;
+			};
+		};
+
 		rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>;
-- 
2.17.1

