Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5D0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB26921872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IQrE4LPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfAWWMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:12:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39274 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfAWWMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:12:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so1853869pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pVl7bCsOHzkGeahZhY8Ncz7NfrTGxcO0q/yglLjGzmw=;
        b=IQrE4LPvV57mlfzrCUdebjEHm4BLIp6vl3r8n/Jja7hGmEzhP6TYSfSaO2RNkODs66
         +Bs6r9aRJwNeeKI4NjIXuVPpz3Y8Z/tZ2R2SWQJWjCnuFEYNSmYUTMsvKlo+Zq/OoQ6k
         D7YyOzTvMIXCJzJJehPiQdYHVJ/8FtXnSVknM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pVl7bCsOHzkGeahZhY8Ncz7NfrTGxcO0q/yglLjGzmw=;
        b=rG2UaejSvH87tnx/iSuyW+LNjbcPPqc9ZxGIL/+SNr2G/F++AiynCgZpPRHgC51386
         pY1aWgW56pU2WXoHy0cMc/ydj1qHaeXxo+odK4wsipYwCgBVyNNN1BF6yBwQnlIeVX1Z
         /g+ppiGHaHxEPvntay/06Vh+SQ/8LsWwTINAGl2Q+Wb46AiZyUqYoD8LPxf8UfwPfyAD
         8wcYPq+30eDwkX2Y4C2pMDnqr6ILaqz+MVs/vGGhGvkOZf2NjEvv2nZVZIPj4D4V7OTn
         JqrPyfS7Vxrcumchag7nm3oRMW3x/Pxm/lQfopumZz+J3M6myXCz1PH2E/S6LCtfkcFH
         wM7Q==
X-Gm-Message-State: AJcUukdQTKM4OuqJGt86f+TDmd5yu7lg7z3SAPW7rFHXuZiGp74BrxI9
        jJbSlj53Du7JKBn384KLawr9Wg==
X-Google-Smtp-Source: ALg8bN5b0HWWlE6LmfnU3YA89tZwb7Ig3jAhpvPv+fGuRgg9nB0q4tx5F41wp02HLcXL63DKTbB8OA==
X-Received: by 2002:a17:902:e18d:: with SMTP id cd13mr4067085plb.262.1548281532616;
        Wed, 23 Jan 2019 14:12:12 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d18sm27927943pfj.47.2019.01.23.14.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 14:12:11 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 4/9] arm64: dts: sdm845: Add UFS PHY reset
Date:   Wed, 23 Jan 2019 14:11:32 -0800
Message-Id: <20190123221137.41722-5-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190123221137.41722-1-evgreen@chromium.org>
References: <20190123221137.41722-1-evgreen@chromium.org>
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

Changes in v2: None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b29332b265d9e..029ab66405cf4 100644
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
2.18.1

