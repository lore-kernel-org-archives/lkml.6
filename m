Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFD1C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EBA208B6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RB+TWfvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EBA208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753700AbeGDKLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:11:09 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39058 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753295AbeGDKLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:11:06 -0400
Received: by mail-wr0-f196.google.com with SMTP id b8-v6so4741621wro.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=i2oGYEp341u8C1fswQNAfOIuZtruZ8UpU8iAoJupQ7M=;
        b=RB+TWfvBUGeLQzx8Vhkkm+7sqzmERHA/ekWJ1WdKmIJqE8I/MyCIOWe49OqFxIhLSW
         7ACZAByXyPWgwg7GZVTZBj5w0Szbtca+wRwDiw/4sxoGXHEF/jtoy+2vYHgTdSVGTsJM
         NFW6xr7O1mvqlqt1Xr2r7hgVdkbuOoHfqXTFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=i2oGYEp341u8C1fswQNAfOIuZtruZ8UpU8iAoJupQ7M=;
        b=GBoG31MqeVRLYeUab+9OJlAb72pyunejbEDp9nD0pYaNC21Rc6+ezQWynoNqGcLQ9m
         44Zg3DF5y3FHC6pTxFrwUVSywJVxmjM5rxh6bLWc7d7gl1Op0VPnva2jz5/Uj1BQl2jw
         3AuIso7aAwbaHnW//R4GJh8g5BXFsikmBr99q8Cgg+OzzKg9B9H9IeO1/wU6T7F0TgZv
         Cr2oIGw3p+UULA5Z0/V93+ZJMCfjXd+d9VhByEprkLs4VNctlzn9F4aMHKNMyJM2INO5
         xv83n26jD3C01V+G2VoHEPzoSzuiokkpNJaJbTTJmZ8t1yA1EAk0H7YWD4NHTlIp3XI6
         KjWw==
X-Gm-Message-State: APt69E11MOZq4BYVaXANsxpLOPBKgBGiNUy1V3i8mjbv12sqm1nQO/fP
        08p++iWZwMU89X5TnKAuWUCCwg==
X-Google-Smtp-Source: AAOMgpdCOu8dQkAQFVBozBfBD3H9O+NTufg5q6gAhoHNRmc1q6HOdr/pyF1Sewa0Ohjr7WbVNR1qGg==
X-Received: by 2002:adf:b05c:: with SMTP id g28-v6mr1112784wra.128.1530699064938;
        Wed, 04 Jul 2018 03:11:04 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id o8-v6sm6489881wro.68.2018.07.04.03.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 03:11:04 -0700 (PDT)
Date:   Wed, 4 Jul 2018 11:11:02 +0100
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
Message-ID: <20180704101102.GA496@dell>
References: <cover.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
 <18a04e42debb2a23aec855cac3bcf3d6ab6c55fd.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_533te3UuY9V9U+Z0yxTkW==3wsK22uzB4G=aWGour7Quw@mail.gmail.com>
 <20180704083911.GH2118@localhost.localdomain>
 <20180704095257.GJ2118@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180704095257.GJ2118@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jul 2018, Matti Vaittinen wrote:

> On Wed, Jul 04, 2018 at 11:39:11AM +0300, Matti Vaittinen wrote:
> > On Tue, Jul 03, 2018 at 11:26:00AM +0200, Enric Balletbo Serra wrote:
> > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > > dia dv., 29 de juny 2018 a les 11:47:
> > > 
> > > Now that you use devm calls and you don't need to unwind things I
> > > think is better to use plain returns. So,
> > > 
> > > return -ENOMEM;
> > 
> > I have never really understood why use of gotos in error handling is
> > discouraged.

They're not.

> > Personally I would always choose single point of exit from
> > a function when it is simple enough to achieve (like in this case). I've
> > written and fixed way too many functions which leak resources or
> > accidentally keep a lock when exiting from error branches. But I know
> > many colleagues like you who prefer not to have gotos but  in place returns
> > instead. So I guess I'll leave the final call on this to the one who is
> > maintainer for this code. And it is true there is no things to unwind
> > now - which does not mean that next updater won't add such. But as I
> > said, I know plenty of people share your view - and even though I rather
> > maintain code with only one exit the final call is on subsystem maintainer
> > here.

Please use gotos in the error path.

IMO, it's the nicest way to unwind (as you call it).

