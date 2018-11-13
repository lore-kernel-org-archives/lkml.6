Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE42C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2557D2082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2557D2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbeKMUE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:04:59 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:39589 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731448AbeKMUE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:04:58 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42vNbV0Nlpz1r05H;
        Tue, 13 Nov 2018 11:07:33 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42vNbT2qbbz1qr2g;
        Tue, 13 Nov 2018 11:07:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id kUjZH0P3wL5N; Tue, 13 Nov 2018 11:07:30 +0100 (CET)
X-Auth-Info: EacCkqFOx+67gQLMuXjccAUg1L2GB2Is9g+IPv2rPw8=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 13 Nov 2018 11:07:29 +0100 (CET)
From:   Parthiban Nallathambi <pn@denx.de>
To:     linus.walleij@linaro.org, manivannan.sadhasivam@linaro.org,
        afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        mp-cs@actions-semi.com, thomas.liau@actions-semi.com,
        linux@cubietech.com, pn@denx.de, sravanhome@gmail.com
Subject: [PATCH v6 1/5] pinctrl: actions: define constructor generic to Actions Semi SoC's
Date:   Tue, 13 Nov 2018 11:07:05 +0100
Message-Id: <20181113100709.5615-2-pn@denx.de>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181113100709.5615-1-pn@denx.de>
References: <20181113100709.5615-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravanan Sekar <sravanhome@gmail.com>

Move generic defines common to the Owl family out of S900 driver.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/pinctrl/actions/pinctrl-owl.h  | 131 +++++++++++++++++++++++
 drivers/pinctrl/actions/pinctrl-s900.c | 139 ++-----------------------
 2 files changed, 137 insertions(+), 133 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
index a724d1d406d4..31cc33d7c4a5 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.h
+++ b/drivers/pinctrl/actions/pinctrl-owl.h
@@ -15,6 +15,136 @@
 #define OWL_PINCONF_SLEW_SLOW 0
 #define OWL_PINCONF_SLEW_FAST 1
 
