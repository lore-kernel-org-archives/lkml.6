Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F689C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578B5244AF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RoPOcF6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578B5244AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933687AbeGDKxO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:53:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45358 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933006AbeGDKxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:53:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id u7-v6so4851937wrn.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RkOVIFRZwSAlehAEhxbIqjxlfp2/AofDBJWzNdRHSKo=;
        b=RoPOcF6rmgcYOuT0E7VRP773mCsPuA5cbRXjyxqfYvd1Rr0pfmIcaPnmSx2PAaVsfn
         Xf9yLTQ0t4pm4m9HE0/B8ZnBe/e+V3Z9XRgazoLaaRnx5P88i6dRx7wJcl0sAmQ5yn2J
         y0H2TR8eh9VDzIp+mLKjli+EnJ/i8zHGcAaRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RkOVIFRZwSAlehAEhxbIqjxlfp2/AofDBJWzNdRHSKo=;
        b=Er0cm/qI/h3cZYe+u41GOWZNSBpiJTBQDUBzWyMCjjh4NfSBvnpWJtwDSzSWCI/ZuI
         +sD6GtGewYyGVCcfQ9QrPTwJj/xVlbrbfClf6zqTBCNAlP0CBVtYEiX3/aMxZZhFWo6D
         EEITnER93HmaAkP/QqcIETUlHHbK/3Agc/qWEdL1lbpnXExO3WcwYgj1Cu7opmzMdib9
         XDzbTp9JWmx+MekHIMraEu0rJIZXgLNMS6pINCNFfUeaH94j+PhlrkOts9ofUvZrUyvA
         TBM8V2oDZXxBoXN+174bVUDj3tOMweyYSA5zx34rn8S3EuF/6wvLPJkdIo9maIa3rxb7
         eeKg==
X-Gm-Message-State: APt69E1gWzMVpVgUg71RKHKT+Ci30QYWe4o32b/Em6wF3hbmaHhMSgNR
        xBxmYw8vzL7Tm9sVSHHw+wPNyQ==
X-Google-Smtp-Source: AAOMgpd0tU2XJZ2735ZEqc60iR2KEdUiq/YkSq9I+tzh9QruuFljUAaxn7Kad3v8ft7jl/PjZYHR/Q==
X-Received: by 2002:adf:ad38:: with SMTP id p53-v6mr1286345wrc.10.1530701589158;
        Wed, 04 Jul 2018 03:53:09 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id i193-v6sm5201131wmf.13.2018.07.04.03.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 03:53:07 -0700 (PDT)
Date:   Wed, 4 Jul 2018 11:53:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v8 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180704105002.GD496@dell>
References: <cover.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
 <18a04e42debb2a23aec855cac3bcf3d6ab6c55fd.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_533te3UuY9V9U+Z0yxTkW==3wsK22uzB4G=aWGour7Quw@mail.gmail.com>
 <20180704083911.GH2118@localhost.localdomain>
 <20180704095257.GJ2118@localhost.localdomain>
 <20180704101102.GA496@dell>
 <20180704103430.GA13087@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180704103430.GA13087@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jul 2018, Matti Vaittinen wrote:

> On Wed, Jul 04, 2018 at 11:11:02AM +0100, Lee Jones wrote:
> > On Wed, 04 Jul 2018, Matti Vaittinen wrote:
> > 
> > > On Wed, Jul 04, 2018 at 11:39:11AM +0300, Matti Vaittinen wrote:
> > > > On Tue, Jul 03, 2018 at 11:26:00AM +0200, Enric Balletbo Serra wrote:
> > > > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > > > > dia dv., 29 de juny 2018 a les 11:47:
> > > > > 
> > > > > Now that you use devm calls and you don't need to unwind things I
> > > > > think is better to use plain returns. So,
> > > > > 
> > > > > return -ENOMEM;
> > > > 
> > > > I have never really understood why use of gotos in error handling is
> > > > discouraged.
> > 
> > They're not.
> > 
> > > > Personally I would always choose single point of exit from
> > > > a function when it is simple enough to achieve (like in this case). I've
> > > > written and fixed way too many functions which leak resources or
> > > > accidentally keep a lock when exiting from error branches. But I know
> > > > many colleagues like you who prefer not to have gotos but  in place returns
> > > > instead. So I guess I'll leave the final call on this to the one who is
> > > > maintainer for this code. And it is true there is no things to unwind
> > > > now - which does not mean that next updater won't add such. But as I
> > > > said, I know plenty of people share your view - and even though I rather
> > > > maintain code with only one exit the final call is on subsystem maintainer
> > > > here.
> > 
> > Please use gotos in the error path.
> > 
> > IMO, it's the nicest way to unwind (as you call it).
> 
> I'll keep the gotos but clean other stuff for patch v9 then.

Sounds good.

> > > Actually, If it was completely my call the probe would look something
> > > like this:
> > > 
> > > +static int bd71837_i2c_probe(struct i2c_client *i2c,
> > > +                           const struct i2c_device_id *id)
> > > +{

[...]

> > > +}
> > > 
> > > What do you think of this? To my eye it is nice. It keeps single point of
> > > exit and introduces only simple if-statements without the need of curly
> > > brackets. And finally the error prints string works as a comment too.
> > > I've seen bunch of constructs like this on the networking side but I
> > > have no idea if this is frowned on this subsystem =) Oh, and probe abowe
> > > is just to illustrate the idea, I did not even try compiling it yet.
> > 
> > That is horrible.  I nearly vomited on my keyboard. 
> 
> Note to self: Never to buy second hand keyboard from Lee =)

That is sound advice.

Not sure I would buy 2nd-hand keyboard from anyone - ewe! :\

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
