Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E56CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E8C20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJuzJXyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E8C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeIDBUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 21:20:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43289 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeIDBUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 21:20:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so599810pfi.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 13:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pwYS0ElqZUfmFETs8IkgJeJlHTUP3W0dJVhvDK/tRLw=;
        b=cJuzJXyXcrtgEIeMCUBTgfmELWbPuKGM2+hpSoRJkdRM7BZUvXK9IoLYM+cTeREOms
         foJ9HGjQgboYhHkDsUc5Ab8OSRevpiGp142a+gPk4L2JZO3aiDF6RSDnLMtQKGPLlx+c
         Zx0gFrSQkCnD7k4GjjAUDODGSWoUEhFY/JHpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pwYS0ElqZUfmFETs8IkgJeJlHTUP3W0dJVhvDK/tRLw=;
        b=C9aaMaTWa3KKKWGdLQBUy6yQCCArIqUzgrguJBLlzsK7CKRnVGxEpPP9nBhoBtwVeu
         u8mudFlrThZp50XOE00vSA99PAO90WYynZZiK5fUPs/daIV3Pz5dLVhvc0IRoqeV9H05
         MHQCEi758z5ynMtOHaGAFJ2dr0ZsybdtQuOND1ych9R1D8JfOvFS5PurSooB/GWbpHcs
         mK7AIO8MDdN9YnRq+MwG+r+nxPxyTP8U0K18nJAz2k0YTWBWqQ2OTTJkFn0G0JdDnIyA
         Pvu1rvn0traZPrjIH9Lfl2wdHklIRQ2qpBx/lTPF9/EuBzijuW04rpzyTkiP5oLWCzs8
         Cfug==
X-Gm-Message-State: APzg51B1R2L4AyY6OGigS1su+4l8xIzyZGMb09y7f5bTLxJvR/K0cATu
        CJ3AqSIlxm7tbjRru/h268QgZQ==
X-Google-Smtp-Source: ANB0VdYMSV6XuerHvdaPToTyGm3c42gVAVSBEYOKdszUAVwwyQBZWYyP/no3MP1jpyugyAAcIk3zYw==
X-Received: by 2002:a63:a06:: with SMTP id 6-v6mr28738802pgk.318.1536008284889;
        Mon, 03 Sep 2018 13:58:04 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d12-v6sm24315081pfn.118.2018.09.03.13.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 13:58:04 -0700 (PDT)
Date:   Mon, 3 Sep 2018 14:01:59 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Ivan T . Ivanov" <iivanov@mm-sol.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFT PATCH 1/2] pinctrl: ssbi-gpio: Fix pm8xxx_pin_config_get()
 to be compliant
Message-ID: <20180903210159.GD1437@tuxbook-pro>
References: <20180830152340.242249-1-dianders@chromium.org>
 <20180830152340.242249-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830152340.242249-2-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30 Aug 08:23 PDT 2018, Douglas Anderson wrote:

> If you look at "pinconf-groups" in debugfs for ssbi-gpio you'll notice
> it looks like nonsense.
> 
> The problem is fairly well described in commit 1cf86bc21257 ("pinctrl:
> qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant") and
> commit 05e0c828955c ("pinctrl: msm: Fix msm_config_group_get() to be
> compliant"), but it was pointed out that ssbi-gpio has the same
> problem.  Let's fix it there too.
> 
> Fixes: b4c45fe974bc ("pinctrl: qcom: ssbi: Family A gpio & mpp drivers")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
>  drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 28 ++++++++++++++++++------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
> index f53e32a9d8fc..0e153bae322e 100644
> --- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
> @@ -260,22 +260,32 @@ static int pm8xxx_pin_config_get(struct pinctrl_dev *pctldev,
>  
>  	switch (param) {
>  	case PIN_CONFIG_BIAS_DISABLE:
> -		arg = pin->bias == PM8XXX_GPIO_BIAS_NP;
> +		if (pin->bias != PM8XXX_GPIO_BIAS_NP)
> +			return -EINVAL;
> +		arg = 1;
>  		break;
>  	case PIN_CONFIG_BIAS_PULL_DOWN:
> -		arg = pin->bias == PM8XXX_GPIO_BIAS_PD;
> +		if (pin->bias != PM8XXX_GPIO_BIAS_PD)
> +			return -EINVAL;
> +		arg = 1;
>  		break;
>  	case PIN_CONFIG_BIAS_PULL_UP:
> -		arg = pin->bias <= PM8XXX_GPIO_BIAS_PU_1P5_30;
> +		if (pin->bias > PM8XXX_GPIO_BIAS_PU_1P5_30)
> +			return -EINVAL;
> +		arg = 1;
>  		break;
>  	case PM8XXX_QCOM_PULL_UP_STRENGTH:
>  		arg = pin->pull_up_strength;
>  		break;
>  	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> -		arg = pin->disable;
> +		if (!pin->disable)
> +			return -EINVAL;
> +		arg = 1;
>  		break;
>  	case PIN_CONFIG_INPUT_ENABLE:
> -		arg = pin->mode == PM8XXX_GPIO_MODE_INPUT;
> +		if (pin->mode != PM8XXX_GPIO_MODE_INPUT)
> +			return -EINVAL;
> +		arg = 1;
>  		break;
>  	case PIN_CONFIG_OUTPUT:
>  		if (pin->mode & PM8XXX_GPIO_MODE_OUTPUT)
> @@ -290,10 +300,14 @@ static int pm8xxx_pin_config_get(struct pinctrl_dev *pctldev,
>  		arg = pin->output_strength;
>  		break;
>  	case PIN_CONFIG_DRIVE_PUSH_PULL:
> -		arg = !pin->open_drain;
> +		if (pin->open_drain)
> +			return -EINVAL;
> +		arg = 1;
>  		break;
>  	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> -		arg = pin->open_drain;
> +		if (!pin->open_drain)
> +			return -EINVAL;
> +		arg = 1;
>  		break;
>  	default:
>  		return -EINVAL;
> -- 
> 2.19.0.rc0.228.g281dcd1b4d0-goog
> 
