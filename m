Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC113C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8596B21E26
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jx79hEdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8596B21E26
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeHKAX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:23:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36838 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbeHKAXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:23:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so5108951pfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+hB8rYixDPv7w8pbb3jOsSGCvJWRG2FAXm2rwnOssvo=;
        b=jx79hEdbUO2JsOdrUet17IkQGVwFHDzJ4/Bw8KSSz3dkoHWHU6z3wMiQ/PE8V5kbWF
         MV0R7jXGKL5tZ6A66gkWfLknug4dqajI6g6nKvP3EH2Hli8DXQq8WuUoClk/N8BTB+j7
         Y/fa50t+GB3PGKSR8zO+7RvEJ9MODoiGeJKJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+hB8rYixDPv7w8pbb3jOsSGCvJWRG2FAXm2rwnOssvo=;
        b=LLhs2BK5YawBzu5cxHvFfKR8d+6UCTuMKYsFunzj4Lgn1fJXbqCcgViXokqpX/Qx9q
         JrUXDUu13ha1cVLzcn8sPyctkybrXCq2hyKRy91rfUYVDQze88fgLsKOi9433ruNQuWj
         CzF8aRT06maO5f6W+tNjx5WWDMKnzitCkM29XTPkHP7CrE0zbAgqtqM3QnDFEEQYrClt
         W5WnAOwGY22478HstcLSo+aaX6cVJ+3WNu3eW1XYTB625ZPCkoGzFGQyE8BzdFsTWKCB
         XjItK+FEB8tjva6yxD3h4wkTDVXDxDxBcIu/SFbJB5HrbBxw7mVvD8x9YX3efZeL8Ay4
         vgMg==
X-Gm-Message-State: AOUpUlH16hUxb3X6D+kpQ/DD3Rr4GHA4F3gLalnY1erpsFTrCtAVBpQL
        0K7f+IEpN4HVfpAJstHo88Io8nfKO38=
X-Google-Smtp-Source: AA+uWPz7UB7wZZ+LttRIB4cEaUuQhzgTW9Dqm3bnYimUBTXANcLpmOeIDAlL00vLJiMkLYOQN2tiEQ==
X-Received: by 2002:a63:2a0b:: with SMTP id q11-v6mr7970627pgq.36.1533937933577;
        Fri, 10 Aug 2018 14:52:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id g11-v6sm25730102pgi.90.2018.08.10.14.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 14:52:12 -0700 (PDT)
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
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] arm64: dts: qcom: sdm845: Add USB-related nodes
Date:   Fri, 10 Aug 2018 14:51:48 -0700
Message-Id: <20180810215150.82490-2-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180810215150.82490-1-dianders@chromium.org>
References: <20180810215150.82490-1-dianders@chromium.org>
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

Changes in v2:
- Use "0x784000" for qfprom rather than "0x780000" as per docs.
- Add calibration for 2nd USB port too

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 196 +++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ae57c065780c..f13d8c2fb4a5 100644
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
+			reg = <0x780000 0x8ff>;
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
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0x1100>,
-- 
2.18.0.597.ga71716f1ad-goog

