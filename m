Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BE3C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731A820647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8jRAqvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731A820647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbeGZTML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:12:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40009 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731823AbeGZTML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:12:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so1607197pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S7Lhg+eN2AyiUgIgQ7QDnTyPB8kYe/WwAc2m+x3NEHc=;
        b=V8jRAqvkQWltlv8uItncFzX42aSco1xxTiZbDVQ5NKtNim4JuxXq76N66d5QYCKQSA
         Ou0h0F/qwX3IZOAFdd6/36VyZjbeSPAH47chyjgUqjoCSxO5hAWK+gYxvoLmwHkYWudt
         DuJHugnkQXJxFeOZkrvIJu4Wa0UeG+QW/8/HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S7Lhg+eN2AyiUgIgQ7QDnTyPB8kYe/WwAc2m+x3NEHc=;
        b=OhnI0gxuREXaIWyGviedu4HG9i3m4ALGU6rVaaSxnvC3DednZ8w7NYmhy++PSTMErB
         4NDPLuURDnHZULbLzo8oHIwoEGxk0Ouk7l20gm5Y4vWOyV0oXeRjk9wCTEmQpi3f9u5l
         IFSQy7xUEExCSwF+FpNU7e71zWlcCYgOONEXbULUUkWjI6ybEJIUHaS2r4muGqObwasy
         L+FMACGr9YBkqGUe+91AQJjG/AnrSM5N2UCSJMSIn6n9X9LOtYnAaHSsq3xWPm585+xq
         AWim4Yu5WVtufz+9Q3bcyGjBhPvKLasf1crC7N05X6lwVh+7hI2qeY2a31VmzRCbVU0y
         VVGQ==
X-Gm-Message-State: AOUpUlGfN5IFsUd4SG4+3ev2FNBe+0dTQNULmEilVRSekqgwn36IA+AJ
        UT0SZObBLgi+j+G7pwz14Vzf
X-Google-Smtp-Source: AAOMgpd/l12PPEMYUcEGrSnxIwr1V6iy8ICnC5CUcJefMr3n+sucMl4BSiza4dCf1IbZ57FtQkaTkw==
X-Received: by 2002:a65:40ca:: with SMTP id u10-v6mr2819345pgp.2.1532627657410;
        Thu, 26 Jul 2018 10:54:17 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:628e:aef6:6d51:3501:dada:e06d])
        by smtp.gmail.com with ESMTPSA id j83-v6sm4908516pfj.71.2018.07.26.10.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 10:54:16 -0700 (PDT)
Date:   Thu, 26 Jul 2018 23:24:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com
Subject: Re: [PATCH 1/5] pinctrl: actions: define constructor generic to
 Actions Semi SoC's
Message-ID: <20180726175405.GD5220@Mani-XPS-13-9360>
References: <20180722163601.28346-1-sravanhome@gmail.com>
 <20180722163601.28346-2-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180722163601.28346-2-sravanhome@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravanan,

On Sun, Jul 22, 2018 at 06:35:57PM +0200, Saravanan Sekar wrote:
> Existing constructor defined in S900 is reused generic
> for all Actions Semi SoC's.
> 

Perhaps this could be,

Move generic defines common to the Owl family out of S900 driver.

Thanks,
Mani

> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  drivers/pinctrl/actions/pinctrl-owl.h  | 124 +++++++++++++++++++++++++
>  drivers/pinctrl/actions/pinctrl-s900.c | 122 ------------------------
>  2 files changed, 124 insertions(+), 122 deletions(-)
> 
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
> index 74342378937c..42635366e68f 100644
> --- a/drivers/pinctrl/actions/pinctrl-owl.h
> +++ b/drivers/pinctrl/actions/pinctrl-owl.h
> @@ -15,6 +15,130 @@
>  #define OWL_PINCONF_SLEW_SLOW 0
>  #define OWL_PINCONF_SLEW_FAST 1
>  
> +#define OWL_GPIO_PORT_A		0
> +#define OWL_GPIO_PORT_B		1
> +#define OWL_GPIO_PORT_C		2
> +#define OWL_GPIO_PORT_D		3
> +#define OWL_GPIO_PORT_E		4
> +#define OWL_GPIO_PORT_F		5
> +

