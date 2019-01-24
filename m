Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A40AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C0B2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyVlWGPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfAXOhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:37:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41421 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfAXOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:37:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so2975672plm.8;
        Thu, 24 Jan 2019 06:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xn1VVko+etvUCk3QL1sGUoOD3oCOAgP6osfKszYJpfI=;
        b=qyVlWGPt7BgrlHIwfwCyah+Tb7njLbSWStyGjl9zS2a9VIVzAQPDRIj3ICsXgA9ZzE
         LMHXCzOCuJ1CT8kwhpewgmqTmuMeV91NtmJVluhq7s0RHml39tXAJy/Fsz1HVevdyGPY
         LhYppSkqrCQIEMmk9aVZa5UaOkIfm43mb4MjEjDtWjxmgGXIyoj/xPaYot/o0kEHZbyc
         e/n8NwHDT1pDI20uqmzYCZVpa5y6OR5hHcHtOgEpNGdz89NdkNjY+SGYRa5tXHPaHeOH
         IGlf2CjQQhWFCxWx1imljj/WVesqAH/0PDh1DEJBQMmhm2dG8XOQxMy6b5kgfwoZZ1AV
         92ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xn1VVko+etvUCk3QL1sGUoOD3oCOAgP6osfKszYJpfI=;
        b=H7nD+59cQWIqP9zghfKJpgU61RVfzuT7g85Ep2GiY58e/K2DhbkwAvvYPgDmzwrOMq
         d/yUDcdlgntzr7xBDPXYpyFHkVYnajoKa1UVMIXjztTvFbotBduiW/oBGFOXoo8L2AUb
         LaCMzCajIs4CxSlwS5saCY2/F3FvLgiiw3Pfa3MuYUu9soTYq4YH4TSwicAw/wtiW+vg
         OhjyeYifVRGbsm/5btv4Z+BJOyxItsSDwIt5Qy7y3hAAGikT7mWXo9+sZwadhKo8a43c
         ydhTX+q15BCA/VgmYfK4ZEEAQsgmCvKZUi4wkgvQzk5BxiqNti4wV6+R4Mhq4xcQpw1Q
         bScw==
X-Gm-Message-State: AJcUukcayF08IOlWRTx/uJ/eDM3ZGKXOmc9/aCEbXoBomzrFyEwopUdJ
        us/lEzG2zTLTHs/Nyck3XU0=
X-Google-Smtp-Source: ALg8bN77Y5oJvELoKgchO19nGc14m7zKUHPvxmSzFaQd3zvm+Okd/8Vo1YYljulVtHkE4n6MWTlRkA==
X-Received: by 2002:a17:902:981:: with SMTP id 1mr6650745pln.142.1548340670826;
        Thu, 24 Jan 2019 06:37:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o66sm37808457pgo.75.2019.01.24.06.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 06:37:49 -0800 (PST)
Date:   Thu, 24 Jan 2019 06:37:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>, mazziesaccount@gmail.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        wim@linux-watchdog.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [RFC PATCH v1 13/13] watchdog: bd70528: Initial support for ROHM
 BD70528 watchdog block
Message-ID: <20190124143747.GA29002@roeck-us.net>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <ec70833179d1953dbc91e01901b79d3319ff013d.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <20190122154750.GB1705@roeck-us.net>
 <20190122171023.GC2559@localhost.localdomain>
 <20190122174056.GB4964@roeck-us.net>
 <20190122180309.GD2559@localhost.localdomain>
 <20190123174728.uu7zhno5xea2bga7@earth.universe>
 <20190124104434.GF2559@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124104434.GF2559@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 12:44:35PM +0200, Matti Vaittinen wrote:
> On Wed, Jan 23, 2019 at 06:47:28PM +0100, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Tue, Jan 22, 2019 at 08:03:09PM +0200, Matti Vaittinen wrote:
> > > On Tue, Jan 22, 2019 at 09:40:56AM -0800, Guenter Roeck wrote:
> > > > On Tue, Jan 22, 2019 at 07:10:23PM +0200, Matti Vaittinen wrote:
> > > > > On Tue, Jan 22, 2019 at 07:47:50AM -0800, Guenter Roeck wrote:
> > > > > > On Tue, Jan 22, 2019 at 11:48:36AM +0200, Matti Vaittinen wrote:
> > > > > > > +static int bd70528_wdt_probe(struct platform_device *pdev)
> > > > > > > +{
> > > > > > > +	struct bd70528 *tmp;
> > > > > > > +	struct bd70528 *bd70528;
> > > > > > > +	int ret;
> > > > > > > +
> > > > > > > +	tmp = dev_get_drvdata(pdev->dev.parent);
> > > > > > > +	if (!tmp) {
> > > > > > > +		dev_err(&pdev->dev, "No MFD driver data\n");
> > > > > > > +		return -EINVAL;
> > > > > > > +	}
> > > > > > > +	bd70528 = devm_kzalloc(&pdev->dev, sizeof(*bd70528), GFP_KERNEL);
> > > > > > > +	if (!bd70528)
> > > > > > > +		return -ENOMEM;
> > > > > > > +
> > > > > > > +	*bd70528 = *tmp;
> > > > > > > +	bd70528->chip.dev = &pdev->dev;
> > > > > > 
> > > > > > This is wrong.
> > > > > > You should not copy the parent's driver data but have local driver
> > > > > > data as needed which then points to the parent's driver data if
> > > > > > needed. I assume this is why the mutex is a pointer, but that
> > > > > > just shows that the whole approach is wrong.
> > > > > 
> > > > > Mutex is a pointer because we want to use same mutex from WDT and RTC.
> > > > > We can sure point to parent data but then we still need our own dev
> > > > > pointer. So we can have a struct with pointer to parent data and dev
> > > > > pointer - but I'm not at all sure it is any clearer.
> > > > 
> > > > As I said, that is wrong. To say it in plaintext, I won't accept
> > > > the driver if it copies the parent's driver data. The driver should
> > > > have and use its own driver data, and only maintain a pointer to
> > > > its parent's driver data. And most definitely you don't want to
> > > > copy and use any device data structure from the parent.
> > > 
> > > Allright. At the moment the WDT driver only needs regmap pointer from
> > > parent. I'm not sure if it will later need DT or "chip type" - but I
> > > will change this.
> > 
> > You probably want to use this:
> > 
> > dev_get_regmap(pdev->dev.parent, NULL);
> 
> Thanks a bunch Sebastian. All help is highly appreciated!! =)
> 
> Unfortunately I forgot to mention the key thing - the RTC mutex. We also
> need that because RTC needs to stop WDT when RTC is adjusted as the WDT
> uses RTC as counter - and jumping the RTC WDT enabled might trigger WDT
> or have other consequences.
> 
> Se even if we used dev_get_regmap (which is slightly heavier than
> accessing direct pointer) - we would still need at least the mutex from
> parent data, possibly also the chip type and if we want to avoid code
> dublication - then also the WDT start/stop function.
> 
> Thus I guess we can as well keep the regmap in parent data because we
> need the parent data anyways, right?
> 

You are free to _use_ the parent data. Just not copy it.

Another possibility would be for the parent to provide platform
data for the rtc driver to use, and that platform data would
include pointers to the regmap and to the rtc mutex.

However, again, the one thing you can _not_ do is to copy the parent's
driver data.

Guenter
