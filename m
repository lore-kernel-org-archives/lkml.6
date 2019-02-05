Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DEBC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401BF2184B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DfnWzRMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfBES7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:59:42 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38966 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730620AbfBES7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:59:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so1901702pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ub6DMVr4auSHNs1xLpJC+apup1Uo439lpEy/vO5ywDY=;
        b=DfnWzRMonVA0OeASO4zDOEk8t8plHWBjUQ+vMco631djwRv0aC0pADpBoAabvaQOt/
         o3j38P+w8Sa4V6tbn0UmGlgKxkGco5rQH/ircQWzsEqFYdSfcd4reRD9h/8E4BMQgCBQ
         5bovwsHNmTTvYkVuHJqKnVVDUOt2a8yk+mDNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ub6DMVr4auSHNs1xLpJC+apup1Uo439lpEy/vO5ywDY=;
        b=p4vbJps7KiVKXKJNaOgrR2NYoTJKLxbVnqQaasq2z/lMtm3upm1uAMg3a7hDN3WaXY
         EANzLcHkFPEqE+WNdvbNhKqSnMTzQ/QGW+ntjOqew00CbA4C2aOSoWV9B17V6XcLPwVd
         sqdyrhXy9l85FJ5VU3R8qJQIbG0Jku7Fmt+3eEsRtw+2TRkyHzew4RQ/azyk/phXVqXT
         GnOcTqfrvOCffT7plcQDyCkVWeOIN4BGJtvVc93+SAkS5ydUl7Pb6Q0CCIHL6KeaqISg
         AsuRfsk90STXazhmXkfCsyEhSCYrCO2pkKTrdZ3mZgU8HxcT9LQqHVYh7pErX4kwiRQZ
         TPLg==
X-Gm-Message-State: AHQUAuYHADKiwNpJ+fH5y8jKmZH4sWFlURzlvcs45PWYMwEX2yCuFIDl
        +Sch+ECvTlqrFLVMQRIwOT364w==
X-Google-Smtp-Source: AHgI3IYb1R/p8CwVIea6SCHsqavmyj3O4mqtCGIMvLIq3WapP0ONUuIuag46MD8/x64Zpp5uqP0UXQ==
X-Received: by 2002:a17:902:4503:: with SMTP id m3mr6637325pld.23.1549393178491;
        Tue, 05 Feb 2019 10:59:38 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id m3sm6424435pfi.102.2019.02.05.10.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Feb 2019 10:59:37 -0800 (PST)
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
Subject: [PATCH v3 5/8] arm64: dts: msm8996: Add UFS PHY reset controller
Date:   Tue,  5 Feb 2019 10:58:59 -0800
Message-Id: <20190205185902.106085-6-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205185902.106085-1-evgreen@chromium.org>
References: <20190205185902.106085-1-evgreen@chromium.org>
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

