Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D01C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC46F2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfBUUm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:42:26 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37581 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUUmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:42:25 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gwvAd-0007TW-ML; Thu, 21 Feb 2019 21:42:15 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gwvAd-0005Av-07; Thu, 21 Feb 2019 21:42:15 +0100
Date:   Thu, 21 Feb 2019 21:42:14 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Claudiu.Beznea@microchip.com
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] pwm: atmel: add support for controllers with 32
 bit counters
Message-ID: <20190221204214.krpobz2ezneynht5@pengutronix.de>
References: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
 <1550570914-26391-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1550570914-26391-3-git-send-email-claudiu.beznea@microchip.com>
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

On Tue, Feb 19, 2019 at 10:08:57AM +0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> New SAM9X60's PWM controller use 32 bits counters thus it could generate
> signals with higher period and duty cycles than the old ones. Prepare the
> current driver to be able to work with old controllers (that uses 16 bits
> counters) and with the new SAM9X60's controller, by providing counters
> information based on compatible.

I'd write:

	The PWM controller of the new SAM9X60 SoC uses 32 bit wide
	counters compared to 16 bit wide counters in the earlier chips.
	To support this add a new structure to the compatibles' data
	that describe the counter width and precision and make use of
	them instead of the hard coded values.

Other than that the commit looks fine.

> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/pwm/pwm-atmel.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 7e86a5266eb6..647d063562db 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -48,15 +48,11 @@
>  #define PWMV2_CPRD		0x0C
>  #define PWMV2_CPRDUPD		0x10
>  
> -/*
> - * Max value for duty and period
> - *
> - * Although the duty and period register is 32 bit,
> - * however only the LSB 16 bits are significant.
> - */
> -#define PWM_MAX_DTY		0xFFFF
> -#define PWM_MAX_PRD		0xFFFF
> -#define PRD_MAX_PRES		10
> +/* Max values for period and prescaler */
> +
> +/* Only the LSB 16 bits are significant. */
> +#define PWM_MAXV1_PRD		0xFFFF
> +#define PRD_MAXV1_PRES		10
>  
>  struct atmel_pwm_registers {
>  	u8 period;
> @@ -65,8 +61,14 @@ struct atmel_pwm_registers {
>  	u8 duty_upd;
>  };
>  
> +struct atmel_pwm_config {
> +	u32 max_period;
> +	u32 max_pres;
> +};
> +
>  struct atmel_pwm_data {
>  	struct atmel_pwm_registers regs;
> +	struct atmel_pwm_config cfg;
>  };
>  
>  struct atmel_pwm_chip {
> @@ -125,10 +127,10 @@ static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
>  	cycles *= clk_get_rate(atmel_pwm->clk);
>  	do_div(cycles, NSEC_PER_SEC);
>  
> -	for (*pres = 0; cycles > PWM_MAX_PRD; cycles >>= 1)
> +	for (*pres = 0; cycles > atmel_pwm->data->cfg.max_period; cycles >>= 1)
>  		(*pres)++;

Orthogonal to this patch, this could be calculated without a loop.
Something like

	pres = roundup_pow_of_two(cycles);
	if (pres > bitwidth_of_counter_register)
		pres -= bitwidth_of_counter_register;
	else
		pres = 0

(where bitwidth_of_counter_register is 16 for the older PWMs and 32 for
the new one). Maybe it would make more sense to put 16 into the
structure describing the PWM then instead of 0xffff (which is easily
calculated from 16)? If picking this up, you might have to pay
attention to pick functions that support long long arguments.
roundup_pow_of_two() doesn't as of now.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
