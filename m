Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeBSR3W (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:29:22 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41201 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbeBSR3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:29:19 -0500
X-Google-Smtp-Source: AH8x227zzrwve4Sq/5OCiJfuzG/hmihlXHcFpgU01EeqpTzN8+yviZ1wcudddDAWAJPAdckJyYkOrw==
Date: Mon, 19 Feb 2018 22:59:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: linus.walleij@linaro.org, robh+dt@kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] pinctrl: actions: Add Actions S900 pinctrl driver
Message-ID: <20180219172909.ph26jjihypnsxv25@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-5-manivannan.sadhasivam@linaro.org>
 <086c080d-6d2d-6922-1cf3-1b1fbe028b0e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <086c080d-6d2d-6922-1cf3-1b1fbe028b0e@suse.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,
On Sat, Feb 17, 2018 at 10:41:48PM +0100, Andreas Färber wrote:
> Am 17.02.2018 um 21:44 schrieb Manivannan Sadhasivam:
> > Add pinctrl driver for Actions Semi S900 SoC. The driver supports
> > pinctrl, pinmux and pinconf functionalities through a range of registers
> > common to both gpio driver and pinctrl driver.
> > 
> > Pinmux functionality is available only for the pin groups while the
> > pinconf functionality is available for both pin groups and individual
> > pins.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pinctrl/Kconfig                |    1 +
> >  drivers/pinctrl/Makefile               |    1 +
> >  drivers/pinctrl/actions/Kconfig        |   12 +
> >  drivers/pinctrl/actions/Makefile       |    2 +
> >  drivers/pinctrl/actions/pinctrl-owl.c  |  573 ++++++++
> >  drivers/pinctrl/actions/pinctrl-owl.h  |  178 +++
> >  drivers/pinctrl/actions/pinctrl-s900.c | 2536 ++++++++++++++++++++++++++++++++
> >  7 files changed, 3303 insertions(+)
> >  create mode 100644 drivers/pinctrl/actions/Kconfig
> >  create mode 100644 drivers/pinctrl/actions/Makefile
> >  create mode 100644 drivers/pinctrl/actions/pinctrl-owl.c
> >  create mode 100644 drivers/pinctrl/actions/pinctrl-owl.h
> >  create mode 100644 drivers/pinctrl/actions/pinctrl-s900.c
> > 
> > diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> > index 0f254b35c378..838c8fff8c24 100644
> > --- a/drivers/pinctrl/Kconfig
> > +++ b/drivers/pinctrl/Kconfig
> > @@ -368,6 +368,7 @@ config PINCTRL_OCELOT
> >  	select GENERIC_PINMUX_FUNCTIONS
> >  	select REGMAP_MMIO
> >  
> > +source "drivers/pinctrl/actions/Kconfig"
> >  source "drivers/pinctrl/aspeed/Kconfig"
> >  source "drivers/pinctrl/bcm/Kconfig"
> >  source "drivers/pinctrl/berlin/Kconfig"
> > diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> > index d3692633e9ed..bf41d2484a44 100644
> > --- a/drivers/pinctrl/Makefile
> > +++ b/drivers/pinctrl/Makefile
> > @@ -48,6 +48,7 @@ obj-$(CONFIG_PINCTRL_INGENIC)	+= pinctrl-ingenic.o
> >  obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
> >  obj-$(CONFIG_PINCTRL_OCELOT)	+= pinctrl-ocelot.o
> >  
> > +obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
> 
> Here you require CONFIG_ARCH_ACTIONS ...
> 
How about making this as obj-y and having separate
CONFIG_PINCTRL_OWL and CONFIG_PINCTRL_S900 options in platform
makefile?
> >  obj-$(CONFIG_ARCH_ASPEED)	+= aspeed/
> >  obj-y				+= bcm/
> >  obj-$(CONFIG_PINCTRL_BERLIN)	+= berlin/
> > diff --git a/drivers/pinctrl/actions/Kconfig b/drivers/pinctrl/actions/Kconfig
> > new file mode 100644
> > index 000000000000..6075909d04e9
> > --- /dev/null
> > +++ b/drivers/pinctrl/actions/Kconfig
> > @@ -0,0 +1,12 @@
> > +config PINCTRL_OWL
> > +        bool
> 
> Indentation.
> 
Ack.
> > +	depends on (ARCH_ACTIONS || COMPILE_TEST) && OF
> 
> ... so || COMPILE_TEST becomes moot.
> 
> Use CONFIG_PINCTRL_OWL in Makefile instead?
> 
Yes, as said above.
> > +	select PINMUX
> > +	select PINCONF
> > +	select GENERIC_PINCONF
> > +
> > +config PINCTRL_S900
> > +	bool "Actions Semi S900 pinctrl driver"
> > +	select PINCTRL_OWL
> > +	help
> > +	  Say Y here to enable Actions S900 pinctrl driver
> 
> Repeating the shortened name does not seem too helpful?
> 
Okay. Will make Actions Semi S900 everywhere.
> > diff --git a/drivers/pinctrl/actions/Makefile b/drivers/pinctrl/actions/Makefile
> > new file mode 100644
> > index 000000000000..bd232d28400f
> > --- /dev/null
> > +++ b/drivers/pinctrl/actions/Makefile
> > @@ -0,0 +1,2 @@
> > +obj-$(CONFIG_PINCTRL_OWL)	+= pinctrl-owl.o
> > +obj-$(CONFIG_PINCTRL_S900) 	+= pinctrl-s900.o
> > diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
> > new file mode 100644
> > index 000000000000..7ed8625c30f3
> > --- /dev/null
> > +++ b/drivers/pinctrl/actions/pinctrl-owl.c
> > @@ -0,0 +1,573 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * OWL SoC's Pinctrl driver
> > + *
> > + * Copyright (c) 2014 Actions Semi Inc.
> > + * Author: David Liu <liuwei@actions-semi.com>
> > + *
> > + * Copyright (c) 2018 Linaro Ltd.
> > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pinctrl/machine.h>
> > +#include <linux/pinctrl/pinctrl.h>
> > +#include <linux/pinctrl/pinmux.h>
> > +#include <linux/pinctrl/pinconf.h>
> > +#include <linux/pinctrl/pinconf-generic.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +
> > +#include "../core.h"
> > +#include "../pinctrl-utils.h"
> > +#include "pinctrl-owl.h"
> > +
> > +/**
> > + * struct owl_pinctrl - pinctrl state of the device
> > + * @dev: device handle
> > + * @pctrldev: pinctrl handle
> > + * @lock: spinlock to protect registers
> > + * @soc: reference to soc_data
> > + * @base: pinctrl register base address
> > + */
> > +struct owl_pinctrl {
> > +	struct device *dev;
> > +	struct pinctrl_dev *pctrldev;
> > +	raw_spinlock_t lock;
> > +	struct clk *clk;
> > +	const struct owl_pinctrl_soc_data *soc;
> > +	void __iomem *base;
> > +};
> > +
> > +static int owl_get_groups_count(struct pinctrl_dev *pctrldev)
> > +{
> > +	struct owl_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrldev);
> > +
> > +	return pctrl->soc->ngroups;
> > +}
> > +
> > +static const char *owl_get_group_name(struct pinctrl_dev *pctrldev,
> > +				unsigned int group)
> > +{
> > +	struct owl_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrldev);
> > +
> > +	return pctrl->soc->groups[group].name;
> > +}
> > +
> > +static int owl_get_group_pins(struct pinctrl_dev *pctrldev,
> > +				unsigned int group,
> > +				const unsigned int **pins,
> > +				unsigned int *num_pins)
> > +{
> > +	struct owl_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrldev);
> > +
> > +	*pins = pctrl->soc->groups[group].pads;
> > +	*num_pins = pctrl->soc->groups[group].npads;
> > +
> > +	return 0;
> > +}
> > +
> > +static void owl_pin_dbg_show(struct pinctrl_dev *pctrldev,
> > +				struct seq_file *s,
> > +				unsigned int offset)
> > +{
> > +	struct owl_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrldev);
> > +
> > +	seq_printf(s, "%s", dev_name(pctrl->dev));
> > +}
> > +
> > +static struct pinctrl_ops owl_pinctrl_ops = {
> > +	.get_groups_count = owl_get_groups_count,
> > +	.get_group_name = owl_get_group_name,
> > +	.get_group_pins = owl_get_group_pins,
> > +	.pin_dbg_show = owl_pin_dbg_show,
> > +	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
> > +	.dt_free_map = pinctrl_utils_free_map,
> > +};
> > +
> > +static int owl_get_funcs_count(struct pinctrl_dev *pctrldev)
> > +{
> > +	struct owl_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrldev);
> > +
> > +	return pctrl->soc->nfunctions;
> > +}
> > +
> > +static const char *owl_get_func_name(struct pinctrl_dev *pctrldev,
> > +				unsigned int function)
> > +{
> > +	struct owl_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrldev);
> > +
> > +	return pctrl->soc->functions[function].name;
> > +}
> > +
> > +static int owl_get_func_groups(struct pinctrl_dev *pctrldev,
> > +				unsigned int function,
> > +				const char * const **groups,
> > +				unsigned int * const num_groups)
> > +{
> > +	struct owl_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrldev);
> > +
> > +	*groups = pctrl->soc->functions[function].groups;
> > +	*num_groups = pctrl->soc->functions[function].ngroups;
> > +
> > +	return 0;
> > +}
> > +
> > +static inline int get_group_mfp_mask_val(const struct owl_pingroup *g,
> > +				int function,
> > +				u32 *mask,
> > +				u32 *val)
> > +{
> > +	int id;
> > +	u32 option_num;
> > +	u32 option_mask;
> > +
> > +	for (id = 0; id < g->nfuncs; id++) {
> > +		if (g->funcs[id] == function)
> > +			break;
> > +	}
> > +	if (WARN_ON(id == g->nfuncs))
> > +		return -EINVAL;
> > +
> > +	option_num = (1 << g->mfpctl_width);
> > +	if (id > option_num)
> > +		id -= option_num;
> > +
> > +	option_mask = option_num - 1;
> > +	*mask = (option_mask  << g->mfpctl_shift);
> > +	*val = (id << g->mfpctl_shift);
> > +
> > +	return 0;
> > +}
> > +
> > +static int owl_set_mux(struct pinctrl_dev *pctrldev,
> > +				unsigned int function,
> > +				unsigned int group)
> > +{
> > +	struct owl_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrldev);
> > +	const struct owl_pingroup *g;
> > +	unsigned long flags;
> > +	u32 val, mask, mfpval;
> > +
> > +	g = &pctrl->soc->groups[group];
> > +
> > +	if (get_group_mfp_mask_val(g, function, &mask, &val))
> > +		return -EINVAL;
> > +
> > +	raw_spin_lock_irqsave(&pctrl->lock, flags);
> > +
> > +	mfpval = readl(pctrl->base + g->mfpctl_reg);
> > +	mfpval &= ~mask;
> > +	mfpval |= val;
> > +	writel(mfpval, pctrl->base + g->mfpctl_reg);
> > +
> > +	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct pinmux_ops owl_pinmux_ops = {
> > +	.get_functions_count = owl_get_funcs_count,
> > +	.get_function_name = owl_get_func_name,
> > +	.get_function_groups = owl_get_func_groups,
> > +	.set_mux = owl_set_mux,
> > +};
> > +
> > +static int owl_pad_pinconf_reg(const struct owl_padinfo *info,
> > +				unsigned int param,
> > +				u32 *reg,
> > +				u32 *bit,
> > +				u32 *width)
> > +{
> > +	switch (param) {
> > +	case PIN_CONFIG_BIAS_BUS_HOLD:
> > +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> > +	case PIN_CONFIG_BIAS_PULL_DOWN:
> > +	case PIN_CONFIG_BIAS_PULL_UP:
> > +		if (!info->pullctl)
> > +			return -EINVAL;
> > +		*reg = info->pullctl->reg;
> > +		*bit = info->pullctl->shift;
> > +		*width = info->pullctl->width;
> > +		break;
> > +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> > +		if (!info->st)
> > +			return -EINVAL;
> > +		*reg = info->st->reg;
> > +		*bit = info->st->shift;
> > +		*width = info->st->width;
> > +		break;
> > +	default:
> > +		return -ENOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int owl_pad_pinconf_arg2val(const struct owl_padinfo *info,
> > +				unsigned int param,
> > +				u32 *arg)
> > +{
> > +	switch (param) {
> > +	case PIN_CONFIG_BIAS_BUS_HOLD:
> > +		*arg = OWL_PINCONF_PULL_HOLD;
> > +		break;
> > +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> > +		*arg = OWL_PINCONF_PULL_HIZ;
> > +		break;
> > +	case PIN_CONFIG_BIAS_PULL_DOWN:
> > +		*arg = OWL_PINCONF_PULL_DOWN;
> > +		break;
> > +	case PIN_CONFIG_BIAS_PULL_UP:
> > +		*arg = OWL_PINCONF_PULL_UP;
> > +		break;
> > +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> > +		*arg = (*arg >= 1 ? 1 : 0);
> > +		break;
> > +	default:
> > +		return -ENOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int owl_pad_pinconf_val2arg(const struct owl_padinfo *padinfo,
> > +				unsigned int param,
> > +				u32 *arg)
> > +{
> > +	switch (param) {
> > +	case PIN_CONFIG_BIAS_BUS_HOLD:
> > +		*arg = *arg == OWL_PINCONF_PULL_HOLD;
> > +		break;
> > +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> > +		*arg = *arg == OWL_PINCONF_PULL_HIZ;
> > +		break;
> > +	case PIN_CONFIG_BIAS_PULL_DOWN:
> > +		*arg = *arg == OWL_PINCONF_PULL_DOWN;
> > +		break;
> > +	case PIN_CONFIG_BIAS_PULL_UP:
> > +		*arg = *arg == OWL_PINCONF_PULL_UP;
> > +		break;
> > +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> > +		*arg = *arg == 1;
> > +		break;
> > +	default:
> > +		return -ENOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int owl_pin_config_get(struct pinctrl_dev *pctrldev,
> > +				unsigned int pin,
> > +				unsigned long *config)
> > +{
> > +	int ret = 0;
> > +	struct owl_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrldev);
> > +	const struct owl_padinfo *info;
> > +	unsigned int param = pinconf_to_config_param(*config);
> > +	u32 reg, bit, width;
> > +	u32 tmp, mask;
> > +	u32 arg = 0;
> > +
> > +	info = &pctrl->soc->padinfo[pin];
> > +
> > +	ret = owl_pad_pinconf_reg(info, param, &reg, &bit, &width);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tmp = readl(pctrl->base + reg);
> > +	mask = (1 << width) - 1;
> > +	arg = (tmp >> bit) & mask;
> > +
> > +	ret = owl_pad_pinconf_val2arg(info, param, &arg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*config = pinconf_to_config_packed(param, arg);
> > +
> > +	return ret;
> > +}
> > +
> > +static int owl_pin_config_set(struct pinctrl_dev *pctrldev,
> > +				unsigned int pin,
> > +				unsigned long *configs,
> > +				unsigned int num_configs)
> > +{
> > +	int ret = 0;
> > +	struct owl_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrldev);
> > +	const struct owl_padinfo *info;
> > +	unsigned long flags;
> > +	unsigned int param;
> > +	u32 reg, bit, width;
> > +	u32 mask = 0, tmp, arg = 0;
> > +	int i;
> > +
> > +	info = &pctrl->soc->padinfo[pin];
> > +
> > +	for (i = 0; i < num_configs; i++) {
> > +		param = pinconf_to_config_param(configs[i]);
> > +		arg = pinconf_to_config_argument(configs[i]);
> > +
> > +		ret = owl_pad_pinconf_reg(info, param, &reg, &bit, &width);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = owl_pad_pinconf_arg2val(info, param, &arg);
> > +		if (ret)
> > +			return ret;
> > +
> > +		raw_spin_lock_irqsave(&pctrl->lock, flags);
> > +
> > +		mask = (1 << width) - 1;
> > +		mask = mask << bit;
> > +		tmp = readl(pctrl->base + reg);
> > +		tmp &= ~mask;
> > +		tmp |= arg << bit;
> > +		writel(tmp, pctrl->base + reg);
> > +
> > +		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int owl_group_pinconf_reg(const struct owl_pingroup *g,
> > +				unsigned int param,
> > +				u32 *reg,
> > +				u32 *bit,
> > +				u32 *width)
> > +{
> > +	switch (param) {
> > +	case PIN_CONFIG_DRIVE_STRENGTH:
> > +		if (g->drv_reg < 0)
> > +			return -EINVAL;
> > +		*reg = g->drv_reg;
> > +		*bit = g->drv_shift;
> > +		*width = g->drv_width;
> > +		break;
> > +	case PIN_CONFIG_SLEW_RATE:
> > +		if (g->sr_reg < 0)
> > +			return -EINVAL;
> > +		*reg = g->sr_reg;
> > +		*bit = g->sr_shift;
> > +		*width = g->sr_width;
> > +		break;
> > +	default:
> > +		return -ENOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int owl_group_pinconf_arg2val(const struct owl_pingroup *g,
> > +				unsigned int param,
> > +				u32 *arg)
> > +{
> > +	switch (param) {
> > +	case PIN_CONFIG_DRIVE_STRENGTH:
> > +		switch (*arg) {
> > +		case 2:
> > +			*arg = OWL_PINCONF_DRV_2MA;
> > +			break;
> > +		case 4:
> > +			*arg = OWL_PINCONF_DRV_4MA;
> > +			break;
> > +		case 8:
> > +			*arg = OWL_PINCONF_DRV_8MA;
> > +			break;
> > +		case 12:
> > +			*arg = OWL_PINCONF_DRV_12MA;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case PIN_CONFIG_SLEW_RATE:
> > +		if (*arg)
> > +			*arg = OWL_PINCONF_SLEW_FAST;
> > +		else
> > +			*arg = OWL_PINCONF_SLEW_SLOW;
> > +		break;
> > +	default:
> > +		return -ENOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int owl_group_pinconf_val2arg(const struct owl_pingroup *g,
> > +				unsigned int param,
> > +				u32 *arg)
> > +{
> > +	switch (param) {
> > +	case PIN_CONFIG_DRIVE_STRENGTH:
> > +		switch (*arg) {
> > +		case OWL_PINCONF_DRV_2MA:
> > +			*arg = 2;
> > +			break;
> > +		case OWL_PINCONF_DRV_4MA:
> > +			*arg = 4;
> > +			break;
> > +		case OWL_PINCONF_DRV_8MA:
> > +			*arg = 8;
> > +			break;
> > +		case OWL_PINCONF_DRV_12MA:
> > +			*arg = 12;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case PIN_CONFIG_SLEW_RATE:
> > +		if (*arg)
> > +			*arg = 1;
> > +		else
> > +			*arg = 0;
> > +		break;
> > +	default:
> > +		return -ENOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int owl_group_config_get(struct pinctrl_dev *pctrldev,
> > +				unsigned int group,
> > +				unsigned long *config)
> > +{
> > +	int ret = 0;
> > +	const struct owl_pingroup *g;
> > +	struct owl_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrldev);
> > +	unsigned int param = pinconf_to_config_param(*config);
> > +	u32 reg, bit, width;
> > +	u32 mask, tmp, arg = 0;
> > +
> > +	g = &pctrl->soc->groups[group];
> > +
> > +	ret = owl_group_pinconf_reg(g, param, &reg, &bit, &width);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tmp = readl(pctrl->base + reg);
> > +	mask = (1 << width) - 1;
> > +	arg = (tmp >> bit) & mask;
> > +
> > +	ret = owl_group_pinconf_val2arg(g, param, &arg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*config = pinconf_to_config_packed(param, arg);
> > +
> > +	return ret;
> > +
> > +}
> > +
> > +static int owl_group_config_set(struct pinctrl_dev *pctrldev,
> > +				unsigned int group,
> > +				unsigned long *configs,
> > +				unsigned int num_configs)
> > +{
> > +	int ret = 0;
> > +	const struct owl_pingroup *g;
> > +	struct owl_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrldev);
> > +	unsigned long flags;
> > +	unsigned int param;
> > +	u32 reg, bit, width;
> > +	u32 mask, arg = 0;
> > +	u32 tmp;
> > +	int i;
> > +
> > +	g = &pctrl->soc->groups[group];
> > +
> > +	for (i = 0; i < num_configs; i++) {
> > +		param = pinconf_to_config_param(configs[i]);
> > +		arg = pinconf_to_config_argument(configs[i]);
> > +
> > +		ret = owl_group_pinconf_reg(g, param, &reg, &bit, &width);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = owl_group_pinconf_arg2val(g, param, &arg);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Update register */
> > +		raw_spin_lock_irqsave(&pctrl->lock, flags);
> > +
> > +		mask = (1 << width) - 1;
> > +		mask = mask << bit;
> > +		tmp = readl(pctrl->base + reg);
> > +		tmp &= ~mask;
> > +		tmp |= arg << bit;
> > +		writel(tmp, pctrl->base + reg);
> > +
> > +		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct pinconf_ops owl_pinconf_ops = {
> > +	.is_generic = true,
> > +	.pin_config_get = owl_pin_config_get,
> > +	.pin_config_set = owl_pin_config_set,
> > +	.pin_config_group_get = owl_group_config_get,
> > +	.pin_config_group_set = owl_group_config_set,
> > +};
> > +
> > +static struct pinctrl_desc owl_pinctrl_desc = {
> > +	.pctlops = &owl_pinctrl_ops,
> > +	.pmxops = &owl_pinmux_ops,
> > +	.confops = &owl_pinconf_ops,
> > +	.owner = THIS_MODULE,
> > +};
> > +
> > +int owl_pinctrl_probe(struct platform_device *pdev,
> > +				struct owl_pinctrl_soc_data *soc_data)
> > +{
> > +	struct resource *res;
> > +	struct owl_pinctrl *pctrl;
> > +
> > +	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
> > +	if (!pctrl)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	pctrl->base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(pctrl->base))
> > +		return PTR_ERR(pctrl->base);
> > +
> > +	/* enable GPIO/MFP clock */
> > +	pctrl->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(pctrl->clk)) {
> > +		dev_err(&pdev->dev, "no clock defined\n");
> > +		return -ENODEV;
> 
> You need to return PTR_ERR(pctrl->clk) to make deferred loading work.
>
Ack. 
> > +	}
> > +	clk_prepare_enable(pctrl->clk);
> > +
> > +	raw_spin_lock_init(&pctrl->lock);
> > +
> > +	owl_pinctrl_desc.name = dev_name(&pdev->dev);
> > +	owl_pinctrl_desc.pins = soc_data->pins;
> > +	owl_pinctrl_desc.npins = soc_data->npins;
> > +
> > +	pctrl->soc = soc_data;
> > +	pctrl->dev = &pdev->dev;
> > +
> > +	pctrl->pctrldev = devm_pinctrl_register(&pdev->dev,
> > +					&owl_pinctrl_desc, pctrl);
> > +	if (IS_ERR(pctrl->pctrldev)) {
> > +		dev_err(&pdev->dev, "could not register Actions OWL pinmux driver\n");
> > +		return PTR_ERR(pctrl->pctrldev);
> > +	}
> > +
> > +	platform_set_drvdata(pdev, pctrl);
> > +
> > +	pr_info("Initialized Actions OWL pin control driver\n");
> 
> Drop?
> 
Ack.
> > +
> > +	return 0;
> > +}
> [snip]
> 
> Let's discuss concerns about the naming and design separately.
> 
So, as per our discussion I'll be making all the pin names as lowercase
and the register name based pin groups will be changed to handle pinmuxing
using individual pins.

Thanks,
Mani
> Regards,
> Andreas
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
