Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C5FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF90F2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LxjqOT2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfBES7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:59:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38753 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730608AbfBES7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:59:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so1777003pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pvPGDk0MYEUJat4AWVry/938UIVI5hfg1gRfbgdxD78=;
        b=LxjqOT2QAYJwd2Ht0s9cRUf9eMshGYaOmr8+TwSjnFDjc8kRVnelqyl4DJqNpXA53A
         qM2B1qggwiKD2VugxIgHAq5PN0RkhDNkUPQCaqoEDM9oNQlssSwBQRlQOVpJEza8/3f5
         Qnju5DuCz8buu5fgyoUmg6+ard1jv3MEUYYTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pvPGDk0MYEUJat4AWVry/938UIVI5hfg1gRfbgdxD78=;
        b=EJP6J2t08TobFHwg4K2Huek03BDico+FrbQdx8XjoMGALA0zbra2QALOrkG+jRXMeb
         YELCx5UZOeXYrfCsEi6NkP6zPr70iRlEqW6OQQNU7EkmYb16/g8bdaAPE/hsgRjYhad5
         om3v06fouM25Di3Io1Tv+/1SjrrtMLpWT2ZgnWncMiWacUXhHLSurD57tpR7SPc6+8Vp
         Z78AcZLqHRXQ8YRPL4W5VTAcQznsGHmQdf9BudBbczFsPkmvQtefnDABHUoWf+0XV240
         WEXjy5UqAeFs17cpwZ0wIQpUgu6gzT8D97adscPmzCQ8niuLIHQKWPZhPRdV29DrfDiZ
         TjbA==
X-Gm-Message-State: AHQUAuZeFfPZosPxE2JCrESMFRC3WKnI3qZu7OjWwjOtI0t/XXoYWOHE
        BnaDpkWBIvyDagzn7eIe+nth3g==
X-Google-Smtp-Source: AHgI3IYpkYxN/5RBsZxy2k7Wgov4+uLA1hpFyktUcaDVQSvpDu+avApH15Q5oTlxhyrDc0efcdB1WA==
X-Received: by 2002:aa7:8802:: with SMTP id c2mr6453769pfo.20.1549393176039;
        Tue, 05 Feb 2019 10:59:36 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id m3sm6424435pfi.102.2019.02.05.10.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Feb 2019 10:59:35 -0800 (PST)
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
Subject: [PATCH v3 4/8] arm64: dts: sdm845: Add UFS PHY reset
Date:   Tue,  5 Feb 2019 10:58:58 -0800
Message-Id: <20190205185902.106085-5-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205185902.106085-1-evgreen@chromium.org>
References: <20190205185902.106085-1-evgreen@chromium.org>
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

