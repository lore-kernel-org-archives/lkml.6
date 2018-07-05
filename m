Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A315C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040162411D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OU98YPC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040162411D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbeGEFuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:50:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51863 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbeGEFul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:50:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so8922100wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 22:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P7DovC925e3+lSqxS5dHVhTdxEkbJUMUjg29TMg5ykg=;
        b=OU98YPC/VrkRcNI0jOv6E/gjiIYV7F1WdlBTE8DgQy7dcvYHhS1CRUOXv2lNYYW6PB
         64dxDIpSFZm5YSE3vOACvW9/XM/HZOGHqYEi9OlwG1kDggmFwRLqVHtdj5a1PVvfk5ft
         HoNkhfpqtmce7QCfktXiVM6FrVayksS3jkqTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P7DovC925e3+lSqxS5dHVhTdxEkbJUMUjg29TMg5ykg=;
        b=gyCm9Ug0EuHQFkwZEJ9AfRTNdLat5/Ul38sKcj+dGb541/M1JQzQocZqxZLejzEZUV
         NQJnFTWdaQO1gaM/k7nvX7V+YTx37nkZ2qiG8ulbWNQr7cnAjwy6LgMbjfaMQXCTU3sB
         XTq3PYZgyuP01IxImIZB1dJ3sIYzJwv6ujO1VYEuVn7iyx8dcKtWuPOqxAmnUlY6XBK7
         tyiYZpXm6Ks/OcOc4SuX2y+6c4OUs9Ie/daHRSzR81Fmr80KeF12sW1iqnFGsuhvpWA8
         29QLqWw9+VvdGweot4txiP+EcxNiEVUqtURxP4iTf6niuv9zWP4JSBGJ4m5imXTRppSm
         uHIA==
X-Gm-Message-State: APt69E30QAr5TXBaKnDt38yabZfX56mVglR2FKQIxrUufqHFc14JR8wu
        TURGIwubmXv3MTC8hW8wdsev5A==
X-Google-Smtp-Source: AAOMgpcZGamwerRQSioXBkBPDijhiEkaaamDZnrj1+AkNTzKerTWIIJjr0fdb/pRroqao8ABO81Iwg==
X-Received: by 2002:a1c:b484:: with SMTP id d126-v6mr3103382wmf.17.1530769840204;
        Wed, 04 Jul 2018 22:50:40 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id 136-v6sm10760414wmr.18.2018.07.04.22.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 22:50:39 -0700 (PDT)
Date:   Thu, 5 Jul 2018 06:50:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Phil Reid <preid@electromag.com.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Peter Rosin <peda@axentia.se>, patches@opensource.cirrus.com,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] gpiolib: Defer on non-DT find_chip_by_name() failure
Message-ID: <20180705055037.GI496@dell>
References: <20180703172635.32508-1-jmkrzyszt@gmail.com>
 <20180703193141.747fa950@bbrezillon>
 <7058252.SGNltMTCCa@z50>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7058252.SGNltMTCCa@z50>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jul 2018, Janusz Krzysztofik wrote:

> On Tuesday, July 3, 2018 7:31:41 PM CEST Boris Brezillon wrote:
> > Hi Janusz,
> > 
> > On Tue,  3 Jul 2018 19:26:35 +0200
> > 
> > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> > > Avoid replication of error code conversion in non-DT GPIO consumers'
> > > code by returning -EPROBE_DEFER from gpiod_find() in case a chip
> > > identified by its label in a registered lookup table is not ready.
> > > 
> > > See https://lkml.org/lkml/2018/5/30/176 for example case.
> > > 
> > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > > ---
> > > If accepted, please add
> > > 
> > > 	Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > 
> > > if Boris doesn't mind.
> > > 
> > > Thanks,
> > > Janusz
> > > 
> > >  drivers/gpio/gpiolib.c | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index e11a3bb03820..15dc77c80328 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -3639,9 +3639,16 @@ static struct gpio_desc *gpiod_find(struct device
> > > *dev, const char *con_id,> 
> > >  		chip = find_chip_by_name(p->chip_label);
> > >  		
> > >  		if (!chip) {
> > > 
> > > -			dev_err(dev, "cannot find GPIO chip %s\n",
> > > -				p->chip_label);
> > > -			return ERR_PTR(-ENODEV);
> > > +			/*
> > > +			 * As the lookup table indicates a chip with
> > > +			 * p->chip_label should exist, assume it may
> > > +			 * still appear latar and let the interested
> > 
> > 					^ later
> > 
> > > +			 * consumer be probed again or let the Deferred
> > > +			 * Probe infrastructure handle the error.
> > > +			 */
> > > +			dev_warn(dev, "cannot find GPIO chip %s, deferring\n",
> > > +				 p->chip_label);
> > > +			return ERR_PTR(-EPROBE_DEFER);
> > > 
> > >  		}
> > >  		
> > >  		if (chip->ngpio <= p->chip_hwnum) {
> > 
> > Looks good otherwise. Let's hope we're not breaking implementations
> > testing for -ENODEV...
> 
> I've reviewed them all and found two which I think may be affected:
> - drivers/mfd/arizona-core.c,
> - drivers/i2c/busses/i2c-imx.c.
> As far as I can understand the code, both depend on error != -EPROBE_DEFER in 
> order to continue in degraded mode. I'm adding their maintainers to the loop.

From a quick glance, the -EPROBE_DEFER handing in Arizona Core appears
to be correct.  Would you mind explaining what your concerns are in
more detail please?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
