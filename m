Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeETPhs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 11:37:48 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40893 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeETPho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 11:37:44 -0400
X-Google-Smtp-Source: AB8JxZrJdBIZaar0zhgBK+HVN1URMZCtIifBS37vdf1nw5jg8hGUMJqeZFcbi3g+jPOPz0vLgpGiUg==
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Mark Brown <broonie@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Richard Weinberger <richard@nod.at>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-fbdev@vger.kernel.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup table
Date: Sun, 20 May 2018 17:37:44 +0200
Message-ID: <3505791.x6nWYTo8eb@z50>
In-Reply-To: <CAHp75Ved2nw1JKnXT2Jxnw4XLsby1eVJU6cfBjE2sp4LP4Kwmg@mail.gmail.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com> <5456625.lDWjtgZygK@z50> <CAHp75Ved2nw1JKnXT2Jxnw4XLsby1eVJU6cfBjE2sp4LP4Kwmg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, May 20, 2018 4:44:31 PM CEST Andy Shevchenko wrote:
> On Sun, May 20, 2018 at 12:55 AM, Janusz Krzysztofik
> 
> <jmkrzyszt@gmail.com> wrote:
> > On Saturday, May 19, 2018 8:00:38 PM CEST Andy Shevchenko wrote:
> >> On Sat, May 19, 2018 at 2:15 AM, Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > 
> > wrote:
> >> NULL check in practice discards the _optional part of gpiod_get(). So,
> >> either you use non-optional variant and decide how to handle an
> >> errors, or user _optional w/o NULL check.
> > 
> > OK, I'm going to use something like the below while submitting v2:
> > 
> > -       gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
> > -       if (!IS_ERR_OR_NULL(gpiod_rdy)) {
> > -               this->dev_ready = ams_delta_nand_ready;
> > -       } else {
> > -               this->dev_ready = NULL;
> > -               pr_notice("Couldn't request gpio for Delta NAND
> > ready.\n");
> > +       priv->gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy",
> > +                                                 GPIOD_IN);
> > +       if (IS_ERR(priv->gpiod_rdy)) {
> > +               err = PTR_ERR(priv->gpiod_nwp);
> > +               dev_warn(&pdev->dev, "RDY GPIO request failed (%d)\n",
> > err); +               goto err_gpiod;
> > 
> >         }
> > 
> > +       if (priv->gpiod_rdy)
> > +               this->dev_ready = ams_delta_nand_ready;
> 
> This makes sense.
> 
> Though, I completely dislike "rdy" name of GPIO. Where is it documented?

No documentation files for Amstrad Delta nor for its NAND driver specifically 
exist under Documentation/. However, there exist some for generic GPIO NAND 
driver where the pin name "rdy" is used explicitly:
Documentation/driver-api/gpio/drivers-on-gpio.rst
Documentation/devicetree/bindings/mtd/gpio-control-nand.txt
You can find that mnemonic used across drivers/mtd/nand/, standalone or as a 
suffix, including the Amstrad Delta NAND driver before the change discussed.

To be honest, I don't like it much either, but I'm just using it instead of 
inventing something new.

Thanks,
Janusz
