Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97CFECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795FF208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5Sblg6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795FF208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeIWUjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 16:39:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44970 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeIWUjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 16:39:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so17162949wro.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GP3JztH/Vwj4u0V6vJbUixpliHR0L20gPto8V5SbRFw=;
        b=A5Sblg6CLYqyrxIq4Z/lJ8RkWI1HlYY1fMTJBzGzt6WZVUcAiKoiinfDmPmcs6pm/m
         pLrNLFryThYOrrfHV/lpVhfFpBYu2kV07eldL+BAKiv6QKU2i067AujFv5f2sCjmBlMO
         UGJwnZis1lSaPaiUqj2dAl6LjLMrTV4AUuWIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GP3JztH/Vwj4u0V6vJbUixpliHR0L20gPto8V5SbRFw=;
        b=OJlo71AqdBq0ofWOEj2QX7GSThH/5bcqofx8eL1OZUvyXb9MQQnOoR+5Jf/c7sYbOp
         f59btDMs74j7MzzSpXgI4LD6pP1APmx3OfUTc9M23ZBFaMOQoeod3oGy6gowioxN0w4H
         A1VK44Vs4Bfmx6VrY3y9MQOVI2VAPfQtI4ZPEDQ7itiWpQQGM3QD89K+8zqwZb1NPkOM
         ZS8pftpoXCIvtpVFe6STJbXNGmN+BFswArlpPQZ9YrCshBa0MkcMo3kde7j+jaqr1/DD
         uvrAw/tImUX7Qmkbayc67SR4Bv5jNkppHmwKB8nDm/QnBEpXE1Xv6B6kHBFLf7V97Y3y
         OsjA==
X-Gm-Message-State: ABuFfogtpH+LLlKqJNKto0jb50GF5PCMnkTkPVvMrkS4y7rvxHHs2uBp
        F8IpImTlMkPQ9MFxGk7/80/uTw==
X-Google-Smtp-Source: ACcGV632bPjsQTTKujfZ3PwC9RIl5V0IWoJQVSvn7D+b3y3H0OuVrB5KvsJAfHzlcQ3Ilp2yUo/aSw==
X-Received: by 2002:adf:8447:: with SMTP id 65-v6mr4989684wrf.251.1537713697228;
        Sun, 23 Sep 2018 07:41:37 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id b189-v6sm12246917wmd.39.2018.09.23.07.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 07:41:36 -0700 (PDT)
Date:   Sun, 23 Sep 2018 15:41:34 +0100
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
Subject: Re: [PATCH V2 2/8] mfd: stpmic1: add stpmic1 driver
Message-ID: <20180923144134.GF11050@dell>
References: <1536325173-16617-1-git-send-email-p.paillet@st.com>
 <1536325173-16617-3-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536325173-16617-3-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Sep 2018, Pascal PAILLET-LME wrote:

> From: pascal paillet <p.paillet@st.com>

This is odd.  What is your reason for not using `git send-email`?

Also your name should really be capitalised.

  Pascal Paillet

> stpmic1 is a pmic from STMicroelectronics. The stpmic1 integrates 10

"STPMIC1" and "PMIC"

> regulators and 3 switches with various capabilities.

What about the Watchdog that I saw in the bindings?

> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v2:
> * the hardware component has been renamed from stpmu1 to stpmic1 !
> * Handle remarks from Enric
> * change headers
> * split binding description on another patch

Please use proper English grammar.

Capital letters at the start of sentences and for names of things, etc.

> On other mfd upstreamed by us (ST) we always get the remark to use 

MFD

> devm_of_platform_populate and not mfd_add_devices().
> MFD maintainers could you please clarify wich API I should here, thanks ?

You can use either depending on the use-case.

Here I think the former (first - devm_of_platform_populate) is better.

