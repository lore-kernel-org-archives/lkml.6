Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057C1C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08E62145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxwrCGEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08E62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeJIC17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:27:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35387 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJIC15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:27:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id f8-v6so10492620plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 12:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZvL9JXPkSCEpU6IxoDs/WZI6AFU5ENywXz2f9GrqSf8=;
        b=gxwrCGEljkrpXtlXSyZ1blqbi0+WuBcrN6KShqdSAH9+BolUCUdLzx3iZpJghKEoSW
         CaYR0UWTf3eAD2V+dKRzGtkp+uQFU6YOEocN8JognNp/+rXhYpHujsgbP/BPfsOQVVhB
         iZcQ9vPwFQs69RVPBHtlVYYIXJ/bJ6FjDhmWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZvL9JXPkSCEpU6IxoDs/WZI6AFU5ENywXz2f9GrqSf8=;
        b=GpTXfhTHzm1saM5Mn6fQ9zTxtoinHmPPJ9AgX9r3d7tZhdJM0gWAjMuXjfXK2JiKOV
         bSXIrcd2H32xQ9lhffdSEJMNEZaPSh2CQCZdkvOFDHlL64ES/aj/9/1IlWtT1DKPqL7h
         lPHnZND9rraPjhqIFldk7JdjHVKS8h8YSQxG3BRK6M174sq7w+883NpxLJNogGxp59oe
         1IdAloqclYTFfJDHuUo+4+KbuwlbEJV/j315GD8hfxhAVfx4Bn/E5jns83Tcsgt+Ni9Z
         5emqbDlb7Q1Ws9LRSqiti3yfFt6r/YnweYPEQ3cz8cdaM9WC3Yab6jiFt3HK9QTUP6Cc
         Wm2g==
X-Gm-Message-State: ABuFfogwnYq0D1f/RoRpy+cSIQHxVz8Bqg08LVB17l0icjyRMGrX+5ei
        9+mBZUVD2YMdxHzb93oTFkjpOVK1Vw==
X-Google-Smtp-Source: ACcGV62kaGS4fowQudFTnmWTCtKB7YIIfqmaRo51lhj3onIDtWeIfk66q562QXr5BBMIYTrnoj4VMA==
X-Received: by 2002:a17:902:8f90:: with SMTP id z16-v6mr24250133plo.329.1539026082010;
        Mon, 08 Oct 2018 12:14:42 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c6:20ea:9fd:1785:d893:1e98])
        by smtp.gmail.com with ESMTPSA id a15-v6sm15648035pff.8.2018.10.08.12.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 12:14:41 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sean.wang@mediatek.com, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/5] arm64: dts: mediatek: mt6797: Add pinctrl support
Date:   Tue,  9 Oct 2018 00:44:08 +0530
Message-Id: <20181008191411.32555-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl support for Mediatek MT6797 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 4beaa71107d7..231230d32d09 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/mt6797-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/mt6797-pinfunc.h>
 
 / {
 	compatible = "mediatek,mt6797";
@@ -129,6 +130,19 @@
 		#clock-cells = <1>;
 	};
 
+	pio: pinctrl@10005000 {
+		compatible = "mediatek,mt6797-pinctrl";
+		reg = <0 0x10005000 0 0x1000>,
+		      <0 0x10002000 0 0x400>,
+		      <0 0x10002400 0 0x400>,
+		      <0 0x10002800 0 0x400>,
+		      <0 0x10002C00 0 0x400>;
+		reg-names = "gpio", "iocfgl", "iocfgb",
+			    "iocfgr", "iocfgt";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	scpsys: scpsys@10006000 {
 		compatible = "mediatek,mt6797-scpsys";
 		#power-domain-cells = <1>;
-- 
2.17.1

