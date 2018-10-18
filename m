Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E08C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AC12098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j3AUMW06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83AC12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeJSFMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 01:12:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44062 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeJSFMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 01:12:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id r9-v6so15434898pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 14:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C21QYdTfz09iS1Hzt4A9FPL9X6rUDQrdVSY18Xmu2nc=;
        b=j3AUMW06Zb+x5XcfA2ieAgwKBdqTQXet6fKLzyexCpDMAV80GUZtajHaezgL1+Cb5x
         LOFI/+ccXerSqgE0YAgKWNdejoqa+OUz/DMOEUuTKFekIWhZvVfvzwHeU92uXlptaHyl
         t+pMcumyEFKi/Zej79xdF5BiZWsVtcMN2N6MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C21QYdTfz09iS1Hzt4A9FPL9X6rUDQrdVSY18Xmu2nc=;
        b=HvJ74JabFJC1+08KtiPSMtp6KeVIwebHK/7P06RKyT218YB1f7qB9rokCYcO978X0G
         diX3TYZSARevXXmfdjX3mB2rVd7/1D+ML76RbBwSuwLQP7HmH+s2H71GlZ4MkONtRc0I
         qcf6g065h7+Oiok90Oo48r9NKM6jVVSbeMVxNhlZvM8puR30UdsK4b9zOwjG3KLCl9qq
         BW7P51kQDa4rnFlqJuogk4kV7LvCsgf+TBUegzmCStFxSpiBTEQ/TChWX8gLPPCRRpzx
         c9PDcW3tOa+aXnWyx4NEaTuzPHTLadfMZVooP8VQsN1DmIpvLu91oJiOWwB0si6GkdkH
         EKCg==
X-Gm-Message-State: ABuFfohKDL7e1txqJC4MKyYsqJmKONj8gjUzj12QEuoly1raIVS+Wvr3
        zJND87v21wO08jAI2k6ETxSkew==
X-Google-Smtp-Source: ACcGV61shdQiXY0/t0sMdshDLoLybA+FspmUwKFllCf/vi2ReR0miNqNTwRCPEUOJ9NibNblXQHa4A==
X-Received: by 2002:a63:2503:: with SMTP id l3-v6mr29811965pgl.69.1539896997573;
        Thu, 18 Oct 2018 14:09:57 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id i29-v6sm35133678pfj.82.2018.10.18.14.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 14:09:56 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        swboyd@chromium.org
Cc:     Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 3/5] arm64: dts: qcom: sdm845: add UFS controller
Date:   Thu, 18 Oct 2018 14:09:31 -0700
Message-Id: <20181018210933.113592-4-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181018210933.113592-1-evgreen@chromium.org>
References: <20181018210933.113592-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds the UFS controller and PHY to SDM845.

Signed-off-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 67 ++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a5..9c72edb678ec 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -808,6 +808,73 @@
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
+		ufsphy1: phy@1d87000 {
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
+			ufsphy1_lanes: lanes@1d87400 {
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
2.16.4

