Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B49C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4DB2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d/6zGUei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4DB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeLJT27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:28:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40598 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbeLJT2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:28:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so5423592pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=029zCa/kXIkbhjJJ9PqSXZqbJI7NE+AHEj0/comb9Wo=;
        b=d/6zGUeizfINWF6i/7MFl7xN5dEiWJ1DAB7N+R6aLCDr4E0XdJF3QAv85agjkSkmXD
         nUyAYiiRV/wW0bh8vXiE+buvUDrHKaSLBVm1BhAn2aCTeMejOb+2+y5X940McVOcXNo2
         iKjgYXAyAjwmEEzYg/r9s06YA7WWoBqETsvlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=029zCa/kXIkbhjJJ9PqSXZqbJI7NE+AHEj0/comb9Wo=;
        b=deEt4C1oaGDntiLH1eN3yIH0QuWRlBgOcfz1tMj1VupWCRq7DsNN4pAo6x7N2BSZ1F
         J/PNPUH956Nx9qCktlyGMv6hlZkb3GdHyNZRkCoYXBvcAV6ryUI6asel9nKVq9CBC4YJ
         dsiL3DH/1uBdk+LVjQnZj1LDTtIUDA+p7BtzFoPmGiip0QyfFrN4FzK5sreeY5mYVqb7
         ux3wfbTaOTonPlwmsGA850rAOcx4XXaoo8fBWbb0v4jc6+mCq8FEsNGVvavxOBJ3BlD2
         dgynHrL402ZyroMAcO/kMsSAFmvuTyijF1jfSZer3hwR2fF31Nt1AIudw5gjM25NHBqs
         fbkA==
X-Gm-Message-State: AA+aEWYAvt/YdSvw91T+UKbDB2vt73CVhYLBiwnITlcPNlkYqpsA2yZv
        RGOLijG+fVTPAneWQbfKu44/55V1wBc=
X-Google-Smtp-Source: AFSGD/U6ePPVvMC3BNNZ06p7C7Kq/8fRGbumzD0eC0kooFSkrAq0ArK6o7FhXT+nrk8c4M96vzgzpA==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr13425486pfh.151.1544470135036;
        Mon, 10 Dec 2018 11:28:55 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v12sm18318674pgg.41.2018.12.10.11.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:28:54 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v7 3/5] arm64: dts: qcom: sdm845: add UFS controller
Date:   Mon, 10 Dec 2018 11:28:24 -0800
Message-Id: <20181210192826.241350-4-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181210192826.241350-1-evgreen@chromium.org>
References: <20181210192826.241350-1-evgreen@chromium.org>
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

Changes in v7: None
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
index b72bdb0a31a57..4ad4eaf1d61ce 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -808,6 +808,70 @@
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

