Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11036C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C5A204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGctb+Zl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C5A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbeJXDcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:32:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41601 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbeJXDcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:32:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id p5-v6so1063310plq.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m7OpRdxUBC/ox/YnPiQqQeukhD6ryQi0+yXVdK+eRGw=;
        b=VGctb+ZleozBkR1WBbOyfJB8zCoOXO9QMkWtKnIHRpvdsw1eWxqJvdjeYDUdq36GLH
         66K6BT4uMw7TkiLumL3eNCgAKU0/pczN8c/H26supEyX8xZzl0NcozjWJhpRgbFVSVp9
         hraC5LCvsOC2olGw5Z7qt6ge+KDY2/ves3n0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m7OpRdxUBC/ox/YnPiQqQeukhD6ryQi0+yXVdK+eRGw=;
        b=Bfj7puYKBb1mABf6HjgQowxcmtSNHvv4+w9EtjQBrh7X3tWdimwsdOTihTev9PGBeu
         C+1sLOLMls7yV8IK5i+zhvwuMUg31T0w/Y8l9BfoEdYf1Fp0EJBL2M4gwDDlQHisAI1B
         18HR+vOdmT0y7m3IhYJwnoj6LyLoxLgdVmfEcR3EFI7NpJ7gfxi1yAfbmwdiWxpBrRdR
         uBlf9yfdRPe09gmiDWKFnG3uWhhC0hDUobaBYp8Yjbv+jD/zaMVBKz+TzVhoZUH5xEoU
         lDbeOqqo2sV9ZB3sJVgRzYYE65EPgi/z1owamtZbocWGQgNFH1Z11k/VscETVpdYf2kv
         /98Q==
X-Gm-Message-State: ABuFfojRpVssUUeHxKNV/2GpG2uAJ0bJr/NGzQ8D3ThH9E+SEWIE36VD
        pDGCEmU2cFrXS1/JK3vKyDFo
X-Google-Smtp-Source: ACcGV63v8A8SDSwqBg7qIFlN4Pb/69kGtQaScsZS7C6fI34oBk8flL04NGy3YjHmcfxBcSWwQDOp1g==
X-Received: by 2002:a17:902:187:: with SMTP id b7-v6mr49880442plb.150.1540321650544;
        Tue, 23 Oct 2018 12:07:30 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:744c:7bc5:17c:5f65:76c4:d542])
        by smtp.gmail.com with ESMTPSA id v189-v6sm4897075pfb.54.2018.10.23.12.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:07:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com, linus.walleij@linaro.org, robh+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/5] arm64: dts: hisilicon: hi3670: Add UART nodes
Date:   Wed, 24 Oct 2018 00:36:53 +0530
Message-Id: <20181023190655.12004-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
References: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UART nodes for HiSilicon HI3670 SoC and also relevant pinmux/pinconf
entries.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  72 ++++++++
 .../boot/dts/hisilicon/hikey970-pinctrl.dtsi  | 157 ++++++++++++++++++
 2 files changed, 229 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index b99f5e0fe577..a5bd6d80b226 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -187,6 +187,76 @@
 			#clock-cells = <1>;
 		};
 
+		uart0: serial@fdf02000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfdf02000 0x0 0x1000>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_UART0>,
+				 <&crg_ctrl HI3670_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pmx_func &uart0_cfg_func>;
+			status = "disabled";
+		};
+
+		uart1: serial@fdf00000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfdf00000 0x0 0x1000>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_UART1>,
+				 <&crg_ctrl HI3670_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			status = "disabled";
+		};
+
+		uart2: serial@fdf03000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfdf03000 0x0 0x1000>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_UART2>,
+				 <&crg_ctrl HI3670_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_pmx_func &uart2_cfg_func>;
+			status = "disabled";
+		};
+
+		uart3: serial@ffd74000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xffd74000 0x0 0x1000>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_UART3>,
+				 <&crg_ctrl HI3670_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart3_pmx_func &uart3_cfg_func>;
+			status = "disabled";
+		};
+
+		uart4: serial@fdf01000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfdf01000 0x0 0x1000>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_UART4>,
+				 <&crg_ctrl HI3670_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart4_pmx_func &uart4_cfg_func>;
+			status = "disabled";
+		};
+
+		uart5: serial@fdf05000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfdf05000 0x0 0x1000>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_UART5>,
+				 <&crg_ctrl HI3670_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			status = "disabled";
+		};
+
 		uart6: serial@fff32000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfff32000 0x0 0x1000>;