+#define MUX_PG(group_name, reg, shift, width)				\
+	{								\
+		.name = #group_name,					\
+		.pads = group_name##_pads,				\
+		.npads = ARRAY_SIZE(group_name##_pads),			\
+		.funcs = group_name##_funcs,				\
+		.nfuncs = ARRAY_SIZE(group_name##_funcs),		\
+		.mfpctl_reg  = MFCTL##reg,				\
+		.mfpctl_shift = shift,					\
+		.mfpctl_width = width,					\
+		.drv_reg = -1,						\
+		.drv_shift = -1,					\
+		.drv_width = -1,					\
+		.sr_reg = -1,						\
+		.sr_shift = -1,						\
+		.sr_width = -1,						\
+	}
+
+#define DRV_PG(group_name, reg, shift, width)				\
+	{								\
+		.name = #group_name,					\
+		.pads = group_name##_pads,				\
+		.npads = ARRAY_SIZE(group_name##_pads),			\
+		.mfpctl_reg  = -1,					\
+		.mfpctl_shift = -1,					\
+		.mfpctl_width = -1,					\
+		.drv_reg = PAD_DRV##reg,				\
+		.drv_shift = shift,					\
+		.drv_width = width,					\
+		.sr_reg = -1,						\
+		.sr_shift = -1,						\
+		.sr_width = -1,						\
+	}
+
+#define SR_PG(group_name, reg, shift, width)				\
+	{								\
+		.name = #group_name,					\
+		.pads = group_name##_pads,				\
+		.npads = ARRAY_SIZE(group_name##_pads),			\
+		.mfpctl_reg  = -1,					\
+		.mfpctl_shift = -1,					\
+		.mfpctl_width = -1,					\
+		.drv_reg = -1,						\
+		.drv_shift = -1,					\
+		.drv_width = -1,					\
+		.sr_reg = PAD_SR##reg,					\
+		.sr_shift = shift,					\
+		.sr_width = width,					\
+	}
+
+#define FUNCTION(fname)					\
+	{						\
+		.name = #fname,				\
+		.groups = fname##_groups,		\
+		.ngroups = ARRAY_SIZE(fname##_groups),	\
+	}
+
+/* PAD PULL UP/DOWN CONFIGURES */
+#define PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)	\
+	{						\
+		.reg = PAD_PULLCTL##pull_reg,		\
+		.shift = pull_sft,			\
+		.width = pull_wdt,			\
+	}
+
+#define PAD_PULLCTL_CONF(pad_name, pull_reg, pull_sft, pull_wdt)	\
+	struct owl_pullctl pad_name##_pullctl_conf			\
+		= PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)
+
+#define ST_CONF(st_reg, st_sft, st_wdt)			\
+	{						\
+		.reg = PAD_ST##st_reg,			\
+		.shift = st_sft,			\
+		.width = st_wdt,			\
+	}
+
+#define PAD_ST_CONF(pad_name, st_reg, st_sft, st_wdt)	\
+	struct owl_st pad_name##_st_conf		\
+		= ST_CONF(st_reg, st_sft, st_wdt)
+
+#define PAD_INFO(name)					\
+	{						\
+		.pad = name,				\
+		.pullctl = NULL,			\
+		.st = NULL,				\
+	}
+
+#define PAD_INFO_ST(name)				\
+	{						\
+		.pad = name,				\
+		.pullctl = NULL,			\
+		.st = &name##_st_conf,			\
+	}
+
+#define PAD_INFO_PULLCTL(name)				\
+	{						\
+		.pad = name,				\
+		.pullctl = &name##_pullctl_conf,	\
+		.st = NULL,				\
+	}
+
+#define PAD_INFO_PULLCTL_ST(name)			\
+	{						\
+		.pad = name,				\
+		.pullctl = &name##_pullctl_conf,	\
+		.st = &name##_st_conf,			\
+	}
+
+#define OWL_GPIO_PORT_A		0
+#define OWL_GPIO_PORT_B		1
+#define OWL_GPIO_PORT_C		2
+#define OWL_GPIO_PORT_D		3
+#define OWL_GPIO_PORT_E		4
+#define OWL_GPIO_PORT_F		5
+
+#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat, _intc_ctl,\
+			_intc_pd, _intc_msk, _intc_type, _share)	\
+	[OWL_GPIO_PORT_##port] = {				\
+		.offset = base,					\
+		.pins = count,					\
+		.outen = _outen,				\
+		.inen = _inen,					\
+		.dat = _dat,					\
+		.intc_ctl = _intc_ctl,				\
+		.intc_pd = _intc_pd,				\
+		.intc_msk = _intc_msk,				\
+		.intc_type = _intc_type,			\
+		.shared_ctl_offset = _share,			\
+	}
+
 enum owl_pinconf_pull {
 	OWL_PINCONF_PULL_HIZ,
 	OWL_PINCONF_PULL_DOWN,
@@ -148,6 +278,7 @@ struct owl_gpio_port {
 	unsigned int intc_pd;
 	unsigned int intc_msk;
 	unsigned int intc_type;
+	u8 shared_ctl_offset;
 };
 
 /**
diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
index ea67b14ef93b..0597009d8369 100644
--- a/drivers/pinctrl/actions/pinctrl-s900.c
+++ b/drivers/pinctrl/actions/pinctrl-s900.c
@@ -33,13 +33,6 @@
 #define PAD_SR1			(0x0274)
 #define PAD_SR2			(0x0278)
 
-#define OWL_GPIO_PORT_A		0
-#define OWL_GPIO_PORT_B		1
-#define OWL_GPIO_PORT_C		2
-#define OWL_GPIO_PORT_D		3
-#define OWL_GPIO_PORT_E		4
-#define OWL_GPIO_PORT_F		5
-
 #define _GPIOA(offset)		(offset)
 #define _GPIOB(offset)		(32 + (offset))
 #define _GPIOC(offset)		(64 + (offset))
@@ -892,55 +885,6 @@ static unsigned int i2c2_sr_pads[]		= { I2C2_SCLK, I2C2_SDATA };
 static unsigned int sensor0_sr_pads[]		= { SENSOR0_PCLK,
 						    SENSOR0_CKOUT };
 
-#define MUX_PG(group_name, reg, shift, width)				\
-	{								\
-		.name = #group_name,					\
-		.pads = group_name##_pads,				\
-		.npads = ARRAY_SIZE(group_name##_pads),			\
-		.funcs = group_name##_funcs,				\
-		.nfuncs = ARRAY_SIZE(group_name##_funcs),		\
-		.mfpctl_reg  = MFCTL##reg,				\
-		.mfpctl_shift = shift,					\
-		.mfpctl_width = width,					\
-		.drv_reg = -1,						\
-		.drv_shift = -1,					\
-		.drv_width = -1,					\
-		.sr_reg = -1,						\
-		.sr_shift = -1,						\
-		.sr_width = -1,						\
-	}
-
-#define DRV_PG(group_name, reg, shift, width)				\
-	{								\
-		.name = #group_name,					\
-		.pads = group_name##_pads,				\
-		.npads = ARRAY_SIZE(group_name##_pads),			\
-		.mfpctl_reg  = -1,					\
-		.mfpctl_shift = -1,					\
-		.mfpctl_width = -1,					\
-		.drv_reg = PAD_DRV##reg,				\
-		.drv_shift = shift,					\
-		.drv_width = width,					\
-		.sr_reg = -1,						\
-		.sr_shift = -1,						\
-		.sr_width = -1,						\
-	}
-
-#define SR_PG(group_name, reg, shift, width)				\
-	{								\
-		.name = #group_name,					\
-		.pads = group_name##_pads,				\
-		.npads = ARRAY_SIZE(group_name##_pads),			\
-		.mfpctl_reg  = -1,					\
-		.mfpctl_shift = -1,					\
-		.mfpctl_width = -1,					\
-		.drv_reg = -1,						\
-		.drv_shift = -1,					\
-		.drv_width = -1,					\
-		.sr_reg = PAD_SR##reg,					\
-		.sr_shift = shift,					\
-		.sr_width = width,					\
-	}
 
 /* Pinctrl groups */
 static const struct owl_pingroup s900_groups[] = {
@@ -1442,13 +1386,6 @@ static const char * const sirq2_groups[] = {
 	"sirq2_dummy",
 };
 
-#define FUNCTION(fname)					\
-	{						\
-		.name = #fname,				\
-		.groups = fname##_groups,		\
-		.ngroups = ARRAY_SIZE(fname##_groups),	\
-	}
-
 static const struct owl_pinmux_func s900_functions[] = {
 	[S900_MUX_ERAM] = FUNCTION(eram),
 	[S900_MUX_ETH_RMII] = FUNCTION(eth_rmii),
@@ -1500,28 +1437,6 @@ static const struct owl_pinmux_func s900_functions[] = {
 	[S900_MUX_SIRQ1] = FUNCTION(sirq1),
 	[S900_MUX_SIRQ2] = FUNCTION(sirq2)
 };
-/* PAD PULL UP/DOWN CONFIGURES */
-#define PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)			\
-	{								\
-		.reg = PAD_PULLCTL##pull_reg,				\
-		.shift = pull_sft,					\
-		.width = pull_wdt,					\
-	}
-
-#define PAD_PULLCTL_CONF(pad_name, pull_reg, pull_sft, pull_wdt)	\
-	struct owl_pullctl pad_name##_pullctl_conf			\
-		= PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)
-
-#define ST_CONF(st_reg, st_sft, st_wdt)					\
-	{								\
-		.reg = PAD_ST##st_reg,					\
-		.shift = st_sft,					\
-		.width = st_wdt,					\
-	}
-
-#define PAD_ST_CONF(pad_name, st_reg, st_sft, st_wdt)			\
-	struct owl_st pad_name##_st_conf				\
-		= ST_CONF(st_reg, st_sft, st_wdt)
 
 /* PAD_PULLCTL0 */
 static PAD_PULLCTL_CONF(ETH_RXER, 0, 18, 2);
@@ -1639,34 +1554,6 @@ static PAD_ST_CONF(SPI0_SS, 1, 2, 1);
 static PAD_ST_CONF(I2S_BCLK0, 1, 1, 1);
 static PAD_ST_CONF(I2S_MCLK0, 1, 0, 1);
 
-#define PAD_INFO(name)							\
-	{								\
-		.pad = name,						\
-		.pullctl = NULL,					\
-		.st = NULL,						\
-	}
-
-#define PAD_INFO_ST(name)						\
-	{								\
-		.pad = name,						\
-		.pullctl = NULL,					\
-		.st = &name##_st_conf,					\
-	}
-
-#define PAD_INFO_PULLCTL(name)						\
-	{								\
-		.pad = name,						\
-		.pullctl = &name##_pullctl_conf,			\
-		.st = NULL,						\
-	}
-
-#define PAD_INFO_PULLCTL_ST(name)					\
-	{								\
-		.pad = name,						\
-		.pullctl = &name##_pullctl_conf,			\
-		.st = &name##_st_conf,					\
-	}
-
 /* Pad info table */
 static struct owl_padinfo s900_padinfo[NUM_PADS] = {
 	[ETH_TXD0] = PAD_INFO_ST(ETH_TXD0),
@@ -1821,27 +1708,13 @@ static struct owl_padinfo s900_padinfo[NUM_PADS] = {
 	[SGPIO3] = PAD_INFO_PULLCTL_ST(SGPIO3)
 };
 
-#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat,		\
-			_intc_ctl, _intc_pd, _intc_msk, _intc_type)	\
-	[OWL_GPIO_PORT_##port] = {					\
-		.offset = base,						\
-		.pins = count,						\
-		.outen = _outen,					\
-		.inen = _inen,						\
-		.dat = _dat,						\
-		.intc_ctl = _intc_ctl,					\
-		.intc_pd = _intc_pd,					\
-		.intc_msk = _intc_msk,					\
-		.intc_type = _intc_type,				\
-	}
-
 static const struct owl_gpio_port s900_gpio_ports[] = {
-	OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8, 0x204, 0x208, 0x20C, 0x240),
-	OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8, 0x534, 0x204, 0x208, 0x23C),
-	OWL_GPIO_PORT(C, 0x0018, 12, 0x0, 0x4, 0x8, 0x52C, 0x200, 0x204, 0x238),
-	OWL_GPIO_PORT(D, 0x0024, 30, 0x0, 0x4, 0x8, 0x524, 0x1FC, 0x200, 0x234),
-	OWL_GPIO_PORT(E, 0x0030, 32, 0x0, 0x4, 0x8, 0x51C, 0x1F8, 0x1FC, 0x230),
-	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8, 0x460, 0x140, 0x144, 0x178)
+	OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8, 0x204, 0x208, 0x20C, 0x240, 0),
+	OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8, 0x534, 0x204, 0x208, 0x23C, 0),
+	OWL_GPIO_PORT(C, 0x0018, 12, 0x0, 0x4, 0x8, 0x52C, 0x200, 0x204, 0x238, 0),
+	OWL_GPIO_PORT(D, 0x0024, 30, 0x0, 0x4, 0x8, 0x524, 0x1FC, 0x200, 0x234, 0),
+	OWL_GPIO_PORT(E, 0x0030, 32, 0x0, 0x4, 0x8, 0x51C, 0x1F8, 0x1FC, 0x230, 0),
+	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8, 0x460, 0x140, 0x144, 0x178, 0)
 };
 
 static struct owl_pinctrl_soc_data s900_pinctrl_data = {
-- 
2.17.2

