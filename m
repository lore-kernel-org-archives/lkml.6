Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C7CC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0142D22444
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHQ4kXdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0142D22444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbeHJUZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:25:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40188 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbeHJUY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:24:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id e13-v6so4862881pff.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8L70xoQazhZ+vmqb3tr43erEpnJ9J2hYHapvvy6sfeA=;
        b=EHQ4kXdqcT/fu180+z87kRmwrmIbNY58gj12SYa9LN/VEFpiSUyif2ewhSJkB5Pynw
         MUtEw49LgbbylGcpZYRVb9z3wKOTAUKU2Zfvgn180vtBjRBI/Fr6NJeaubU8nkCul7YJ
         KYuphU1H8ScmU0Fanj12vhRYvM/3rck06e4+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8L70xoQazhZ+vmqb3tr43erEpnJ9J2hYHapvvy6sfeA=;
        b=DCXcRNKJv67RrSsb1Y0Zmn5TQzG7POQ3rBeIhEWBZvN1RA/6HruTZfJwwNJ4cGRbgh
         fA92Rr/7j5vMrCXQhg9yHNENmcdMfnJ/7idBPrbERb/I3nflvsHFBn8qJzptEj8kScYX
         c1s41i0sCNSe6KBVewkIIRKtbHAWdVBVQVKEurdP8qoRWKs1MSmfu8wT7w+odTv5BYCW
         tc1pZYmBQkA/EyHIsLma/FzSlTiZ3xjeXCsiFL8wEDEPzKq2ch3nGMq7TGxgBffC8CQE
         jm0A5d66vMZ/y15+VJ2zELKceSVAzxF7jY1ViPrIQVjHsxaJfMX6i2k5dqe96WQwHF66
         aVtw==
X-Gm-Message-State: AOUpUlGKnSzT1gwAICtc34LnyL4oYqodSr09feq6s5BlxY8JGE5gFdmC
        BwbAJowIuqxVZO6md8QsIJNp
X-Google-Smtp-Source: AA+uWPzYuPPiRe3Iu138jtxyuSk2WxfSQjpe5bDPIIg8w8Jan3fcU4IV6UFqzlRCkEJ1oMyVltW52Q==
X-Received: by 2002:a63:3d41:: with SMTP id k62-v6mr7379417pga.254.1533923647643;
        Fri, 10 Aug 2018 10:54:07 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6391:e983:9562:f5f7:1a60:4363])
        by smtp.gmail.com with ESMTPSA id l127-v6sm16981262pfc.55.2018.08.10.10.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 10:54:07 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/4] arm64: dts: Add devicetree for Hisilicon Hi3670 SoC
Date:   Fri, 10 Aug 2018 23:23:37 +0530
Message-Id: <20180810175339.25421-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
References: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial devicetree support for Hisilicon Hi3670 SoC which
is similar to Hi3660 SoC with NPU support.

This SoC has Octal core BigLittle CPUs in two clusters(4 * A53 & 4 * A73).

Only UART6 has been added for console support which is
pre configured by the bootloader. A fixed clock is sourcing
the UART6 which will get replaced by the clock driver when available.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 162 ++++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3670.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
new file mode 100644
index 000000000000..c90e6f6a34ec
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Hisilicon Hi3670 SoC
+ *
+ * Copyright (C) 2016, Hisilicon Ltd.
+ * Copyright (C) 2018, Linaro Ltd.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "hisilicon,hi3670";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+				core1 {
+					cpu = <&cpu5>;
+				};
+				core2 {
+					cpu = <&cpu6>;
+				};
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+		};
+
+		cpu4: cpu@100 {
+			compatible = "arm,cortex-a73", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+		};
+
+		cpu5: cpu@101 {
+			compatible = "arm,cortex-a73", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+		};
+
+		cpu6: cpu@102 {
+			compatible = "arm,cortex-a73", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x102>;
+			enable-method = "psci";
+		};
+
+		cpu7: cpu@103 {
+			compatible = "arm,cortex-a73", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x103>;
+			enable-method = "psci";
+		};
+	};
+
+	gic: interrupt-controller@e82b0000 {
+		compatible = "arm,gic-400";
+		reg = <0x0 0xe82b1000 0 0x1000>, /* GICD */
+		      <0x0 0xe82b2000 0 0x2000>, /* GICC */
+		      <0x0 0xe82b4000 0 0x2000>, /* GICH */
+		      <0x0 0xe82b6000 0 0x2000>; /* GICV */
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) |
+					 IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-controller;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) |
+					  IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <1920000>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		uart6_clk: clk_19_2M {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <19200000>;
+		};
+
+		uart6: serial@fff32000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfff32000 0x0 0x1000>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart6_clk &uart6_clk>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+	};
+};
-- 
2.17.1

