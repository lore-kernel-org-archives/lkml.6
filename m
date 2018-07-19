Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F322C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F7120854
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F7120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeGSGIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:08:01 -0400
Received: from mx.socionext.com ([202.248.49.38]:35084 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbeGSGIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:08:01 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Jul 2018 14:26:42 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 3D4E8180D69;
        Thu, 19 Jul 2018 14:26:42 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 19 Jul 2018 14:26:42 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id CC9F01A11BB;
        Thu, 19 Jul 2018 14:26:41 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        yamada.masahiro@socionext.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] clk: uniphier: add clock frequency support for SPI
Date:   Thu, 19 Jul 2018 14:23:48 +0900
Message-Id: <1531977828-8276-1-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Add clock control for SPI controller on UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---
 drivers/clk/uniphier/clk-uniphier-peri.c | 9 +++++++++
 drivers/clk/uniphier/clk-uniphier-sys.c  | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-peri.c b/drivers/clk/uniphier/clk-uniphier-peri.c
index 521c80e..89b3ac3 100644
--- a/drivers/clk/uniphier/clk-uniphier-peri.c
+++ b/drivers/clk/uniphier/clk-uniphier-peri.c
@@ -27,6 +27,12 @@
 #define UNIPHIER_PERI_CLK_FI2C(idx, ch)					\
 	UNIPHIER_CLK_GATE("i2c" #ch, (idx), "i2c", 0x24, 24 + (ch))
 
+#define UNIPHIER_PERI_CLK_SCSSI(idx)					\
+	UNIPHIER_CLK_GATE("scssi", (idx), "spi", 0x20, 17)
+
+#define UNIPHIER_PERI_CLK_MCSSI(idx)					\
+	UNIPHIER_CLK_GATE("mcssi", (idx), "spi", 0x24, 14)
+
 const struct uniphier_clk_data uniphier_ld4_peri_clk_data[] = {
 	UNIPHIER_PERI_CLK_UART(0, 0),
 	UNIPHIER_PERI_CLK_UART(1, 1),
@@ -38,6 +44,7 @@ const struct uniphier_clk_data uniphier_ld4_peri_clk_data[] = {
 	UNIPHIER_PERI_CLK_I2C(6, 2),
 	UNIPHIER_PERI_CLK_I2C(7, 3),
 	UNIPHIER_PERI_CLK_I2C(8, 4),
+	UNIPHIER_PERI_CLK_SCSSI(11),
 	{ /* sentinel */ }
 };
 
@@ -53,5 +60,7 @@ const struct uniphier_clk_data uniphier_pro4_peri_clk_data[] = {
 	UNIPHIER_PERI_CLK_FI2C(8, 4),
 	UNIPHIER_PERI_CLK_FI2C(9, 5),
 	UNIPHIER_PERI_CLK_FI2C(10, 6),
+	UNIPHIER_PERI_CLK_SCSSI(11),
+	UNIPHIER_PERI_CLK_MCSSI(12),
 	{ /* sentinel */ }
 };
diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index 4f5ff9f..a2c3c10 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -93,6 +93,7 @@ const struct uniphier_clk_data uniphier_ld4_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 5625, 512),	/* 270 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 16),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
+	UNIPHIER_CLK_FACTOR("spi", -1, "spll", 1, 32),
 	UNIPHIER_LD4_SYS_CLK_NAND(2),
 	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
@@ -108,6 +109,7 @@ const struct uniphier_clk_data uniphier_pro4_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("gpll", -1, "ref", 10, 1),		/* 250 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 8),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 32),
+	UNIPHIER_CLK_FACTOR("spi", 1, "spll", 1, 32),
 	UNIPHIER_LD4_SYS_CLK_NAND(2),
 	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
@@ -130,6 +132,7 @@ const struct uniphier_clk_data uniphier_sld8_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 270, 25),	/* 270 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 20),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
+	UNIPHIER_CLK_FACTOR("spi", -1, "spll", 1, 32),
 	UNIPHIER_LD4_SYS_CLK_NAND(2),
 	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
@@ -143,6 +146,7 @@ const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("dapll2", -1, "dapll1", 144, 125),	/* 2949.12 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "dapll2", 1, 40),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
+	UNIPHIER_CLK_FACTOR("spi", -1, "spll", 1, 48),
 	UNIPHIER_PRO5_SYS_CLK_NAND(2),
 	UNIPHIER_PRO5_SYS_CLK_SD,
 	UNIPHIER_LD4_SYS_CLK_STDMAC(8),				/* HSC */
@@ -158,6 +162,7 @@ const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 96, 1),		/* 2400 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 27),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
+	UNIPHIER_CLK_FACTOR("spi", -1, "spll", 1, 48),
 	UNIPHIER_PRO5_SYS_CLK_NAND(2),
 	UNIPHIER_PRO5_SYS_CLK_SD,
 	UNIPHIER_PRO4_SYS_CLK_ETHER(6),
@@ -180,6 +185,7 @@ const struct uniphier_clk_data uniphier_ld11_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vspll", -1, "ref", 80, 1),		/* 2000 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
+	UNIPHIER_CLK_FACTOR("spi", -1, "spll", 1, 40),
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
 	/* Index 5 reserved for eMMC PHY */
@@ -213,6 +219,7 @@ const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vppll", -1, "ref", 504, 5),	/* 2520 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
+	UNIPHIER_CLK_FACTOR("spi", -1, "spll", 1, 40),
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
 	/* Index 5 reserved for eMMC PHY */
@@ -254,6 +261,7 @@ const struct uniphier_clk_data uniphier_pxs3_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("s2pll", -1, "ref", 88, 1),		/* IPP: 2400 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
+	UNIPHIER_CLK_FACTOR("spi", -1, "spll", 1, 40),
 	UNIPHIER_LD20_SYS_CLK_SD,
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
-- 
2.7.4

