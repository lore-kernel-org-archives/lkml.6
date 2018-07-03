Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A7AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C202243E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYupy1A1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C202243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbeGCGxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:53:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40029 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753159AbeGCGxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:53:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so992630wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 23:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=j4D+4miuiCyuhMPdeAoyi1dxlxwFn/TzNmBlg9vLJ3U=;
        b=YYupy1A1PnYFrdZpQDrbHZt+nJ70vzt+ThYPsIlaBvGBxAp4L35Z56f9BNhx6J7GVG
         LAzrNwvEBPqobSxXtNE0qynknQ0Vsj051o/zFL/RuP9ABw4AxtpfELlKM1ZmvJhX1Gwc
         wtrm7bRC2a1TTTC2DeADhLoiWfQYkyFrObl98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=j4D+4miuiCyuhMPdeAoyi1dxlxwFn/TzNmBlg9vLJ3U=;
        b=FkMzjJHKZgCIK2EV39SQqghxApK7niUpBo4+mkyJ1yLwa0fqsKB5CL7e5HKZPlKaC8
         5zOfXmAYJJ6AvSP3dYMl1UP7LRZ/uUhTzMsqXKSgdqdOPYErMGaGSv2A4BFhOUSnkUSX
         DMh/SXMl1l14WGwnon6sMGB5XttgOK+cl2n3thSLar87Pd8qPkEazvV8wvPc4ngnTgrq
         dLjH7yO08j2p1GUJHH37CrcmZBPhm3zinY4gbxm5gzPz/EKzTjawEmIja28fh1Qhy1vk
         Xda2JYvVmlsRncy9lE6FfP+XH91ONOZZcXQlGnFuzagiEkSMYKwIZrOOKV3NESMFw8EO
         7lsQ==
X-Gm-Message-State: APt69E0Ooa6rguHsEgE4y3EB1vP04L4Dv8dzaLz5iLEcDk4YgW7+giBj
        QOuk9VRFj5v4P8khEUCg8x4DJA==
X-Google-Smtp-Source: AAOMgpdTF9hciAVxg+gtu0GOyhVXDc+Hnz9i7Hdvz8RTMUn2x9wXVz+cDsiYBHWnzbzvH3keRih4hQ==
X-Received: by 2002:a1c:6709:: with SMTP id b9-v6mr10295523wmc.68.1530600812777;
        Mon, 02 Jul 2018 23:53:32 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id o13-v6sm356697wrq.91.2018.07.02.23.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 23:53:31 -0700 (PDT)
Date:   Tue, 3 Jul 2018 07:53:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     matti.vaittinen@fi.rohmeurope.com,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, mazziesaccount@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com,
        andrew.smirnov@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180703065329.GA20176@dell>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
 <20180626112455.GC2118@localhost.localdomain>
 <CAFqH_52NERfORwSkBh0stW+mvzRpw0to9CiWPwLB9mFo_TsW_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_52NERfORwSkBh0stW+mvzRpw0to9CiWPwLB9mFo_TsW_w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018, Enric Balletbo Serra wrote:

> Hi Matti,
> Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> dia dt., 26 de juny 2018 a les 13:25:
> >
> > Hello Eric,
> >
> > Thanks for the comments! I'll be addressing these in patch series v8
> > - except the regmap wrapper one which will be taken care of by another
> > patch set.
> >
> > On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra wrote:
> > > Hi Matti,
> > >
> > > Thanks for the patch, a few comments below, some are feedback I
> > > received when I sent some patches to this subsystem.
> > >
> > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > > dia dt., 19 de juny 2018 a les 12:57:
> > > >
> > > > ROHM BD71837 PMIC MFD driver providing interrupts and support
> > > > for two subsystems:
> > > > - clk
> > > > - Regulators
> > > >
> > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > ---
> > > >  drivers/mfd/Kconfig         |  13 ++
> > > >  drivers/mfd/Makefile        |   1 +
> > > >  drivers/mfd/bd71837.c       | 221 ++++++++++++++++++++++++++
> > > >  include/linux/mfd/bd71837.h | 367 ++++++++++++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 602 insertions(+)
> > > >  create mode 100644 drivers/mfd/bd71837.c
> > > >  create mode 100644 include/linux/mfd/bd71837.h

[...]

> > > > +static const struct of_device_id bd71837_of_match[] = {
> > > > +       { .compatible = "rohm,bd71837", .data = (void *)0},
> > > > +       { },
> > >
> > > nit: { /* sentinel */ }
> >
> > I am sorry but I didn't quite get the point here. Could you please
> > explain what did you expect to be added here?
> >
> 
> It's a nit but It is a good practice to specify that the last entry is
> a sentinel. Just this.
> 
> +static const struct of_device_id bd71837_of_match[] = {
> +       { .compatible = "rohm,bd71837", .data = (void *)0},
> +       { /* sentinel */ }
> +};

I would not say this is "good practice" at all.

We all know what empty brackets mean.  No need for obvious comments.

When authors put this, I let it go because "sentinel" is a cool word -
and nothing more! ;)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
