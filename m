Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF36ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36396206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lq0Ahtip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36396206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeJYB5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:57:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45738 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJYB5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:57:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id t10-v6so1333525pfh.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1YMXXvnPT80nLN/AeRFvYKT6u9kQcvBBEAiIyCdBvqI=;
        b=Lq0Ahtipr6t/85CWRjyUFcqKyaKN4r7LDsXNByrYsTIqZjSjNWkTnhGO9SVr/YXXB4
         eb3kb4SQYvA7VzINBN15czFZeS3TZhzZxkgnYjJplmfRbHE0xgFqADcFp1B9uyELyuS4
         s/2v7LHXQKhRPSM2ICZO3pxBj6AqtYQUVMcT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1YMXXvnPT80nLN/AeRFvYKT6u9kQcvBBEAiIyCdBvqI=;
        b=nQHZQc7YNEwOkWoQfa4v+1PdLhL0+ppvbvgPDiD1tZFNaVQFqMl7O0jkSzJjuIMqKr
         TUspkLeHRSpYlA2pArcHXCoP3yuuGIWlv4VigPNXtHl2MwHU+bFWGDJnSFZ7K2dt/1qc
         OOt8ZJyEWlJal1/1qnGRhmbTU6oJ5WTfByvkTvtOjs8/Ba+KvR7rrOs0zu90Auej5/GP
         OGPEzH4pW2PgLW+vJw6u5VofvoUWt952wlj2WSTonWMn/zscpdJApt16o/iBic9FlEjG
         HROdf6eScQcIKesjujXcAaY8NYgLRG75oC4u/owj50V1BAlNkUSxPEKuqaiWODiQSqCH
         GgZw==
X-Gm-Message-State: AGRZ1gKvf9mdoApIdXk4oSNhiSJFkY1C+Bwj1adCuTg4Fc8n2ssZDM3O
        DwXyDio/Al2oJYsGjJkfSrEefg==
X-Google-Smtp-Source: AJdET5eE/x93izDsYzVpAIqkPew9unLYHGs1U7wWg3NxyYVlNDzxXjUQYyx3TKO8LBGFKrRs6jHliQ==
X-Received: by 2002:a63:c0f:: with SMTP id b15-v6mr3423345pgl.400.1540402103844;
        Wed, 24 Oct 2018 10:28:23 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id v185-v6sm5674265pfv.48.2018.10.24.10.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 10:28:22 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v4 3/5] arm64: dts: qcom: sdm845: add UFS controller
Date:   Wed, 24 Oct 2018 10:27:33 -0700
Message-Id: <20181024172735.154304-4-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181024172735.154304-1-evgreen@chromium.org>
References: <20181024172735.154304-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the UFS controller and PHY to SDM845.

Signed-off-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>

---
As Doug mentioned in v2, this should land after (or with) the driver fix
in this series.

Changes in v4: None
Changes in v3: None
Changes in v2:
- Renamed ufsphy to phy (Vivek)
- Removed #clock-cells (Vivek)

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

