Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeEBDlj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 23:41:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60315 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751140AbeEBDlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 23:41:32 -0400
X-UUID: eb1babd2fff14a419320e8f5eb591ce0-20180502
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 2/2] arm64: dts: mt7622: add audio related device nodes
Date: Wed, 2 May 2018 11:41:24 +0800
Message-ID: <e48bc87f54d7f2e06664ee358822aa9a9e34256b.1525231985.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <d208e8cf93f18b97ee9cf24cdd0220aa44188b8b.1525231985.git.sean.wang@mediatek.com>
References: <d208e8cf93f18b97ee9cf24cdd0220aa44188b8b.1525231985.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

Add audio device nodes and its proper setup for all used pins

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 11 +++-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 89 ++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 45d8655..b783764 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -18,7 +18,7 @@
 	compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
 
 	chosen {
-		bootargs = "console=ttyS0,115200n1";
+		bootargs = "console=ttyS0,115200n1 swiotlb=512";
 	};
 
 	cpus {
@@ -163,10 +163,17 @@
 	i2s1_pins: i2s1-pins {
 		mux {
 			function = "i2s";
-			groups =  "i2s_out_bclk_ws_mclk",
+			groups =  "i2s_out_mclk_bclk_ws",
 				  "i2s1_in_data",
 				  "i2s1_out_data";
 		};
+
+		conf {
+			pins = "I2S1_IN", "I2S1_OUT", "I2S_BCLK",
+			       "I2S_WS", "I2S_MCLK";
+			drive-strength = <12>;
+			bias-pull-down;
+		};
 	};
 
 	irrx_pins: irrx-pins {
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 6bbabb6..9213c96 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -527,6 +527,95 @@
 		status = "disabled";
 	};
 
+	audsys: clock-controller@11220000 {
+		compatible = "mediatek,mt7622-audsys", "syscon";
+		reg = <0 0x11220000 0 0x2000>;
+		#clock-cells = <1>;
+
+		afe: audio-controller {
+			compatible = "mediatek,mt7622-audio";
+			interrupts =  <GIC_SPI 144 IRQ_TYPE_LEVEL_LOW>,
+				      <GIC_SPI 145 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-names	= "afe", "asys";
+
+			clocks = <&infracfg CLK_INFRA_AUDIO_PD>,
+				 <&topckgen CLK_TOP_AUD1_SEL>,
+				 <&topckgen CLK_TOP_AUD2_SEL>,
+				 <&topckgen CLK_TOP_A1SYS_HP_DIV_PD>,
+				 <&topckgen CLK_TOP_A2SYS_HP_DIV_PD>,
+				 <&topckgen CLK_TOP_I2S0_MCK_SEL>,
+				 <&topckgen CLK_TOP_I2S1_MCK_SEL>,
+				 <&topckgen CLK_TOP_I2S2_MCK_SEL>,
+				 <&topckgen CLK_TOP_I2S3_MCK_SEL>,
+				 <&topckgen CLK_TOP_I2S0_MCK_DIV>,
+				 <&topckgen CLK_TOP_I2S1_MCK_DIV>,
+				 <&topckgen CLK_TOP_I2S2_MCK_DIV>,
+				 <&topckgen CLK_TOP_I2S3_MCK_DIV>,
+				 <&topckgen CLK_TOP_I2S0_MCK_DIV_PD>,
+				 <&topckgen CLK_TOP_I2S1_MCK_DIV_PD>,
+				 <&topckgen CLK_TOP_I2S2_MCK_DIV_PD>,
+				 <&topckgen CLK_TOP_I2S3_MCK_DIV_PD>,
+				 <&audsys CLK_AUDIO_I2SO1>,
+				 <&audsys CLK_AUDIO_I2SO2>,
+				 <&audsys CLK_AUDIO_I2SO3>,
+				 <&audsys CLK_AUDIO_I2SO4>,
+				 <&audsys CLK_AUDIO_I2SIN1>,
+				 <&audsys CLK_AUDIO_I2SIN2>,
+				 <&audsys CLK_AUDIO_I2SIN3>,
+				 <&audsys CLK_AUDIO_I2SIN4>,
+				 <&audsys CLK_AUDIO_ASRCO1>,
+				 <&audsys CLK_AUDIO_ASRCO2>,
+				 <&audsys CLK_AUDIO_ASRCO3>,
+				 <&audsys CLK_AUDIO_ASRCO4>,
+				 <&audsys CLK_AUDIO_AFE>,
+				 <&audsys CLK_AUDIO_AFE_CONN>,
+				 <&audsys CLK_AUDIO_A1SYS>,
+				 <&audsys CLK_AUDIO_A2SYS>;
+
+			clock-names = "infra_sys_audio_clk",
+				      "top_audio_mux1_sel",
+				      "top_audio_mux2_sel",
+				      "top_audio_a1sys_hp",
+				      "top_audio_a2sys_hp",
+				      "i2s0_src_sel",
+				      "i2s1_src_sel",
+				      "i2s2_src_sel",
+				      "i2s3_src_sel",
+				      "i2s0_src_div",
+				      "i2s1_src_div",
+				      "i2s2_src_div",
+				      "i2s3_src_div",
+				      "i2s0_mclk_en",
+				      "i2s1_mclk_en",
+				      "i2s2_mclk_en",
+				      "i2s3_mclk_en",
+				      "i2so0_hop_ck",
+				      "i2so1_hop_ck",
+				      "i2so2_hop_ck",
+				      "i2so3_hop_ck",
+				      "i2si0_hop_ck",
+				      "i2si1_hop_ck",
+				      "i2si2_hop_ck",
+				      "i2si3_hop_ck",
+				      "asrc0_out_ck",
+				      "asrc1_out_ck",
+				      "asrc2_out_ck",
+				      "asrc3_out_ck",
+				      "audio_afe_pd",
+				      "audio_afe_conn_pd",
+				      "audio_a1sys_pd",
+				      "audio_a2sys_pd";
+
+			assigned-clocks = <&topckgen CLK_TOP_A1SYS_HP_SEL>,
+					  <&topckgen CLK_TOP_A2SYS_HP_SEL>,
+					  <&topckgen CLK_TOP_A1SYS_HP_DIV>,
+					  <&topckgen CLK_TOP_A2SYS_HP_DIV>;
+			assigned-clock-parents = <&topckgen CLK_TOP_AUD1PLL>,
+						 <&topckgen CLK_TOP_AUD2PLL>;
+			assigned-clock-rates = <0>, <0>, <49152000>, <45158400>;
+		};
+	};
+
 	mmc0: mmc@11230000 {
 		compatible = "mediatek,mt7622-mmc";
 		reg = <0 0x11230000 0 0x1000>;
-- 
2.7.4