> Actually, If it was completely my call the probe would look something
> like this:
> 
> +static int bd71837_i2c_probe(struct i2c_client *i2c,
> +                           const struct i2c_device_id *id)
> +{
> +       struct bd71837 *bd71837;
> +       struct bd71837_board *board_info;
> +       int gpio_intr = 0;
> +
> +       const char *errstr = "No IRQ configured";
> +       int ret = -EINVAL;
> +
> +       bd71837 = devm_kzalloc(&i2c->dev, sizeof(struct bd71837), GFP_KERNEL);
> +
> +       if (bd71837 == NULL)
> +               return -ENOMEM;
> +
> +       board_info = dev_get_platdata(&i2c->dev);
> +
> +       if (!board_info)
> +               gpio_intr = i2c->irq;
> +       else
> +               gpio_intr = board_info->gpio_intr;
> +
> +       if (!gpio_intr)
> +               goto err_out;
> +
> +       i2c_set_clientdata(i2c, bd71837);
> +       bd71837->dev = &i2c->dev;
> +       bd71837->i2c_client = i2c;
> +       bd71837->chip_irq = gpio_intr;
> +
> +       errstr = "regmap initialization failed";
> +
> +       bd71837->regmap = devm_regmap_init_i2c(i2c, &bd71837_regmap_config);
> +       ret = PTR_ERR(bd71837->regmap);
> +       if (IS_ERR(bd71837->regmap))
> +               goto err_out;
> +
> +       errstr = "Read BD71837_REG_DEVICE failed";
> +       ret = bd71837_reg_read(bd71837, BD71837_REG_REV);
> +       if (ret < 0)
> +               goto err_out;
> +
> +       errstr = "Failed to add irq_chip";
> +       ret = devm_regmap_add_irq_chip(&i2c->dev, bd71837->regmap,
> +                                      bd71837->chip_irq, IRQF_ONESHOT, 0,
> +                                      &bd71837_irq_chip, &bd71837->irq_data);
> +       if (ret < 0)
> +               goto err_out;
> +
> +       errstr = "Failed to configure button short press timeout";
> +       ret = regmap_update_bits(bd71837->regmap,
> +                                BD71837_REG_PWRONCONFIG0,
> +                                BD718XX_PWRBTN_PRESS_DURATION_MASK,
> +                                BD718XX_PWRBTN_SHORT_PRESS_10MS);
> +       if (ret < 0)
> +               goto err_out;
> +
> +       /* According to BD71847 datasheet the HW default for long press
> +        * detection is 10ms. So lets change it to 10 sec so we can actually
> +        * get the short push and allow gracefull shut down
> +        */
> +       ret = regmap_update_bits(bd71837->regmap,
> +                                BD71837_REG_PWRONCONFIG1,
> +                                BD718XX_PWRBTN_PRESS_DURATION_MASK,
> +                                BD718XX_PWRBTN_LONG_PRESS_10S);
> +
> +       errstr = "Failed to configure button long press timeout";
> +       if (ret < 0)
> +               goto err_out;
> +
> +       btns[0].irq = regmap_irq_get_virq(bd71837->irq_data,
> +                                         BD71837_INT_PWRBTN_S);
> +
> +       errstr = "Failed to get the IRQ";
> +       ret = btns[0].irq;
> +       if (btns[0].irq < 0)
> +               goto err_out;
> +
> +       errstr = "Failed to create subdevices";
> +       ret = devm_mfd_add_devices(bd71837->dev, PLATFORM_DEVID_AUTO,
> +                                  bd71837_mfd_cells,
> +                                  ARRAY_SIZE(bd71837_mfd_cells), NULL, 0,
> +                                  regmap_irq_get_domain(bd71837->irq_data));
> +       if (ret) {
> +err_out:
> +               if (errstr)
> +                       dev_err(&i2c->dev, "%s (%d)\n", errstr, ret);
> +       }
> +
> +       return ret;
> +}
> 
> What do you think of this? To my eye it is nice. It keeps single point of
> exit and introduces only simple if-statements without the need of curly
> brackets. And finally the error prints string works as a comment too.
> I've seen bunch of constructs like this on the networking side but I
> have no idea if this is frowned on this subsystem =) Oh, and probe abowe
> is just to illustrate the idea, I did not even try compiling it yet.

That is horrible.  I nearly vomited on my keyboard.  It doesn't flow
anywhere nearly as nicely has sorting out all of the error handling
*after* it has been detected.  You're sacrificing readability to save
a single line and do not save any *actual* lines of code, only a brace.

Landing a goto in the middle of a statement is messy and unsightly.

What happens when you have some resources to free?  The last few lines
will become very messy, very quickly.

Nit: "something == NULL" is better written as "!something".
Nit: Please use proper multi-line comments as per the Coding Style.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
