Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44846C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084932086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084932086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeKHCAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:00:17 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52353 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbeKHCAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:00:16 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gKQhZ-0005py-Ln; Wed, 07 Nov 2018 17:29:09 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gKQhZ-0007KT-3M; Wed, 07 Nov 2018 17:29:09 +0100
Date:   Wed, 7 Nov 2018 17:29:09 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suji Velupillai <suji.velupillai@broadcom.com>
Subject: Re: [PATCH 2/2] pwm: bcm-kona: apply pwm settings on enable
Message-ID: <20181107162908.tejzekhc35pbknut@pengutronix.de>
References: <20181107093613.26734-1-peron.clem@gmail.com>
 <20181107093613.26734-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181107093613.26734-2-peron.clem@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 07, 2018 at 10:36:13AM +0100, Clément Péron wrote:
> From: Suji Velupillai <suji.velupillai@broadcom.com>
> 
> When pwm_bl framework calls enable, a call to pwm_is_enabled(pwm) still
> return false, this prevents the backlight being turn on at boot time.
> 
> Signed-off-by: Suji Velupillai <suji.velupillai@broadcom.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> index 09a95aeb3a70..d991d53c4b38 100644
> --- a/drivers/pwm/pwm-bcm-kona.c
> +++ b/drivers/pwm/pwm-bcm-kona.c
> @@ -108,8 +108,8 @@ static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
>  	ndelay(400);
>  }
>  
> -static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
> -			    int duty_ns, int period_ns)
> +static int __pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 int duty_ns, int period_ns, bool pwmc_enabled)
>  {
>  	struct kona_pwmc *kp = to_kona_pwmc(chip);
>  	u64 val, div, rate;
> @@ -155,7 +155,7 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	 * always calculated above to ensure the new values are
>  	 * validated immediately instead of on enable.
>  	 */
> -	if (pwm_is_enabled(pwm)) {
> +	if (pwm_is_enabled(pwm) || pwmc_enabled) {

Having pwm-API-calls in hw-drivers is ugly. Apart from not giving the
intended return code this function should IMHO be reserved to pwm
consumers. The underlaying problem is that pwm-bl does:

	pwm_config(pwm, duty_cycle, period);
	pwm_enable(pwm);

and expects that the duty_cycle and period is used then. Doesn't
everything works just fine if the if-block is always executed?

The better fix here would be to convert the driver to the atomic API
(i.e. implement .apply instead of .config, .set_polarity, .enable and
.disable).

Alternatively in .enable ensure that the hardware is programmed with the
parameters from pwm->state. (But converting to the atomic API is the
better approach.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
