Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFE2C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA015222F0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="UIINnWqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfAEUqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:46:42 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:46526 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfAEUql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1546721197; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHe/ZBXwRJD2vtuchEr4bfhlNRWlZCQ6Rnk/RfFz72g=;
        b=UIINnWqPFRgPmvn6+knV+MJo6fGrDjTwaitj+VcIpl2Ur81KAjWbKoU17MGSq9u9MDvbOg
        53x2a7w7uXD6m2IoayvXFPztGtlv8SJuy2T3kxsjJUIcRmbmkCv1BV2MueZzWRgE1yLtb7
        frScfE1GSsp58aaG4b7jrl+lCiNKtvM=
Date:   Sat, 05 Jan 2019 17:46:18 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v9 12/27] pwm: jz4740: Use regmap from TCU driver
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
Message-Id: <1546721178.28727.0@crapouillou.net>
In-Reply-To: <20190105194226.pe4huzynz4civ3lm@pengutronix.de>
References: <20181227181319.31095-1-paul@crapouillou.net>
        <20181227181319.31095-13-paul@crapouillou.net>
        <20190105194226.pe4huzynz4civ3lm@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Sat, Jan 5, 2019 at 4:42 PM, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> wrote:
> On Thu, Dec 27, 2018 at 07:13:04PM +0100, Paul Cercueil wrote:
>>  The ingenic-timer "TCU" driver provides us with a regmap, that we=20
>> can
>>  use to safely access the TCU registers.
>>=20
>>  While this driver is devicetree-compatible, it is never (as of now)
>>  probed from devicetree, so this change does not introduce a ABI=20
>> problem
>>  with current devicetree files.
>=20
> Does it change behaviour? If so, how?

No, it does not change the behaviour.

>>  @@ -113,26 +117,37 @@ static int jz4740_pwm_apply(struct pwm_chip=20
>> *chip, struct pwm_device *pwm,
>>=20
>>   	jz4740_pwm_disable(chip, pwm);
>>=20
>>  -	jz4740_timer_set_count(pwm->hwpwm, 0);
>>  -	jz4740_timer_set_duty(pwm->hwpwm, duty);
>>  -	jz4740_timer_set_period(pwm->hwpwm, period);
>>  +	/* Set abrupt shutdown */
>>  +	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
>>  +			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
>=20
> I think I already pointed that out before: abrupt mode is wrong. If
> .apply is called with a new set of parameters the currently running
> period with the old values is expected to complete before the new=20
> values
> take effect.

You pointed it, indeed; but I won't change it until I can verify that=20
the
behaviour is correct (which does not seem to be the case even if I leave
this bit cleared). Besides, this is the TCU patchset, fixes and patches
unrelated to the TCU don't belong here.

> Best regards
> Uwe

Kind regards,
-Paul
=