@@ -194,6 +264,8 @@
 			clocks = <&crg_ctrl HI3670_CLK_UART6>,
 				 <&crg_ctrl HI3670_PCLK>;
 			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart6_pmx_func &uart6_cfg_func>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi
index 64fb9a3bd707..67bb52d43619 100644
--- a/arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi
@@ -20,6 +20,47 @@
 			pinctrl-single,function-mask = <0x7>;
 			/* pin base, nr pins & gpio function */
 			pinctrl-single,gpio-range = <&range 0 82 0>;
+
+			uart0_pmx_func: uart0_pmx_func {
+				pinctrl-single,pins = <
+					0x054 MUX_M2 /* UART0_RXD */
+					0x058 MUX_M2 /* UART0_TXD */
+				>;
+			};
+
+			uart2_pmx_func: uart2_pmx_func {
+				pinctrl-single,pins = <
+					0x700 MUX_M2 /* UART2_CTS_N */
+					0x704 MUX_M2 /* UART2_RTS_N */
+					0x708 MUX_M2 /* UART2_RXD */
+					0x70c MUX_M2 /* UART2_TXD */
+				>;
+			};
+
+			uart3_pmx_func: uart3_pmx_func {
+				pinctrl-single,pins = <
+					0x064 MUX_M1 /* UART3_CTS_N */
+					0x068 MUX_M1 /* UART3_RTS_N */
+					0x06c MUX_M1 /* UART3_RXD */
+					0x070 MUX_M1 /* UART3_TXD */
+				>;
+			};
+
+			uart4_pmx_func: uart4_pmx_func {
+				pinctrl-single,pins = <
+					0x074 MUX_M1 /* UART4_CTS_N */
+					0x078 MUX_M1 /* UART4_RTS_N */
+					0x07c MUX_M1 /* UART4_RXD */
+					0x080 MUX_M1 /* UART4_TXD */
+				>;
+			};
+
+			uart6_pmx_func: uart6_pmx_func {
+				pinctrl-single,pins = <
+					0x05c MUX_M1 /* UART6_RXD */
+					0x060 MUX_M1 /* UART6_TXD */
+				>;
+			};
 		};
 
 		pmx2: pinmux@e896c800 {
@@ -27,6 +68,122 @@
 			reg = <0x0 0xe896c800 0x0 0x72c>;
 			#pinctrl-cells = <1>;
 			pinctrl-single,register-width = <0x20>;
+
+			uart0_cfg_func: uart0_cfg_func {
+				pinctrl-single,pins = <
+					0x058 0x0 /* UART0_RXD */
+					0x05c 0x0 /* UART0_TXD */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_04MA DRIVE6_MASK
+				>;
+			};
+
+			uart2_cfg_func: uart2_cfg_func {
+				pinctrl-single,pins = <
+					0x700 0x0 /* UART2_CTS_N */
+					0x704 0x0 /* UART2_RTS_N */
+					0x708 0x0 /* UART2_RXD */
+					0x70c 0x0 /* UART2_TXD */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_04MA DRIVE6_MASK
+				>;
+			};
+
+			uart3_cfg_func: uart3_cfg_func {
+				pinctrl-single,pins = <
+					0x068 0x0 /* UART3_CTS_N */
+					0x06c 0x0 /* UART3_RTS_N */
+					0x070 0x0 /* UART3_RXD */
+					0x074 0x0 /* UART3_TXD */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_04MA DRIVE6_MASK
+				>;
+			};
+
+			uart4_cfg_func: uart4_cfg_func {
+				pinctrl-single,pins = <
+					0x078 0x0 /* UART4_CTS_N */
+					0x07c 0x0 /* UART4_RTS_N */
+					0x080 0x0 /* UART4_RXD */
+					0x084 0x0 /* UART4_TXD */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_04MA DRIVE6_MASK
+				>;
+			};
+
+			uart6_cfg_func: uart6_cfg_func {
+				pinctrl-single,pins = <
+					0x060 0x0 /* UART6_RXD */
+					0x064 0x0 /* UART6_TXD */
+				>;
+				pinctrl-single,bias-pulldown = <
+					PULL_DIS
+					PULL_DOWN
+					PULL_DIS
+					PULL_DOWN
+				>;
+				pinctrl-single,bias-pullup = <
+					PULL_DIS
+					PULL_UP
+					PULL_DIS
+					PULL_UP
+				>;
+				pinctrl-single,drive-strength = <
+					DRIVE7_02MA DRIVE6_MASK
+				>;
+			};
 		};
 
 		pmx5: pinmux@fc182000 {
-- 
2.17.1

