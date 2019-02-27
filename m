Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704A4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF9C21852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJ4/ULr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfB0G7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:59:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37908 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfB0G7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:59:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id g37so4725723plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 22:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MnpOjV/SNe6sQfK3nZ3ll5DmkqSi2WszLWuZJmb/Hwk=;
        b=RJ4/ULr6kCR3Wf0u4VCRXQs44ee4owE4NZSWETDPbZphtp43x6BgQm29dg47lUq5iY
         rmOPMJ7vSalrG8zab3uq1S8VHzWYW4ErwdswKvpY/Bx5i2IENz9E+T5EFMupEh8QQVJE
         pYXwKog9RhfSpz1fFXXGLVM8aTUEl2yPUMD9jzz2zskaMR+Jke5qbsTofS+pKRBDjHeh
         c57xPGM8RnIm9V3lnXdKQ07Ebho+qXJSTXIHTA4cJm6rumcfa1vRS5u/A6jELX2pIIhb
         jdLYuU67AV0tZ53o4Rj3HCj9tUBReet4sOmR98YFeznew/dvYxZ20pZnGehnYJ+xyGVT
         6VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MnpOjV/SNe6sQfK3nZ3ll5DmkqSi2WszLWuZJmb/Hwk=;
        b=a4VWlNpswbcGXyU57X7qFWDjFB7+7rqemQFGOX8mMvVpAvAC1fMEnBWwdqN66zIzB1
         xD7ERpYvG/g+WmMqwo1NEA1njUgl5qcdW0hl6sgpa2RorFpkSutm5EWmTzHiDCVMU44Z
         70nWqEGIcc2F0ChWaJe6ut2lJd2j4v24AK9Z9/S2ZEjgBMfrl74W2hBSTilCoFFfwduv
         thBz2d4GQXI+7yL0YmzwZ2BIbw3G4rpCD4ln+fq4GYN8V7JGZuHcCUuRmBHaLknENdrd
         RQa2zisoXSwD7oFH64DpJznxh6orZVKAZljzgAOxYl6oKjcI/MkG6JFFsKsrUFdG6t36
         e/zA==
X-Gm-Message-State: AHQUAuaph2iYdImkErIqIbWKpeIYj7T641vW7+6BIrlISvt3158vEhni
        HmLGfHAFeTyarJg8lKnETB1dcQ==
X-Google-Smtp-Source: AHgI3IYNQw3x+3kfufjCbE4iQceIdArYPfR9Uww6OktY+kw8ZLg/TX3gAAvi94LLEZSxn3LY57Yt+w==
X-Received: by 2002:a17:902:bd96:: with SMTP id q22mr622404pls.7.1551250789467;
        Tue, 26 Feb 2019 22:59:49 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o6sm36475061pgo.27.2019.02.26.22.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 22:59:48 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sdm845: Add GEN2 PCIe controller and PHY
Date:   Tue, 26 Feb 2019 23:00:22 -0800
Message-Id: <20190227070022.31975-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190226070525.22453-1-bjorn.andersson@linaro.org>
References: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 sports two PCIe controller/phy pairs; one GEN2 and one GEN3. Add
the nodes for the GEN2 pair.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- "reg" is spelled without a 't'

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 103 +++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5308f1671824..35887fedfd0e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1024,6 +1024,109 @@
 			};
 		};
 
+		pcie0: pci@1c00000 {
+			compatible = "qcom,pcie-sdm845", "snps,dw-pcie";
+			reg = <0 0x01c00000 0 0x2000>,
+			      <0 0x60000000 0 0xf1d>,
+			      <0 0x60000f20 0 0xa8>,
+			      <0 0x60100000 0 0x100000>;
+			reg-names = "parf", "dbi", "elbi", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0xd00000>;
+
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+				 <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+			clock-names = "pipe",
+				      "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "tbu";
+
+			iommu-map = <0x0 &apps_smmu 0x1c10 0x1>,
+				    <0x100 &apps_smmu 0x1c11 0x1>,
+				    <0x200 &apps_smmu 0x1c12 0x1>,
+				    <0x300 &apps_smmu 0x1c13 0x1>,
+				    <0x400 &apps_smmu 0x1c14 0x1>,
+				    <0x500 &apps_smmu 0x1c15 0x1>,
+				    <0x600 &apps_smmu 0x1c16 0x1>,
+				    <0x700 &apps_smmu 0x1c17 0x1>,
+				    <0x800 &apps_smmu 0x1c18 0x1>,
+				    <0x900 &apps_smmu 0x1c19 0x1>,
+				    <0xa00 &apps_smmu 0x1c1a 0x1>,
+				    <0xb00 &apps_smmu 0x1c1b 0x1>,
+				    <0xc00 &apps_smmu 0x1c1c 0x1>,
+				    <0xd00 &apps_smmu 0x1c1d 0x1>,
+				    <0xe00 &apps_smmu 0x1c1e 0x1>,
+				    <0xf00 &apps_smmu 0x1c1f 0x1>;
+
+			resets = <&gcc GCC_PCIE_0_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_0_GDSC>;
+
+			phys = <&pcie0_lane>;
+			phy-names = "pciephy";
+
+			status = "disabled";
+		};
+
+		pcie0_phy: phy@1c06000 {
+			compatible = "qcom,sdm845-qmp-pcie-phy";
+			reg = <0 0x01c06000 0 0x18c>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_CLKREF_CLK>,
+				 <&gcc GCC_PCIE_PHY_REFGEN_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "refgen";
+
+			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+			reset-names = "phy";
+
+			assigned-clocks = <&gcc GCC_PCIE_PHY_REFGEN_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			status = "disabled";
+
+			pcie0_lane: lanes@1c06200 {
+				reg = <0 0x01c06200 0 0x128>,
+				      <0 0x01c06400 0 0x1fc>,
+				      <0 0x01c06800 0 0x218>,
+				      <0 0x01c06600 0 0x70>;
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+				clock-names = "pipe0";
+
+				#phy-cells = <0>;
+				clock-output-names = "pcie_0_pipe_clk";
+			};
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
-- 
2.18.0

