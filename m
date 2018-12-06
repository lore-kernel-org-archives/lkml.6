Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159B9C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8B42146F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SZfDT2Yy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8B42146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeLFXc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:32:26 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33212 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeLFXcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:32:24 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so904440plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F36H2yFwmgGDNBfcZxCvb5Zmw+1JrX+IJ0TMEgz6BGY=;
        b=SZfDT2YyMoznP+45Ot7gW7PSDNHkLXoXKLT271i/Hi+9+a8dTVb2qsV549lMOy1bBA
         IK1scs1jioSFTEdgEvUlZG5nuCb4G+1DAK9VpzOKGOQ89taroolmNW2bYLgxKDP/KlIw
         zyliwmGDhj8RJLt+2tXDEMQP1ofDdwbdeBp6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F36H2yFwmgGDNBfcZxCvb5Zmw+1JrX+IJ0TMEgz6BGY=;
        b=h7rodHI1ri1+0weWtxqOXGm8DVE+wIgLMUzQYCPD9SMvnRZQoRoOQh1TFDMmqrX6Z0
         82AMtR3vRVrCN4c+KpxkQBbEejDL23+k0JCt0uP9D/QtYilDVRKsE2+oj6fY7Rd5xUAf
         XSMdVcm70a3FCBggyZJkeqRQr+bG1LGYU73/8+wrFL8aYgPDpf/voASHu273G2fwIqMg
         yY2Vgp/mY92bVkAdiBNafgg28RXjvg6qThs14fAd80AE+FC8UWLdFAsOcWEgBwXayaOZ
         lB0ahfThp9Kf3MG0slqh9SKig/aFWmdeqraIF8Gu1+xAlmHrYQ15kKW5bQjw2VZPm3KY
         In6A==
X-Gm-Message-State: AA+aEWYygcFXXzwQhIzRxfdjqeTLdDQfUSVX8Ge+jmw507xJxLy6BNRC
        3kZX05ed9PzZci3RnJjYGXI1mA==
X-Google-Smtp-Source: AFSGD/U4lPLOPNyEF9BrOeMbgYKkAJNaHWt2gwo7ycPa1wiY17d4DxNllSoO60q5ylJWQNR/dSlCdw==
X-Received: by 2002:a17:902:4c85:: with SMTP id b5mr28830814ple.226.1544139143452;
        Thu, 06 Dec 2018 15:32:23 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id s190sm2100875pfb.103.2018.12.06.15.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 15:32:22 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 3/5] arm64: dts: qcom: sdm845: add UFS controller
Date:   Thu,  6 Dec 2018 15:32:02 -0800
Message-Id: <20181206233205.193244-4-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181206233205.193244-1-evgreen@chromium.org>
References: <20181206233205.193244-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the UFS controller and PHY to SDM845.

Signed-off-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

---
As Doug mentioned in v2, this should land after (or with) the driver fix
in this series.

Changes in v6:
- Removed resets and reset-names (Bjorn)
- Renamed nodes (Bjorn)

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
- Renamed ufsphy to phy (Vivek)
- Removed #clock-cells (Vivek)

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 64 ++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 1419b0098cb38..9e4ad805d2936 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -816,6 +816,70 @@
 			};
 		};
 
+		ufs_mem_hc: ufshc@1d84000 {
+			compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0x1d84000 0x2500>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufs_mem_phy_lanes>;
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
+			status = "disabled";
+		};
+
+		ufs_mem_phy: phy@1d87000 {
+			compatible = "qcom,sdm845-qmp-ufs-phy";
+			reg = <0x1d87000 0x18c>;
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
+			ufs_mem_phy_lanes: lanes@1d87400 {
+				reg = <0x1d87400 0x108>,
+				      <0x1d87600 0x1e0>,
+				      <0x1d87c00 0x1dc>,
+				      <0x1d87800 0x108>,
+				      <0x1d87a00 0x1e0>;
+				#phy-cells = <0>;
+			};
+		};
+
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
 			reg = <0x1f40000 0x40000>;
-- 
2.18.1

