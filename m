Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174F1C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B211C2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tv8Jb1er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B211C2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbeGZTdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:33:12 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40229 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730728AbeGZTdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:33:12 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so1169196plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 11:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ev3LOzmoyFMPlmx066OkXUoTkkL46xCKpZ9mtZC5VoA=;
        b=Tv8Jb1er/I5SWa2Ssra6rgLu8dxaTK7sd8LHmgyZBSztvU/0Mj5wSKM9L1Jbwt69Yi
         mGU3hwaioRVuKcyW9hr88nmgis/o3DKw6RArdTakjdiq+lrIyUY6o9drZlDwJcXOjhLe
         QUjJ5wyApyqMmqdozHSWfJ/rd1fkm6mbbXdP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ev3LOzmoyFMPlmx066OkXUoTkkL46xCKpZ9mtZC5VoA=;
        b=LvHBCDwJKPSJcfr1Hp+6Z7RKjNcwnlfoXTma2AcVpG4FfgC2Ia7Rd0iBJJ+TLbLVhF
         y1kJnGpLdMvlqqgBYoR4p8rRwK0x0cLaKtmXfmDtg7gi8M676SE4ZmAESQ8/Ef6Z3Ay/
         a+W7VwR7JadqeleWVBClxELgpcfuXWXn9w/cZakst6Kj4f162WonzJ390rpqpOl5EqVe
         zFvZBCqGigA2OPQEfPXjYWoRdtE66cn1mDkWQcJulbWZ/wns+/4gOTiCjVUuHbQcEGmQ
         /7LbOis7YfPm6nXuCBmX7kHBUNibadxdWp5ojoZyVqQoZaQ19x36u6J/ZgIGbGNjfk2H
         evwQ==
X-Gm-Message-State: AOUpUlF+EekW4T84sJQLAjjLT1CtBYx3TjmWE7bwjWLQB+ed4W3nb1B7
        hyLVCFFPL/8ASOIC3yRwTdAh
X-Google-Smtp-Source: AAOMgpery35rOZFAFrv7GMnAZ1l+enYf599lQH+9sCc/E9byRqmberHSTM/vlcqu2wVGQ7c/T9DIbg==
X-Received: by 2002:a17:902:f83:: with SMTP id 3-v6mr2891910plz.282.1532628914763;
        Thu, 26 Jul 2018 11:15:14 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:628e:aef6:6d51:3501:dada:e06d])
        by smtp.gmail.com with ESMTPSA id r81-v6sm4589945pfa.18.2018.07.26.11.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 11:15:14 -0700 (PDT)
Date:   Thu, 26 Jul 2018 23:45:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com
Subject: Re: [PATCH 2/5] pinctrl: actions: define pad control configurtion to
 SoC specific
Message-ID: <20180726181503.GE5220@Mani-XPS-13-9360>
References: <20180722163601.28346-1-sravanhome@gmail.com>
 <20180722163601.28346-3-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180722163601.28346-3-sravanhome@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 22, 2018 at 06:35:58PM +0200, Saravanan Sekar wrote:
> pad control for s900 and s700 are differs in number of
> pull control configuraions
> s900 has 4 pull controls - high impedence, pull up, pull down, repeater
> s700, s500 has 2 pull controls - pull up and pull down
> 

You should clearly mention what the commit is actually doing.

> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  drivers/pinctrl/actions/pinctrl-owl.c  | 64 ++++---------------------
>  drivers/pinctrl/actions/pinctrl-owl.h  | 13 +++--
>  drivers/pinctrl/actions/pinctrl-s900.c | 66 +++++++++++++++++++++++++-
>  3 files changed, 79 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
> index b5c880b50bb3..f72da7aae4ff 100644
> --- a/drivers/pinctrl/actions/pinctrl-owl.c
> +++ b/drivers/pinctrl/actions/pinctrl-owl.c
> @@ -242,60 +242,6 @@ static int owl_pad_pinconf_reg(const struct owl_padinfo *info,
>  	return 0;
>  }
>  
> -static int owl_pad_pinconf_arg2val(const struct owl_padinfo *info,
> -				unsigned int param,
> -				u32 *arg)
> -{
> -	switch (param) {
> -	case PIN_CONFIG_BIAS_BUS_HOLD:
> -		*arg = OWL_PINCONF_PULL_HOLD;
> -		break;
> -	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> -		*arg = OWL_PINCONF_PULL_HIZ;
> -		break;
> -	case PIN_CONFIG_BIAS_PULL_DOWN:
> -		*arg = OWL_PINCONF_PULL_DOWN;
> -		break;
> -	case PIN_CONFIG_BIAS_PULL_UP:
> -		*arg = OWL_PINCONF_PULL_UP;
> -		break;
> -	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> -		*arg = (*arg >= 1 ? 1 : 0);
> -		break;
> -	default:
> -		return -ENOTSUPP;
> -	}
> -
> -	return 0;
> -}
> -
> -static int owl_pad_pinconf_val2arg(const struct owl_padinfo *padinfo,
> -				unsigned int param,
> -				u32 *arg)
> -{
> -	switch (param) {
> -	case PIN_CONFIG_BIAS_BUS_HOLD:
> -		*arg = *arg == OWL_PINCONF_PULL_HOLD;
> -		break;
> -	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> -		*arg = *arg == OWL_PINCONF_PULL_HIZ;
> -		break;
> -	case PIN_CONFIG_BIAS_PULL_DOWN:
> -		*arg = *arg == OWL_PINCONF_PULL_DOWN;
> -		break;
> -	case PIN_CONFIG_BIAS_PULL_UP:
> -		*arg = *arg == OWL_PINCONF_PULL_UP;
> -		break;
> -	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> -		*arg = *arg == 1;
> -		break;
> -	default:
> -		return -ENOTSUPP;
> -	}
> -
> -	return 0;
> -}
> -
>  static int owl_pin_config_get(struct pinctrl_dev *pctrldev,
>  				unsigned int pin,
>  				unsigned long *config)
> @@ -314,7 +260,10 @@ static int owl_pin_config_get(struct pinctrl_dev *pctrldev,
>  
>  	arg = owl_read_field(pctrl, reg, bit, width);
>  
> -	ret = owl_pad_pinconf_val2arg(info, param, &arg);
> +	if (!pctrl->soc->padctl_val2arg)
> +		return -ENOTSUPP;
> +
> +	ret = pctrl->soc->padctl_val2arg(info, param, &arg);
>  	if (ret)
>  		return ret;
>  
> @@ -345,7 +294,10 @@ static int owl_pin_config_set(struct pinctrl_dev *pctrldev,
>  		if (ret)
>  			return ret;
>  
> -		ret = owl_pad_pinconf_arg2val(info, param, &arg);
> +		if (!pctrl->soc->padctl_arg2val)
> +			return -ENOTSUPP;
> +
> +		ret = pctrl->soc->padctl_arg2val(info, param, &arg);
>  		if (ret)
>  			return ret;
>  
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
> index 42635366e68f..669591c5400e 100644
> --- a/drivers/pinctrl/actions/pinctrl-owl.h
> +++ b/drivers/pinctrl/actions/pinctrl-owl.h
> @@ -139,13 +139,6 @@
>  		.st = &name##_st_conf,			\
>  	}
>  
> -enum owl_pinconf_pull {
> -	OWL_PINCONF_PULL_HIZ,
> -	OWL_PINCONF_PULL_DOWN,
> -	OWL_PINCONF_PULL_UP,
> -	OWL_PINCONF_PULL_HOLD,
> -};
> -

Why can't this be left here itself?

>  enum owl_pinconf_drv {
>  	OWL_PINCONF_DRV_2MA,
>  	OWL_PINCONF_DRV_4MA,
> @@ -278,6 +271,12 @@ struct owl_pinctrl_soc_data {
>  	unsigned int ngpios;
>  	const struct owl_gpio_port *ports;
>  	unsigned int nports;
> +	int (*padctl_val2arg)(const struct owl_padinfo *padinfo,
> +				unsigned int param,
> +				u32 *arg);
> +	int (*padctl_arg2val)(const struct owl_padinfo *info,
> +				unsigned int param,
> +				u32 *arg);
>  };
>  
>  int owl_pinctrl_probe(struct platform_device *pdev,
> diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
> index baa2f4847418..dc7bdc1f5cde 100644
> --- a/drivers/pinctrl/actions/pinctrl-s900.c
> +++ b/drivers/pinctrl/actions/pinctrl-s900.c
> @@ -13,6 +13,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinconf-generic.h>
>  #include "pinctrl-owl.h"
>  
>  /* Pinctrl registers offset */
> @@ -1717,6 +1718,67 @@ static const struct owl_gpio_port s900_gpio_ports[] = {
>  	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8)
>  };
>  
> +enum owl_pinconf_pull {
> +	OWL_PINCONF_PULL_HIZ,
> +	OWL_PINCONF_PULL_DOWN,
> +	OWL_PINCONF_PULL_UP,
> +	OWL_PINCONF_PULL_HOLD,
> +};
> +
> +static int owl_pad_pinconf_s900_arg2val(const struct owl_padinfo *info,
> +				unsigned int param,
> +				u32 *arg)

How about s900_pad_pinconf_arg2val?

> +{
> +	switch (param) {
> +	case PIN_CONFIG_BIAS_BUS_HOLD:
> +		*arg = OWL_PINCONF_PULL_HOLD;
> +		break;
> +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> +		*arg = OWL_PINCONF_PULL_HIZ;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		*arg = OWL_PINCONF_PULL_DOWN;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		*arg = OWL_PINCONF_PULL_UP;
> +		break;
> +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +		*arg = (*arg >= 1 ? 1 : 0);
> +		break;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int owl_pad_pinconf_s900_val2arg(const struct owl_padinfo *padinfo,
> +				unsigned int param,
> +				u32 *arg)

How about s900_pad_pinconf_val2arg?

Thanks,
Mani

> +{
> +	switch (param) {
> +	case PIN_CONFIG_BIAS_BUS_HOLD:
> +		*arg = *arg == OWL_PINCONF_PULL_HOLD;
> +		break;
> +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> +		*arg = *arg == OWL_PINCONF_PULL_HIZ;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		*arg = *arg == OWL_PINCONF_PULL_DOWN;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		*arg = *arg == OWL_PINCONF_PULL_UP;
> +		break;
> +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +		*arg = *arg == 1;
> +		break;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct owl_pinctrl_soc_data s900_pinctrl_data = {
>  	.padinfo = s900_padinfo,
>  	.pins = (const struct pinctrl_pin_desc *)s900_pads,
> @@ -1727,7 +1789,9 @@ static struct owl_pinctrl_soc_data s900_pinctrl_data = {
>  	.ngroups = ARRAY_SIZE(s900_groups),
>  	.ngpios = NUM_GPIOS,
>  	.ports = s900_gpio_ports,
> -	.nports = ARRAY_SIZE(s900_gpio_ports)
> +	.nports = ARRAY_SIZE(s900_gpio_ports),
> +	.padctl_arg2val = owl_pad_pinconf_s900_arg2val,
> +	.padctl_val2arg = owl_pad_pinconf_s900_val2arg,
>  };
>  
>  static int s900_pinctrl_probe(struct platform_device *pdev)
> -- 
> 2.18.0
> 
