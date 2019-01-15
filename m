Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50F9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8575220657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YjhwLD/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfAOMAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:00:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46430 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbfAOMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:00:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so2023434ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A2TnvTce074ilZIpjnc5rnhGM3ugBMbYPiWmZkyaNQE=;
        b=YjhwLD/q98Jd63P1qmtCXWROtKn43eDj1lrVAuAf75xQxF4+wUk2kbGdC6ceplJU+W
         Iy/II0RhTcl+GPiSzPKn41eEnG7jcWhj7uiqQAtfdO/EQcL7brEGvCGKjzbjexsdXepB
         Y4Bxz6q3gyqHLKrW/8k9gATnvK153IS7WCOkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A2TnvTce074ilZIpjnc5rnhGM3ugBMbYPiWmZkyaNQE=;
        b=Tqx2VF9MV8rKajSYSmoL6drffc5yhwWiUimCXLLQyeJqXSy54GTGikriBgLPpZzJSL
         wpnibIOBKsA9K3ofNaUXVvD/HwwFkmJsC0UpK4G0iJ5PCw6TnW2x5vRzcAzGAIVkabvQ
         ASQmgJ2WBTFvex+UNfp7KHsH5B+Qg38B7QwqW/AJynLZRQF7F/FByJm4IM/r1GDgMzVs
         kHMF1Tew6Bahjg9zKQHmAd9DSwcsU+rRiqRx0NUIl9IswCz7caM1ooWbeRd3bleG65w5
         RKCoesSWl8hdCPsCtHz1DCKNy69ILlXuekEARFRpWu5aI2Us5jNv9OOrtF5GU63TRPxq
         TMGA==
X-Gm-Message-State: AJcUukeQ1ZrELHJYBUGTcQK08ylBEC+6cJe2U0fBMFzfKYTrJ/PijbnR
        mlICpBdQANn0lxAvizP1ntrgbA9Yz0jrCJFKUuMVJQ==
X-Google-Smtp-Source: ALg8bN6HuyGoizI2/u+t8I79gSKj2V3SvDiKujaSc+WISkahm8OhrMzOTugzj6oZWdW7Yjw1C/QbYuC5CPfsz5no2os=
X-Received: by 2002:a2e:5854:: with SMTP id x20-v6mr2453276ljd.31.1547553629425;
 Tue, 15 Jan 2019 04:00:29 -0800 (PST)
MIME-Version: 1.0
References: <732ea4f8ff1bf3ad28bda543ae8e1727c78f8b3b.1547538574.git.baolin.wang@linaro.org>
 <CAMpxmJVyMd=rebK2h=uC_Cu_KXivRpCDCxzrneig0eZnK=wXpQ@mail.gmail.com>
In-Reply-To: <CAMpxmJVyMd=rebK2h=uC_Cu_KXivRpCDCxzrneig0eZnK=wXpQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 15 Jan 2019 20:00:18 +0800
Message-ID: <CAMz4kuKwj9o6P+m3P34paxJUmHhO9snuhG6pq_ksvN1oWvN3Qg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: sprd: Fix the incorrect data register
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, neo.hou@unisoc.com,
        Mark Brown <broonie@kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 at 18:47, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> wt., 15 sty 2019 o 08:53 Baolin Wang <baolin.wang@linaro.org> napisa=C5=
=82(a):
> >
> > From: Neo Hou <neo.hou@unisoc.com>
> >
> > Since differnt type EICs have its own data register to read, thus fix t=
he
> > incorrect data register.
> >
> > Signed-off-by: Neo Hou <neo.hou@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/gpio/gpio-eic-sprd.c |   13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.=
c
> > index e0d6a0a..257df59 100644
> > --- a/drivers/gpio/gpio-eic-sprd.c
> > +++ b/drivers/gpio/gpio-eic-sprd.c
> > @@ -180,7 +180,18 @@ static void sprd_eic_free(struct gpio_chip *chip, =
unsigned int offset)
> >
> >  static int sprd_eic_get(struct gpio_chip *chip, unsigned int offset)
> >  {
> > -       return sprd_eic_read(chip, offset, SPRD_EIC_DBNC_DATA);
> > +       struct sprd_eic *sprd_eic =3D gpiochip_get_data(chip);
> > +
> > +       switch (sprd_eic->type) {
> > +       case SPRD_EIC_DEBOUNCE:
> > +               return sprd_eic_read(chip, offset, SPRD_EIC_DBNC_DATA);
> > +       case SPRD_EIC_ASYNC:
> > +               return sprd_eic_read(chip, offset, SPRD_EIC_ASYNC_DATA)=
;
> > +       case SPRD_EIC_SYNC:
> > +               return sprd_eic_read(chip, offset, SPRD_EIC_SYNC_DATA);
> > +       default:
> > +               return -ENOTSUPP;
> > +       }
> >  }
> >
> >  static int sprd_eic_direction_input(struct gpio_chip *chip, unsigned i=
nt offset)
> > --
> > 1.7.9.5
> >
>
> I guess both this and the second patch should go into stable and have
> a Fixes: tag?

Sure. I will send out v2 with a fix tag if no other issues.

--=20
Baolin Wang
Best Regards
