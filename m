Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61D5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FA52084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h6k4pgWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfAKXCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:02:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39153 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfAKXCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:02:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so6916056pgl.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ulw7GmeZQfl8VV/7kr1fBqzdA+8zFDUimIIDwT+KzKY=;
        b=h6k4pgWEdJ5oK3yMBqb5gdNSOR6ouHGcQEeQfQU1zh2PvmPrHOR9JOblfanrrzx4bn
         WpBE97hFNbGlt2gICd15nKVydaWKyd0fftS2hNP5SJ3Yo3+5GfbI1U0HDetqyxxEY8u0
         OMaZAPtwyS3O3/siKM0h1tmwPj1Twi2AWOEbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ulw7GmeZQfl8VV/7kr1fBqzdA+8zFDUimIIDwT+KzKY=;
        b=XarHRpIpRjm3QwoFh1p/jasXOP6ZvFqzP5t8D4shZIq9LJDP7Z0KiatFHYGZI7gCxT
         AaSYy5evR7Qf7Lpi6Z/NLV1GpucClg48sasbeTJbJ1cllL+9+hWfV2BZ1/X8xSud4Xzu
         0GW7tE/PXv5aOul9kllH9ymKpU70KabxRxs0zVVeR1ik9A9UhYxqztCA8MyWFaXO/SOK
         7NHytyRZQA+76sew2FQUddHmudotkcGXttwZP38wx5VSIPrKMIi8+7m7QHOP5ZAOPFOo
         PR0HYV1p7eH7BBmUiXFB3dGnTuAPR1wATmMxPWN5VBj3Ysg10yerxwXT9UiskDZ35ogZ
         ASlw==
X-Gm-Message-State: AJcUukePhO04GMEVfxqGya3mkO2WAc96ARDjM+44tiIICMKr5vtyuTTi
        wJLG+E2ouw2ohAvFSvobVRH6Ekuz++Y=
X-Google-Smtp-Source: ALg8bN5qAQ3iBHoJ0wFHaD2bHkeLfhuykgOD9ZUlCxPaubz/cKkbAhf9RecUAUn0NGgXIC11YT6o+Q==
X-Received: by 2002:a63:24c2:: with SMTP id k185mr14552455pgk.406.1547247725865;
        Fri, 11 Jan 2019 15:02:05 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id 15sm116045186pfr.55.2019.01.11.15.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 15:02:05 -0800 (PST)
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
Subject: [PATCH v1 4/8] arm64: dts: msm8996: Add UFS PHY reset controller
Date:   Fri, 11 Jan 2019 15:01:25 -0800
Message-Id: <20190111230129.127037-5-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190111230129.127037-1-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset controller for the UFS controller, and wire it up
so that the UFS PHY can initialize itself without relying on
implicit sequencing between the two drivers.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 99b7495455a62..179f1988d45c5 100644
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
2.18.1

