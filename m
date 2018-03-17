Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbeCQUqa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 16:46:30 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:37042 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752878AbeCQUq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 16:46:29 -0400
Date: Sat, 17 Mar 2018 21:46:04 +0100
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/4] pwm: pwm-jz4740: Implement set_polarity
To: Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1521319566.2835.0@smtp.crapouillou.net>
In-Reply-To: <20180106165843.3461-2-paul@crapouillou.net>
References: <20180106165843.3461-1-paul@crapouillou.net>
        <20180106165843.3461-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2HKkaO8022602

Hi,

Could this patchset get a bit of love?
I have other changes waiting for this patchset to get in, so it'd be 
great
to see it in 4.17-rc1.

Thanks,
-Paul

Le sam. 6 janv. 2018 à 17:58, Paul Cercueil <paul@crapouillou.net> a 
écrit :
> This permits clients of this driver to specify the polarity to use for
> their PWM channel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/pwm/pwm-jz4740.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index 2e41ba213f39..6539c001fe32 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -130,10 +130,29 @@ static int jz4740_pwm_config(struct pwm_chip 
> *chip, struct pwm_device *pwm,
>  	return 0;
>  }
> 
> +static int jz4740_pwm_set_polarity(struct pwm_chip *chip,
> +		struct pwm_device *pwm, enum pwm_polarity polarity)
> +{
> +	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->pwm);
> +
> +	switch (polarity) {
> +	case PWM_POLARITY_NORMAL:
> +		ctrl &= ~JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
> +		break;
> +	case PWM_POLARITY_INVERSED:
> +		ctrl |= JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
> +		break;
> +	}
> +
> +	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
> +	return 0;
> +}
> +
>  static const struct pwm_ops jz4740_pwm_ops = {
>  	.request = jz4740_pwm_request,
>  	.free = jz4740_pwm_free,
>  	.config = jz4740_pwm_config,
> +	.set_polarity = jz4740_pwm_set_polarity,
>  	.enable = jz4740_pwm_enable,
>  	.disable = jz4740_pwm_disable,
>  	.owner = THIS_MODULE,
> --
> 2.11.0
> 
