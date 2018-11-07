Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CFAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329A920892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwwAthh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329A920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbeKHDUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:20:44 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43903 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387796AbeKHDUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:20:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id g7-v6so5739985pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v+EkBGJYgP5l8roNkAIcHxwpqxLvNbg8+WmAulqw8rE=;
        b=VwwAthh0B85ajA9GkQEvFwNHX72Ayd9FtzHG+fDvqnViLraYeRrrsynDx7f/L1s4hr
         rBi755aMl/HGQsuKBfw8SxOQIIcpoGhjNvwDXjnpumE1JLpY5vGmhqQBFxjFskFWApjb
         bp3NhxA2PaROm+FgrP+2/C5oecq1KR46uJNiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v+EkBGJYgP5l8roNkAIcHxwpqxLvNbg8+WmAulqw8rE=;
        b=CaMDNfZ7+LSJR1Iu55R6P0cQ81+VJx171bNH7Om9JQiW7z8uPsz4XGp7M4z+UmJtup
         I3LjWHipUfNtWkSJam1xHKTna8oAaWb7IthiEG6ifG1quA3eF9HNiDZNT2R1IErWIQ7c
         bWJVNlt4NOlMHclYAw6qHXWY7+Rx3Uua+lJfhxQImHpDufL/ND5VTV9S752ZtbFAMc5G
         qqs6lJ5BwzhMlKohXOfyRhYPCHSVkdqNB527rj5wuKHgoI5WfeVNIVsrlbxovkNoduli
         Yob7qs7QrtqydMqy4l+PRKeY1ubvnPST6aouqBQ3hxpV6m2kYy09J74IeYujtuw+S4HG
         kh4A==
X-Gm-Message-State: AGRZ1gJKZ7Vt882WebqMygTSeukGTaiUcMDsPNSLtAR29I5/oRcfy1gy
        2bpUD1HUQ2cGJwjD8G4pwstz
X-Google-Smtp-Source: AJdET5deKLsNwFLmsO1x4UcMK+2eE2AiapEiuBaX1NvQrGmHGUqBRHsz9goW3XLiev8vpCnJBt6H5g==
X-Received: by 2002:a63:4d66:: with SMTP id n38mr984121pgl.270.1541612956699;
        Wed, 07 Nov 2018 09:49:16 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6282:6ca8:a0d9:6a81:97fe:992e])
        by smtp.gmail.com with ESMTPSA id e70-v6sm1232645pfb.113.2018.11.07.09.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 09:49:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sean.wang@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/4] arm64: dts: mediatek: x20: Add pinmux support for UART1
Date:   Wed,  7 Nov 2018 23:18:43 +0530
Message-Id: <20181107174844.5381-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
References: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinmux support for UART1 on MediatekX20 Development board based
on Mediatek MT6797 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts | 2 ++
 arch/arm64/boot/dts/mediatek/mt6797.dtsi        | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
index 742938a1a548..13939d55b85b 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
@@ -30,4 +30,6 @@
 
 &uart1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins_a>;
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 231230d32d09..a64bb84bdec3 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -141,6 +141,13 @@
 			    "iocfgr", "iocfgt";
 		gpio-controller;
 		#gpio-cells = <2>;
+
+		uart1_pins_a: uart1 {
+			pins1 {
+				pinmux = <MT6797_GPIO232__FUNC_URXD1>,
+					 <MT6797_GPIO233__FUNC_UTXD1>;
+			};
+		};
 	};
 
 	scpsys: scpsys@10006000 {
-- 
2.17.1

