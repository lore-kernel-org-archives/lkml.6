Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69585C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4311D218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbfBKTGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:06:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54393 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731751AbfBKTGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:06:38 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gtGuU-00066d-Ph; Mon, 11 Feb 2019 20:06:30 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gtGuS-0007sp-If; Mon, 11 Feb 2019 20:06:28 +0100
Date:   Mon, 11 Feb 2019 20:06:28 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, tduszyns@gmail.com,
        mark.rutland@arm.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 3/3] pwm: core: add consumer device link
Message-ID: <20190211190628.eisyi6wjus4ltrrn@pengutronix.de>
References: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
 <1549901522-15071-4-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1549901522-15071-4-git-send-email-fabrice.gasnier@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fabrice,

On Mon, Feb 11, 2019 at 05:12:02PM +0100, Fabrice Gasnier wrote:
> Add a device link between the PWM consumer and the PWM provider. This
> enforces the PWM user to get suspended before the PWM provider. It
> allows proper synchronization of suspend/resume sequences: the PWM user
> is responsible for properly stopping PWM, before the provider gets
> suspended: see [1]. Add the device link in:
> - pwm_get()
> - devm_pwm_get()
> - devm_of_pwm_get()
> as it requires a reference to the device for the PWM consumer.
> 
> [1] https://lkml.org/lkml/2019/2/5/770
> 
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/core.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 1581f6a..2835e27 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -770,8 +770,13 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>  	int err;
>  
>  	/* look up via DT first */
> -	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
> -		return of_pwm_get(dev->of_node, con_id);
> +	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node) {
> +		pwm = of_pwm_get(dev->of_node, con_id);
> +		if (!IS_ERR(pwm))
> +			device_link_add(dev, pwm->chip->dev,
> +					DL_FLAG_AUTOREMOVE_CONSUMER);
> +		return pwm;
> +	}
>  
>  	/*
>  	 * We look up the provider in the static table typically provided by
> @@ -851,6 +856,8 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>  	pwm->args.period = chosen->period;
>  	pwm->args.polarity = chosen->polarity;
>  
> +	device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> +
>  	return pwm;
>  }
>  EXPORT_SYMBOL_GPL(pwm_get);
> @@ -943,6 +950,8 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
>  	if (!IS_ERR(pwm)) {
>  		*ptr = pwm;
>  		devres_add(dev, ptr);
> +		device_link_add(dev, pwm->chip->dev,
> +				DL_FLAG_AUTOREMOVE_CONSUMER);

IMHO it's surprising that devm_of_pwm_get() does more than of_pwm_get()
+ devres stuff. I'd put device_link_add() into of_pwm_get().

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
