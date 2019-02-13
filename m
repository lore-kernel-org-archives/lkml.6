Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADF8C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B6C218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LiZLNlqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391169AbfBMX0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:26:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39421 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390694AbfBMX02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:26:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so1980006pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z1ZzbSMaLkcrujFXMVmUGhZGSWFapd4E02x4M5Q5CXM=;
        b=LiZLNlqJcuFSlZ2KM8smAvyO33KbhXwgO53Y9ocn/IQrEHfKsl7H9jVO59Go8ACKKn
         RpH8rSh5pH8WE51+kT0jMjdtLI5kDRJZbrV/IHtguKCKxJF5bKxzC2WgOQqZvN3B2krZ
         s7UgOYhDmzLkbunRDxqNkUwLLMI9yMVPVNcmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z1ZzbSMaLkcrujFXMVmUGhZGSWFapd4E02x4M5Q5CXM=;
        b=JKrrWKz9uZsUCp1lcFCJOXLhS9TKfa7vwQAkk+o8qwhAQbWiJYcBUndmFST5Rxkvb2
         whZmdWI618R//0a9KTLg8gyf40FulWdaYvtu81GimuYZqwuGPjs/UFq4/qgK58ffcoSL
         lstROgPrwk72SYSmeg8mlG15LS4PfbTv1mx86o9w9TrHOlQ0z39/60Jdq7atXc4bpf7b
         TJLAk849r4GeWkF5lzJeEGg4+2zimtr13cjgvrTtklGc8rg4K/nXC9cLOrZqZu8DSYgb
         q9BivObp0G1CuNYt2TyKiwEZMfd0jrSvmEL4lu1cB1Ao34DN6OrFwAzCJJDETZPp86n3
         7K3Q==
X-Gm-Message-State: AHQUAub7e9AGTECVjR55CMnqIjqDz4Pm4lIhks+LGPs6o6Z0IPAbrmtS
        q8pVmUzpw2pmWyuy0xaXNhSBEA==
X-Google-Smtp-Source: AHgI3IbPGCJAsPZdqVVOt69EZjNuubGM3/7szxlvMu9oyudavwb1c/rPG4J9DaLt8bcNX6apXbIqoA==
X-Received: by 2002:a17:902:8d8d:: with SMTP id v13mr740991plo.121.1550100387494;
        Wed, 13 Feb 2019 15:26:27 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d129sm560660pfc.31.2019.02.13.15.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 15:26:26 -0800 (PST)
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
Subject: [PATCH v4 5/8] arm64: dts: msm8996: Add UFS PHY reset controller
Date:   Wed, 13 Feb 2019 15:25:23 -0800
Message-Id: <20190213232526.26995-6-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213232526.26995-1-evgreen@chromium.org>
References: <20190213232526.26995-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset controller for the UFS controller, and wire it up
so that the UFS PHY can initialize itself without relying on
implicit sequencing between the two drivers.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 99b7495455a6..179f1988d45c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -663,10 +663,11 @@
 			clock-names = "ref_clk_src", "ref_clk";
 			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
 				 <&gcc GCC_UFS_CLKREF_CLK>;
+			resets = <&ufshc 0>;
 			status = "disabled";
 		};
 
-		ufshc@624000 {
+		ufshc: ufshc@624000 {
 			compatible = "qcom,ufshc";
 			reg = <0x624000 0x2500>;
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
@@ -722,6 +723,7 @@
 				<0 0>;
 
 			lanes-per-direction = <1>;
+			#reset-cells = <1>;
 			status = "disabled";
 
 			ufs_variant {
-- 
2.20.1

