Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBEAC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C06D20824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pbia4ZTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C06D20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeJYTyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:54:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56241 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJYTyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:54:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id s10-v6so1139867wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CfiSXINxS7iQon6FMXiKae/IUs50QkPeKQ5sCMX04DY=;
        b=Pbia4ZTnLhw6PFgG6IMQ1RgvuKHLB29eibU+kgx+NaC3WtT03Jed3h0BH9bhgxvtzr
         oQPWIhBRAF1tK9Q3DYWxYrtyYzQV7qC63AiAuCGRCPz4KYTkD/VVuPQa9MGwnaMHjM5l
         xdHaiWNpbegq5XgHb8yN0Efy3lWP8pitIMLUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CfiSXINxS7iQon6FMXiKae/IUs50QkPeKQ5sCMX04DY=;
        b=ldi9FGEwzJaF40lqtPN+3c314XC8j3RtsQXHV520KW5E1of3hH1JfcgSHN5XggduIA
         4nkGpZlxGcNsdh9dRHV0sJeTw23066dJlosv7iDtVzs58GDflY4OBDV3Fc7lCAdx9Uh9
         iyosCm+FK3iNuDKjVNAAniNrN/MLfs0fCRXXd/NtLDkI4/Gfly1BCAieigraS94TVZ6F
         L/zsCuxBQG9U6BkrMrXMnzKUQYlY3Y7bomEQV1nkYcoBTMj0YRCiiTkSDxp1M5Su7mDv
         fynTujg6vD4JiPbranXVl2A0YSd+5qyfRl+b5/Z8a/tLP+im8EeChfPHNIEQZhLtzkbL
         +Tdg==
X-Gm-Message-State: AGRZ1gKWTQLY3AeGrC3863uvEIBwRHplfKr19khyjDvqqTF98Vr3qjz/
        rbkMuKnnGmuXR99IIYi+F/UWbA==
X-Google-Smtp-Source: AJdET5dfeBg8AAJiJcAgJ8WcD4wdEWVoF//4CS5HDpgc7zuJm3nYPCnljnh7+xns01NxUOKW9pVxHw==
X-Received: by 2002:a1c:9c84:: with SMTP id f126-v6mr1421959wme.8.1540466519238;
        Thu, 25 Oct 2018 04:21:59 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id t198-v6sm1320890wmd.9.2018.10.25.04.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 04:21:58 -0700 (PDT)
Date:   Thu, 25 Oct 2018 12:21:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
Subject: Re: [PATCH v4 2/8] mfd: stpmic1: add stpmic1 driver
Message-ID: <20181025112156.GB4870@dell>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-3-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1539853324-29051-3-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018, Pascal PAILLET-LME wrote:

> From: pascal paillet <p.paillet@st.com>
> 
> stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10
> regulators , 3 switches, a watchdog and an input for a power on key.

Same comments as for the DT binding patch.

> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v4:
> * rename PONKEY_PU_ACTIVE to PONKEY_PU_INACTIVE
> 
>  drivers/mfd/Kconfig         |  13 ++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/stpmic1.c       | 401 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stpmic1.h | 212 +++++++++++++++++++++++
>  4 files changed, 627 insertions(+)
>  create mode 100644 drivers/mfd/stpmic1.c
>  create mode 100644 include/linux/mfd/stpmic1.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 11841f4..b8dabc7 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1855,6 +1855,19 @@ config MFD_STM32_TIMERS
>  	  for PWM and IIO Timer. This driver allow to share the
>  	  registers between the others drivers.
>  
> +config MFD_STPMIC1
> +	tristate "Support for STPMIC1 PMIC"
> +	depends on (I2C=y && OF)
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	select MFD_CORE
> +	help
> +	  Support for ST Microelectronics STPMIC1 PMIC. STPMIC1 MFD driver is

Remove 'MFD' and replace with something else.

MFD is not a real thing.  It's a Linuxisum.

> +	  the core driver for STPMIC1 component that mainly handles interrupts.

You need to document what the child devices are.

> +	  To compile this driver as a module, choose M here: the
> +	  module will be called stpmic1.
> +
>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
>  
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 5856a94..76fff14 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -232,6 +232,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
>  obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
>  
>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
> +obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
>  obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
>  
>  obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
> diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
> new file mode 100644
> index 0000000..90dfee4
> --- /dev/null
> +++ b/drivers/mfd/stpmic1.c
> @@ -0,0 +1,401 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) STMicroelectronics 2018

