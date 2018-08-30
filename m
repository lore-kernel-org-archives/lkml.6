Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BC5C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62D720834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62D720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeHaADK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:03:10 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:60934 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeHaADK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:03:10 -0400
Received: from belgarion.home ([90.89.234.36])
        by mwinf5d82 with ME
        id VXzF1y0020nnJME03XzKQ9; Thu, 30 Aug 2018 21:59:19 +0200
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 30 Aug 2018 21:59:19 +0200
X-ME-IP: 90.89.234.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: pxa: add pincontrol helpers
Date:   Thu, 30 Aug 2018 21:59:12 +0200
Message-Id: <20180830195912.6025-1-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 3 helpers so that pincontrol definitions for pxa25x and pxa27x are
easier, and can be easily converted from old mfp mach-pxa code to
devicetree.

An example of such conversion would be :
static unsigned long mioa701_pin_config[] = {
	GPIO32_MMC_CLK,
	GPIO92_MMC_DAT_0,
	GPIO109_MMC_DAT_1,
	GPIO110_MMC_DAT_2,
	GPIO111_MMC_DAT_3,
	GPIO112_MMC_CMD,
	MIO_CFG_IN(GPIO78_SDIO_RO, AF0),
	MIO_CFG_IN(GPIO15_SDIO_INSERT, AF0),
	MIO_CFG_OUT(GPIO91_SDIO_EN, AF0, DRIVE_LOW),
};
into:
	pinctrl_mmc_default: mmc-default {
		PMMUX(sd-insert, 15, gpio_in);
		PMMUX(mmclk, 32, MMCLK);
		PMMUX(sd-ro, 78, gpio_in);
		PMMUX_LPM_LOW(sd-enable, 91, gpio_out);
		PMMUX(mmdat0, 92, MMDAT<0>);
		PMMUX(mmdat1, 109, MMDAT<1>);
		PMMUX(mmdat2, 110, MMDAT<2>);
		PMMUX(mmdat3, 111, MMDAT<3>);
		PMMUX(mmcmd, 112, MMCMD);
	};

The third column of PMMUX*() helpers can be found in pincontrol muxing
functions, either in pinctrl-pxa27x.c (or pinctrl-pxa25x.c), or by
inspecting the pincontrol once booted in debugfs.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa2xx.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index a520b4c14ea9..81312a9813f6 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -9,6 +9,25 @@
 #include "skeleton.dtsi"
 #include "dt-bindings/clock/pxa-clock.h"
 
+#define PMGROUP(pin) #pin
+#define PMMUX(func, pin, af)			\
+	mux- ## func {				\
+		groups = PMGROUP(P ## pin);	\
+		function = #af;			\
+	}
+#define PMMUX_LPM_LOW(func, pin, af)		\
+	mux- ## func {				\
+		groups = PMGROUP(P ## pin);	\
+		function = #af;			\
+		low-power-disable;		\
+	}
+#define PMMUX_LPM_HIGH(func, pin, af)		\
+	mux- ## func {				\
+		groups = PMGROUP(P ## pin);	\
+		function = #af;			\
+		low-power-enable;		\
+	}
+
 / {
 	model = "Marvell PXA2xx family SoC";
 	compatible = "marvell,pxa2xx";
-- 
2.11.0

