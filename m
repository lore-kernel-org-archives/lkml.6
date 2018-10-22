Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59024C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716EA20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V751cXiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716EA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbeJWFMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:12:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36942 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbeJWFML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:12:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so19574197pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Za6AXbZULknJhEO7JV3z0QWbK51r0hvShkOrvCcc+ok=;
        b=V751cXiuYFv2t8pk2LUxgcEtPk3oP+oRnpDjz6ba3tcKFbqN1Pw7aB5BFmN1fNMVrO
         v8MTvQdiihocoEjsCFQvnVo07iKuvZ2pw3gzGQ6NnAgDkiKZdYAt8chX5+uA9zQVIpPk
         Q8sVN2rBa3S3zyexmeJvjVk4AdAIXFjmhz5VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Za6AXbZULknJhEO7JV3z0QWbK51r0hvShkOrvCcc+ok=;
        b=VgE+n4VBHSne6DHIpW8P7I9vsMg6eJymkztHMWUK8JPGJA6CyHiGABcZVuUnoyLTcN
         eLjprc0haECWAKbRcj64aUt4WmdzkPFxt0IeHtKJVpWyiBDKLIYauO3Ei93bG3ts6VWk
         va9Ob+fI429U06oEcCJ/v/t821VcKjTCHl6qcZ6No6A0vSMhAb7Yhs9LLJ61SCcezF5d
         kjKrcmRp83Nu+bussNZqdDqG6d70wnIqfkrH2iBsYNC6obOzXxreKTLMOTw3MnIuXMSv
         luFKVKU3LCQvbingl+sLIHqbDXuqixfN+vwe19DcRyYuIKOfQGNpnaRrsCv478DLCm0k
         tXXg==
X-Gm-Message-State: ABuFfogQvWkEpWZiJHcGJz4RjP9FQpJGhU96q598LWAPxBF+RWo0U48O
        Jq5L8JGvgzIRBh548B14GTbwMw==
X-Google-Smtp-Source: ACcGV60peR0nlouhfZ/61FrKZJlic0cFT8eiKuNuQolx8DCAcNLCI0xZ1FhSCeM97GV07dRMyMgTDg==
X-Received: by 2002:a62:48ce:: with SMTP id q75-v6mr47897474pfi.22.1540241524833;
        Mon, 22 Oct 2018 13:52:04 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id a11-v6sm37216041pfn.66.2018.10.22.13.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 13:52:03 -0700 (PDT)
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
Subject: [PATCH v3 3/5] arm64: dts: qcom: sdm845: add UFS controller
Date:   Mon, 22 Oct 2018 13:51:00 -0700
Message-Id: <20181022205102.74825-4-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181022205102.74825-1-evgreen@chromium.org>
References: <20181022205102.74825-1-evgreen@chromium.org>
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

