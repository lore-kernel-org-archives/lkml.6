Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E61C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419782085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZX7DIOnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419782085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbeJLA3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:29:32 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53260 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbeJLA3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:29:32 -0400
Received: by mail-it1-f196.google.com with SMTP id q70-v6so14575983itb.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOtASjkTmL8BxytzRxSIubYq0ixql2iNYSNXitfRfTo=;
        b=ZX7DIOnKJy4Oum7YN43bbaADP+6WgUgJ4fxzmWm2SWOvL+EjQwcq2QPeH6Tm0wHrEG
         5dhpVvGCof0Lv1/T2QpovztzpZbtt8SMRYRdGBd9l875Iz84j1TpP/VP1Kz2vWu4RqR5
         lVdLprt8pqjLlQOyR6XKsHQeKVEZ65P4Fhk/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOtASjkTmL8BxytzRxSIubYq0ixql2iNYSNXitfRfTo=;
        b=rKczaOXDQypdIJWM4AiHbbGewYvHsuM1vlrZNPv2ZF5IasDVzOBGzVeDzhjrAvUu7w
         Kw4X+aOtvZevXGidUibMwax9NJ69V7DH7LWZaG8B/uBLIgXjEMYlk13gLWO1EUVZqRju
         L5UFRteT3F//EiByy5bA/2xw3bobkJeETFBbxH3zL4v6okgBpDLWGTRwGmwANO89Lk9j
         MW5Nlq9W0keaOJAEg8r9vsoCDqRcqpH+EfnicOSum0dQPtFk5gEN/eHNqi0xOQ0d6pMz
         w34nLIwTdR/nbpabgtEVmSneBKlOpHYTSjaYrjZNtr9mg03syvIzSb0GkANHS/2ytf0X
         H5LQ==
X-Gm-Message-State: ABuFfoh8cjQu3Xj0u3jtfYmSrrRH+dqV9JVU+jnnnacbnHVNEnYMq030
        +r3xEaXqzbYjkhOmzAWvz58ZGugRqNRtgR/q+VsPhQ==
X-Google-Smtp-Source: ACcGV63JLEBTxcrP5SB41Ro0B/Dg2Fw7Mm2IyUN4qWiz2MpAVks3Il+d7oXKJLSjtp3zrgf4aONzcSsGiIU4wCWElMA=
X-Received: by 2002:a24:7b50:: with SMTP id q77-v6mr1816333itc.154.1539277285998;
 Thu, 11 Oct 2018 10:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181011143531.7195-1-linus.walleij@linaro.org> <20181011144330.GF25351@sirena.org.uk>
In-Reply-To: <20181011144330.GF25351@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Oct 2018 19:01:13 +0200
Message-ID: <CACRpkdbTnBQhPQARX77KfjtfWXY+t0oH6-B=WUN4hid8eQT0DA@mail.gmail.com>
Subject: Re: [PATCH] gpio/regulator: Allow nonexclusive GPIO access
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 4:43 PM Mark Brown <broonie@kernel.org> wrote:
> On Thu, Oct 11, 2018 at 04:35:31PM +0200, Linus Walleij wrote:
>
> > +     /*
> > +      * Some fixed regulators share the enable line between two
> > +      * regulators which makes it necessary to get a handle on the
> > +      * same descriptor for two different consumers. This will get
> > +      * the GPIO descriptor, but only the first call will initialize
> > +      * it so any flags such as inversion or open drain will only
> > +      * be set up by the first caller and assumed identical on the
> > +      * next caller.
> > +      *
> > +      * FIXME: find a better way to deal with this.
> > +      */
> > +     gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
> > +
>
> It's not just fixed regulators that do this, often regulators with
> register control can do this as well.

Yeah I thought that was implicit since the comment is inside
fixed.c but I can change it, or you can edit when applying if
you like.

>  Since power up is often a
> performance critical path but regulators tend to be controlled via slow
> buses like I2C it's common to have register control combined with a GPIO
> enable line so you don't need to use the bus to do the enables.  That
> should just be a case of adding this flag to all the drivers that have
> already been converted to gpiod (including the core code that's in
> regulator_ena_gpio_request() which I thought was coping with this
> already) unless I'm missing something?

Sorry if I don't get it... we already have code in the core to
check if the same gpiod is used by two regulators.
regulator_ena_gpio_request() does this:

        if (config->ena_gpiod)
                gpiod = config->ena_gpiod;
        else
                gpiod = gpio_to_desc(config->ena_gpio);

So after the change I made to fixed.c this comes in through
config->ena_gpiod.

Later in this function:

        list_for_each_entry(pin, &regulator_ena_gpio_list, list) {
                if (pin->gpiod == gpiod) {
                        rdev_dbg(rdev, "GPIO %d is already used\n",
                                config->ena_gpio);

So there is the reference counting code, where we identify
that the same descriptor is already in use.

The only change this patch really does is make it possible for
the same gpiod to come in twice from fixed.c (as is proper).

If it's a simple and single consumer enable/disable disable
line all is fine and it doesn't get reference counted etc, since
there is one and only one consumer for the GPIO.
gpiod_get[_optional]() is just fine in these cases.

When I straight out the FIXME:s I would add code to check
that the flags passed to gpiolib are coherent and maybe store
all users in an array instead of a simple char * inside the
gpio descriptor, so we properly handle more than one user
in gpiolib.

Possibly the reference counting should be moved
over from regulator core as well: this would apply if there
are more subsystems than regulator using the same
GPIO with multiple consumers.

But that is for the future fixups.

Yours,
Linus Walleij
