Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51876C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1894A20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="JBbFAERd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1894A20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbeLMN6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:58:42 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:57384 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbeLMN6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:58:42 -0500
Date:   Thu, 13 Dec 2018 14:58:31 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 12/26] pwm: jz4740: Allow selection of PWM channels 0
 and 1
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me
Message-Id: <1544709511.18952.0@crapouillou.net>
In-Reply-To: <20181213091822.r5ilpsllfhzaiqw4@pengutronix.de>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <20181212220922.18759-13-paul@crapouillou.net>
        <20181213091822.r5ilpsllfhzaiqw4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1544709518; bh=26MoHcxWFkAmikKZd//2oI7Jptf7WKxs2OlZ7GVv+Io=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=JBbFAERd2CX+tEa7VVKLv26zALIkQ8qAjxxGiPYlZhXx/jnbcaM36KjqZhphUYdV/xmAz+JRgiIQph+EcRo6J8rRSWlUOzhYwDX4RTT7kt9M/o8qCe5+4oPx2bqMUKpgtYhB77ezxHcy8LJsa2wBl+5IXs1HCi0HE8Vt3ttVhsI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeu. 13 d=E9c. 2018 =E0 10:18, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> On Wed, Dec 12, 2018 at 11:09:07PM +0100, Paul Cercueil wrote:
>>  The TCU channels 0 and 1 were previously reserved for system tasks,=20
>> and
>>  thus unavailable for PWM.
>>=20
>>  The driver will now only allow a PWM channel to be requested if=20
>> memory
>>  resources corresponding to the register area of the channel were
>>  supplied to the driver. This allows the TCU channels to be reserved=20
>> for
>>  system tasks from within the devicetree.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>=20
> While there is someone caring for this driver I'd like to complete (a
> bit) my picture about the different capabilities and specialities of=20
> the
> supported PWMs. So I have a few questions:
>=20
> Is there a publicly available reference manual for this device? (If
> yes, adding a link to the driver would be great.)

I have them here: https://zcrc.me/~paul/jz_docs/

> jz4740_pwm_config looks as if the currently running period isn't
> completed before the new config is in effect. Is that correct? If yes,
> can this be fixed? A similar question for set_polarity: Does setting=20
> the
> JZ_TIMER_CTRL_PWM_ACTIVE_LOW bit in the control register take effect
> immediately or is this shadowed until the next period starts?

I don't really know. We only use this driver for a rumble motor and=20
backlight.
Somebody would have to check with a logic analyzer.

> How does the device's output behave after the PWM is disabled?
> Does it complete the currently running period? How does the output
> behave then? (active/inactive/high/low/high-z?)

There's a bit to toggle between "graceful" shutdown (bit clear) and=20
"abrupt"
shutdown (bit set). TCSR bit 9. I think that graceful shutdown will=20
complete
the running period, then keep the level active. Abrupt shutdown will=20
keep the
current level of the line.

>>  @@ -42,11 +68,7 @@ static int jz4740_pwm_request(struct pwm_chip=20
>> *chip, struct pwm_device *pwm)
>>   	char clk_name[16];
>>   	int ret;
>>=20
>>  -	/*
>>  -	 * Timers 0 and 1 are used for system tasks, so they are=20
>> unavailable
>>  -	 * for use as PWMs.
>>  -	 */
>>  -	if (pwm->hwpwm < 2)
>>  +	if (!jz4740_pwm_can_use_chn(jz, pwm->hwpwm))
>>   		return -EBUSY;
>=20
> Maybe EBUSY isn't the best choice here. If the needed register space=20
> for
> the requested pwm is not included in the memory resources provided to
> the device I'd prefer ENXIO or ENODEV.

The idea was that if we don't get the register space we need, that means
the channel is used for something else, hence the EBUSY. Should I switch
it to ENXIO?

>>   	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
>>  @@ -208,6 +230,12 @@ static int jz4740_pwm_probe(struct=20
>> platform_device *pdev)
>>   		return -EINVAL;
>>   	}
>>=20
>>  +	jz4740->parent_res =3D platform_get_resource(
>>  +				to_platform_device(dev->parent),
>>  +				IORESOURCE_MEM, 0);
>>  +	if (!jz4740->parent_res)
>>  +		return -EINVAL;
>>  +
>>   	jz4740->chip.dev =3D dev;
>>   	jz4740->chip.ops =3D &jz4740_pwm_ops;
>>   	jz4740->chip.npwm =3D NUM_PWM;
>=20
> Thanks
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |
=

