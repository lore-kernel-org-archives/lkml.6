Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88F1C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919BD2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfBEUrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:47:45 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56913 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfBEUro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:47:44 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gr7d0-00038p-P4; Tue, 05 Feb 2019 21:47:34 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gr7cy-0005Ed-MN; Tue, 05 Feb 2019 21:47:32 +0100
Date:   Tue, 5 Feb 2019 21:47:32 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     jic23@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        vilhelm.gray@gmail.com, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
Message-ID: <20190205204732.zrbhgyxnvjbwfyw4@pengutronix.de>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Feb 05, 2019 at 01:40:27PM +0100, Fabrice Gasnier wrote:
> Add suspend/resume PM sleep ops. When going to low power, disable
> active PWM channel. Active PWM channel is resumed, by calling
> pwm_apply_state(). This is inspired by Thierry's comment in [1].
> Don't touch inactive channels, as it may be used by other LPTimer MFD
> child driver.
> [1]https://lkml.org/lkml/2017/12/5/175
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> index 0059b24c..0c40d48 100644
> --- a/drivers/pwm/pwm-stm32-lp.c
> +++ b/drivers/pwm/pwm-stm32-lp.c
> @@ -13,6 +13,7 @@
>  #include <linux/mfd/stm32-lptimer.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  
> @@ -20,6 +21,8 @@ struct stm32_pwm_lp {
>  	struct pwm_chip chip;
>  	struct clk *clk;
>  	struct regmap *regmap;
> +	struct pwm_state suspend;
> +	bool suspended;
>  };
>  
>  static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
> @@ -223,6 +226,40 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
>  	return pwmchip_remove(&priv->chip);
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int stm32_pwm_lp_suspend(struct device *dev)
> +{
> +	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
> +
> +	pwm_get_state(&priv->chip.pwms[0], &priv->suspend);
> +	priv->suspended = priv->suspend.enabled;
> +
> +	/* safe to call pwm_disable() for already disabled pwm */
> +	pwm_disable(&priv->chip.pwms[0]);
> +
> +	return pinctrl_pm_select_sleep_state(dev);

IMHO a PWM should not stop if the PWM user didn't call pwm_disable() (or
pwm_apply_state() with .enabled = false).

I don't understand all the PM details, but I think there is no defined
order in which devices are signalled to suspend. If so the PWM might be
stopped before its consumer. Then the PWM changes state without the
consumer being aware of that.

I understand Thierry's position in the link you provided in the commit
log consistant with my position here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
