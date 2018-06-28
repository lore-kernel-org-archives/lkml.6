Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769A1C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBCC2784D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="chNAPO41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBCC2784D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753728AbeF1TLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:11:19 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53808 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbeF1TLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:11:18 -0400
Date:   Thu, 28 Jun 2018 21:11:06 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 0/5] pinctrl_gpio_get_direction & ingenic fixes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <1530213066.3755.0@smtp.crapouillou.net>
In-Reply-To: <CAHp75Vc3QTYKp6oS6kW6EezsBbiLf9E=NBErHMbpxRU9EXMxWg@mail.gmail.com>
References: <20180627114904.10890-1-paul@crapouillou.net>
        <CAHp75Vc3QTYKp6oS6kW6EezsBbiLf9E=NBErHMbpxRU9EXMxWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530213075; bh=mgVWQ/s9fIAZBH5KoCSkbtKGBqTkABjO7ucduGcRTHE=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=chNAPO41fZ3pBpHf85K9Y40ZE86cF5w4Uu7fFVME5kiaxGRveYykU3T1p89T9UtE+uukiwNHM7rupCDcqiwl1M1+Svy3KpQyj2ircyiWWdSBZ2q3qTO3E1K98eGqNYgFDCA3AifkBxzJx6zVltcFVKY+KczG6sTY6SXXPbo7WAs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andy,

Le mer. 27 juin 2018 =E0 19:18, Andy Shevchenko=20
<andy.shevchenko@gmail.com> a =E9crit :
> On Wed, Jun 27, 2018 at 2:48 PM, Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>  Hi Linus,
>>=20
>>  Here's a set of (rather RFC) patches, to implement
>>  pinctrl_gpio_get_direction(). I did that, because my gpio-ingenic=20
>> driver
>>  calls pinctrl_gpio_set_direction() within its gpio_chip's=20
>> .set_direction
>>  callback, but there was no corresponding function to implement the
>>  .get_direction callback. If that's not the right way to do it,=20
>> please
>>  advise.
>>=20
>>  If not merging the whole series, patch [3/5] is a real fix that=20
>> should
>>  go through.
>>=20
>>  Note that it doesn't make checkpatch.pl happy, I wasn't sure=20
>> whether I
>>  should try to comply to checkpatch.pl or match the coding style in=20
>> the
>>  pinctrl subsystem, I chose the latter.
>=20
> I dunno what Linus would going to say about this, but I would like to
> see a schematics for this piece of IP.

ftp://ftp.ingenic.com/SOC/JZ4780/JZ4780_pm.pdf

> Even if GPIO and pin muxing has only one set of buffers to indicate
> input or output (same registers in use) it's a GPIO driver business to
> get direction from GPIO part of IP.

If I follow that logic it's also a GPIO driver business to set the=20
direction
of a GPIO, right? Truth is the pinctrl subsystem takes care of that. So=20
why
have "set direction" and no "get direction"?

> Looking into the existing code I would rather say that
> pinctrl-ingenic.c should incorporate gpio-ingenic.c as they are
> (partially) sharing same registers.
> To ->get_direction() implementation it's pretty straight forward, just
> read necessary registers in the gpio-ingenic.c directly. No need to
> have pin control or pin muxing to be involved.

Sure, it'd be pretty straightforward to do it from the GPIO driver, but=20
I'd
still like to hear Linus' point of view about this.

As for merging pinctrl-ingenic.c and gpio-ingenic.c... I wouldn't=20
disagree more,
even if they share registers, they belong to different subsystems.=20
Besides,
your platform might need the pinctrl driver but not the GPIO one, or=20
you might
want to provide the GPIO driver as a loadable module, etc.

Regards,
-Paul
=

