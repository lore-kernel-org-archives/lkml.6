Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF905C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A17920813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBLv7cFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A17920813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeJXDcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:32:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46265 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbeJXDcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:32:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id bb7-v6so1048097plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lKH0jwLiRVlENS6aRB/Oj5rNouOei52a1v6Xef+RhcM=;
        b=OBLv7cFtZmJOXgUiL7Gn/PgIZwxZaXD9KClD22BMJX4YU+xs1rkm3B+8r4X39mMHLV
         L0NOBfjx+jA6tBYV6RnuFvLnBOAhWZs07EUwU5t9GrR7JiLlQmwk6c37Aml7GEHloFOg
         ncbudJXmoI4hia9ShtGc67fZ42L2tKQOjvjVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lKH0jwLiRVlENS6aRB/Oj5rNouOei52a1v6Xef+RhcM=;
        b=owUpldYzFxiQ0mYUi2sIIj1gpXzZO4U0wPwmWaGIoTx8/qfKzoz1UFNqdqNNnllkq+
         Odtl5LqTDo5PZ4iByaR2DIZ4BQ+Lzyy1m51t+vCens5lYVftN3oAJZLfL5cNbQjXqKh1
         8pBS1IScg2x252AFuZY050VMKu0Ga4IDwD0pett2Qq8AIs8LKmg+9F8+FlADhQLGltwQ
         KI9Sbb+qnyRCfSzNZZSlDwQrI1l3jRpoLN4VoFo/gPGlL53FbsOqdPqp0687J3ybqLLm
         tk4QfgBG1lbLwvJAVKSS8AZyT/qK8U3ZiAQoQAw2rTjulVYzspUyZLgq2piAW9P+O3/J
         38tg==
X-Gm-Message-State: ABuFfoiXJHf5YRJCjNTxsRxNIPrnsG05WuTUBEUBf7zbnPJoDHb1Inp+
        tphUJODXS1QGIIzymGnuSYXW
X-Google-Smtp-Source: ACcGV63lcYItjV0G4qBfm+zO6+6EWFIpNa8dPT6cgAvnNIeF/FRt8of5Wakakoo6Nf3vrg4S8pkunQ==
X-Received: by 2002:a17:902:7408:: with SMTP id g8-v6mr18724847pll.168.1540321644866;
        Tue, 23 Oct 2018 12:07:24 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:744c:7bc5:17c:5f65:76c4:d542])
        by smtp.gmail.com with ESMTPSA id v189-v6sm4897075pfb.54.2018.10.23.12.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:07:24 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com, linus.walleij@linaro.org, robh+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/5] arm64: dts: hisilicon: hi3760: Add GPIO controller support
Date:   Wed, 24 Oct 2018 00:36:52 +0530
Message-Id: <20181023190655.12004-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
References: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPIO controller support for HiSilicon HI3670 SoC based on ARM
Primecell PL061 GPIO controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/hisilicon/hi3670-hikey970.dts    |   1 +
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 379 ++++++++++++++++++
 2 files changed, 380 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index 4f5118642024..8fdc1dfcb06c 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -10,6 +10,7 @@
 /dts-v1/;
 
 #include "hi3670.dtsi"
+#include "hikey970-pinctrl.dtsi"
 
 / {
 	model = "HiKey970";
diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 34a2f0dbc6f7..b99f5e0fe577 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -196,5 +196,384 @@
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
+
+		gpio0: gpio@e8a0b000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a0b000 0x0 0x1000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 1 0 1 &pmx0 3 1 5>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO0>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio1: gpio@e8a0c000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a0c000 0x0 0x1000>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO1>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio2: gpio@e8a0d000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a0d000 0x0 0x1000>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 1 6 7>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio3: gpio@e8a0e000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a0e000 0x0 0x1000>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges =  <&pmx0 0 13 4 &pmx0 7 17 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO3>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio4: gpio@e8a0f000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a0f000 0x0 0x1000>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 18 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO4>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio5: gpio@e8a10000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a10000 0x0 0x1000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 26 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO5>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio6: gpio@e8a11000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a11000 0x0 0x1000>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 1 34 7>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO6>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio7: gpio@e8a12000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a12000 0x0 0x1000>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 41 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO7>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio8: gpio@e8a13000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a13000 0x0 0x1000>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 49 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO8>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio9: gpio@e8a14000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a14000 0x0 0x1000>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 57 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO9>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio10: gpio@e8a15000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a15000 0x0 0x1000>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 65 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO10>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio11: gpio@e8a16000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a16000 0x0 0x1000>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 73 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO11>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio12: gpio@e8a17000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a17000 0x0 0x1000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 81 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO12>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio13: gpio@e8a18000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a18000 0x0 0x1000>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO13>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio14: gpio@e8a19000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a19000 0x0 0x1000>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO14>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio15: gpio@e8a1a000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a1a000 0x0 0x1000>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO15>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio16: gpio@e8a1b000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a1b000 0x0 0x1000>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx5 0 0 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO16>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio17: gpio@e8a1c000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a1c000 0x0 0x1000>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx5 0 8 2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO17>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio18: gpio@fff28000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff28000 0x0 0x1000>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx1 4 42 4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_GPIO18>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio19: gpio@fff29000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff29000 0x0 0x1000>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx1 0 61 2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_GPIO19>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio20: gpio@e8a1f000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a1f000 0x0 0x1000>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx7 0 0 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO20>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio21: gpio@e8a20000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a20000 0x0 0x1000>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx7 0 8 4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO21>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio22: gpio@fff0b000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff0b000 0x0 0x1000>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO176 */
+			gpio-ranges = <&pmx1 2 0 6>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_AO_GPIO0>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio23: gpio@fff0c000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff0c000 0x0 0x1000>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO184 */
+			gpio-ranges = <&pmx1 0 6 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_AO_GPIO1>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio24: gpio@fff0d000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff0d000 0x0 0x1000>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO192 */
+			gpio-ranges = <&pmx1 0 14 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_AO_GPIO2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio25: gpio@fff0e000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff0e000 0x0 0x1000>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO200 */
+			gpio-ranges = <&pmx1 0 22 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_AO_GPIO3>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio26: gpio@fff0f000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff0f000 0x0 0x1000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO208 */
+			gpio-ranges = <&pmx1 0 30 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_AO_GPIO4>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio27: gpio@fff10000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff10000 0x0 0x1000>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO216 */
+			gpio-ranges = <&pmx1 4 31 4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_AO_GPIO5>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio28: gpio@fff1d000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff1d000 0x0 0x1000>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx1 1 35 7>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_AO_GPIO6>;
+			clock-names = "apb_pclk";
+		};
 	};
 };
-- 
2.17.1

