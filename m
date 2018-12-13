Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7888C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645E320851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="T7UHAV5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645E320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbeLMOe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:34:59 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:33626 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMOe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:34:58 -0500
Date:   Thu, 13 Dec 2018 15:34:48 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 11/26] pwm: jz4740: Use regmap and clocks from TCU
 driver
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
Message-Id: <1544711688.18952.2@crapouillou.net>
In-Reply-To: <20181213093049.rxdvf6tip7iqdj3c@pengutronix.de>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <20181212220922.18759-12-paul@crapouillou.net>
        <20181213093049.rxdvf6tip7iqdj3c@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1544711695; bh=vaRtKNxh69Zx4hzvWE5BlnM9SpbIUcaAwID6xRuePy8=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=T7UHAV5/VDNreRQfwVVjkZX+9isrsLbPDUyjv9HX0ECy20R2rJZgWtH8FSok79fnY87YvQff34fYuHIwmRmCVTFQGkRzUs0Lclil4Imr34ZWTQy6ETzwB2nJX8dGGZskwkrWKvJNBRbUrM+DSnhnqOcNo5FSow8chDMzWibIufs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeu. 13 d=E9c. 2018 =E0 10:30, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello,
>=20
> On Wed, Dec 12, 2018 at 11:09:06PM +0100, Paul Cercueil wrote:
>>  [...]
>>   static int jz4740_pwm_enable(struct pwm_chip *chip, struct=20
>> pwm_device *pwm)
>>   {
>>  -	uint32_t ctrl =3D jz4740_timer_get_ctrl(pwm->pwm);
>>  +	struct jz4740_pwm_chip *jz =3D to_jz4740(chip);
>>=20
>>  -	ctrl |=3D JZ_TIMER_CTRL_PWM_ENABLE;
>>  -	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
>>  -	jz4740_timer_enable(pwm->hwpwm);
>>  +	/* Enable PWM output */
>>  +	regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
>>  +				TCU_TCSR_PWM_EN, TCU_TCSR_PWM_EN);
>=20
> Usually follow-up lines are indented to the matching parenthesis.

OK.

>>  [...]
>>   static int jz4740_pwm_config(struct pwm_chip *chip, struct=20
>> pwm_device *pwm,
>>   			     int duty_ns, int period_ns)
>>   {
>>   	struct jz4740_pwm_chip *jz4740 =3D to_jz4740(pwm->chip);
>>  +	struct clk *clk =3D jz4740->clks[pwm->hwpwm];
>>  +	unsigned long rate, new_rate, period, duty;
>>   	unsigned long long tmp;
>>  -	unsigned long period, duty;
>>  -	unsigned int prescaler =3D 0;
>>  -	uint16_t ctrl;
>>  +	unsigned int tcsr;
>>   	bool is_enabled;
>>=20
>>  -	tmp =3D (unsigned long long)clk_get_rate(jz4740->clk) * period_ns;
>>  -	do_div(tmp, 1000000000);
>>  -	period =3D tmp;
>>  +	rate =3D clk_get_rate(clk);
>>  +
>>  +	for (;;) {
>>  +		tmp =3D (unsigned long long) rate * period_ns;
>>  +		do_div(tmp, 1000000000);
>>=20
>>  -	while (period > 0xffff && prescaler < 6) {
>>  -		period >>=3D 2;
>>  -		++prescaler;
>>  +		if (tmp <=3D 0xffff)
>>  +			break;
>>  +
>>  +		new_rate =3D clk_round_rate(clk, rate / 2);
>>  +
>>  +		if (new_rate < rate)
>>  +			rate =3D new_rate;
>>  +		else
>>  +			return -EINVAL;
>>   	}
>>=20
>>  -	if (prescaler =3D=3D 6)
>>  -		return -EINVAL;
>>  +	clk_set_rate(clk, rate);
>=20
> Maybe this could better live in a separate patch. If you split still
> further to have the conversion to regmap in a single patch, then the
> conversion to the clk_* functions and then improve the algorithm for=20
> the
> clk settings each of the patches is easier to review than this one=20
> patch
> that does all three things at once.

I can try.

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |
=

