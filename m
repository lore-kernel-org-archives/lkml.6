Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE22C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BF821471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+X94Fq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BF821471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJQF61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbeJQF61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:58:27 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 637A521471;
        Tue, 16 Oct 2018 22:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539727560;
        bh=eMmSIcwmkm1w5QJrOlDkrdcdGv62BM4K2WMN6KWt07M=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=H+X94Fq9/zGwLxVwFJdu8m3EoTr99y2NBRdMSx+PwXejA1a15MRDk0HxicqhywEl2
         W0cfMPxd+geksjgjPDX+zME+DAGWLXA9LfPUzRaxbGELr3OpX6+NmCG7d6fUaN6Fad
         iSsPUX1DPPAM7tqR60/55A5mh94MVEkZQFCm38/8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Craig Tatlor <ctatlor97@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180925173603.2274-1-ctatlor97@gmail.com>
Cc:     ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org
References: <20180810202123.29238-1-ctatlor97@gmail.com>
 <20180925173603.2274-1-ctatlor97@gmail.com>
Message-ID: <153972755969.5275.6009136144671817459@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3] clk: qcom: Add Global Clock controller (GCC) driver for SDM660
Date:   Tue, 16 Oct 2018 15:05:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Craig Tatlor (2018-09-25 10:35:58)
> From: Taniya Das <tdas@codeaurora.org>
> =

> Add support for the global clock controller found on SDM660
> based devices. This should allow most non-multimedia device
> drivers to probe and control their clocks.
> Based on CAF implementation.
> =

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> [craig: rename parents to fit upstream, and other cleanups]
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---

Applied to clk-next

But there was some noise:

drivers/clk/qcom/gcc-sdm660.c:2304:10: warning: Initializer entry defined t=
wice
drivers/clk/qcom/gcc-sdm660.c:2306:10: also defined here

and I didn't like seeing gcc_660, so I applied this fixup on top:

diff --git a/drivers/clk/qcom/gcc-sdm660.c b/drivers/clk/qcom/gcc-sdm660.c
index 1722a9b181e2..9efb55092ebf 100644
--- a/drivers/clk/qcom/gcc-sdm660.c
+++ b/drivers/clk/qcom/gcc-sdm660.c
@@ -2253,12 +2253,12 @@ static struct gdsc pcie_0_gdsc =3D {
 };
 =

 static struct clk_hw *gcc_sdm660_hws[] =3D {
-	[GCC_XO] =3D &xo.hw,
-	[GCC_GPLL0_EARLY_DIV] =3D &gpll0_early_div.hw,
-	[GCC_GPLL1_EARLY_DIV] =3D &gpll1_early_div.hw,
+	&xo.hw,
+	&gpll0_early_div.hw,
+	&gpll1_early_div.hw,
 };
 =

