Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66033C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CFD20658
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e1/ilcqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CFD20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeHVVCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:02:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41526 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeHVVCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:02:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id s15-v6so1231707pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9McL/g/MgpstktVbMGU7DKBV2+ctoWiSxe0CS09NNqo=;
        b=e1/ilcqsxf+iqI7kcuu2jzCLYOgolkxSqK7WqUDuIkER/s95rE0wk8RYbfpUp9mEAd
         HTxwMfXb8FNOLnBFCDRo0aoRVZ5MyWf5us/4RKaQH9dIc+zrvSNYaRv08qd6ToNFhXXe
         zeOof32O02j62gxy1MLblCXPw98NRHsbASF7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9McL/g/MgpstktVbMGU7DKBV2+ctoWiSxe0CS09NNqo=;
        b=c6FQYXn+FijjQHJ7lBAnFFnCGohhUbkcQtx7d+qRC1L93b2YxkUrBMgWlMsc+l7ZlJ
         QaxrSudbppPMmsuuvGZrQTlZ2lvGc01lGTRzBLn8Hhp0UidOkQhwfYbf7vI7m29UHq7w
         Wq3jAXBZnLMhtuQqpKUUc9CXEXTYSZ9ulWXbPy+1Lgl0vGWg5RrwTN4r/xv806DsNqfi
         /LjMw4eE4GgNXJIf/95l5SDYeXKxoTwP/3t0HbtUxOG4mzhdbyRsCCqQIFepJ+UIUe0J
         m9iDSX4qQcsInBf+MzU4zWxL7n5/3GCJiKdrYy/Lr+gsJKhehvTrtUspJfIHgwPy0zcw
         KEoQ==
X-Gm-Message-State: AOUpUlFi1HRY/OTvOBgyy31/RitQOzGAXGaIU2Qg/WU42IdcruPXY3py
        1JODuGZn2blhpefwbcWyTYCVgg==
X-Google-Smtp-Source: AA+uWPwjxjSdNAD4gynl8m9SxWyhrrg9lDaOaKF5KXpb54ivjBXL+BHKyB2jGNKZf9Z6TK6zRHSVEQ==
X-Received: by 2002:a65:5286:: with SMTP id y6-v6mr51927597pgp.65.1534959414567;
        Wed, 22 Aug 2018 10:36:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id s73-v6sm3378439pfi.154.2018.08.22.10.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 10:36:53 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, swboyd@chromium.org,
        tfiga@chromium.org, Manu Gautam <mgautam@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v3 1/3] arm64: dts: qcom: sdm845: Add USB-related nodes
Date:   Wed, 22 Aug 2018 10:36:27 -0700
Message-Id: <20180822173629.202885-2-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45-goog
In-Reply-To: <20180822173629.202885-1-dianders@chromium.org>
References: <20180822173629.202885-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Gautam <mgautam@codeaurora.org>

This adds nodes for USB and related PHYs.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
[dianders: reworked quite a bit]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Don't just fix qfprom unit address, fix the reg too (Stephen).
- Rebased to next-20180822

Changes in v2:
- Use "0x784000" for qfprom rather than "0x780000" as per docs.
- Add calibration for 2nd USB port too

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 196 +++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 627e8c181c20..8c2088de3a8d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -249,6 +250,23 @@
 			#power-domain-cells = <1>;
 		};
 
+		qfprom@784000 {
+			compatible = "qcom,qfprom";
+			reg = <0x784000 0x8ff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qusb2p_hstx_trim: hstx-trim-primary@1eb {
+				reg = <0x1eb 0x1>;
+				bits = <1 4>;
+			};
+
+			qusb2s_hstx_trim: hstx-trim-secondary@1eb {
+				reg = <0x1eb 0x2>;
+				bits = <6 4>;
+			};
+		};
+
 		qupv3_id_0: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x8c0000 0x6000>;
@@ -962,6 +980,184 @@
 			};
 		};
 
+		usb_1_hsphy: phy@88e2000 {
+			compatible = "qcom,sdm845-qusb2-phy";
+			reg = <0x88e2000 0x400>;
+			status = "disabled";
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+
+			nvmem-cells = <&qusb2p_hstx_trim>;
+		};
+
+		usb_2_hsphy: phy@88e3000 {
+			compatible = "qcom,sdm845-qusb2-phy";
+			reg = <0x88e3000 0x400>;
+			status = "disabled";
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
+
+			nvmem-cells = <&qusb2s_hstx_trim>;
+		};
+
+		usb_1_qmpphy: phy@88e9000 {
+			compatible = "qcom,sdm845-qmp-usb3-phy";
+			reg = <0x88e9000 0x18c>,
+			      <0x88e8000 0x10>;
+			reg-names = "reg-base", "dp_com";
+			status = "disabled";
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
+
+			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
+				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
+			reset-names = "phy", "common";
+
+			usb_1_ssphy: lane@88e9200 {
+				reg = <0x88e9200 0x128>,
+				      <0x88e9400 0x200>,
+				      <0x88e9c00 0x218>,
+				      <0x88e9a00 0x100>;
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_phy_pipe_clk_src";
+			};
+		};
+
+		usb_2_qmpphy: phy@88eb000 {
+			compatible = "qcom,sdm845-qmp-usb3-uni-phy";
+			reg = <0x88eb000 0x18c>;
+			status = "disabled";
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
+				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&gcc GCC_USB3_SEC_CLKREF_CLK>,
+				 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
+
+			resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR>,
+				 <&gcc GCC_USB3_PHY_SEC_BCR>;
+			reset-names = "phy", "common";
+
+			usb_2_ssphy: lane@88eb200 {
+				reg = <0x88eb200 0x128>,
+				      <0x88eb400 0x1fc>,
+				      <0x88eb800 0x218>,
+				      <0x88e9600 0x70>;
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_uni_phy_pipe_clk_src";
+			};
+		};
+
+		usb_1: usb@a6f8800 {
+			compatible = "qcom,sdm845-dwc3", "qcom,dwc3";
+			reg = <0xa6f8800 0x400>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
+				      "sleep";
+
+			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <150000000>;
+
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+					  "dm_hs_phy_irq", "dp_hs_phy_irq";
+
+			power-domains = <&gcc USB30_PRIM_GDSC>;
+
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+
+			usb_1_dwc3: dwc3@a600000 {
+				compatible = "snps,dwc3";
+				reg = <0xa600000 0xcd00>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
+
+		usb_2: usb@a8f8800 {
+			compatible = "qcom,sdm845-dwc3", "qcom,dwc3";
+			reg = <0xa8f8800 0x400>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB30_SEC_SLEEP_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
+				      "sleep";
+
+			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <150000000>;
+
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+					  "dm_hs_phy_irq", "dp_hs_phy_irq";
+
+			power-domains = <&gcc USB30_SEC_GDSC>;
+
+			resets = <&gcc GCC_USB30_SEC_BCR>;
+
+			usb_2_dwc3: dwc3@a800000 {
+				compatible = "snps,dwc3";
+				reg = <0xa800000 0xcd00>;
+				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys = <&usb_2_hsphy>, <&usb_2_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
+
 		tsens0: thermal-sensor@c263000 {
 			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
 			reg = <0xc263000 0x1ff>, /* TM */
-- 
2.18.0.1017.ga543ac7ca45-goog

