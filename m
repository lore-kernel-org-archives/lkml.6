Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79458C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F7721872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oS7IHi/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfAWWMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:12:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45481 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfAWWMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:12:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so1837243plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mqCwH6BIZivVe3OBbc+81a+uEmmjQXROxVrtJyv9BP8=;
        b=oS7IHi/ahKWj1O2zk8olDYsFbSOV2lPf3wgYi4rcR6aQZnnN8kYYMxApHPPl9TdQeE
         fP0W1TToPxIfMtIftN+TaGT+NCY121Y3oTS6dyJzwJZ4j+/rBeUg642ZnV4xR56BBK1R
         AmX4/odaTnbL8dbgn+87y/aBsE4VvA+ztr768=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mqCwH6BIZivVe3OBbc+81a+uEmmjQXROxVrtJyv9BP8=;
        b=jTmqz10oO+LioMR2+viOv1lPErIzm9FYeUYfvGAX5+MjpVxZbglR7ffd+lRf1bHgco
         nsYqVetFbPa75MelT1SHw4Q8tVAmvrYw/EbvwjwGxqrrT8rJQM5nMehhh+5q0k9EdeAo
         Q6XU0vLmKSizg37CeAspkvzApG0TbG5HTUSf7/fOIzK1gJleAxeh35064Acya5I635kH
         MVoG9Xcnhf+ju9vnEGpBmfOcwRV9cE0D77rmW2x7/7oAbLFzWxz5ouwL4871+7n32OAt
         qWIqUpvgovcy7Kgf1u2iHh7hBwQURmvKBzEbDed7Z7JKf1jq6Dh1xxu5Ek031I4XONT7
         NmPg==
X-Gm-Message-State: AJcUuke+14SjoSMmPm8T92Zx0zYZ0Efw9MPHSOE74DWPU15COgj2xljv
        s9RXrTo2mSGvj99AJScSeXIdcg==
X-Google-Smtp-Source: ALg8bN6Gx0VtoKhooyDor85zWU3uENefVxO5rJlF+cwRYkAKJnegkl9+At6p5EyuEa4utFV45Y7L5g==
X-Received: by 2002:a17:902:720c:: with SMTP id ba12mr4062677plb.79.1548281535641;
        Wed, 23 Jan 2019 14:12:15 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d18sm27927943pfj.47.2019.01.23.14.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 14:12:14 -0800 (PST)
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
Subject: [PATCH v2 5/9] arm64: dts: msm8996: Add UFS PHY reset controller
Date:   Wed, 23 Jan 2019 14:11:33 -0800
Message-Id: <20190123221137.41722-6-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190123221137.41722-1-evgreen@chromium.org>
References: <20190123221137.41722-1-evgreen@chromium.org>
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

Changes in v2: None

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

