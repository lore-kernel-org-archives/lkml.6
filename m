Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9184C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946DD20896
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkyEKJpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946DD20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754291AbeGCG4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:56:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33890 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753130AbeGCG4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:56:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id l15-v6so9551277wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 23:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=H3y4yrbmcZWDG5gVTlBGNCbHBQkI2vsCrrQGUnxfJek=;
        b=GkyEKJpN8uRBlGiQjC2EGlGLeu8z0p18K+kwDZp/NurgCLZwjJWZkkJjjbzB81fQNH
         5D1ENwduEuDxUZmzJssAzvG7wITQBkXe1+WbeI5UyzpMXgpo3dFjaImoKD51rCmeKp2K
         vXlKmGbKGgW+4TVbGOmKeK7jt8cGTKWDPv0NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H3y4yrbmcZWDG5gVTlBGNCbHBQkI2vsCrrQGUnxfJek=;
        b=bUGnJJ8w7yaXQ4B4i+AtFF8YaiCMczmntI6B72EJiZiI+8FRAss/xqCqDAna728U+S
         QXA3Xm4O+IOQbDIID6ErRp0OY0w5ntUnEjus+l+Yy8lzaqKQL9JopvSe98Qxb4uCvy3T
         06O4i2eRlIJirLZCxE70+6bMK9T4viMNqfCv4tgZ+kTLmTRX2S0mbnUSrb9la/gqD8Pb
         ylZylyKlBtlOABVKYPo69LJvr345I1DcgdvMCnwfZSOrTxkel3nDi9cIwi2AA/Hx0XJS
         Rg8hcyNS7ucohCrIFd0HfTsXf+YyRiT/SdzY9dd8I7Ifvf0gxqGdZabaVtE1uXbH5Tn3
         G9eg==
X-Gm-Message-State: APt69E0+1EIuyhReNpcTVchvl0zcuqxXFgHum7cItQaxFgyrV44ewMHn
        d47rVOtMv5v6yQEECjbmr1ZxZw==
X-Google-Smtp-Source: AAOMgpcIctWrBLjK7bFJRh61l7zoDyyFlKa/gCemI2ZEvb+QoDDDxJPH3GGDtabJB9so0focLClzPg==
X-Received: by 2002:a1c:cf81:: with SMTP id f123-v6mr10525128wmg.3.1530601010864;
        Mon, 02 Jul 2018 23:56:50 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id z14-v6sm588463wma.11.2018.07.02.23.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 23:56:50 -0700 (PDT)
Date:   Tue, 3 Jul 2018 07:56:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     matti.vaittinen@fi.rohmeurope.com,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
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
        linux-clk@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180703065648.GB20176@dell>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
 <20180626112455.GC2118@localhost.localdomain>
 <CAFqH_52NERfORwSkBh0stW+mvzRpw0to9CiWPwLB9mFo_TsW_w@mail.gmail.com>
 <20180626120306.GD2118@localhost.localdomain>
 <CAFqH_52v3-L1xLL12hzyGCbuooX5T52Lm7BXHM3sBX1ERWmhiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_52v3-L1xLL12hzyGCbuooX5T52Lm7BXHM3sBX1ERWmhiQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018, Enric Balletbo Serra wrote:

> Hi Matti,
> 
> Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> dia dt., 26 de juny 2018 a les 14:03:
> >
> > Hello Again Eric,
> >
> > On Tue, Jun 26, 2018 at 01:40:40PM +0200, Enric Balletbo Serra wrote:
> > > Hi Matti,
> > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > > dia dt., 26 de juny 2018 a les 13:25:
> > > > On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra wrote:
> > > > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > > > > dia dt., 19 de juny 2018 a les 12:57:
> > > >
> > > > > > +static const struct of_device_id bd71837_of_match[] = {
> > > > > > +       { .compatible = "rohm,bd71837", .data = (void *)0},
> > > > > > +       { },
> > > > >
> > > > > nit: { /* sentinel */ }
> > > >
> > > > I am sorry but I didn't quite get the point here. Could you please
> > > > explain what did you expect to be added here?
> > > >
> > >
> > > It's a nit but It is a good practice to specify that the last entry is
> > > a sentinel. Just this.
> > >
> > > +static const struct of_device_id bd71837_of_match[] = {
> > > +       { .compatible = "rohm,bd71837", .data = (void *)0},
> > > +       { /* sentinel */ }
> > > +};
> >
> > Oh, I see. Finally something I can disagree =) I quickly opened few
> > random drivers which declare match table. None of them practiced this
> > good practice. So I guess it is not such a standard after all. And I
> > guess the meaning of last entry in match table should be quite obvious.
> > Adding the comment /* sentinel */ sounds like stating the obvious at
> > best - at worst it gets one just to wonder what the "sentinel" means =)
> >
> 
> git grep "/\* sentinel \*/"
> 
> Anyway, I marked this change as a nit, so you don't need to change. I
> just commented because at some point I received a "complain" when I
> didn't add it. But this is up to the maintainer and I am not sure if
> the "complain" was received in this subsystem :)

Certainly not from me.  I don't agree with the practice.

I'd like to know who is enforcing this!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
