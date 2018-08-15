Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47637C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0B42168C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0B42168C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeHOIJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 04:09:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60371 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725993AbeHOIJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 04:09:04 -0400
X-UUID: 205530ec308c4bb69200b39893a2a79d-20180815
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 772791543; Wed, 15 Aug 2018 13:18:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 15 Aug 2018 13:18:19 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 15 Aug 2018 13:18:19 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/5] arm64: dts: mt7622: add some misc device nodes
Date:   Wed, 15 Aug 2018 13:18:13 +0800
Message-ID: <68c4ca0158518d6bf50f2f7becfcb87ff3ce158a.1534130854.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timer and CCI-400 device nodes for MT7622.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 9213c96..b235df7 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -79,6 +79,7 @@
 			#cooling-cells = <2>;
 			enable-method = "psci";
 			clock-frequency = <1300000000>;
+			cci-control-port = <&cci_control2>;
 		};
 
 		cpu1: cpu@1 {
@@ -91,6 +92,7 @@
 			operating-points-v2 = <&cpu_opp_table>;
 			enable-method = "psci";
 			clock-frequency = <1300000000>;
+			cci-control-port = <&cci_control2>;
 		};
 	};
 
@@ -217,6 +219,16 @@
 		#reset-cells = <1>;
 	};
 
+	timer: timer@10004000 {
+		compatible = "mediatek,mt7622-timer",
+			     "mediatek,mt6577-timer";
+		reg = <0 0x10004000 0 0x80>;
+		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_APXGPT_PD>,
+			 <&topckgen CLK_TOP_RTC>;
+		clock-names = "system-clk", "rtc-clk";
+	};
+
 	scpsys: scpsys@10006000 {
 		compatible = "mediatek,mt7622-scpsys",
 			     "syscon";
@@ -317,6 +329,42 @@
 		      <0 0x10360000 0 0x2000>;
 	};
 
+	cci: cci@10390000 {
+		compatible = "arm,cci-400";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0x10390000 0 0x1000>;
+		ranges = <0 0 0x10390000 0x10000>;
+
+		cci_control0: slave-if@1000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace-lite";
+			reg = <0x1000 0x1000>;
+		};
+
+		cci_control1: slave-if@4000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x4000 0x1000>;
+		};
+
+		cci_control2: slave-if@5000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x5000 0x1000>;
+		};
+
+		pmu@9000 {
+			compatible = "arm,cci-400-pmu,r1";
+			reg = <0x9000 0x5000>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 61 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 62 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+
 	auxadc: adc@11001000 {
 		compatible = "mediatek,mt7622-auxadc";
 		reg = <0 0x11001000 0 0x1000>;
-- 
1.9.1

