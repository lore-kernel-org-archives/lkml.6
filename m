Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F27C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6E9218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mCFnT7yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390701AbfBMX02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:26:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46908 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390589AbfBMX00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:26:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so1935965pfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3GYIBtzh9YUlSNloRNN96QL04Mij/ii9fAITHcdb0eI=;
        b=mCFnT7ynNfsC0XD9+/w/rH71ZIEM4K5r54CbaN6ztzgaIRNbct0sTvbr1AJP5YsnJN
         dAG3q0qTPnWwXWkR3lFA3l9RZy4mPaPUZCH3JXwNLHGbRI7sAk+0hgLFrniJpUgFtaKN
         /JGdEmPHK912xa/8hDaPYMrbEVPrKdX0DN6iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3GYIBtzh9YUlSNloRNN96QL04Mij/ii9fAITHcdb0eI=;
        b=n/F1aH5+j12C/rqBPMH1zrT2aXYIQHiB7ac0DH1VPOc38yoyZNvmGB9fQqafcGpe1k
         yb3/Bg0Ro/n86yn65QoNpv03wIqsCj0xl3IR473oV9Dj14peHoA3A6cOAgAXvCVQiOtD
         7bWuNw620J8uufnJOvHjHMg74ZHPHJcLce+NPiTjJwIL7CMeN32/eFnc5E12lIFg8r8H
         bCYFRWqlMfyuep4S9dBjtj0MuaOiWQ5+jDONQjGmDstvl6CduCusbSfht4gkX68TxP7A
         7CJkYuiLIIFEpy1s6yEjib7I9qK9dWyQgjRZE5Sj0HRoInhTRwZW6X4Ipljzy7qfg8+H
         f7ug==
X-Gm-Message-State: AHQUAuZD+nMrkq9LtToEiPb9erjcAcJd4MQ9Rg2p61qVfdAAfKDHRfpA
        TgQnxWYAT9wR/vs5LPbEdB9H3Q==
X-Google-Smtp-Source: AHgI3Iav4MsQlnkHWZkAD6VtSrwqFmw2DpwEdiv5VjSSKg2hm9qKjBKb3v7mlSGX8S5YxFYAmPq8Sg==
X-Received: by 2002:a62:55c4:: with SMTP id j187mr710186pfb.129.1550100385290;
        Wed, 13 Feb 2019 15:26:25 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d129sm560660pfc.31.2019.02.13.15.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 15:26:24 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 4/8] arm64: dts: sdm845: Add UFS PHY reset
Date:   Wed, 13 Feb 2019 15:25:22 -0800
Message-Id: <20190213232526.26995-5-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213232526.26995-1-evgreen@chromium.org>
References: <20190213232526.26995-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the reset controller in the Qcom UFS controller for the PHY.
This will be used to toggle PHY reset during initialization of the PHY.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
This commit is based atop the series at [1]. Patches 1 and 2 of that
series have landed, but 3, 4, and 5 are still outstanding.

[1] https://lore.kernel.org/lkml/20181210192826.241350-1-evgreen@chromium.org/

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b29332b265d9..029ab66405cf 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -990,6 +990,7 @@
 			phy-names = "ufsphy";
 			lanes-per-direction = <2>;
 			power-domains = <&gcc UFS_PHY_GDSC>;
+			#reset-cells = <1>;
 
 			clock-names =
 				"core_clk",
@@ -1033,6 +1034,8 @@
 			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
 				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
 
+			resets = <&ufs_mem_hc 0>;
+			reset-names = "ufsphy";
 			status = "disabled";
 
 			ufs_mem_phy_lanes: lanes@1d87400 {
-- 
2.20.1

