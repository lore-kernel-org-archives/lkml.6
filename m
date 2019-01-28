Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064A3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C353F2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqaqvk4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfA1Ufa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:35:30 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33983 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfA1Uf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:35:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id j10so7722570pga.1;
        Mon, 28 Jan 2019 12:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HZY5zlA0Ha3XPIX1d22y6C5wxhdVkfX48tyGip9wUas=;
        b=Dqaqvk4lou7Mukp/6zwsZ/Yyessk6GOUeMSOXv7LYUQRkFgWwFdEOOcYfvF1fx3CVi
         7j2m2JfKy2SQbMyGRAQf5kSIvXzJfduDUxc0UgNjg2aEi1hfe6P6S5WL1yfkLi+0MF9v
         PjezxUy4ahMvR6l+4AzoNfxUspc3Z+Df3tm0dPji9qZYPdFRv0cylwZNnmK2RELRQbIa
         uLK38hS8Ixjf0/g4AjonBIMZkGd4jH1zjIawva+Xkd9/V7HyGqagp/wmjikgF+72dpnh
         E/jLd4NBYZGSaN5GzGOfMN3kSLGHTA1jnlUMKpkOIBzYpJbIZzzEhuOfkeiFhH2Wvd9y
         g9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HZY5zlA0Ha3XPIX1d22y6C5wxhdVkfX48tyGip9wUas=;
        b=QDgar+aNsmfHBwv836r/o1ePveRF/RRJKfntG065cMtGuVEHLLf2FK5rTgIwvBa3/J
         7Imu4jOd4RamMPc1N/u+yIb2OdnbAh41XyJyipXWgCQv446UYSB2AghRaAbAy98X4sji
         MvYnCh3if4yDucwoD/pChSrE7uD9YDZBJVFvgcrMjCrjaq1MykdNi+5SrZddWMeJUpAL
         5tutgJFSwmV8Wci/4CJ/SYciSYlkUaDmrMUY8RWZO537CdW+XnYHIVoSGLMTbgwW31WO
         PP5DTtgw7CB8DFLbwIZat3TYjZW5z4LDBZzqHeLbUF3umEplXE7a+SgysWegMQSMoPfK
         xzUQ==
X-Gm-Message-State: AJcUukfiqLabmIQ0tGhC6xdsvCtEi7OasmZfFA9OftOr9QxeCERgbx7k
        4cSQClZP0eZh0VjHanCARJKhonfh
X-Google-Smtp-Source: ALg8bN60zvB6enLA9SFpuAMVRa2pznc6DdhSpwzLw1XzfD04R5tY3ijB8H0CokfbMLSxvBojmvxtgQ==
X-Received: by 2002:a63:484c:: with SMTP id x12mr21034788pgk.375.1548707728387;
        Mon, 28 Jan 2019 12:35:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w88sm71806835pfk.11.2019.01.28.12.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 12:35:27 -0800 (PST)
Date:   Mon, 28 Jan 2019 12:35:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/10] watchdog: bd70528: Initial support for ROHM
 BD70528 watchdog block
Message-ID: <20190128203526.GA13726@roeck-us.net>
References: <20190125110625.GA29348@localhost.localdomain>
 <1d05ec19-daf6-f1d9-f80c-57fc92906d22@roeck-us.net>
 <20190128080035.GC2030@localhost.localdomain>
 <20190128081347.GD2030@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128081347.GD2030@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:13:47AM +0200, Matti Vaittinen wrote:
> On Mon, Jan 28, 2019 at 10:00:35AM +0200, Matti Vaittinen wrote:
> > On Sat, Jan 26, 2019 at 08:36:14AM -0800, Guenter Roeck wrote:
> > > On 1/25/19 3:06 AM, Matti Vaittinen wrote:
> > > > +/* Max time we can set is 1 hour, 59 minutes and 59 seconds */
> > > > +#define WDT_MAX_MS ((2 * 60 * 60 - 1) * 1000)
> > > > +/* Minimum time is 1 second */
> > > > +#define WDT_MIN_MS 1000
> > > > +#define DEFAULT_TIMEOUT 60
> > > > +
> > > > +static int bd70528_wdt_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct bd70528 *bd70528;
> > > > +	struct wdtbd70528 *w;
> > > > +	int ret;
> > > > +	unsigned int reg;
> > > > +	struct watchdog_device *wdt;
> > > > +
> > > > +	bd70528 = dev_get_drvdata(pdev->dev.parent);
> > > > +	if (!bd70528) {
> > > > +		dev_err(&pdev->dev, "No MFD driver data\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +	w = devm_kzalloc(&pdev->dev, sizeof(*w), GFP_KERNEL);
> > > > +	if (!w)
> > > > +		return -ENOMEM;
> > > > +	w->bd = bd70528;
> > > 
> > > Unless I am missing something, only the mutex and the regmap pointer
> > > are used from struct bd70528. With that in mind, it might be desirable
> > > to copy those pointers to struct wdtbd70528 to avoid the additional
> > > dereferencing at runtime.
> > 
> > You are not missing anyting. If we ever add support for another PMIC
> > variant we will probably be using also the chip_type. Untill then only
> > the mutex and regmap. (And maybe the of_node if we have any RTC
> > properties in DT). So at this point we just use regmap and mutex. I will
> > change this.
> 
> Oh, but actually we are also using the WDT state setting function
> provided by MFD. And this is taking the struct bd70528 as parameter. So
> maybe we can keep it like this afterall? 
> 
Ok.

Guenter

> > 
> > > > +	w->dev = &pdev->dev;
> > > > +
> > > > +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> > > > +	if (!wdt)
> > > > +		return -ENOMEM;
> > > > +
> > > 
> > > struct watchdog_device can be part of struct wdtbd70528. Two separate allocations
> > > are not necessary.
> > 
> > Correct. Thanks for pointing that out. I'll simplify this.
> > 
> > > > +	wdt->info = &bd70528_wdt_info;
> > > > +	wdt->ops =  &bd70528_wdt_ops;
> > > > +	wdt->min_hw_heartbeat_ms = WDT_MIN_MS;
> > > > +	wdt->max_hw_heartbeat_ms = WDT_MAX_MS;
> > > > +	wdt->parent = pdev->dev.parent;
> > > > +	wdt->timeout = DEFAULT_TIMEOUT;
> > > > +	watchdog_set_drvdata(wdt, w);
> > > > +	watchdog_init_timeout(wdt, 0, pdev->dev.parent);
> > > > +
> > > > +	ret = bd70528_wdt_set_timeout(wdt, wdt->timeout);
> > > > +	if (ret) {
> > > > +		dev_err(&pdev->dev, "Failed to set the watchdog timeout\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	mutex_lock(&bd70528->rtc_timer_lock);
> > > > +	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_WDT_CTRL, &reg);
> > > > +	mutex_unlock(&bd70528->rtc_timer_lock);
> > > > +
> > > 
> > > I don't see the point for the above mutex locks. This is just reading a
> > > single register. regmap itself provides locking for that already.
> > 
> > It has a purpose here - but I'd better add a comment. We want to get the
> > initial state of WDG here. If the probe is executed when RTC time is being
> > set we may read the state just when RTC is (temporarily) disabling WDT -
> > and we might tell the WDT core that WDT is disabled - even if it is
> > actually enabled. The mutex prevents us from reading the WDT state when
> > RTC is being set.
> >  
> > Br,
> > 	Matti Vaittinen
