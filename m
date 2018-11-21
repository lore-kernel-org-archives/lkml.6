Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8BAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB7421479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB7421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbeKVDop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:44:45 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:58536 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbeKVDop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:44:45 -0500
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2018 22:44:43 EST
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 6A58F5C06C6; Wed, 21 Nov 2018 17:01:16 +0000 (UTC)
Date:   Wed, 21 Nov 2018 18:01:16 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     hofrat@osadl.org, Linus Walleij <linus.walleij@linaro.org>,
        matthias.bgg@gmail.com, sergio.paracuellos@gmail.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] gpio: mt7621: handle failure of devm_kasprintf()
Message-ID: <20181121170116.GA10656@osadl.at>
References: <1542818142-27800-1-git-send-email-hofrat@osadl.org>
 <CAMpxmJUNYWqk4PEKcZ5o5PMR3RhMhudK+Pf+Pfo64mvJ8ND2wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJUNYWqk4PEKcZ5o5PMR3RhMhudK+Pf+Pfo64mvJ8ND2wQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 05:43:43PM +0100, Bartosz Golaszewski wrote:
> ??r., 21 lis 2018 o 17:39 Nicholas Mc Guire <hofrat@osadl.org> napisa??(a):
> >
> > kasprintf() may return NULL on failure of internal allocation thus the
> > assigned  label  is not safe if not explicitly checked. On error
> > mediatek_gpio_bank_probe() returns negative values so -ENOMEM in the
> > (unlikely) failure case should be fine here.
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
> > ---
> >
> > Problem located with experimental coccinelle script
> >
> > Patch was compile tested with: omega2p_defconfig, SOC_MT7621=y,
> > GPIOLIB=y, GPIO_MT7621=y
> >
> > Patch is against 4.20-rc3 (localversion-next is next-20181121)
> >
> >  drivers/gpio/gpio-mt7621.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
> > index d72af6f..42f0c67 100644
> > --- a/drivers/gpio/gpio-mt7621.c
> > +++ b/drivers/gpio/gpio-mt7621.c
> > @@ -244,6 +244,10 @@ mediatek_gpio_bank_probe(struct device *dev,
> >         rg->chip.of_xlate = mediatek_gpio_xlate;
> >         rg->chip.label = devm_kasprintf(dev, GFP_KERNEL, "%s-bank%d",
> >                                         dev_name(dev), bank);
> > +       if (!rg->chip.label) {
> > +               dev_err(dev, "Could not allocate label\n");
> 
> No need for an error message here, an -ENOMEM says enough.
>

I just thought its more consistent with the rest of
the code - and as it is a highly unlikely event it would
probably be hard to pinpoint as some of the other functions
can return -ENOMEM (but with a message).

....and the call site of mediatek_gpio_bank_probe() actually 
currently ignores the return value so the -ENOMEM would go
unnoticed which is a bug as well - patch for that a bit later.

anyway fine with me - I´ll send a V2 and drop the dev_err() here.

thx!
hofrat
 
> Bart
> 
> > +               return -ENOMEM;
> > +       }
> >
> >         ret = devm_gpiochip_add_data(dev, &rg->chip, mtk);
> >         if (ret < 0) {
> > --
> > 2.1.4
> >
