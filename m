Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5105C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BDE208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjzc+82U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BDE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeIZPLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:11:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36335 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeIZPL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:11:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id l10-v6so2984193wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3nYesuWXskPgbFbo6Mo++hkKmoHXSTVcYd3yObm7dSc=;
        b=fjzc+82UtBaLPTSoX2vLTtZLMqC6HVmrWNHnD6cHon7PFT1sBNIPeWLT+/5aSb8T3X
         Eid27prGXApfZQN6GxNTlIYXbEVJrZ0BH/xvUvKfFzggFyf9ut/ICrsPu65Wi2djPAgi
         XQhAXuyeOcugP0Vbb0cYs/clFVsjhUXxZORJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3nYesuWXskPgbFbo6Mo++hkKmoHXSTVcYd3yObm7dSc=;
        b=TQpP81lFlLFef3RqMFNo55SLg2xU6sEi3SeuTastR/P4ZPSjKojN0Um6A06TfuIeaL
         ZBvC7zj2/Ea8zeaRKbdTvHuI508dpiIiZw81qMnxN+RvD6+yKUIQOaalKAee08YQbzBU
         jbct0OUA2nxwx+i9N563fUztZTekNgEwN4Sz0Vp9+QSnbshk4ubhon+8jkmAh+hdmi/N
         i95Xhwol5VcGEGh/v472DI2BuHuKFJG63VC1Bpocy2IOXOpSB4ZccTRawwHz3e+PFnxb
         c3K+7zTrCNluePHoeSEu4YdB/DbaKiKJO5i7c0MSNTBxkw1kok3vSwt/p2IpR8x+eE+k
         qQ0A==
X-Gm-Message-State: ABuFfojjhw/bZhPUVoRoUYKp7+QW/qu4EyOAULDkt+v6sUEK7TWp/z9o
        a+vVshTlBT9LN8QuxA+Hle241g==
X-Google-Smtp-Source: ACcGV60ZpfvgF+gzIVN5MTztc7xMKQhuMVgb8eWoInTYM6XMi8WTU3Ez8NqOZd+3SD3mNw1H/Dccag==
X-Received: by 2002:adf:d1ce:: with SMTP id m14-v6mr4378892wri.138.1537952371935;
        Wed, 26 Sep 2018 01:59:31 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b12sm4197166wrx.11.2018.09.26.01.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 01:59:30 -0700 (PDT)
Date:   Wed, 26 Sep 2018 09:59:28 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, lee.jones@linaro.org,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] backlight: lm3639: Unconditionally call
 led_classdev_unregister
Message-ID: <20180926085928.hzwunjz3a5zbfpam@holly.lan>
References: <20180921202130.12480-1-natechancellor@gmail.com>
 <CAKwvOdnj5M1xTKue7qZCV-2=hLTATnB-J1QOVvaVVa+8h+vq4A@mail.gmail.com>
 <20180921231047.GA25998@flashbox>
 <CAKwvOdnRzGhDZw-O_5khqsi4Bi7QOrrQ9GBpfhxUGxkOkuX6CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnRzGhDZw-O_5khqsi4Bi7QOrrQ9GBpfhxUGxkOkuX6CA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 02:41:04PM -0700, Nick Desaulniers wrote:
> On Fri, Sep 21, 2018 at 4:10 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Fri, Sep 21, 2018 at 03:48:50PM -0700, Nick Desaulniers wrote:
> > > On Fri, Sep 21, 2018 at 1:23 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > Clang warns that the address of a pointer will always evaluated as true
> > > > in a boolean context.
> > > >
> > > > drivers/video/backlight/lm3639_bl.c:403:14: warning: address of
> > > > 'pchip->cdev_torch' will always evaluate to 'true'
> > > > [-Wpointer-bool-conversion]
> > > >         if (&pchip->cdev_torch)
> > > >         ~~   ~~~~~~~^~~~~~~~~~
> > > > drivers/video/backlight/lm3639_bl.c:405:14: warning: address of
> > > > 'pchip->cdev_flash' will always evaluate to 'true'
> > > > [-Wpointer-bool-conversion]
> > > >         if (&pchip->cdev_flash)
> > > >         ~~   ~~~~~~~^~~~~~~~~~
> > > > 2 warnings generated.
> > > >
> > > > These statements have been present since 2012, introduced by
> > > > commit 0f59858d5119 ("backlight: add new lm3639 backlight
> > > > driver"). Given that they have been called unconditionally since
> > > > then presumably without any issues, removing the always true if
> > > > statements to fix the warnings without any real world changes.
> > > >
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/119
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Based on conversation below...

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> > > > ---
> > > >
> > > > Alternatively, it's possible the address wasn't supposed to be taken or
> > > > the dev in these structs should be checked instead. I don't have this
> > > > hardware to make that call so I would appreciate some review and
> > > > opinions on what was intended here.
> > > >
> > > > Thanks!
> > > >
> > > >  drivers/video/backlight/lm3639_bl.c | 6 ++----
> > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
> > > > index cd50df5807ea..086611c7bc03 100644
> > > > --- a/drivers/video/backlight/lm3639_bl.c
> > > > +++ b/drivers/video/backlight/lm3639_bl.c
> > > > @@ -400,10 +400,8 @@ static int lm3639_remove(struct i2c_client *client)
> > > >
> > > >         regmap_write(pchip->regmap, REG_ENABLE, 0x00);
> > > >
> > > > -       if (&pchip->cdev_torch)
> > > > -               led_classdev_unregister(&pchip->cdev_torch);
> > > > -       if (&pchip->cdev_flash)
> > > > -               led_classdev_unregister(&pchip->cdev_flash);
> > > > +       led_classdev_unregister(&pchip->cdev_torch);
> > > > +       led_classdev_unregister(&pchip->cdev_flash);
> > >
> > > led_classdev_unregister() requires that its arg is non-null (as it
> > > dereferences it without any kind of check).  It's not clear that
> > > i2c_get_clientdata() can never return a null pointer, so I think all
> > > references to pchip in this function should instead be guarded with a
> > > null check.  Would you mind making that change and sending a v2?
> > >
> >
> > Hi Nick,
> >
> > I did a quick grep throughout the tree and I didn't see any place where
> > there were null checks for i2c_get_clientdata, leading me to believe
> > that such a check isn't necessary although I am nowhere close to an expert
> > into this stuff.
> 
> This seems to be the case.  We should start using
> __attribute__((returns_nonnull)) (gated on gcc 5+).
> I *think* that the device's driver_data is actually set in
> drivers/video/backlight/backlight.c.  Looks like
> CONFIG_BACKLIGHT_LM3639 depends on CONFIG_BACKLIGHT_CLASS_DEVICE so I
> feel more confident in your patch.
> I would still prefer the maintainers to review though.

AFAICT it is impossible for the probe function to complete
successfully without having called i2c_set_clientdata()
and therefore it is impossible for pchip to be NULL
in the remove function.

Not sure it is possible to use return_nonnull though. It is not that
i2c_get_clientdata() can *never* return non-NULL, it is that in *this*
case (which is actually a fairly common one) it can never return
non-NULL.


Daniel.