'\n' here.

> +// Author: Pascal Paillet <p.paillet@st.com>
> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/stpmic1.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_wakeirq.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/mfd/st,stpmic1.h>
> +
> +#define STPMIC1_MAIN_IRQ 0
> +#define STPMIC1_WAKEUP_IRQ 1
> +
> +static bool stpmic1_reg_readable(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case TURN_ON_SR:
> +	case TURN_OFF_SR:
> +	case ICC_LDO_TURN_OFF_SR:
> +	case ICC_BUCK_TURN_OFF_SR:
> +	case RREQ_STATE_SR:
> +	case VERSION_SR:
> +	case SWOFF_PWRCTRL_CR:
> +	case PADS_PULL_CR:
> +	case BUCKS_PD_CR:
> +	case LDO14_PD_CR:
> +	case LDO56_VREF_PD_CR:
> +	case VBUS_DET_VIN_CR:
> +	case PKEY_TURNOFF_CR:
> +	case BUCKS_MASK_RANK_CR:
> +	case BUCKS_MASK_RESET_CR:
> +	case LDOS_MASK_RANK_CR:
> +	case LDOS_MASK_RESET_CR:
> +	case WCHDG_CR:
> +	case WCHDG_TIMER_CR:
> +	case BUCKS_ICCTO_CR:
> +	case LDOS_ICCTO_CR:
> +	case BUCK1_ACTIVE_CR:
> +	case BUCK2_ACTIVE_CR:
> +	case BUCK3_ACTIVE_CR:
> +	case BUCK4_ACTIVE_CR:
> +	case VREF_DDR_ACTIVE_CR:
> +	case LDO1_ACTIVE_CR:
> +	case LDO2_ACTIVE_CR:
> +	case LDO3_ACTIVE_CR:
> +	case LDO4_ACTIVE_CR:
> +	case LDO5_ACTIVE_CR:
> +	case LDO6_ACTIVE_CR:
> +	case BUCK1_STDBY_CR:
> +	case BUCK2_STDBY_CR:
> +	case BUCK3_STDBY_CR:
> +	case BUCK4_STDBY_CR:
> +	case VREF_DDR_STDBY_CR:
> +	case LDO1_STDBY_CR:
> +	case LDO2_STDBY_CR:
> +	case LDO3_STDBY_CR:
> +	case LDO4_STDBY_CR:
> +	case LDO5_STDBY_CR:
> +	case LDO6_STDBY_CR:
> +	case BST_SW_CR:
> +	case INT_PENDING_R1:
> +	case INT_PENDING_R2:
> +	case INT_PENDING_R3:
> +	case INT_PENDING_R4:
> +	case INT_DBG_LATCH_R1:
> +	case INT_DBG_LATCH_R2:
> +	case INT_DBG_LATCH_R3:
> +	case INT_DBG_LATCH_R4:
> +	case INT_CLEAR_R1:
> +	case INT_CLEAR_R2:
> +	case INT_CLEAR_R3:
> +	case INT_CLEAR_R4:
> +	case INT_MASK_R1:
> +	case INT_MASK_R2:
> +	case INT_MASK_R3:
> +	case INT_MASK_R4:
> +	case INT_SET_MASK_R1:
> +	case INT_SET_MASK_R2:
> +	case INT_SET_MASK_R3:
> +	case INT_SET_MASK_R4:
> +	case INT_CLEAR_MASK_R1:
> +	case INT_CLEAR_MASK_R2:
> +	case INT_CLEAR_MASK_R3:
> +	case INT_CLEAR_MASK_R4:
> +	case INT_SRC_R1:
> +	case INT_SRC_R2:
> +	case INT_SRC_R3:
> +	case INT_SRC_R4:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool stpmic1_reg_writeable(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case SWOFF_PWRCTRL_CR:
> +	case PADS_PULL_CR:
> +	case BUCKS_PD_CR:
> +	case LDO14_PD_CR:
> +	case LDO56_VREF_PD_CR:
> +	case VBUS_DET_VIN_CR:
> +	case PKEY_TURNOFF_CR:
> +	case BUCKS_MASK_RANK_CR:
> +	case BUCKS_MASK_RESET_CR:
> +	case LDOS_MASK_RANK_CR:
> +	case LDOS_MASK_RESET_CR:
> +	case WCHDG_CR:
> +	case WCHDG_TIMER_CR:
> +	case BUCKS_ICCTO_CR:
> +	case LDOS_ICCTO_CR:
> +	case BUCK1_ACTIVE_CR:
> +	case BUCK2_ACTIVE_CR:
> +	case BUCK3_ACTIVE_CR:
> +	case BUCK4_ACTIVE_CR:
> +	case VREF_DDR_ACTIVE_CR:
> +	case LDO1_ACTIVE_CR:
> +	case LDO2_ACTIVE_CR:
> +	case LDO3_ACTIVE_CR:
> +	case LDO4_ACTIVE_CR:
> +	case LDO5_ACTIVE_CR:
> +	case LDO6_ACTIVE_CR:
> +	case BUCK1_STDBY_CR:
> +	case BUCK2_STDBY_CR:
> +	case BUCK3_STDBY_CR:
> +	case BUCK4_STDBY_CR:
> +	case VREF_DDR_STDBY_CR:
> +	case LDO1_STDBY_CR:
> +	case LDO2_STDBY_CR:
> +	case LDO3_STDBY_CR:
> +	case LDO4_STDBY_CR:
> +	case LDO5_STDBY_CR:
> +	case LDO6_STDBY_CR:
> +	case BST_SW_CR:
> +	case INT_DBG_LATCH_R1:
> +	case INT_DBG_LATCH_R2:
> +	case INT_DBG_LATCH_R3:
> +	case INT_DBG_LATCH_R4:
> +	case INT_CLEAR_R1:
> +	case INT_CLEAR_R2:
> +	case INT_CLEAR_R3:
> +	case INT_CLEAR_R4:
> +	case INT_SET_MASK_R1:
> +	case INT_SET_MASK_R2:
> +	case INT_SET_MASK_R3:
> +	case INT_SET_MASK_R4:
> +	case INT_CLEAR_MASK_R1:
> +	case INT_CLEAR_MASK_R2:
> +	case INT_CLEAR_MASK_R3:
> +	case INT_CLEAR_MASK_R4:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool stpmic1_reg_volatile(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case TURN_ON_SR:
> +	case TURN_OFF_SR:
> +	case ICC_LDO_TURN_OFF_SR:
> +	case ICC_BUCK_TURN_OFF_SR:
> +	case RREQ_STATE_SR:
> +	case INT_PENDING_R1:
> +	case INT_PENDING_R2:
> +	case INT_PENDING_R3:
> +	case INT_PENDING_R4:
> +	case INT_SRC_R1:
> +	case INT_SRC_R2:
> +	case INT_SRC_R3:
> +	case INT_SRC_R4:
> +	case WCHDG_CR:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

Can you use ranges for all of these?

> +const struct regmap_config stpmic1_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_RBTREE,
> +	.max_register = PMIC_MAX_REGISTER_ADDRESS,
> +	.readable_reg = stpmic1_reg_readable,
> +	.writeable_reg = stpmic1_reg_writeable,
> +	.volatile_reg = stpmic1_reg_volatile,
> +};
> +
> +static const struct regmap_irq stpmic1_irqs[] = {
> +	[IT_PONKEY_F]		= { .mask = 0x01 },
> +	[IT_PONKEY_R]		= { .mask = 0x02 },
> +	[IT_WAKEUP_F]		= { .mask = 0x04 },
> +	[IT_WAKEUP_R]		= { .mask = 0x08 },
> +	[IT_VBUS_OTG_F]		= { .mask = 0x10 },
> +	[IT_VBUS_OTG_R]		= { .mask = 0x20 },
> +	[IT_SWOUT_F]		= { .mask = 0x40 },
> +	[IT_SWOUT_R]		= { .mask = 0x80 },
> +
> +	[IT_CURLIM_BUCK1]	= { .reg_offset = 1, .mask = 0x01 },
> +	[IT_CURLIM_BUCK2]	= { .reg_offset = 1, .mask = 0x02 },
> +	[IT_CURLIM_BUCK3]	= { .reg_offset = 1, .mask = 0x04 },
> +	[IT_CURLIM_BUCK4]	= { .reg_offset = 1, .mask = 0x08 },
> +	[IT_OCP_OTG]		= { .reg_offset = 1, .mask = 0x10 },
> +	[IT_OCP_SWOUT]		= { .reg_offset = 1, .mask = 0x20 },
> +	[IT_OCP_BOOST]		= { .reg_offset = 1, .mask = 0x40 },
> +	[IT_OVP_BOOST]		= { .reg_offset = 1, .mask = 0x80 },
> +
> +	[IT_CURLIM_LDO1]	= { .reg_offset = 2, .mask = 0x01 },
> +	[IT_CURLIM_LDO2]	= { .reg_offset = 2, .mask = 0x02 },
> +	[IT_CURLIM_LDO3]	= { .reg_offset = 2, .mask = 0x04 },
> +	[IT_CURLIM_LDO4]	= { .reg_offset = 2, .mask = 0x08 },
> +	[IT_CURLIM_LDO5]	= { .reg_offset = 2, .mask = 0x10 },
> +	[IT_CURLIM_LDO6]	= { .reg_offset = 2, .mask = 0x20 },
> +	[IT_SHORT_SWOTG]	= { .reg_offset = 2, .mask = 0x40 },
> +	[IT_SHORT_SWOUT]	= { .reg_offset = 2, .mask = 0x80 },
> +
> +	[IT_TWARN_F]		= { .reg_offset = 3, .mask = 0x01 },
> +	[IT_TWARN_R]		= { .reg_offset = 3, .mask = 0x02 },
> +	[IT_VINLOW_F]		= { .reg_offset = 3, .mask = 0x04 },
> +	[IT_VINLOW_R]		= { .reg_offset = 3, .mask = 0x08 },
> +	[IT_SWIN_F]		= { .reg_offset = 3, .mask = 0x40 },
> +	[IT_SWIN_R]		= { .reg_offset = 3, .mask = 0x80 },
> +};

There should be a MACRO for doing this.

If there isn't, you should author one and put it in the Regmap header.

> +static const struct regmap_irq_chip stpmic1_regmap_irq_chip = {
> +	.name = "pmic_irq",
> +	.status_base = INT_PENDING_R1,
> +	.mask_base = INT_CLEAR_MASK_R1,
> +	.unmask_base = INT_SET_MASK_R1,
> +	.ack_base = INT_CLEAR_R1,
> +	.num_regs = STPMIC1_PMIC_NUM_IRQ_REGS,
> +	.irqs = stpmic1_irqs,
> +	.num_irqs = ARRAY_SIZE(stpmic1_irqs),
> +};
> +
> +static int stpmic1_probe(struct i2c_client *i2c,
> +			 const struct i2c_device_id *id)
> +{
> +	struct stpmic1 *ddata;
> +	struct device *dev = &i2c->dev;
> +	int ret;
> +	struct device_node *np = dev->of_node;
> +	u32 reg;
> +
> +	ddata = devm_kzalloc(dev, sizeof(struct stpmic1), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, ddata);
> +	ddata->dev = dev;
> +
> +	ddata->regmap = devm_regmap_init_i2c(i2c, &stpmic1_regmap_config);
> +	if (IS_ERR(ddata->regmap))
> +		return PTR_ERR(ddata->regmap);
> +
> +	ddata->irq = of_irq_get(np, STPMIC1_MAIN_IRQ);
> +	if (ddata->irq < 0) {
> +		dev_err(dev, "Failed to get main IRQ: %d\n", ddata->irq);
> +		return ddata->irq;
> +	}
> +
> +	if (!of_property_read_u32(np, "st,main-control-register", &reg)) {

I'm still waiting on feedback from Rob as to whether this is
acceptable.  I suggest that it isn't.

> +		ret = regmap_update_bits(ddata->regmap,
> +					 SWOFF_PWRCTRL_CR,
> +					 PWRCTRL_POLARITY_HIGH |
> +					 PWRCTRL_PIN_VALID |
> +					 RESTART_REQUEST_ENABLED,
> +					 reg);
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed to update main control register: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	/* Read Version ID */
> +	ret = regmap_read(ddata->regmap, VERSION_SR, &reg);
> +	if (ret) {
> +		dev_err(dev, "Unable to read pmic version\n");

"PMIC"

> +		return ret;
> +	}
> +	dev_info(dev, "PMIC Chip Version: 0x%x\n", reg);

[...]

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
