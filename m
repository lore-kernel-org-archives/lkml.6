Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4D1ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C9221477
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cuCcoPf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C9221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJRBU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:20:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36654 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeJRBU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:20:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id y11-v6so13008755plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9EIWQQk5EjjFfrDkrK63GK5vxiX3qXyY+XumPaw9dsY=;
        b=cuCcoPf9voMp8CTmUgfpn7eps/N6acCmW3WC2ka3dZU3XUtRgyCXGh5/EjkGlCILaU
         WQFjiywqThJFWGTCpZNeHHyKF7RttBwFjeXergUrNQfMxYCp5sMGumOjVLY7kzz/Vpel
         SghWPBEwRHM7CRo0EeKR//wzDzaprh7IwQ13k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9EIWQQk5EjjFfrDkrK63GK5vxiX3qXyY+XumPaw9dsY=;
        b=tsL4R/BBYAATgFVy9CohUhWwWaIJRwXbTO5UvCD9G7ZaOO/mUDHquDFq3dcz6uZWiq
         nvySHNbiKf0N1W+UR4bSDthxSTMWAcG+DLThrkVpccYDJkX7DeNXl7PbVt9KRnL8GZ9w
         pSmQdGkaQ2998nqQTAGb4hCj97ljSy6FLOrDE7Fw1201rDiJXNvLMB95IvC+ppQB4PyY
         GpowWYA0T+xvIZ6fyeyN3zORGoeopjR8T5tflkd/+rm1S3fqpLdWzDFCeNTZ6WYDcpBd
         B/snyYpn7B7r7w2SWc6yHBcn1DmX9akWa+UPMK+eQj9Zws3a4qeq+4LzKkuoooehe2/w
         anlw==
X-Gm-Message-State: ABuFfohpjkfIPOMJQ1F9wVSOxvk408eC1wfihkNYSHkOo2WXha7rDvLh
        uqM7IftubxU8GL4lEqoUjr6lhA==
X-Google-Smtp-Source: ACcGV60eqiDrN849rDif+1g+IITyA7nwcoGomQ/uwdvgZqvyPm8QP9oOj8BnnngExyoUa1ipdXZS9Q==
X-Received: by 2002:a17:902:2867:: with SMTP id e94-v6mr13594311plb.317.1539797027351;
        Wed, 17 Oct 2018 10:23:47 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id h75-v6sm19760141pfe.146.2018.10.17.10.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 10:23:46 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     swboyd@chromium.org, dianders@chromium.org,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH 1/2] arm64: dts: qcom: sdm845: add UFS controller
Date:   Wed, 17 Oct 2018 10:23:11 -0700
Message-Id: <20181017172312.194281-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181017172312.194281-1-evgreen@chromium.org>
References: <20181017172312.194281-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds the UFS controller and PHY to SDM845.

Signed-off-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 66 ++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a5..20b2c258816a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -808,6 +808,72 @@
 			};
 		};
 
+		ufshc1: ufshc@1d84000 {
+			compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0x1d84000 0x2500>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufsphy1_lanes>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <2>;
+			power-domains = <&gcc UFS_PHY_GDSC>;
+
+			clock-names =
+				"core_clk",
+				"bus_aggr_clk",
+				"iface_clk",
+				"core_clk_unipro",
+				"ref_clk",
+				"tx_lane0_sync_clk",
+				"rx_lane0_sync_clk",
+				"rx_lane1_sync_clk";
+			clocks =
+				<&gcc GCC_UFS_PHY_AXI_CLK>,
+				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				<&gcc GCC_UFS_PHY_AHB_CLK>,
+				<&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				<&rpmhcc RPMH_CXO_CLK>,
+				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
+			freq-table-hz =
+				<50000000 200000000>,
+				<0 0>,
+				<0 0>,
+				<37500000 150000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>;
+
+			resets = <&gcc GCC_UFS_PHY_BCR>;
+			reset-names = "rst";
+
+			status = "disabled";
+		};
+
+		ufsphy1: ufsphy@1d87000 {
+			compatible = "qcom,sdm845-qmp-ufs-phy";
+			reg = <0x1d87000 0x18c>;
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clock-names = "ref",
+				      "ref_aux";
+			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+
+			status = "disabled";
+
+			ufsphy1_lanes: lanes@1d87400 {
+				reg = <0x1d87400 0x108>,
+				      <0x1d87600 0x1e0>,
+				      <0x1d87c00 0x1dc>;
+				#phy-cells = <0>;
+			};
+		};
+
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
 			reg = <0x1f40000 0x40000>;
-- 
2.16.4

