Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B1BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD62B21533
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD62B21533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390126AbeHGT0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:26:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36790 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388706AbeHGT0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:26:25 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CD33320789; Tue,  7 Aug 2018 19:11:04 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1C5A02093C;
        Tue,  7 Aug 2018 19:10:42 +0200 (CEST)
Date:   Tue, 7 Aug 2018 19:10:42 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 09/12] gpiolib: Identify GPIO descriptor arrays
 with direct mapping
Message-ID: <20180807191042.0204909a@bbrezillon>
In-Reply-To: <1793769.2WP40jSPqy@z50>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
        <20180806222918.12644-10-jmkrzyszt@gmail.com>
        <CACRpkdZtuU6zXBz6UqprE7-31vW9-1ZabFjyzHBgWaTgmqkbbQ@mail.gmail.com>
        <1793769.2WP40jSPqy@z50>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Aug 2018 18:50:22 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Hi Linus,
> 
> On Tuesday, August 7, 2018 1:29:43 AM CEST Linus Walleij wrote:
> > Hi Janusz!
> > 
> > On Tue, Aug 7, 2018 at 12:29 AM Janusz Krzysztofik <jmkrzyszt@gmail.com>   
> wrote:
> >   
> > > Certain GPIO array lookup results may map directly to GPIO pins of a
> > > single GPIO chip in hardware order.  If that condition is recognized
> > > and handled efficiently, significant performance gain of get/set array
> > > functions may be possible.
> > >
> > > While processing a request for an array of GPIO descriptors, verify if
> > > the descriptors just collected represent consecutive pins of a single
> > > GPIO chip.  Pass that information with the array to the caller so it
> > > can benefit from enhanced performance as soon as bitmap based get/set
> > > array functions which can make efficient use of that are available.
> > >
> > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>  
> > (...)  
> > >  This function returns a struct gpio_descs which contains an array of
> > > -descriptors::
> > > +descriptors.  It may also contain a valid descriptor of a single GPIO   
> chip in
> > > +case the array strictly matches pin hardware layout of the chip::
> > >
> > >         struct gpio_descs {
> > >                 unsigned int ndescs;
> > >                 struct gpio_desc *desc[];
> > > +               struct gpio_chip *chip;  
> > 
> > This must be motivated: if the only purpose is to indicate to the consumer   
> that
> > all GPIOs are on the same chip, why not just have a
> > 
> > bool all_on_same_chip;
> > 
> > That you set to true if these are all on the same chip?  
> 
> My approach would probably save one or two instructions per get/set call, but 
> I'm not stuck to it and will be happy to find a better solution.
> 
> How about folding the chip descriptor inside an additional structure, private 
> to drivers, with internals not revealed to consumers?

Or just get the chip from gpio_descs->desc[0]->gdev->chip when
->all_on_same_chip is true...

That adds 2 dereferencing though.
