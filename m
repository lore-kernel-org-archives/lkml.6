Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D4CC10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA822077B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="PYc1r9Qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfBWBSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 20:18:25 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:54142 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBWBSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 20:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1550884700; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2Gzx13EM6NHHpEWkJGNYC/vDL9E3xqHovmRZEC0C7Y=;
        b=PYc1r9QhSE1uAxYeMTY4hpm+IGKCnis5GhyYUKQnw/6PPV4cVISFdST77HlfrNhUMOz0Bp
        BRF2HJ1/2YQhU+tQMqm56e8vzEkS65K+EHViYNfX/n5SfRSw+Db1YfNL0x0owV0544oPY8
        bUllPRgZKDjLKFqIqSLVKYTWHXHQSTk=
Date:   Fri, 22 Feb 2019 22:17:58 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v9 14/27] pwm: jz4740: Improve algorithm of clock
 calculation
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>
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
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Message-Id: <1550884678.20534.0@crapouillou.net>
In-Reply-To: <1547129096.16183.0@crapouillou.net>
References: <20181227181319.31095-1-paul@crapouillou.net>
        <20181227181319.31095-15-paul@crapouillou.net>
        <20190105195725.cuxfge6zkpbt3cyk@pengutronix.de>
        <1546722339.30174.0@crapouillou.net>
        <20190105212711.s765knwwerceytvk@pengutronix.de>
        <1547129096.16183.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeu. 10 janv. 2019 =E0 11:04, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> Adding Stephen to the discussion.
> Adding Stephen to the discussion.
>=20
> On Sat, Jan 5, 2019 at 6:27 PM, Uwe Kleine-K=F6nig=20
> <u.kleine-koenig@pengutronix.de> wrote:
>> Hello Paul,
>>=20
>> On Sat, Jan 05, 2019 at 06:05:38PM -0300, Paul Cercueil wrote:
>>>  On Sat, Jan 5, 2019 at 4:57 PM, Uwe Kleine-K=F6nig
>>>  <u.kleine-koenig@pengutronix.de> wrote:
>>>  > You are assuming stuff here about the parent clk which isn't=20
>>> =7F=7Fguaranteed
>>>  > (AFAICT) by the clk framework: If you call clk_round_rate(clk,=20
>>> =7F=7Frate - 1)
>>>  > this might well return rate even if the clock could run slower=20
>>> =7F=7Fthan
>>>  > rate.
>>>=20
>>>  It may not be guaranteed by the clock framework itself, but it is=20
>>> =7F=7Fguaranteed
>>>  to behave like that on this family of SoCs.
>>=20
>> You shouldn't rely on that. Experience shows that people will start
>> copying code to machines where this is not guaranteed. Even if they
>> don't copy and only learn from reading this is bad. Also how do you
>> guarantee that this won't change in the future making the pwm code=20
>> =7Fbreak
>> without noticing?
>>=20
>> If you use an API better don't assume more things given than are
>> guaranteed by the API.
>>=20
>> Having said that I would consider it sensible to introduce something
>> like clk_roundup_rate() and clk_rounddown_rate() which would allow
>> calculations like that.
>=20
> @Stephen:
> Some context: my algorithm makes use of clk_round_rate(clk, rate - 1)=20
> to get the
> next (smaller) clock rate that a clock support.
>=20
> Is it something safe to assume? If not is there a better way?

Bump.

What should I do here?

>>>  > Wouldn't it make sense to start iterating with rate =3D 0xffff *=20
>>> =7F=7F1e9 /
>>>  > period? Otherwise you get bad configurations if rate is=20
>>> =7F=7Fconsiderable
>>>  > slower than necessary.
>>>=20
>>>  The algorithm will start with 'rate' being the parent clock's=20
>>> rate, =7F=7Fwhich
>>>  will always be the highest rate that the child clock will support.
>>=20
>> Ah right, I missed that bit.

Thanks,
-Paul
=

