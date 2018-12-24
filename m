Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CF3C676F1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2097218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfZOFwSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbeLXWBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:01:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37889 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeLXWBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:01:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so12541408wrw.5;
        Mon, 24 Dec 2018 14:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nvq5FeHdEvsC0QZW7YnkE+ErsIu1+CoQUcHwhHtd2Mw=;
        b=pfZOFwSpAjK5EYEOFRZSndyUYxddBP0mfbZU/cND0YylRbIFb6K3wZqG2x7hR9hQhf
         OGh4+Yy6QbdrNLSjCOeHGf47kf0Q+DkPDjVNlSRM2TqLq80mfi2M2bPaKXu43EWdjvyi
         lsOVeZ1olIMJltzM67j1aOcxCg5OY7Qap0BOz184b7FA9JdEBrhK/6vQVyKVQsYjMpnS
         bzQR4bMS6ogS+gL4cPbxTOzONe7SU0c+AhjlpOs+MkyNvY6JEmdrdO6G7AXM11kd48xv
         Ywa2lsekrTXOi98CNC2XNrI6IiszI4OKGPkkdEkfJAxWTJqfx3f5pSG4oIVzcylstoRZ
         vt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nvq5FeHdEvsC0QZW7YnkE+ErsIu1+CoQUcHwhHtd2Mw=;
        b=Q+/Tzdw+QCwBMo93F+TFFaPUt5blEhn5h1fBLoqvVc5I93PAfrb+whSsvWg70Me9eq
         7EB1u7cjta2d1LUMN0CTvnt5QfQor0bMpoBLrat8njJ1FFk1xCJVuRTjiW8Ek24qu+qC
         yTSAat/nVpkJAPLPW36HdQSsi9IkCt3NJMmkbQvg37lLTABeFrpZM1M0ugcPiK5wvUdK
         XeBNOGeDiy9wDFMpB+LABx93I4ZM1iVunLOgs0pI51CJ+IOJKIJ/yHLm46vHpAv+t57z
         Ztxf8vtK3ClE3wfOBZ8Dy/NRElTcXiXdfaYyRUYEDn+8Ohznir1lPjZjAom6I0tIgrtj
         uJKA==
X-Gm-Message-State: AJcUukfHLHLpQw/YCfbh3ycWDU2WGkrPAH36y5ibIYaskAE8j7PWVRgn
        Cr1Wv8xBB3TJ3bBJ7t7NeJE=
X-Google-Smtp-Source: ALg8bN5G4GPJ3oQu8VC60DrM2oylE9uEbEYbpwfRYORSiEBeEoofJXnaBgNsBAD4pcpG9eA5DS1kwg==
X-Received: by 2002:adf:f449:: with SMTP id f9mr13398995wrp.40.1545688874135;
        Mon, 24 Dec 2018 14:01:14 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl. [83.23.22.20])
        by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 14:01:13 -0800 (PST)
From:   cezary.gapinski@gmail.com
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: [PATCH v2 13/14] ARM: dts: stm32: add SPI support on STM32F429 SoC
Date:   Mon, 24 Dec 2018 23:00:39 +0100
Message-Id: <1545688840-23992-14-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

This patch adds all SPI instances of the STM32F429 SoC.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 8d6f028..8dbec00 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -314,6 +314,26 @@
 			status = "disabled";
 		};
 
+		spi2: spi@40003800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40003800 0x400>;
+			interrupts = <36>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(SPI2)>;
+			status = "disabled";
+		};
+
+		spi3: spi@40003C00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40003C00 0x400>;
+			interrupts = <51>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(SPI3)>;
+			status = "disabled";
+		};
+
 		usart2: serial@40004400 {
 			compatible = "st,stm32-uart";
 			reg = <0x40004400 0x400>;
@@ -523,6 +543,26 @@
 			status = "disabled";
 		};
 
+		spi1: spi@40013000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40013000 0x400>;
+			interrupts = <35>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SPI1)>;
+			status = "disabled";
+		};
+
+		spi4: spi@40013400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40013400 0x400>;
+			interrupts = <84>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SPI4)>;
+			status = "disabled";
+		};
+
 		syscfg: system-config@40013800 {
 			compatible = "syscon";
 			reg = <0x40013800 0x400>;
@@ -587,6 +627,26 @@
 			};
 		};
 
+		spi5: spi@40015000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40015000 0x400>;
+			interrupts = <85>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SPI5)>;
+			status = "disabled";
+		};
+
+		spi6: spi@40015400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40015400 0x400>;
+			interrupts = <86>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SPI6)>;
+			status = "disabled";
+		};
+
 		pwrcfg: power-config@40007000 {
 			compatible = "syscon";
 			reg = <0x40007000 0x400>;
-- 
2.7.4

