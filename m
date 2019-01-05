Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F2AC43444
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AF82231B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="EI2cnr69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfAEVGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 16:06:01 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:35844 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfAEVGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 16:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1546722357; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fkt09vQJF+9zLmZ0ojGsJB9dWYlKrc/IC87NSo6xix4=;
        b=EI2cnr691Hi2v0b8cREcjxbjVQXcmWnnuJaO2+LRMgWBdnioMxGjMVp7gMmzzl+TLGp1qs
        dJqWUwJywi9TXvLRABQYLCfmMqDVKdOt+CFAQqy2m5PWNXQs5py5gqoqjV6rKwuxxq7C1M
        02n0fkYxgsETf31Yld93zl/o3XNExKs=
Date:   Sat, 05 Jan 2019 18:05:38 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v9 14/27] pwm: jz4740: Improve algorithm of clock
 calculation
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
        Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Message-Id: <1546722339.30174.0@crapouillou.net>
In-Reply-To: <20190105195725.cuxfge6zkpbt3cyk@pengutronix.de>
References: <20181227181319.31095-1-paul@crapouillou.net>
        <20181227181319.31095-15-paul@crapouillou.net>
        <20190105195725.cuxfge6zkpbt3cyk@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jan 5, 2019 at 4:57 PM, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> wrote:
> On Thu, Dec 27, 2018 at 07:13:06PM +0100, Paul Cercueil wrote:
>>  The previous algorithm hardcoded details about how the TCU clocks=20
>> work.
>>  The new algorithm will use clk_round_rate to find the perfect clock=20
>> rate
>>  for the PWM channel.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>       v9: New patch
>>=20
>>   drivers/pwm/pwm-jz4740.c | 26 +++++++++++++++-----------
>>   1 file changed, 15 insertions(+), 11 deletions(-)
>>=20
>>  diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
>>  index c6136bd4434b..dd80a2cf6528 100644
>>  --- a/drivers/pwm/pwm-jz4740.c
>>  +++ b/drivers/pwm/pwm-jz4740.c
>>  @@ -110,23 +110,27 @@ static int jz4740_pwm_apply(struct pwm_chip=20
>> *chip, struct pwm_device *pwm,
>>   	struct jz4740_pwm_chip *jz4740 =3D to_jz4740(pwm->chip);
>>   	struct clk *clk =3D jz4740->clks[pwm->hwpwm],
>>   		   *parent_clk =3D clk_get_parent(clk);
>>  -	unsigned long rate, period, duty;
>>  +	unsigned long rate, new_rate, period, duty;
>>   	unsigned long long tmp;
>>  -	unsigned int prescaler =3D 0;
>>=20
>>   	rate =3D clk_get_rate(parent_clk);
>>  -	tmp =3D (unsigned long long)rate * state->period;
>>  -	do_div(tmp, 1000000000);
>>  -	period =3D tmp;
>>=20
>>  -	while (period > 0xffff && prescaler < 6) {
>>  -		period >>=3D 2;
>>  -		rate >>=3D 2;
>>  -		++prescaler;
>>  +	for (;;) {
>>  +		tmp =3D (unsigned long long)rate * state->period;
>>  +		do_div(tmp, 1000000000);
>=20
> NSEC_PER_SEC?

Ok, didn't know about it.

>>  +
>>  +		if (tmp <=3D 0xffff)
>>  +			break;
>>  +
>>  +		new_rate =3D clk_round_rate(clk, rate - 1);
>>  +
>>  +		if (new_rate < rate)
>>  +			rate =3D new_rate;
>>  +		else
>>  +			return -EINVAL;
>=20
> You are assuming stuff here about the parent clk which isn't=20
> guaranteed
> (AFAICT) by the clk framework: If you call clk_round_rate(clk, rate -=20
> 1)
> this might well return rate even if the clock could run slower than
> rate.

It may not be guaranteed by the clock framework itself, but it is=20
guaranteed
to behave like that on this family of SoCs.

> Wouldn't it make sense to start iterating with rate =3D 0xffff * 1e9 /
> period? Otherwise you get bad configurations if rate is considerable
> slower than necessary.

The algorithm will start with 'rate' being the parent clock's rate,=20
which
will always be the highest rate that the child clock will support.

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |
=

