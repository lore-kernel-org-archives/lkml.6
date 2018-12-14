Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FF4C43177
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC91B20643
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbeLNN6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:58:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32966 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeLNN6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:58:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so4338226lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 05:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SezyHym3sylgzCgCuR8LmxCPbkk0wgGudnXpwYrAhZA=;
        b=fQdl9Ih2pLrLBhRQawP9+9HiFRyIgMzvK3BdJZOXt/6h67+PVaMgkLh51A0EhZYu8t
         xTgb+nAG8vZX1cSG+FkmWErjSfb3Y0Rj9mYiTUPJ2YKTteDU0JtVlLsxPN+FImhyskyU
         zphitP9uRpZIgZbLy1/fjIc0r6D0QySa3yNVc+t9P9fSdijERFsC8smD9NvqR+xl7TYR
         FID9UtdSaPFUwPPeloUAjnBSBeyzdgNGczUT7AAFK/0oAJ1CYh8puPLlLD7Z+EdIQx+l
         5/eeSenwbiE+47dmkCZEIB2jWDQ+R+hFihC2kLY/azE3OHngld3Y7ELNev4EVvd6XBo/
         ukaQ==
X-Gm-Message-State: AA+aEWbVPvpLDxrNoWp2UjMf/h9WzaNSDpaFDCGURFS9raU/kcWcXnoo
        /ge/FUrWzSGOHvga9c8320PfJfWw
X-Google-Smtp-Source: AFSGD/VkTvXUy/EkECmtwtlujAd4BB25RQZgEEeU3ySpC6S2IpUZMEMlNW2kIzeIIbbNDCieHJCktQ==
X-Received: by 2002:a19:d242:: with SMTP id j63mr2035102lfg.26.1544795913614;
        Fri, 14 Dec 2018 05:58:33 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x21sm937931lfe.6.2018.12.14.05.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 05:58:32 -0800 (PST)
Date:   Fri, 14 Dec 2018 15:58:19 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] regmap-irq: add "main register" and level-irq support
Message-ID: <20181214135819.GA2735@localhost.localdomain>
References: <20181130085908.GA24983@localhost.localdomain>
 <20181204172137.GE6809@sirena.org.uk>
 <20181205082251.GE31204@localhost.localdomain>
 <20181205172701.GH6205@sirena.org.uk>
 <20181207075829.GA24940@localhost.localdomain>
 <20181207131418.GB6510@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207131418.GB6510@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 01:14:18PM +0000, Mark Brown wrote:
> On Fri, Dec 07, 2018 at 09:58:29AM +0200, Matti Vaittinen wrote:
> > On Wed, Dec 05, 2018 at 05:27:01PM +0000, Mark Brown wrote:
> 
> > 		d->domain = irq_domain_add_linear(map->dev->of_node,
> > 						  chip->num_irqs,
> > 						  &regmap_domain_ops, d);
> 
> > where map->dev->of_node points the node added to regmap. And as we
> > really want to use the i2c to access registers, we should have done the
> > regmap using:
> 
> > devm_regmap_init_i2c(i2c, &regmap);
> 
> > where the i2c is the struct i2c_client *. The dev in i2c_client is the
> > i2c device - which has of_node pointing at the "main i2c node" - not the
> > sub block nodes. Hence all irq chips created by regmap_add_irq_chip for
> > this physical i2c slave device will point to the same DT node. 
> 
> Hrm, right.  You'd need to have a proxy regmap for the child devices for
> that.  Not ideal.
> 
> > 	bool mask_writeonly:1;
> > +	bool no_of:1;
> > 
> > and in the regmap_add_irq_chip do:
> 
> > 		node = (chip->no_of) ? NULL : map->dev->of_node;
> > 		d->domain = irq_domain_add_linear(node, chip->num_irqs,
> > 						  &regmap_domain_ops, d);
> 
> > Then we could have chip->no_of set for the 'main irq chip' and for those
> > chips we don't wan't to expose via DT. In my case I would leave no_of
> > unset only for the irq-chip which I created for the GPIO? Is this a
> > silly idea?
> 
> That's worth a shot, yes - I'd need to see it fully fleshed out I think
> but it looks sensible (no ternery operator please).

Do you think this would be benefical even if we add the 'main irq
support'? If so, I can generate a patch out of this. I think this would
really suffice for my current need - but this stops wokrking as soon as
more than one sub-irq-chip want's to expose interrupts via DT.

> > > The mapping isn't guaranteed to be a 1:1 mapping - one way this hardware
> > > gets structured is that the central interrupt controller is saying which
> > > IP block is flagging an interrupt rather than which register has an
> > > interrupt set in it.  You can then have either more than one detailed
> > > status register for that IP
> 
> > Correct. But I guess the IP blocks often have limited set of registers for the
> > "sub interrupts". For such cases my idea would work, right. My RFC
> > handled case where there is many 'sub registers' to read for one 'main
> > bit.
> 
> Your idea definitely works for the current case, yes - I'm just thinking
> about future edge and extension cases.

I could send an example on how the driver utilizing the original RFC
interface would look like. I am starting to think it was not *that* bad
after all...

> > > or several smaller IPs reporting through a
> > > single detailed status register.
> 
> > I think that if we have more than two layers of irqs (main and sub) -
> > then we should do cascaded controllers.
> 
> Yeah, and my first thought here is that we should just be using cascaded
> controllers all the time (but like I say I'm not 100% certain on that).
> 
> > > Right, it's about working out which subregister to read - the point is
> > > you can do this by adding a link in either direction, I'm suggesting
> > > doing it from the individual interrupt to the main register since we
> > > already have individual data structures for those and it feels less
> > > likely to run into hard to represent corner cases.
> 
> > I see your point now. But as I said, I am not sure we should add the
> > overhead of 'main irq bit description' for simple cases just to cover
> > the corner cases. Yet I can try seeing what I can come up with if you
> > think this is the way to go.
> 
> If you could take a look that'd be great.

I did some experiment. I will post this as another RFC - but I am really
not terribly happy about it. It's complex (well, in my opinion) and I am
not sure the driver interface is much easier. But you can see it
yourself.


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
