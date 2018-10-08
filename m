Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB54C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D3A2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GsvmHcKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D3A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeJIC2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:28:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34487 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbeJIC2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:28:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so8820055pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v+EkBGJYgP5l8roNkAIcHxwpqxLvNbg8+WmAulqw8rE=;
        b=GsvmHcKXZLLg9D8JsGEhcSA4tY7FRDhnnZuE4crvm3+w/aW+70L1Z7AXOqjp/Xz0Qx
         HapGzRngWQUsqL9f3l8balsF27eU87IglMFxJacj8ZSJOEur+H6W+bquJmuAP+odSDYA
         1tGnYedayjB/yL6UZQ/loQPEgmL3aoiDgtQXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v+EkBGJYgP5l8roNkAIcHxwpqxLvNbg8+WmAulqw8rE=;
        b=t4MLLC0k/8w6HGLukfkXGVVeg4RzNuV5sD1kmexRzsDeOewjrQ/kJElLEFGGQVmZaZ
         6TJbyl2+QgvDlS0I4pl5AvSxgbJhKH+sSzOTgPouIFv6tYUFQxrFmqAXXPb12gtSYfjN
         mAoPM4u03nKUNQESEGqcDlBw8hlEWmTYNrrAyECq+eSz7rGpgXzarpPjlmZG0wUVSdOt
         JbhGHI4vHm89YH8mEs2rp/XuyYnc/7i5o8udPlWz/e3DCShq59hurZgC+JHSTLU/HZxR
         2Vf8VwhOIrh4+tfo5bFV8876L3wAXwUzLVU0G2+O7hY0/EO+P3emXpfbpaH2+h1t8v89
         eCsQ==
X-Gm-Message-State: ABuFfojzFnrYDQnVnDtE8KcQB+YPqO43m7xq43Q1l4+kBg4rPGCAkCsf
        /Aa8heI2bj/QCjTaYvTw8awB
X-Google-Smtp-Source: ACcGV602BVw9zB7/SpyW34tfwwfJ4y/mI9zsrT1Kde+jE5orFFDc56dVXl3+SBlOskVOTniW0qLLpw==
X-Received: by 2002:a63:5816:: with SMTP id m22-v6mr22077083pgb.332.1539026087434;
        Mon, 08 Oct 2018 12:14:47 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c6:20ea:9fd:1785:d893:1e98])
        by smtp.gmail.com with ESMTPSA id a15-v6sm15648035pff.8.2018.10.08.12.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 12:14:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sean.wang@mediatek.com, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/5] arm64: dts: mediatek: x20: Add pinmux support for UART1
Date:   Tue,  9 Oct 2018 00:44:09 +0530
Message-Id: <20181008191411.32555-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
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