-static struct clk_regmap *gcc_660_clocks[] =3D {
+static struct clk_regmap *gcc_sdm660_clocks[] =3D {
 	[BLSP1_QUP1_I2C_APPS_CLK_SRC] =3D &blsp1_qup1_i2c_apps_clk_src.clkr,
 	[BLSP1_QUP1_SPI_APPS_CLK_SRC] =3D &blsp1_qup1_spi_apps_clk_src.clkr,
 	[BLSP1_QUP2_I2C_APPS_CLK_SRC] =3D &blsp1_qup2_i2c_apps_clk_src.clkr,
@@ -2365,9 +2365,8 @@ static struct clk_regmap *gcc_660_clocks[] =3D {
 	[GPLL0_EARLY] =3D &gpll0_early.clkr,
 	[GPLL1] =3D &gpll1.clkr,
 	[GPLL1_EARLY] =3D &gpll1_early.clkr,
-	[GPLL1] =3D &gpll1.clkr,
-	[GPLL4_EARLY] =3D &gpll4_early.clkr,
 	[GPLL4] =3D &gpll4.clkr,
+	[GPLL4_EARLY] =3D &gpll4_early.clkr,
 	[HMSS_GPLL0_CLK_SRC] =3D &hmss_gpll0_clk_src.clkr,
 	[HMSS_GPLL4_CLK_SRC] =3D &hmss_gpll4_clk_src.clkr,
 	[HMSS_RBCPR_CLK_SRC] =3D &hmss_rbcpr_clk_src.clkr,
@@ -2387,13 +2386,13 @@ static struct clk_regmap *gcc_660_clocks[] =3D {
 	[USB3_PHY_AUX_CLK_SRC] =3D &usb3_phy_aux_clk_src.clkr,
 };
 =

-static struct gdsc *gcc_660_gdscs[] =3D {
+static struct gdsc *gcc_sdm660_gdscs[] =3D {
 	[UFS_GDSC] =3D &ufs_gdsc,
 	[USB_30_GDSC] =3D &usb_30_gdsc,
 	[PCIE_0_GDSC] =3D &pcie_0_gdsc,
 };
 =

-static const struct qcom_reset_map gcc_660_resets[] =3D {
+static const struct qcom_reset_map gcc_sdm660_resets[] =3D {
 	[GCC_QUSB2PHY_PRIM_BCR] =3D { 0x12000 },
 	[GCC_QUSB2PHY_SEC_BCR] =3D { 0x12004 },
 	[GCC_UFS_BCR] =3D { 0x75000 },
@@ -2405,7 +2404,7 @@ static const struct qcom_reset_map gcc_660_resets[] =
=3D {
 	[GCC_USB_PHY_CFG_AHB2PHY_BCR] =3D { 0x6a000 },
 };
 =

-static const struct regmap_config gcc_660_regmap_config =3D {
+static const struct regmap_config gcc_sdm660_regmap_config =3D {
 	.reg_bits	=3D 32,
 	.reg_stride	=3D 4,
 	.val_bits	=3D 32,
@@ -2413,29 +2412,29 @@ static const struct regmap_config gcc_660_regmap_co=
nfig =3D {
 	.fast_io	=3D true,
 };
 =

-static const struct qcom_cc_desc gcc_660_desc =3D {
-	.config =3D &gcc_660_regmap_config,
-	.clks =3D gcc_660_clocks,
-	.num_clks =3D ARRAY_SIZE(gcc_660_clocks),
-	.resets =3D gcc_660_resets,
-	.num_resets =3D ARRAY_SIZE(gcc_660_resets),
-	.gdscs =3D gcc_660_gdscs,
-	.num_gdscs =3D ARRAY_SIZE(gcc_660_gdscs),
+static const struct qcom_cc_desc gcc_sdm660_desc =3D {
+	.config =3D &gcc_sdm660_regmap_config,
+	.clks =3D gcc_sdm660_clocks,
+	.num_clks =3D ARRAY_SIZE(gcc_sdm660_clocks),
+	.resets =3D gcc_sdm660_resets,
+	.num_resets =3D ARRAY_SIZE(gcc_sdm660_resets),
+	.gdscs =3D gcc_sdm660_gdscs,
+	.num_gdscs =3D ARRAY_SIZE(gcc_sdm660_gdscs),
 };
 =

-static const struct of_device_id gcc_660_match_table[] =3D {
+static const struct of_device_id gcc_sdm660_match_table[] =3D {
 	{ .compatible =3D "qcom,gcc-sdm630" },
 	{ .compatible =3D "qcom,gcc-sdm660" },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, gcc_660_match_table);
+MODULE_DEVICE_TABLE(of, gcc_sdm660_match_table);
 =

-static int gcc_660_probe(struct platform_device *pdev)
+static int gcc_sdm660_probe(struct platform_device *pdev)
 {
 	int i, ret =3D 0;
 	struct regmap *regmap;
 =

-	regmap =3D qcom_cc_map(pdev, &gcc_660_desc);
+	regmap =3D qcom_cc_map(pdev, &gcc_sdm660_desc);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 =

@@ -2454,27 +2453,27 @@ static int gcc_660_probe(struct platform_device *pd=
ev)
 			return ret;
 	}
 =

-	return qcom_cc_really_probe(pdev, &gcc_660_desc, regmap);
+	return qcom_cc_really_probe(pdev, &gcc_sdm660_desc, regmap);
 }
 =

-static struct platform_driver gcc_660_driver =3D {
-	.probe		=3D gcc_660_probe,
+static struct platform_driver gcc_sdm660_driver =3D {
+	.probe		=3D gcc_sdm660_probe,
 	.driver		=3D {
 		.name	=3D "gcc-sdm660",
-		.of_match_table =3D gcc_660_match_table,
+		.of_match_table =3D gcc_sdm660_match_table,
 	},
 };
 =

-static int __init gcc_660_init(void)
+static int __init gcc_sdm660_init(void)
 {
-	return platform_driver_register(&gcc_660_driver);
+	return platform_driver_register(&gcc_sdm660_driver);
 }
-core_initcall_sync(gcc_660_init);
+core_initcall_sync(gcc_sdm660_init);
 =

-static void __exit gcc_660_exit(void)
+static void __exit gcc_sdm660_exit(void)
 {
-	platform_driver_unregister(&gcc_660_driver);
+	platform_driver_unregister(&gcc_sdm660_driver);
 }
-module_exit(gcc_660_exit);
+module_exit(gcc_sdm660_exit);
 =

 MODULE_DESCRIPTION("QCOM GCC sdm660 Driver");
diff --git a/include/dt-bindings/clock/qcom,gcc-sdm660.h b/include/dt-bindi=
ngs/clock/qcom,gcc-sdm660.h
index 76aabcc5e7e3..468302282913 100644
--- a/include/dt-bindings/clock/qcom,gcc-sdm660.h
+++ b/include/dt-bindings/clock/qcom,gcc-sdm660.h
@@ -7,140 +7,137 @@
 #ifndef _DT_BINDINGS_CLK_MSM_GCC_660_H
 #define _DT_BINDINGS_CLK_MSM_GCC_660_H
 =

-#define GCC_XO					0
-#define GCC_GPLL0_EARLY_DIV			1
-#define GCC_GPLL1_EARLY_DIV			2
-#define BLSP1_QUP1_I2C_APPS_CLK_SRC		3
-#define BLSP1_QUP1_SPI_APPS_CLK_SRC		4
-#define BLSP1_QUP2_I2C_APPS_CLK_SRC		5
-#define BLSP1_QUP2_SPI_APPS_CLK_SRC		6
-#define BLSP1_QUP3_I2C_APPS_CLK_SRC		7
-#define BLSP1_QUP3_SPI_APPS_CLK_SRC		8
-#define BLSP1_QUP4_I2C_APPS_CLK_SRC		9
-#define BLSP1_QUP4_SPI_APPS_CLK_SRC		10
-#define BLSP1_UART1_APPS_CLK_SRC		11
-#define BLSP1_UART2_APPS_CLK_SRC		12
-#define BLSP2_QUP1_I2C_APPS_CLK_SRC		13
-#define BLSP2_QUP1_SPI_APPS_CLK_SRC		14
-#define BLSP2_QUP2_I2C_APPS_CLK_SRC		15
-#define BLSP2_QUP2_SPI_APPS_CLK_SRC		16
-#define BLSP2_QUP3_I2C_APPS_CLK_SRC		17
-#define BLSP2_QUP3_SPI_APPS_CLK_SRC		18
-#define BLSP2_QUP4_I2C_APPS_CLK_SRC		19
-#define BLSP2_QUP4_SPI_APPS_CLK_SRC		20
-#define BLSP2_UART1_APPS_CLK_SRC		21
-#define BLSP2_UART2_APPS_CLK_SRC		22
-#define GCC_AGGRE2_UFS_AXI_CLK			23
-#define GCC_AGGRE2_USB3_AXI_CLK			24
-#define GCC_BIMC_GFX_CLK			25
-#define GCC_BIMC_HMSS_AXI_CLK			26
-#define GCC_BIMC_MSS_Q6_AXI_CLK			27
-#define GCC_BLSP1_AHB_CLK			28
-#define GCC_BLSP1_QUP1_I2C_APPS_CLK		29
-#define GCC_BLSP1_QUP1_SPI_APPS_CLK		30
-#define GCC_BLSP1_QUP2_I2C_APPS_CLK		31
-#define GCC_BLSP1_QUP2_SPI_APPS_CLK		32
-#define GCC_BLSP1_QUP3_I2C_APPS_CLK		33
-#define GCC_BLSP1_QUP3_SPI_APPS_CLK		34
-#define GCC_BLSP1_QUP4_I2C_APPS_CLK		35
-#define GCC_BLSP1_QUP4_SPI_APPS_CLK		36
-#define GCC_BLSP1_UART1_APPS_CLK		37
-#define GCC_BLSP1_UART2_APPS_CLK		38
-#define GCC_BLSP2_AHB_CLK			39
-#define GCC_BLSP2_QUP1_I2C_APPS_CLK		40
-#define GCC_BLSP2_QUP1_SPI_APPS_CLK		41
-#define GCC_BLSP2_QUP2_I2C_APPS_CLK		42
-#define GCC_BLSP2_QUP2_SPI_APPS_CLK		43
-#define GCC_BLSP2_QUP3_I2C_APPS_CLK		44
-#define GCC_BLSP2_QUP3_SPI_APPS_CLK		46
-#define GCC_BLSP2_QUP4_I2C_APPS_CLK		45
-#define GCC_BLSP2_QUP4_SPI_APPS_CLK		46
-#define GCC_BLSP2_UART1_APPS_CLK		47
-#define GCC_BLSP2_UART2_APPS_CLK		48
-#define GCC_BOOT_ROM_AHB_CLK			49
-#define GCC_CFG_NOC_USB2_AXI_CLK		50
-#define GCC_CFG_NOC_USB3_AXI_CLK		51
-#define GCC_DCC_AHB_CLK				52
-#define GCC_GP1_CLK				53
-#define GCC_GP2_CLK				54
-#define GCC_GP3_CLK				55
-#define GCC_GPU_BIMC_GFX_CLK			56
-#define GCC_GPU_CFG_AHB_CLK			57
-#define GCC_GPU_GPLL0_CLK			58
-#define GCC_GPU_GPLL0_DIV_CLK			59
-#define GCC_HMSS_DVM_BUS_CLK			60
-#define GCC_HMSS_RBCPR_CLK			61
-#define GCC_MMSS_GPLL0_CLK			62
-#define GCC_MMSS_GPLL0_DIV_CLK			63
-#define GCC_MMSS_NOC_CFG_AHB_CLK		64
-#define GCC_MMSS_SYS_NOC_AXI_CLK		65
-#define GCC_MSS_CFG_AHB_CLK			66
-#define GCC_MSS_GPLL0_DIV_CLK			67
-#define GCC_MSS_MNOC_BIMC_AXI_CLK		68
-#define GCC_MSS_Q6_BIMC_AXI_CLK			69
-#define GCC_MSS_SNOC_AXI_CLK			70
-#define GCC_PDM2_CLK				71
-#define GCC_PDM_AHB_CLK				72
-#define GCC_PRNG_AHB_CLK			73
-#define GCC_QSPI_AHB_CLK			74
-#define GCC_QSPI_SER_CLK			75
-#define GCC_SDCC1_AHB_CLK			76
-#define GCC_SDCC1_APPS_CLK			77
-#define GCC_SDCC1_ICE_CORE_CLK			78
-#define GCC_SDCC2_AHB_CLK			79
-#define GCC_SDCC2_APPS_CLK			80
-#define GCC_UFS_AHB_CLK				81
-#define GCC_UFS_AXI_CLK				82
-#define GCC_UFS_CLKREF_CLK			83
-#define GCC_UFS_ICE_CORE_CLK			84
-#define GCC_UFS_PHY_AUX_CLK			85
-#define GCC_UFS_RX_SYMBOL_0_CLK			86
-#define GCC_UFS_RX_SYMBOL_1_CLK			87
-#define GCC_UFS_TX_SYMBOL_0_CLK			88
-#define GCC_UFS_UNIPRO_CORE_CLK			89
-#define GCC_USB20_MASTER_CLK			90
-#define GCC_USB20_MOCK_UTMI_CLK			91
-#define GCC_USB20_SLEEP_CLK			92
-#define GCC_USB30_MASTER_CLK			93
-#define GCC_USB30_MOCK_UTMI_CLK			94
-#define GCC_USB30_SLEEP_CLK			95
-#define GCC_USB3_CLKREF_CLK			96
-#define GCC_USB3_PHY_AUX_CLK			97
-#define GCC_USB3_PHY_PIPE_CLK			98
-#define GCC_USB_PHY_CFG_AHB2PHY_CLK		99
-#define GP1_CLK_SRC				100
-#define GP2_CLK_SRC				101
-#define GP3_CLK_SRC				102
-#define GPLL0					103
-#define GPLL0_EARLY				104
-#define GPLL1					105
-#define GPLL1_EARLY				106
-#define GPLL4					107
-#define GPLL4_EARLY				108
-#define HMSS_GPLL0_CLK_SRC			109
-#define HMSS_GPLL4_CLK_SRC			110
-#define HMSS_RBCPR_CLK_SRC			111
-#define PDM2_CLK_SRC				112
-#define QSPI_SER_CLK_SRC			113
-#define SDCC1_APPS_CLK_SRC			114
-#define SDCC1_ICE_CORE_CLK_SRC			115
-#define SDCC2_APPS_CLK_SRC			116
-#define UFS_AXI_CLK_SRC				117
-#define UFS_ICE_CORE_CLK_SRC			118
-#define UFS_PHY_AUX_CLK_SRC			119
-#define UFS_UNIPRO_CORE_CLK_SRC			120
-#define USB20_MASTER_CLK_SRC			121
-#define USB20_MOCK_UTMI_CLK_SRC			122
-#define USB30_MASTER_CLK_SRC			123
-#define USB30_MOCK_UTMI_CLK_SRC			124
-#define USB3_PHY_AUX_CLK_SRC			125
-#define GPLL0_OUT_MSSCC				126
-#define GCC_UFS_AXI_HW_CTL_CLK			127
-#define GCC_UFS_ICE_CORE_HW_CTL_CLK		128
-#define GCC_UFS_PHY_AUX_HW_CTL_CLK		129
-#define GCC_UFS_UNIPRO_CORE_HW_CTL_CLK		130
-#define GCC_RX0_USB2_CLKREF_CLK			131
-#define GCC_RX1_USB2_CLKREF_CLK			132
+#define BLSP1_QUP1_I2C_APPS_CLK_SRC		0
+#define BLSP1_QUP1_SPI_APPS_CLK_SRC		1
+#define BLSP1_QUP2_I2C_APPS_CLK_SRC		2
+#define BLSP1_QUP2_SPI_APPS_CLK_SRC		3
+#define BLSP1_QUP3_I2C_APPS_CLK_SRC		4
+#define BLSP1_QUP3_SPI_APPS_CLK_SRC		5
+#define BLSP1_QUP4_I2C_APPS_CLK_SRC		6
+#define BLSP1_QUP4_SPI_APPS_CLK_SRC		7
+#define BLSP1_UART1_APPS_CLK_SRC		8
+#define BLSP1_UART2_APPS_CLK_SRC		9
+#define BLSP2_QUP1_I2C_APPS_CLK_SRC		10
+#define BLSP2_QUP1_SPI_APPS_CLK_SRC		11
+#define BLSP2_QUP2_I2C_APPS_CLK_SRC		12
+#define BLSP2_QUP2_SPI_APPS_CLK_SRC		13
+#define BLSP2_QUP3_I2C_APPS_CLK_SRC		14
+#define BLSP2_QUP3_SPI_APPS_CLK_SRC		15
+#define BLSP2_QUP4_I2C_APPS_CLK_SRC		16
+#define BLSP2_QUP4_SPI_APPS_CLK_SRC		17
+#define BLSP2_UART1_APPS_CLK_SRC		18
+#define BLSP2_UART2_APPS_CLK_SRC		19
+#define GCC_AGGRE2_UFS_AXI_CLK			20
+#define GCC_AGGRE2_USB3_AXI_CLK			21
+#define GCC_BIMC_GFX_CLK			22
+#define GCC_BIMC_HMSS_AXI_CLK			23
+#define GCC_BIMC_MSS_Q6_AXI_CLK			24
+#define GCC_BLSP1_AHB_CLK			25
+#define GCC_BLSP1_QUP1_I2C_APPS_CLK		26
+#define GCC_BLSP1_QUP1_SPI_APPS_CLK		27
+#define GCC_BLSP1_QUP2_I2C_APPS_CLK		28
+#define GCC_BLSP1_QUP2_SPI_APPS_CLK		29
+#define GCC_BLSP1_QUP3_I2C_APPS_CLK		30
+#define GCC_BLSP1_QUP3_SPI_APPS_CLK		31
+#define GCC_BLSP1_QUP4_I2C_APPS_CLK		32
+#define GCC_BLSP1_QUP4_SPI_APPS_CLK		33
+#define GCC_BLSP1_UART1_APPS_CLK		34
+#define GCC_BLSP1_UART2_APPS_CLK		35
+#define GCC_BLSP2_AHB_CLK			36
+#define GCC_BLSP2_QUP1_I2C_APPS_CLK		37
+#define GCC_BLSP2_QUP1_SPI_APPS_CLK		38
+#define GCC_BLSP2_QUP2_I2C_APPS_CLK		39
+#define GCC_BLSP2_QUP2_SPI_APPS_CLK		40
+#define GCC_BLSP2_QUP3_I2C_APPS_CLK		41
+#define GCC_BLSP2_QUP3_SPI_APPS_CLK		42
+#define GCC_BLSP2_QUP4_I2C_APPS_CLK		43
+#define GCC_BLSP2_QUP4_SPI_APPS_CLK		44
+#define GCC_BLSP2_UART1_APPS_CLK		45
+#define GCC_BLSP2_UART2_APPS_CLK		46
+#define GCC_BOOT_ROM_AHB_CLK			47
+#define GCC_CFG_NOC_USB2_AXI_CLK		48
+#define GCC_CFG_NOC_USB3_AXI_CLK		49
+#define GCC_DCC_AHB_CLK				50
+#define GCC_GP1_CLK				51
+#define GCC_GP2_CLK				52
+#define GCC_GP3_CLK				53
+#define GCC_GPU_BIMC_GFX_CLK			54
+#define GCC_GPU_CFG_AHB_CLK			55
+#define GCC_GPU_GPLL0_CLK			56
+#define GCC_GPU_GPLL0_DIV_CLK			57
+#define GCC_HMSS_DVM_BUS_CLK			58
+#define GCC_HMSS_RBCPR_CLK			59
+#define GCC_MMSS_GPLL0_CLK			60
+#define GCC_MMSS_GPLL0_DIV_CLK			61
+#define GCC_MMSS_NOC_CFG_AHB_CLK		62
+#define GCC_MMSS_SYS_NOC_AXI_CLK		63
+#define GCC_MSS_CFG_AHB_CLK			64
+#define GCC_MSS_GPLL0_DIV_CLK			65
+#define GCC_MSS_MNOC_BIMC_AXI_CLK		66
+#define GCC_MSS_Q6_BIMC_AXI_CLK			67
+#define GCC_MSS_SNOC_AXI_CLK			68
+#define GCC_PDM2_CLK				69
+#define GCC_PDM_AHB_CLK				70
+#define GCC_PRNG_AHB_CLK			71
+#define GCC_QSPI_AHB_CLK			72
+#define GCC_QSPI_SER_CLK			73
+#define GCC_SDCC1_AHB_CLK			74
+#define GCC_SDCC1_APPS_CLK			75
+#define GCC_SDCC1_ICE_CORE_CLK			76
+#define GCC_SDCC2_AHB_CLK			77
+#define GCC_SDCC2_APPS_CLK			78
+#define GCC_UFS_AHB_CLK				79
+#define GCC_UFS_AXI_CLK				80
+#define GCC_UFS_CLKREF_CLK			81
+#define GCC_UFS_ICE_CORE_CLK			82
+#define GCC_UFS_PHY_AUX_CLK			83
+#define GCC_UFS_RX_SYMBOL_0_CLK			84
+#define GCC_UFS_RX_SYMBOL_1_CLK			85
+#define GCC_UFS_TX_SYMBOL_0_CLK			86
+#define GCC_UFS_UNIPRO_CORE_CLK			87
+#define GCC_USB20_MASTER_CLK			88
+#define GCC_USB20_MOCK_UTMI_CLK			89
+#define GCC_USB20_SLEEP_CLK			90
+#define GCC_USB30_MASTER_CLK			91
+#define GCC_USB30_MOCK_UTMI_CLK			92
+#define GCC_USB30_SLEEP_CLK			93
+#define GCC_USB3_CLKREF_CLK			94
+#define GCC_USB3_PHY_AUX_CLK			95
+#define GCC_USB3_PHY_PIPE_CLK			96
+#define GCC_USB_PHY_CFG_AHB2PHY_CLK		97
+#define GP1_CLK_SRC				98
+#define GP2_CLK_SRC				99
+#define GP3_CLK_SRC				100
+#define GPLL0					101
+#define GPLL0_EARLY				102
+#define GPLL1					103
+#define GPLL1_EARLY				104
+#define GPLL4					105
+#define GPLL4_EARLY				106
+#define HMSS_GPLL0_CLK_SRC			107
+#define HMSS_GPLL4_CLK_SRC			108
+#define HMSS_RBCPR_CLK_SRC			109
+#define PDM2_CLK_SRC				110
+#define QSPI_SER_CLK_SRC			111
+#define SDCC1_APPS_CLK_SRC			112
+#define SDCC1_ICE_CORE_CLK_SRC			113
+#define SDCC2_APPS_CLK_SRC			114
+#define UFS_AXI_CLK_SRC				115
+#define UFS_ICE_CORE_CLK_SRC			116
+#define UFS_PHY_AUX_CLK_SRC			117
+#define UFS_UNIPRO_CORE_CLK_SRC			118
+#define USB20_MASTER_CLK_SRC			119
+#define USB20_MOCK_UTMI_CLK_SRC			120
+#define USB30_MASTER_CLK_SRC			121
+#define USB30_MOCK_UTMI_CLK_SRC			122
+#define USB3_PHY_AUX_CLK_SRC			123
+#define GPLL0_OUT_MSSCC				124
+#define GCC_UFS_AXI_HW_CTL_CLK			125
+#define GCC_UFS_ICE_CORE_HW_CTL_CLK		126
+#define GCC_UFS_PHY_AUX_HW_CTL_CLK		127
+#define GCC_UFS_UNIPRO_CORE_HW_CTL_CLK		128
+#define GCC_RX0_USB2_CLKREF_CLK			129
+#define GCC_RX1_USB2_CLKREF_CLK			130
 =

 #define PCIE_0_GDSC	0
 #define UFS_GDSC	1
