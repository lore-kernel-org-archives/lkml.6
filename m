Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB196ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4D220854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9yd8OuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4D220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbeGVRdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:33:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33642 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbeGVRdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:33:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id r24-v6so1387875wmh.0;
        Sun, 22 Jul 2018 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=laN5hL8Bp9A16KKPaVJ/f+bPiL5CVTlqeaM33vkbGVY=;
        b=n9yd8OuOs4MSzPldd1YKl7qFUZTIjqWYWddvQ1EZtnxUxaHa1hSpIuv+p5MV22fOZv
         OerssUVyZ3e+Sl60/ES/1AUY8Q1+o/i1AekkOHqkezkSQh5yyo+haOrHJhToduhvxAA8
         kWlrOC0I213FMtDidVz4ZGt7PlUKv5zRmZUW06SeEATH88pMhaQsHGQUasX7VUu3EOUu
         zL5h92PRyHaHQdMxwH1IlR3gPm3shvwhKeAusbNo/lRI/dmStvVqFK2UDRSCTshRZAcA
         ejK0n31tdLSbra/HTagXAwxPoK5PvrH4gw4/nqqDXXmLCg0bWqB57KPy0zCTcMEwOvLw
         ZWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=laN5hL8Bp9A16KKPaVJ/f+bPiL5CVTlqeaM33vkbGVY=;
        b=URmC7+JGl17+fvrJFFf1WNrw+Vjq/zlItTeN9gHRqi+fsCcnbsgdyQSKfXjpbENMHG
         VNuxRQdLOjdfgCrxBppOqWVepd8f4dB9uSyKXhd/cd0TpHK7dKbKhw6b46uk6Xd47bF7
         VlEg9pGr+9c8DPtKJ8JJGugHQYsXHRavOuOt4TzpFbgWegtKP3r4yrf1tM9cTIFz/z+0
         sAW/LkcNAavIDkPDhVV5YqYMKPGRUa77cAhjMvFh4dMxnCjcB52AhQBvBnkCn2OtpB9e
         hF9APTbxz3mRYxvjGepaXIrdCCwBYdoWxZHo+GUFObm7wLxujofSDXICkUxfZ4wP7aEd
         +ddA==
X-Gm-Message-State: AOUpUlH4qGLzjpBJvL010B9oHT6dCnoG8BtXt6Cnd+YVhgBmj5PC+4NQ
        QZfhM3gTtLkUmS8NlUTlqTc=
X-Google-Smtp-Source: AAOMgpepwjJMg9wPrMd9+ZbbfSBdTFGJDZKX+wE0HvbcEu0pzGCtVAOd3CYfGFNVbZWSTaYYi1lmHw==
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr5393873wmd.144.1532277377308;
        Sun, 22 Jul 2018 09:36:17 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.37.46])
        by smtp.gmail.com with ESMTPSA id z8-v6sm15195653wrp.54.2018.07.22.09.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 09:36:16 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH 1/5] pinctrl: actions: define constructor generic to Actions Semi SoC's
Date:   Sun, 22 Jul 2018 18:35:57 +0200
Message-Id: <20180722163601.28346-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722163601.28346-1-sravanhome@gmail.com>
References: <20180722163601.28346-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing constructor defined in S900 is reused generic
for all Actions Semi SoC's.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/pinctrl/actions/pinctrl-owl.h  | 124 +++++++++++++++++++++++++
 drivers/pinctrl/actions/pinctrl-s900.c | 122 ------------------------
 2 files changed, 124 insertions(+), 122 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
index 74342378937c..42635366e68f 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.h
+++ b/drivers/pinctrl/actions/pinctrl-owl.h
@@ -15,6 +15,130 @@
 #define OWL_PINCONF_SLEW_SLOW 0
 #define OWL_PINCONF_SLEW_FAST 1
 
+#define OWL_GPIO_PORT_A		0
+#define OWL_GPIO_PORT_B		1
+#define OWL_GPIO_PORT_C		2
+#define OWL_GPIO_PORT_D		3
+#define OWL_GPIO_PORT_E		4
+#define OWL_GPIO_PORT_F		5
+
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
+#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat)	\
+	[OWL_GPIO_PORT_##port] = {				\
+		.offset = base,					\
+		.pins = count,					\
+		.outen = _outen,				\
+		.inen = _inen,					\
+		.dat = _dat,					\
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
 enum owl_pinconf_pull {
 	OWL_PINCONF_PULL_HIZ,
 	OWL_PINCONF_PULL_DOWN,
diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
index 5503c7945764..baa2f4847418 100644
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
@@ -1821,15 +1708,6 @@ static struct owl_padinfo s900_padinfo[NUM_PADS] = {
 	[SGPIO3] = PAD_INFO_PULLCTL_ST(SGPIO3)
 };
 
-#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat)	\
-	[OWL_GPIO_PORT_##port] = {				\
-		.offset = base,					\
-		.pins = count,					\
-		.outen = _outen,				\
-		.inen = _inen,					\
-		.dat = _dat,					\
-	}
-
 static const struct owl_gpio_port s900_gpio_ports[] = {
 	OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8),
 	OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8),
-- 
2.18.0

