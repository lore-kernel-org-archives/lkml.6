Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D16C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5012086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5012086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbeGLMJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:09:46 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16230 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeGLMJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:09:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b4742b10004>; Thu, 12 Jul 2018 04:59:45 -0700
Received: from HQMAIL108.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 12 Jul 2018 05:00:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 12 Jul 2018 05:00:30 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 12 Jul
 2018 12:00:29 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Thu, 12 Jul 2018 12:00:29 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b4742dc0000>; Thu, 12 Jul 2018 05:00:30 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
CC:     Aapo Vienamo <avienamo@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/7] dt-bindings: Add Tegra PMC pad configuration bindings
Date:   Thu, 12 Jul 2018 15:00:11 +0300
Message-ID: <1531396813-6581-6-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531396813-6581-1-git-send-email-avienamo@nvidia.com>
References: <1531396813-6581-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the pinctrl bindings used by the PMC driver for performing pad
configuration. Both nvidia,tegra186-pmc.txt and nvidia,tegra20-pmc.txt
are modified as they both cover SoC generations for which these bindings
apply.

Add a header defining Tegra PMC pad voltage configurations.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     | 84 +++++++++++++++++++
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 95 ++++++++++++++++++++++
 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h | 18 ++++
 3 files changed, 197 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
index 5a3bf7c..9528f41 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
@@ -34,3 +34,87 @@ Board DTS:
 	pmc@c360000 {
 		nvidia,invert-interrupt;
 	};
+
+== Pad Control Nodes ==
+
+The PMC can be used to set pad power state and voltage configuration.
+The pad configuration is done via the pinctrl framework. The driver
+implements power-source, low-power-enable, and low-power-disable pinconf
+pin configuration node properties. Each pinctrl pin corresponds to a
+single Tegra PMC pad. Thus, in the following sections of this document
+pin refers to the pinctrl frameworks notion of a Tegra PMC pad.
+
+The pad configuration state nodes are placed under the pmc node and they
+are referred to by the pinctrl client device properties. For more
+information see the examples presented later and
+Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
+
+The values accepted by power-source property are
+TEGRA_IO_PAD_VOLTAGE_1V8 and TEGRA_IO_PAD_VOLTAGE_3V3, which are defined
+in dt-bindings/pinctrl/pinctrl-tegra-io-pad.h.
+
+Following pinctrl pin name strings are present on Tegra186:
+csia		csib		dsi		mipi-bias
+pex-clk-bias	pex-clk3	pex-clk2	pex-clk1
+usb0		usb1		usb2		usb-bias
+uart		audio		hsic		dbg
+hdmi-dp0	hdmi-dp1	pex-cntrl	sdmmc2-hv
+sdmmc4		cam		dsib		dsic
+dsid		csic		csid		csie
+dsif		spi		ufs		dmic-hv
+edp		sdmmc1-hv	sdmmc3-hv	conn
+audio-hv	ao-hv
+
+All of the listed Tegra186 pins except ao-hv support the
+low-power-enable and low-power-disable properties. The power-source
+property is supported following Tegra210 pins: sdmmc2-hv, dmic-hv,
+sdmmc1-hv, sdmmc3-hv, audio-hv, ao-hv.
+
+Pad configuration state example:
+	pmc: pmc@7000e400 {
+		compatible = "nvidia,tegra186-pmc";
+		reg = <0 0x0c360000 0 0x10000>,
+		      <0 0x0c370000 0 0x10000>,
+		      <0 0x0c380000 0 0x10000>,
+		      <0 0x0c390000 0 0x10000>;
+		reg-names = "pmc", "wake", "aotag", "scratch";
+
+		...
+
+		sdmmc1_3v3: sdmmc1-3v3 {
+			pins = "sdmmc1-hv";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
+		};
+
+		sdmmc1_1v8: sdmmc1-1v8 {
+			pins = "sdmmc1-hv";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
+		};
+
+		hdmi_off: hdmi-off {
+			pins = "hdmi";
+			low-power-enable;
+		}
+
+		hdmi_on: hdmi-on {
+			pins = "hdmi";
+			low-power-disable;
+		}
+	};
+
+Pinctrl client example:
+	sdmmc1: sdhci@3400000 {
+		...
+		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+		pinctrl-0 = <&sdmmc1_3v3>;
+		pinctrl-1 = <&sdmmc1_1v8>;
+	};
+
+	...
+
+	sor0: sor@15540000 {
+		...
+		pinctrl-0 = <&hdmi_off>;
+		pinctrl-1 = <&hdmi_on>;
+		pinctrl-names = "hdmi-on", "hdmi-off";
+	};
diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index a74b37b..d50a505 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -195,3 +195,98 @@ Example:
 		power-domains = <&pd_audio>;
 		...
 	};