>  drivers/mfd/Kconfig         |  13 ++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/stpmic1.c       | 457 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stpmic1.h | 220 +++++++++++++++++++++
>  4 files changed, 691 insertions(+)
>  create mode 100644 drivers/mfd/stpmic1.c
>  create mode 100644 include/linux/mfd/stpmic1.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b860eb5..7984803 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1812,6 +1812,19 @@ config MFD_STM32_TIMERS
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
> +	  Support for STMicroelectronics STPMIC1 PMIC. Stpmic1 mfd driver is

"STPMIC MFD"

> +	  the core driver for stpmic1 component that mainly handles interrupts.

Same here.

> +	  To compile this driver as a module, choose M here: the
> +	  module will be called stpmic1.
> +
>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
>  
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index e9fd20d..b194929 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -220,6 +220,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
>  obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
>  
>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
> +obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
>  obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
>  
>  obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
> diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
> new file mode 100644
> index 0000000..ea0bff2
> --- /dev/null
> +++ b/drivers/mfd/stpmic1.c
> @@ -0,0 +1,457 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) STMicroelectronics 2018
> +// Author: Pascal Paillet <p.paillet@st.com> for STMicroelectronics.

You don't need to put "for STMicroelectronics", since you are an ST
employee.  This is something we agreed to use when upstreaming ST code
with our Linaro addresses.

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

'\n' here.

> +#include <dt-bindings/mfd/st,stpmic1.h>
> +
> +static bool stpmic1_reg_readable(struct device *dev, unsigned int reg);
> +static bool stpmic1_reg_writeable(struct device *dev, unsigned int reg);
> +static bool stpmic1_reg_volatile(struct device *dev, unsigned int reg);

This is a bad sign.  Why you need these forward declarations?

Best to reorder the functions instead.

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
> +#define FILL_IRQS(_index) \
> +	[(_index)] = { \
> +		.reg_offset = ((_index) >> 3), \
> +		.mask = (1 << (_index % 8)), \
> +	}

If you need this, then it is likely that others need it too.  Instead
of hand-rolling your own MACROs, please push it into the Regmap
subsystem.