Please order the defines as pinctrl first and GPIO second. It does look
a lot better.

Thanks,
Mani

> +#define MUX_PG(group_name, reg, shift, width)				\
> +	{								\
> +		.name = #group_name,					\
> +		.pads = group_name##_pads,				\
> +		.npads = ARRAY_SIZE(group_name##_pads),			\
> +		.funcs = group_name##_funcs,				\
> +		.nfuncs = ARRAY_SIZE(group_name##_funcs),		\
> +		.mfpctl_reg  = MFCTL##reg,				\
> +		.mfpctl_shift = shift,					\
> +		.mfpctl_width = width,					\
> +		.drv_reg = -1,						\
> +		.drv_shift = -1,					\
> +		.drv_width = -1,					\
> +		.sr_reg = -1,						\
> +		.sr_shift = -1,						\
> +		.sr_width = -1,						\
> +	}
> +
> +#define DRV_PG(group_name, reg, shift, width)				\
> +	{								\
> +		.name = #group_name,					\
> +		.pads = group_name##_pads,				\
> +		.npads = ARRAY_SIZE(group_name##_pads),			\
> +		.mfpctl_reg  = -1,					\
> +		.mfpctl_shift = -1,					\
> +		.mfpctl_width = -1,					\
> +		.drv_reg = PAD_DRV##reg,				\
> +		.drv_shift = shift,					\
> +		.drv_width = width,					\
> +		.sr_reg = -1,						\
> +		.sr_shift = -1,						\
> +		.sr_width = -1,						\
> +	}
> +
> +#define SR_PG(group_name, reg, shift, width)				\
> +	{								\
> +		.name = #group_name,					\
> +		.pads = group_name##_pads,				\
> +		.npads = ARRAY_SIZE(group_name##_pads),			\
> +		.mfpctl_reg  = -1,					\
> +		.mfpctl_shift = -1,					\
> +		.mfpctl_width = -1,					\
> +		.drv_reg = -1,						\
> +		.drv_shift = -1,					\
> +		.drv_width = -1,					\
> +		.sr_reg = PAD_SR##reg,					\
> +		.sr_shift = shift,					\
> +		.sr_width = width,					\
> +	}
> +
> +#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat)	\
> +	[OWL_GPIO_PORT_##port] = {				\
> +		.offset = base,					\
> +		.pins = count,					\
> +		.outen = _outen,				\
> +		.inen = _inen,					\
> +		.dat = _dat,					\
> +	}
> +
> +#define FUNCTION(fname)					\
> +	{						\
> +		.name = #fname,				\
> +		.groups = fname##_groups,		\
> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
> +	}
> +
> +/* PAD PULL UP/DOWN CONFIGURES */
> +#define PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)	\
> +	{						\
> +		.reg = PAD_PULLCTL##pull_reg,		\
> +		.shift = pull_sft,			\
> +		.width = pull_wdt,			\
> +	}
> +
> +#define PAD_PULLCTL_CONF(pad_name, pull_reg, pull_sft, pull_wdt)	\
> +	struct owl_pullctl pad_name##_pullctl_conf			\
> +		= PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)
> +
> +#define ST_CONF(st_reg, st_sft, st_wdt)			\
> +	{						\
> +		.reg = PAD_ST##st_reg,			\
> +		.shift = st_sft,			\
> +		.width = st_wdt,			\
> +	}
> +
> +#define PAD_ST_CONF(pad_name, st_reg, st_sft, st_wdt)	\
> +	struct owl_st pad_name##_st_conf		\
> +		= ST_CONF(st_reg, st_sft, st_wdt)
> +
> +#define PAD_INFO(name)					\
> +	{						\
> +		.pad = name,				\
> +		.pullctl = NULL,			\
> +		.st = NULL,				\
> +	}
> +
> +#define PAD_INFO_ST(name)				\
> +	{						\
> +		.pad = name,				\
> +		.pullctl = NULL,			\
> +		.st = &name##_st_conf,			\
> +	}
> +
> +#define PAD_INFO_PULLCTL(name)				\
> +	{						\
> +		.pad = name,				\
> +		.pullctl = &name##_pullctl_conf,	\
> +		.st = NULL,				\
> +	}
> +
> +#define PAD_INFO_PULLCTL_ST(name)			\
> +	{						\
> +		.pad = name,				\
> +		.pullctl = &name##_pullctl_conf,	\
> +		.st = &name##_st_conf,			\
> +	}
> +
>  enum owl_pinconf_pull {
>  	OWL_PINCONF_PULL_HIZ,
>  	OWL_PINCONF_PULL_DOWN,
> diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
> index 5503c7945764..baa2f4847418 100644
> --- a/drivers/pinctrl/actions/pinctrl-s900.c
> +++ b/drivers/pinctrl/actions/pinctrl-s900.c
> @@ -33,13 +33,6 @@
>  #define PAD_SR1			(0x0274)
>  #define PAD_SR2			(0x0278)
>  
> -#define OWL_GPIO_PORT_A		0
> -#define OWL_GPIO_PORT_B		1
> -#define OWL_GPIO_PORT_C		2
> -#define OWL_GPIO_PORT_D		3
> -#define OWL_GPIO_PORT_E		4
> -#define OWL_GPIO_PORT_F		5
> -
>  #define _GPIOA(offset)		(offset)
>  #define _GPIOB(offset)		(32 + (offset))
>  #define _GPIOC(offset)		(64 + (offset))
> @@ -892,55 +885,6 @@ static unsigned int i2c2_sr_pads[]		= { I2C2_SCLK, I2C2_SDATA };
>  static unsigned int sensor0_sr_pads[]		= { SENSOR0_PCLK,
>  						    SENSOR0_CKOUT };
>  
> -#define MUX_PG(group_name, reg, shift, width)				\
> -	{								\
> -		.name = #group_name,					\
> -		.pads = group_name##_pads,				\
> -		.npads = ARRAY_SIZE(group_name##_pads),			\
> -		.funcs = group_name##_funcs,				\
> -		.nfuncs = ARRAY_SIZE(group_name##_funcs),		\
> -		.mfpctl_reg  = MFCTL##reg,				\
> -		.mfpctl_shift = shift,					\
> -		.mfpctl_width = width,					\
> -		.drv_reg = -1,						\
> -		.drv_shift = -1,					\
> -		.drv_width = -1,					\
> -		.sr_reg = -1,						\
> -		.sr_shift = -1,						\
> -		.sr_width = -1,						\
> -	}
> -
> -#define DRV_PG(group_name, reg, shift, width)				\
> -	{								\
> -		.name = #group_name,					\
> -		.pads = group_name##_pads,				\
> -		.npads = ARRAY_SIZE(group_name##_pads),			\
> -		.mfpctl_reg  = -1,					\
> -		.mfpctl_shift = -1,					\
> -		.mfpctl_width = -1,					\
> -		.drv_reg = PAD_DRV##reg,				\
> -		.drv_shift = shift,					\
> -		.drv_width = width,					\
> -		.sr_reg = -1,						\
> -		.sr_shift = -1,						\
> -		.sr_width = -1,						\
> -	}
> -
> -#define SR_PG(group_name, reg, shift, width)				\
> -	{								\
> -		.name = #group_name,					\
> -		.pads = group_name##_pads,				\
> -		.npads = ARRAY_SIZE(group_name##_pads),			\
> -		.mfpctl_reg  = -1,					\
> -		.mfpctl_shift = -1,					\
> -		.mfpctl_width = -1,					\
> -		.drv_reg = -1,						\
> -		.drv_shift = -1,					\
> -		.drv_width = -1,					\
> -		.sr_reg = PAD_SR##reg,					\
> -		.sr_shift = shift,					\
> -		.sr_width = width,					\
> -	}
>  
>  /* Pinctrl groups */
>  static const struct owl_pingroup s900_groups[] = {
> @@ -1442,13 +1386,6 @@ static const char * const sirq2_groups[] = {
>  	"sirq2_dummy",
>  };
>  
> -#define FUNCTION(fname)					\
> -	{						\
> -		.name = #fname,				\
> -		.groups = fname##_groups,		\
> -		.ngroups = ARRAY_SIZE(fname##_groups),	\
> -	}
> -
>  static const struct owl_pinmux_func s900_functions[] = {
>  	[S900_MUX_ERAM] = FUNCTION(eram),
>  	[S900_MUX_ETH_RMII] = FUNCTION(eth_rmii),
> @@ -1500,28 +1437,6 @@ static const struct owl_pinmux_func s900_functions[] = {
>  	[S900_MUX_SIRQ1] = FUNCTION(sirq1),
>  	[S900_MUX_SIRQ2] = FUNCTION(sirq2)
>  };
> -/* PAD PULL UP/DOWN CONFIGURES */
> -#define PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)			\
> -	{								\
> -		.reg = PAD_PULLCTL##pull_reg,				\
> -		.shift = pull_sft,					\
> -		.width = pull_wdt,					\
> -	}
> -
> -#define PAD_PULLCTL_CONF(pad_name, pull_reg, pull_sft, pull_wdt)	\
> -	struct owl_pullctl pad_name##_pullctl_conf			\
> -		= PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)
> -
> -#define ST_CONF(st_reg, st_sft, st_wdt)					\
> -	{								\
> -		.reg = PAD_ST##st_reg,					\
> -		.shift = st_sft,					\
> -		.width = st_wdt,					\
> -	}
> -
> -#define PAD_ST_CONF(pad_name, st_reg, st_sft, st_wdt)			\
> -	struct owl_st pad_name##_st_conf				\
> -		= ST_CONF(st_reg, st_sft, st_wdt)
>  
>  /* PAD_PULLCTL0 */
>  static PAD_PULLCTL_CONF(ETH_RXER, 0, 18, 2);
> @@ -1639,34 +1554,6 @@ static PAD_ST_CONF(SPI0_SS, 1, 2, 1);
>  static PAD_ST_CONF(I2S_BCLK0, 1, 1, 1);
>  static PAD_ST_CONF(I2S_MCLK0, 1, 0, 1);
>  
> -#define PAD_INFO(name)							\
> -	{								\
> -		.pad = name,						\
> -		.pullctl = NULL,					\
> -		.st = NULL,						\
> -	}
> -
> -#define PAD_INFO_ST(name)						\
> -	{								\
> -		.pad = name,						\
> -		.pullctl = NULL,					\
> -		.st = &name##_st_conf,					\
> -	}
> -
> -#define PAD_INFO_PULLCTL(name)						\
> -	{								\
> -		.pad = name,						\
> -		.pullctl = &name##_pullctl_conf,			\
> -		.st = NULL,						\
> -	}
> -
> -#define PAD_INFO_PULLCTL_ST(name)					\
> -	{								\
> -		.pad = name,						\
> -		.pullctl = &name##_pullctl_conf,			\
> -		.st = &name##_st_conf,					\
> -	}
> -
>  /* Pad info table */
>  static struct owl_padinfo s900_padinfo[NUM_PADS] = {
>  	[ETH_TXD0] = PAD_INFO_ST(ETH_TXD0),
> @@ -1821,15 +1708,6 @@ static struct owl_padinfo s900_padinfo[NUM_PADS] = {
>  	[SGPIO3] = PAD_INFO_PULLCTL_ST(SGPIO3)
>  };
>  
> -#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat)	\
> -	[OWL_GPIO_PORT_##port] = {				\
> -		.offset = base,					\
> -		.pins = count,					\
> -		.outen = _outen,				\
> -		.inen = _inen,					\
> -		.dat = _dat,					\
> -	}
> -
>  static const struct owl_gpio_port s900_gpio_ports[] = {
>  	OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8),
>  	OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8),
> -- 
> 2.18.0
> 
