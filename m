Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFB2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D89F213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D89F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeJCWGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:06:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42510 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbeJCWGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:06:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1BC2C207BB; Wed,  3 Oct 2018 17:17:27 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id CF1D2206A1;
        Wed,  3 Oct 2018 17:17:26 +0200 (CEST)
Date:   Wed, 3 Oct 2018 17:17:27 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v4 6/8] mtd: maps: gpio-addr-flash: Convert to gpiod
Message-ID: <20181003171727.145e7e41@bbrezillon>
In-Reply-To: <20181003171114.51ab47b8@bbrezillon>
References: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
        <20181001124351.31615-6-ricardo.ribalda@gmail.com>
        <20181003171114.51ab47b8@bbrezillon>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018 17:11:14 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> Hi Ricardo,
> 
> On Mon,  1 Oct 2018 14:43:49 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
> 
> > @@ -248,14 +252,19 @@ static int gpio_flash_probe(struct platform_device *pdev)
> >  
> >  	i = 0;
> >  	do {
> > -		if (devm_gpio_request(&pdev->dev, state->gpio_addrs[i],
> > -				      DRIVER_NAME)) {
> > +		unsigned int *gpio_id = (unsigned int *)gpios->start;
> > +
> > +		if (devm_gpio_request_one(&pdev->dev, gpio_id[i], GPIOD_OUT_LOW,
> > +					DRIVER_NAME)) {
> >  			dev_err(&pdev->dev, "failed to request gpio %d\n",
> > -				state->gpio_addrs[i]);
> > +				gpio_id[i]);
> >  			return -EBUSY;
> >  		}
> > -		gpio_direction_output(state->gpio_addrs[i], 0);
> > -	} while (++i < state->gpio_count);
> > +
> > +		state->gpios->desc[i] = gpio_to_desc(gpio_id[i]);
> > +		if (!state->gpios->desc[i])
> > +			return -EINVAL;
> > +	} while (++i < state->gpios->ndescs);  
> 
> Actually, I was thinking about using devm_gpiod_get_array() here and
> defining a gpio lookup table in the board file registering the device.
> This way, adding support for DT based parsing is transparent.

It's actually easier than I thought since no one is registering such a
device, so all you have to do is call devm_gpiod_get_array() and have a
struct gpio_descs pointer in struct async_state.
