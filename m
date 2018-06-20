Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F5AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1573320836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1573320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754389AbeFTMWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:22:23 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7272 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754210AbeFTMV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:21:26 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b2a46cb0000>; Wed, 20 Jun 2018 05:21:31 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 20 Jun 2018 05:21:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 20 Jun 2018 05:21:29 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 20 Jun
 2018 12:21:25 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Wed, 20 Jun 2018 12:21:25 +0000
Received: from mperttunen-lnx.Nvidia.com (Not Verified[10.21.26.144]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b2a46c20000>; Wed, 20 Jun 2018 05:21:24 -0700
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jassisinghbrar@gmail.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 7/8] arm64: tegra: Add nodes for tcu on Tegra194
Date:   Wed, 20 Jun 2018 15:20:41 +0300
Message-ID: <20180620122042.10950-8-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180620122042.10950-1-mperttunen@nvidia.com>
References: <20180620122042.10950-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes required for communication through the Tegra Combined UART.
This includes the AON HSP instance, addition of shared interrupts
for the TOP0 HSP instance, and finally the TCU node itself. Also
mark the HSP instances as compatible to tegra194-hsp, as the hardware
is not identical but is compatible to tegra186-hsp.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 34 +++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 6d699815a84f..d7f780b06fe2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -217,10 +217,31 @@
 		};
 
 		hsp_top0: hsp@3c00000 {
-			compatible = "nvidia,tegra186-hsp";
+			compatible = "nvidia,tegra194-hsp", "nvidia,tegra186-hsp";
 			reg = <0x03c00000 0xa0000>;
-			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "doorbell";
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "doorbell", "shared0", "shared1", "shared2",
+			                  "shared3", "shared4", "shared5", "shared6",
+			                  "shared7";
+			#mbox-cells = <2>;
+		};
+
+		hsp_aon: hsp@c150000 {
+			compatible = "nvidia,tegra194-hsp", "nvidia,tegra186-hsp";
+			reg = <0x0c150000 0xa0000>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "shared0", "shared1", "shared2", "shared3";
 			#mbox-cells = <2>;
 		};
 
@@ -382,6 +403,13 @@
 		};
 	};
 
+	tcu: tcu {
+		compatible = "nvidia,tegra194-tcu";
+		mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM 0>,
+		         <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM 1>;
+		mbox-names = "rx", "tx";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.16.1

