Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF29C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A1320C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="wurYaYtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A1320C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390797AbeGKX2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 19:28:54 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53558 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732195AbeGKX2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 19:28:54 -0400
Date:   Thu, 12 Jul 2018 01:22:12 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 0/5] pinctrl_gpio_get_direction & ingenic fixes
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <1531351332.2021.2@smtp.crapouillou.net>
In-Reply-To: <CACRpkdav3FV7hc20Fj=n=DaNzvSaA2uLuj8QgHwwcevDkn_6_Q@mail.gmail.com>
References: <20180627114904.10890-1-paul@crapouillou.net>
        <CAHp75Vc3QTYKp6oS6kW6EezsBbiLf9E=NBErHMbpxRU9EXMxWg@mail.gmail.com>
        <CACRpkdav3FV7hc20Fj=n=DaNzvSaA2uLuj8QgHwwcevDkn_6_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531351335; bh=B6kn8SZaY4bt0FSoT6aeY3H4UOJTwi1LFuUIb9i/vlE=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=wurYaYtgGvVgNnD/rDA5u8oXdh7uHib982lln+IK+gZfAQPi9+W9lW4F18mfYs8PIewcUuHFFqHgQGJFKFwDeCVckvEJANT47qCSOjcJkt1TdVGVW4Ev+qzvrff8TT5fjIfV/COIvKXOUsCR8k4LpwO09gh5/SZxRIm4T3sQ2qE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,


Le lun. 9 juil. 2018 =E0 14:09, Linus Walleij <linus.walleij@linaro.org>=20
a =E9crit :
> Hi folks,
>=20
> On Wed, Jun 27, 2018 at 7:18 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>=20
>>  Even if GPIO and pin muxing has only one set of buffers to indicate
>>  input or output (same registers in use) it's a GPIO driver business=20
>> to
>>  get direction from GPIO part of IP.
>>=20
>>  Looking into the existing code I would rather say that
>>  pinctrl-ingenic.c should incorporate gpio-ingenic.c as they are
>>  (partially) sharing same registers.
>=20
> Usually we only split the functionality into two drivers if the two=20
> features
> pin control and GPIO are explicitly in different hardware blocks,
> and typically not sharing the same memory range.
>=20
> If these registers are intermingled and the hardware actually
> just one piece of silicon, I would suggest to try to merge the
> two drivers into a combined pin control and GPIO driver
> inside drivers/pinctrl/pinctrl-ingenic.c.
>=20
> We have a few drivers like that already, good textbook
> examples of how to do this include
> drivers/pinctrl/pinctrl-sx150x.c where the two blocks are
> handled in one driver using both APIs.
>=20
> Paul could you have a look at if we can simply merge these
> two into one big driver? It is much more natural to write
> into the same set of registers when we do that.

Well I wish you had told me that when I submitted the ingenic=20
pinctrl/gpio
patchset :)

I won't have much time before 4.19-rc1, but I can have a look after=20
that.

> If you still prefer to proceed with the GPIO/pinctrl as separate
> drivers we need to look into this patch set, which I am
> a bit ambivalent about, because it makes sense but at the
> same time I want to keep GPIO and pin control business
> separate because separation of concerns is just nice.

Well I can still implement the get_direction() function in the GPIO
driver by reading the registers instead of calling into pinctrl.

I just thought it felt illogic as set_direction() does that.

> Yours,
> Linus Walleij

Thanks,
-Paul
=