+
+== Pad Control Nodes ==
+
+The PMC can be used to set pad power state and voltage configuration.
+This functionality is present on SoCs from Tegra124 onwards. The pad
+configuration is done via the pinctrl framework. The driver implements
+power-source, low-power-enable, and low-power-disable pinconf pin
+configuration node properties. Each pinctrl pin corresponds to a single
+Tegra PMC pad. Thus, in the following sections of this document pin
+refers to the pinctrl frameworks notion of a Tegra PMC pad.
+
+The pad configuration state nodes are placed under the pmc node and they
+are referred to by the pinctrl client device properties. For more
+information see the examples presented later and
+Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
+
+The values accepted by power-source property are
+TEGRA_IO_PAD_VOLTAGE_1V8 and TEGRA_IO_PAD_VOLTAGE_3V3, which are defined
+in dt-bindings/pinctrl/pinctrl-tegra-io-pad.h.
+
+Following pinctrl pin name strings are present on Tegra124 and Tegra132:
+audio		bb		cam		comp
+csia		csb		cse		dsi
+dsib		dsic		dsid		hdmi
+hsic		hv		lvds		mipi-bias
+nand		pex-bias	pex-clk1	pex-clk2
+pex-cntrl	sdmmc1		sdmmc3		sdmmc4
+sys_ddc		uart		usb0		usb1
+usb2		usb_bias
+
+All of the listed Tegra124 and Tegra132 pins support the
+low-power-enable and low-power-disable properties. None of the pins
+support the power-source property.
+
+Following pinctrl pin name strings are present on Tegra210:
+audio		audio-hv	cam		csia
+csib		csic		csid		csie
+csif		dbg		debug-nonao	dmic
+dp		dsi		dsib		dsic
+dsid		emmc		emmc2		gpio
+hdmi		hsic		lvds		mipi-bias
+pex-bias	pex-clk1	pex-clk2	pex-cntrl
+sdmmc1		sdmmc3		spi		spi-hv
+uart		usb0		usb1		usb2
+usb3		usb-bias
+
+All of the listed Tegra210 pins except pex-cntrl support the
+low-power-enable and low-power-disable properties. The power-source
+property is supported following Tegra210 pins: audio, audio-hv, cam,
+dbg, dmic, gpio, pex-cntrl, sdmmc1, sdmmc3, spi, spi-hv, and uart.
+
+Pad configuration state example:
+	pmc: pmc@7000e400 {
+		compatible = "nvidia,tegra210-pmc";
+		reg = <0x0 0x7000e400 0x0 0x400>;
+		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
+		clock-names = "pclk", "clk32k_in";
+
+		...
+
+		sdmmc1_3v3: sdmmc1-3v3 {
+			pins = "sdmmc1";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
+		};
+
+		sdmmc1_1v8: sdmmc1-1v8 {
+			pins = "sdmmc1";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
+		};
+
+		hdmi_off: hdmi-off {
+			pins = "hdmi";
+			low-power-enable;
+		}
+
+		hdmi_on: hdmi-on {
+			pins = "hdmi";
+			low-power-disable;
+		}
+	};
+
+Pinctrl client example:
+	sdmmc1: sdhci@700b0000 {
+		...
+		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+		pinctrl-0 = <&sdmmc1_3v3>;
+		pinctrl-1 = <&sdmmc1_1v8>;
+	};
+	...
+	sor@54540000 {
+		...
+		pinctrl-0 = <&hdmi_off>;
+		pinctrl-1 = <&hdmi_on>;
+		pinctrl-names = "hdmi-on", "hdmi-off";
+	};
diff --git a/include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h b/include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
new file mode 100644
index 0000000..20f4340
--- /dev/null
+++ b/include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * pinctrl-tegra-io-pad.h: Tegra I/O pad source voltage configuration constants
+ * pinctrl bindings.
+ *
+ * Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Author: Aapo Vienamo <avienamo@nvidia.com>
+ */
+
+#ifndef _DT_BINDINGS_PINCTRL_TEGRA_IO_PAD_H
+#define _DT_BINDINGS_PINCTRL_TEGRA_IO_PAD_H
+
+/* Voltage levels of the I/O pad's source rail */
+#define TEGRA_IO_PAD_VOLTAGE_1V8	0
+#define TEGRA_IO_PAD_VOLTAGE_3V3	1
+
+#endif
-- 
2.7.4

