Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D931CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A182183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfAGOav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:30:51 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:15754 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727034AbfAGOau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:30:50 -0500
X-IronPort-AV: E=Sophos;i="5.56,451,1539628200"; 
   d="scan'208";a="353638"
Received: from ironmsg04-blr.qualcomm.com ([10.86.208.133])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 Jan 2019 20:00:47 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9128"; a="3154585"
Received: from mgottam-linux.qualcomm.com ([10.204.65.20])
  by ironmsg04-blr.qualcomm.com with ESMTP; 07 Jan 2019 20:00:46 +0530
Received: by mgottam-linux.qualcomm.com (Postfix, from userid 2305155)
        id 93A2633E2; Mon,  7 Jan 2019 20:00:45 +0530 (IST)
From:   Malathi Gottam <mgottam@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        stanimir.varbanov@linaro.org, vgarodia@codeaurora.org,
        mgottam@codeaurora.org
Subject: [PATCH v4] arm64: dts: sdm845: add video nodes
Date:   Mon,  7 Jan 2019 20:00:44 +0530
Message-Id: <1546871444-13224-1-git-send-email-mgottam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds video nodes to sdm845 based on the examples
in the bindings.

Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0..df31d39 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -87,6 +87,11 @@
 			reg = <0 0x86200000 0 0x2d00000>;
 			no-map;
 		};
+
+		venus_region: memory@95800000 {
+			reg = <0x0 0x95800000 0x0 0x600000>;
+			no-map;
+		};
 	};
 
 	cpus {
@@ -1403,5 +1408,35 @@
 				status = "disabled";
 			};
 		};
+
+		video-codec@aa00000 {
+			compatible = "qcom,sdm845-venus";
+			reg = <0x0aa00000 0xff000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&videocc VENUS_GDSC>;
+			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
+				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
+				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
+			clock-names = "core", "iface", "bus";
+			iommus = <&apps_smmu 0x10a0 0x8>,
+				 <&apps_smmu 0x10b0 0x0>;
+			memory-region = <&venus_region>;
+
+			video-core0 {
+				compatible = "venus-decoder";
+				clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
+					 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
+				clock-names = "core", "bus";
+				power-domains = <&videocc VCODEC0_GDSC>;
+			};
+
+			video-core1 {
+				compatible = "venus-encoder";
+				clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
+					 <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
+				clock-names = "core", "bus";
+				power-domains = <&videocc VCODEC1_GDSC>;
+			};
+		};
 	};
 };
-- 
1.9.1