> +static const struct regmap_irq stpmic1_irqs[] = {
> +	FILL_IRQS(IT_PONKEY_F),
> +	FILL_IRQS(IT_PONKEY_R),
> +	FILL_IRQS(IT_WAKEUP_F),
> +	FILL_IRQS(IT_WAKEUP_R),
> +	FILL_IRQS(IT_VBUS_OTG_F),
> +	FILL_IRQS(IT_VBUS_OTG_R),
> +	FILL_IRQS(IT_SWOUT_F),
> +	FILL_IRQS(IT_SWOUT_R),
> +
> +	FILL_IRQS(IT_CURLIM_BUCK1),
> +	FILL_IRQS(IT_CURLIM_BUCK2),
> +	FILL_IRQS(IT_CURLIM_BUCK3),
> +	FILL_IRQS(IT_CURLIM_BUCK4),
> +	FILL_IRQS(IT_OCP_OTG),
> +	FILL_IRQS(IT_OCP_SWOUT),
> +	FILL_IRQS(IT_OCP_BOOST),
> +	FILL_IRQS(IT_OVP_BOOST),
> +
> +	FILL_IRQS(IT_CURLIM_LDO1),
> +	FILL_IRQS(IT_CURLIM_LDO2),
> +	FILL_IRQS(IT_CURLIM_LDO3),
> +	FILL_IRQS(IT_CURLIM_LDO4),
> +	FILL_IRQS(IT_CURLIM_LDO5),
> +	FILL_IRQS(IT_CURLIM_LDO6),
> +	FILL_IRQS(IT_SHORT_SWOTG),
> +	FILL_IRQS(IT_SHORT_SWOUT),
> +
> +	FILL_IRQS(IT_TWARN_F),
> +	FILL_IRQS(IT_TWARN_R),
> +	FILL_IRQS(IT_VINLOW_F),
> +	FILL_IRQS(IT_VINLOW_R),
> +	FILL_IRQS(IT_SWIN_F),
> +	FILL_IRQS(IT_SWIN_R),
> +};
> +
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
> +
> +static int stpmic1_configure_from_dt(struct stpmic1_dev *pmic_dev)
> +{
> +	struct device_node *np = pmic_dev->np;
> +	u32 reg;
> +	int ret, irq;
> +
> +	irq = of_irq_get(np, 0);
> +	if (irq <= 0) {
> +		dev_err(pmic_dev->dev,

If you do:

struct device *dev = pmic_dev->dev

... above you can save yourself a line break.

> +			"Failed to get irq config: %d\n", irq);

Failed to get the config, or the IRQ?

Also should be "IRQ".

> +		return irq ?: -ENODEV;

Is 0 not a valid IRQ?  If not, what does it mean in this use-case?

> +	}
> +	pmic_dev->irq = irq;
> +
> +	irq = of_irq_get(np, 1);

Please define what '0' and '1' mean here.

> +	if (irq > 0)
> +		pmic_dev->irq_wake = irq;
> +	else
> +		pmic_dev->irq_wake = pmic_dev->irq;
> +
> +	device_init_wakeup(pmic_dev->dev, true);

'\n' here.

> +	ret = dev_pm_set_dedicated_wake_irq(pmic_dev->dev, pmic_dev->irq_wake);
> +	if (ret)
> +		dev_warn(pmic_dev->dev, "failed to set up wakeup irq");

"IRQ"

> +	if (!of_property_read_u32(np, "st,main-control-register", &reg)) {
> +		ret = regmap_update_bits(pmic_dev->regmap,
> +					 SWOFF_PWRCTRL_CR,
> +					 PWRCTRL_POLARITY_HIGH |
> +					 PWRCTRL_PIN_VALID |
> +					 RESTART_REQUEST_ENABLED,
> +					 reg);
> +		if (ret) {
> +			dev_err(pmic_dev->dev,
> +				"Failed to update main control register: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (!of_property_read_u32(np, "st,pads-pull-register", &reg)) {
> +		ret = regmap_update_bits(pmic_dev->regmap,
> +					 PADS_PULL_CR,
> +					 WAKEUP_DETECTOR_DISABLED |
> +					 PWRCTRL_PD_ACTIVE |
> +					 PWRCTRL_PU_ACTIVE |
> +					 WAKEUP_PD_ACTIVE,
> +					 reg);
> +		if (ret) {
> +			dev_err(pmic_dev->dev,
> +				"Failed to update pads control register: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (!of_property_read_u32(np, "st,vin-control-register", &reg)) {
> +		ret = regmap_update_bits(pmic_dev->regmap,
> +					 VBUS_DET_VIN_CR,
> +					 VINLOW_CTRL_REG_MASK,
> +					 reg);
> +		if (ret) {
> +			dev_err(pmic_dev->dev,
> +				"Failed to update vin control register: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (!of_property_read_u32(np, "st,usb-control-register", &reg)) {
> +		ret = regmap_update_bits(pmic_dev->regmap, BST_SW_CR,
> +					 BOOST_OVP_DISABLED |
> +					 VBUS_OTG_DETECTION_DISABLED |
> +					 SW_OUT_DISCHARGE |
> +					 VBUS_OTG_DISCHARGE |
> +					 OCP_LIMIT_HIGH,
> +					 reg);
> +		if (ret) {
> +			dev_err(pmic_dev->dev,
> +				"Failed to update usb control register: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int stpmic1_device_init(struct stpmic1_dev *pmic_dev)
> +{
> +	int ret;
> +	unsigned int val;
> +
> +	pmic_dev->regmap =
> +	    devm_regmap_init_i2c(pmic_dev->i2c, &stpmic1_regmap_config);
> +

Remove this line.

> +	if (IS_ERR(pmic_dev->regmap))
> +		return PTR_ERR(pmic_dev->regmap);
> +
> +	ret = stpmic1_configure_from_dt(pmic_dev);

You don't need all of these separate probe/init/setup functions if you;
a) always call them and b) call them only once from a single call-site.

If you *really* want to break-up probe() just pull out the DT stuff,
but in all honesty, I wouldn't worry about it.

> +	if (ret) {
> +		dev_err(pmic_dev->dev,
> +			"Unable to configure PMIC from Device Tree: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Read Version ID */
> +	ret = regmap_read(pmic_dev->regmap, VERSION_SR, &val);
> +	if (ret) {
> +		dev_err(pmic_dev->dev, "Unable to read pmic version\n");
> +		return ret;
> +	}
> +	dev_info(pmic_dev->dev, "PMIC Chip Version: 0x%x\n", val);
> +
> +	/* Initialize PMIC IRQ Chip & IRQ domains associated */
> +	ret = devm_regmap_add_irq_chip(pmic_dev->dev, pmic_dev->regmap,
> +				       pmic_dev->irq,
> +				       IRQF_ONESHOT | IRQF_SHARED,
> +				       0, &stpmic1_regmap_irq_chip,
> +				       &pmic_dev->irq_data);
> +	if (ret) {
> +		dev_err(pmic_dev->dev, "IRQ Chip registration failed: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int stpmic1_probe(struct i2c_client *i2c,
> +			 const struct i2c_device_id *id)
> +{
> +	struct stpmic1_dev *pmic;

Remove the "_dev" and instead of 'pmic' please use 'ddata'.

Although I don't see the point in having device data at all.  What do
you use it for besides passing to functions called from probe()?

> +	struct device *dev = &i2c->dev;
> +	int ret;
> +
> +	pmic = devm_kzalloc(dev, sizeof(struct stpmic1_dev), GFP_KERNEL);
> +	if (!pmic)
> +		return -ENOMEM;
> +
> +	pmic->np = dev->of_node;
> +
> +	dev_set_drvdata(dev, pmic);

Looks like either this or the i2c_get_clientdata() call is not
correct.  Have you tested suspend/resume?  I suggest you do not use
i2c_get_clientdata().

> +	pmic->dev = dev;
> +	pmic->i2c = i2c;
> +
> +	ret = stpmic1_device_init(pmic);
> +	if (ret)
> +		return ret;
> +
> +	return devm_of_platform_populate(pmic->dev);
> +}
> +
> +static const struct i2c_device_id stpmic1_id[] = {
> +	{ "stpmic1", 0 },

Why 0?

> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, stpmic1_id);
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int stpmic1_suspend(struct device *dev)
> +{
> +	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);

Should use to_i2c_client().

> +	struct stpmic1_dev *pmic_dev = i2c_get_clientdata(i2c);

How does this 'struct stpmic1_dev *' get into there?

Also, if you put it into dev->driver_data instead, it will save a few
lines.

> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(pmic_dev->irq_wake);
> +
> +	disable_irq(pmic_dev->irq);

'\n' here.

> +	return 0;
> +}
> +
> +static int stpmic1_resume(struct device *dev)
> +{
> +	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> +	struct stpmic1_dev *pmic_dev = i2c_get_clientdata(i2c);

As above.

> +	int ret;
> +
> +	ret = regcache_sync(pmic_dev->regmap);
> +	if (ret)
> +		return ret;
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(pmic_dev->irq_wake);
> +
> +	enable_irq(pmic_dev->irq);

'\n' here.

> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(stpmic1_pm, stpmic1_suspend, stpmic1_resume);
> +
> +static struct i2c_driver stpmic1_driver = {
> +	.driver = {
> +		   .name = "stpmic1",
> +		   .pm = &stpmic1_pm,
> +		   },

Odd tabbing.

> +	.probe = stpmic1_probe,
> +	.id_table = stpmic1_id,
> +};
> +
> +module_i2c_driver(stpmic1_driver);
> +
> +MODULE_DESCRIPTION("STPMIC1 PMIC Driver");
> +MODULE_AUTHOR("Pascal Paillet");

This normally contains an email address.

> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/stpmic1.h b/include/linux/mfd/stpmic1.h
> new file mode 100644
> index 0000000..024769d
> --- /dev/null
> +++ b/include/linux/mfd/stpmic1.h
> @@ -0,0 +1,220 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
> + * Author: Philippe Peurichard <philippe.peurichard@st.com>,
> + * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
> + */
> +
> +#ifndef __LINUX_MFD_STPMIC1_H
> +#define __LINUX_MFD_STPMIC1_H
> +
> +#define TURN_ON_SR		0x1
> +#define TURN_OFF_SR		0x2
> +#define ICC_LDO_TURN_OFF_SR	0x3
> +#define ICC_BUCK_TURN_OFF_SR	0x4
> +#define RREQ_STATE_SR		0x5
> +#define VERSION_SR		0x6
> +
> +#define SWOFF_PWRCTRL_CR	0x10
> +#define PADS_PULL_CR		0x11
> +#define BUCKS_PD_CR		0x12
> +#define LDO14_PD_CR		0x13
> +#define LDO56_VREF_PD_CR	0x14
> +#define VBUS_DET_VIN_CR		0x15
> +#define PKEY_TURNOFF_CR		0x16
> +#define BUCKS_MASK_RANK_CR	0x17
> +#define BUCKS_MASK_RESET_CR	0x18
> +#define LDOS_MASK_RANK_CR	0x19
> +#define LDOS_MASK_RESET_CR	0x1A
> +#define WCHDG_CR		0x1B
> +#define WCHDG_TIMER_CR		0x1C
> +#define BUCKS_ICCTO_CR		0x1D
> +#define LDOS_ICCTO_CR		0x1E
> +
> +#define BUCK1_ACTIVE_CR		0x20
> +#define BUCK2_ACTIVE_CR		0x21
> +#define BUCK3_ACTIVE_CR		0x22
> +#define BUCK4_ACTIVE_CR		0x23
> +#define VREF_DDR_ACTIVE_CR	0x24
> +#define LDO1_ACTIVE_CR		0x25
> +#define LDO2_ACTIVE_CR		0x26
> +#define LDO3_ACTIVE_CR		0x27
> +#define LDO4_ACTIVE_CR		0x28
> +#define LDO5_ACTIVE_CR		0x29
> +#define LDO6_ACTIVE_CR		0x2A
> +
> +#define BUCK1_STDBY_CR		0x30
> +#define BUCK2_STDBY_CR		0x31
> +#define BUCK3_STDBY_CR		0x32
> +#define BUCK4_STDBY_CR		0x33
> +#define VREF_DDR_STDBY_CR	0x34
> +#define LDO1_STDBY_CR		0x35
> +#define LDO2_STDBY_CR		0x36
> +#define LDO3_STDBY_CR		0x37
> +#define LDO4_STDBY_CR		0x38
> +#define LDO5_STDBY_CR		0x39
> +#define LDO6_STDBY_CR		0x3A
> +
> +#define BST_SW_CR		0x40
> +
> +#define INT_PENDING_R1		0x50
> +#define INT_PENDING_R2		0x51
> +#define INT_PENDING_R3		0x52
> +#define INT_PENDING_R4		0x53
> +
> +#define INT_DBG_LATCH_R1	0x60
> +#define INT_DBG_LATCH_R2	0x61
> +#define INT_DBG_LATCH_R3	0x62
> +#define INT_DBG_LATCH_R4	0x63
> +
> +#define INT_CLEAR_R1		0x70
> +#define INT_CLEAR_R2		0x71
> +#define INT_CLEAR_R3		0x72
> +#define INT_CLEAR_R4		0x73
> +
> +#define INT_MASK_R1		0x80
> +#define INT_MASK_R2		0x81
> +#define INT_MASK_R3		0x82
> +#define INT_MASK_R4		0x83
> +
> +#define INT_SET_MASK_R1		0x90
> +#define INT_SET_MASK_R2		0x91
> +#define INT_SET_MASK_R3		0x92
> +#define INT_SET_MASK_R4		0x93
> +
> +#define INT_CLEAR_MASK_R1	0xA0
> +#define INT_CLEAR_MASK_R2	0xA1
> +#define INT_CLEAR_MASK_R3	0xA2
> +#define INT_CLEAR_MASK_R4	0xA3
> +
> +#define INT_SRC_R1		0xB0
> +#define INT_SRC_R2		0xB1
> +#define INT_SRC_R3		0xB2
> +#define INT_SRC_R4		0xB3
> +
> +#define PMIC_MAX_REGISTER_ADDRESS INT_SRC_R4
> +
> +#define STPMIC1_PMIC_NUM_IRQ_REGS 4
> +
> +#define TURN_OFF_SR_ICC_EVENT	0x08
> +
> +#define LDO_VOLTAGE_MASK		GENMASK(6, 2)
> +#define BUCK_VOLTAGE_MASK		GENMASK(7, 2)
> +#define LDO_BUCK_VOLTAGE_SHIFT		2
> +
> +#define LDO_ENABLE_MASK			BIT(0)
> +#define BUCK_ENABLE_MASK		BIT(0)
> +
> +#define BUCK_HPLP_ENABLE_MASK		BIT(1)
> +#define BUCK_HPLP_SHIFT			1
> +
> +#define STDBY_ENABLE_MASK  BIT(0)
> +
> +#define BUCKS_PD_CR_REG_MASK	GENMASK(7, 0)
> +#define BUCK_MASK_RANK_REGISTER_MASK	GENMASK(3, 0)
> +#define BUCK_MASK_RESET_REGISTER_MASK	GENMASK(3, 0)
> +#define LDO1234_PULL_DOWN_REGISTER_MASK	GENMASK(7, 0)
> +#define LDO56_VREF_PD_CR_REG_MASK	GENMASK(5, 0)
> +#define LDO_MASK_RANK_REGISTER_MASK	GENMASK(5, 0)
> +#define LDO_MASK_RESET_REGISTER_MASK	GENMASK(5, 0)
> +
> +#define BUCK1_PULL_DOWN_REG		BUCKS_PD_CR
> +#define BUCK1_PULL_DOWN_MASK		BIT(0)
> +#define BUCK2_PULL_DOWN_REG		BUCKS_PD_CR
> +#define BUCK2_PULL_DOWN_MASK		BIT(2)
> +#define BUCK3_PULL_DOWN_REG		BUCKS_PD_CR
> +#define BUCK3_PULL_DOWN_MASK		BIT(4)
> +#define BUCK4_PULL_DOWN_REG		BUCKS_PD_CR
> +#define BUCK4_PULL_DOWN_MASK		BIT(6)
> +
> +#define LDO1_PULL_DOWN_REG		LDO14_PD_CR
> +#define LDO1_PULL_DOWN_MASK		BIT(0)
> +#define LDO2_PULL_DOWN_REG		LDO14_PD_CR
> +#define LDO2_PULL_DOWN_MASK		BIT(2)
> +#define LDO3_PULL_DOWN_REG		LDO14_PD_CR
> +#define LDO3_PULL_DOWN_MASK		BIT(4)
> +#define LDO4_PULL_DOWN_REG		LDO14_PD_CR
> +#define LDO4_PULL_DOWN_MASK		BIT(6)
> +#define LDO5_PULL_DOWN_REG		LDO56_VREF_PD_CR
> +#define LDO5_PULL_DOWN_MASK		BIT(0)
> +#define LDO6_PULL_DOWN_REG		LDO56_VREF_PD_CR
> +#define LDO6_PULL_DOWN_MASK		BIT(2)
> +#define VREF_DDR_PULL_DOWN_REG		LDO56_VREF_PD_CR
> +#define VREF_DDR_PULL_DOWN_MASK		BIT(4)
> +
> +#define BUCKS_ICCTO_CR_REG_MASK	GENMASK(6, 0)
> +#define LDOS_ICCTO_CR_REG_MASK	GENMASK(5, 0)
> +
> +#define LDO_BYPASS_MASK			BIT(7)
> +
> +/* Main PMIC Control Register
> + * SWOFF_PWRCTRL_CR
> + * Address : 0x10
> + */
> +#define ICC_EVENT_ENABLED		BIT(4)
> +#define PWRCTRL_POLARITY_HIGH		BIT(3)
> +#define PWRCTRL_PIN_VALID		BIT(2)
> +#define RESTART_REQUEST_ENABLED		BIT(1)
> +#define SOFTWARE_SWITCH_OFF_ENABLED	BIT(0)
> +
> +/* Main PMIC PADS Control Register
> + * PADS_PULL_CR
> + * Address : 0x11
> + */
> +#define WAKEUP_DETECTOR_DISABLED	BIT(4)
> +#define PWRCTRL_PD_ACTIVE		BIT(3)
> +#define PWRCTRL_PU_ACTIVE		BIT(2)
> +#define WAKEUP_PD_ACTIVE		BIT(1)
> +#define PONKEY_PU_ACTIVE		BIT(0)
> +
> +/* Main PMIC VINLOW Control Register
> + * VBUS_DET_VIN_CRC DMSC
> + * Address : 0x15
> + */
> +#define SWIN_DETECTOR_ENABLED		BIT(7)
> +#define SWOUT_DETECTOR_ENABLED		BIT(6)
> +#define VINLOW_ENABLED			BIT(0)
> +#define VINLOW_CTRL_REG_MASK		GENMASK(7, 0)
> +
> +/* USB Control Register
> + * Address : 0x40
> + */
> +#define BOOST_OVP_DISABLED		BIT(7)
> +#define VBUS_OTG_DETECTION_DISABLED	BIT(6)
> +#define SW_OUT_DISCHARGE		BIT(5)
> +#define VBUS_OTG_DISCHARGE		BIT(4)
> +#define OCP_LIMIT_HIGH			BIT(3)
> +#define SWIN_SWOUT_ENABLED		BIT(2)
> +#define USBSW_OTG_SWITCH_ENABLED	BIT(1)
> +#define BOOST_ENABLED			BIT(0)
> +
> +/* PKEY_TURNOFF_CR
> + * Address : 0x16
> + */
> +#define PONKEY_PWR_OFF			BIT(7)
> +#define PONKEY_CC_FLAG_CLEAR		BIT(6)
> +#define PONKEY_TURNOFF_TIMER_MASK	GENMASK(3, 0)
> +#define PONKEY_TURNOFF_MASK		GENMASK(7, 0)
> +
> +/*
> + * struct stpmic1_dev - stpmic1 master device for sub-drivers
> + * @dev: master device of the chip (can be used to access platform data)
> + * @i2c: i2c client private data for regulator
> + * @np: device DT node pointer
> + * @irq_base: base IRQ numbers
> + * @irq: generic IRQ number
> + * @irq_wake: wakeup IRQ number
> + * @regmap_irq_chip_data: irq chip data
> + */

What do you do with this?

I'm fairly sure not all of these attributes are required.

> +struct stpmic1_dev {
> +	struct device *dev;
> +	struct i2c_client *i2c;
> +	struct regmap *regmap;
> +	struct device_node *np;
> +	unsigned int irq_base;
> +	int irq;
> +	int irq_wake;
> +	struct regmap_irq_chip_data *irq_data;
> +};
> +
> +#endif /*  __LINUX_MFD_STPMIC1_H */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
