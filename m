Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C787EC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 19:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D042084A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 19:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D042084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754304AbeGGTnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 15:43:23 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:25355 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754150AbeGGTnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 15:43:21 -0400
Received: from belgarion.home ([90.55.203.186])
        by mwinf5d73 with ME
        id 7viq1y00641oiFu03viyms; Sat, 07 Jul 2018 21:43:19 +0200
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 07 Jul 2018 21:43:19 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] ARM: dts: pxa: add pincontrol helpers
Date:   Sat,  7 Jul 2018 21:42:46 +0200
Message-Id: <20180707194247.31143-1-robert.jarzmik@free.fr>
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
index e4ebcde17837..f609dbb86abf 100644
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

