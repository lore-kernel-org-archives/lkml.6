Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6A6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED0121900
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389544AbfBNMWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:22:31 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:52031 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfBNMWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:22:31 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 9062413F88A;
        Thu, 14 Feb 2019 13:22:08 +0100 (CET)
Subject: Re: [PATCH -next 3/3] qcom: ssbi-gpio: correct boundary conditions in
 pm8xxx_domain_translate
To:     Brian Masney <masneyb@onstation.org>, linus.walleij@linaro.org
Cc:     sboyd@kernel.org, lee.jones@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20190214013641.9740-1-masneyb@onstation.org>
 <20190214013641.9740-3-masneyb@onstation.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <82660bd6-200f-ec3a-cf78-9b6aec34f2a3@free.fr>
Date:   Thu, 14 Feb 2019 13:22:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214013641.9740-3-masneyb@onstation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2019 02:36, Brian Masney wrote:

> SSBI GPIOs are numbered 1..ngpio, so the boundary check in
> pm8xxx_domain_translate() is off by one. This patch corrects that check.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Originally found by Bjorn Andersson in spmi-gpio.
> 
> Linus: For your ib-qcom-ssbi branch.
> 
>  drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
> index 84a232450000..10575d6e2ba5 100644
> --- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
> @@ -710,7 +710,8 @@ static int pm8xxx_domain_translate(struct irq_domain *domain,
>  	struct pm8xxx_gpio *pctrl = container_of(domain->host_data,
>  						 struct pm8xxx_gpio, chip);
>  
> -	if (fwspec->param_count != 2 || fwspec->param[0] >= pctrl->chip.ngpio)
> +	if (fwspec->param_count != 2 || fwspec->param[0] < 1 ||
> +	    fwspec->param[0] > pctrl->chip.ngpio)
>  		return -EINVAL;
>  
>  	*hwirq = fwspec->param[0] - PM8XXX_GPIO_PHYSICAL_OFFSET;

I would write (using the wrap-around behavior for unsigned int)

	if (fwspec->param_count != 2 || fwspec->param[0] - 1 >= pctrl->chip.ngpio)
		return -EINVAL;

Regards.
