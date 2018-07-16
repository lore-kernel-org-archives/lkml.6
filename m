Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC930ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904AC206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904AC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbeGPIJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:09:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:41824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388375AbeGPIJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:09:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73CDEACB8;
        Mon, 16 Jul 2018 07:25:24 +0000 (UTC)
Date:   Mon, 16 Jul 2018 09:25:23 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: add driver for the MEN 16z069 IP-Core
Message-ID: <20180716072523.4ikug4iix3qnmqto@linux-x5ow.site>
References: <20180713125831.26074-1-jthumshirn@suse.de>
 <3911405c-4192-2554-cfb9-0441c3d8ef9b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3911405c-4192-2554-cfb9-0441c3d8ef9b@roeck-us.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 06:50:25AM -0700, Guenter Roeck wrote:
[...]
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mcb.h>
> > +#include <linux/watchdog.h>
> > +#include <linux/io.h>
> > +
> Alphabetic order, please

Done.
> 
> > +struct men_z069_drv {
> > +	struct watchdog_device wdt;
> > +	void __iomem *base;
> > +	struct resource *mem;
> > +};
> > +
> > +#define MEN_Z069_WTR 0x10
> > +#define MEN_Z069_WTR_WDEN BIT(15)
> > +#define MEN_Z069_WTR_WDET_MASK	0x7fff
> > +#define MEN_Z069_WVR 0x14
> > +
> > +#define MEN_Z069_TIMER_FREQ 500 /* 500 Hz */
> > +#define MEN_Z069_WDT_COUNTER_MIN 1
> > +#define MEN_Z069_WDT_COUNTER_MAX 0x7fff
> > +
> Looks like you are sometimes using tabs and sometimes not.
> Please align all values with tabs, or if you really dislike that don't use
> tabs at all.

Made it all tabs.

[...]
> > +	if (val < MEN_Z069_WDT_COUNTER_MIN || val > MEN_Z069_WDT_COUNTER_MAX)
> > +		return -EINVAL;
> > +
> 
> This is unnecessary. As long as the limits are provided, they are validated
> by the watchdog core.

Good point removed the check.
 
> 
> Note that it is wrng to set ->timeout and then return an error.
> The watchdog core will then report a bad current timeout to user space.

Yeah the return isn't needed anymore.

> 
> > +	reg = readw(drv->base + MEN_Z069_WVR);
> > +	ena = reg & MEN_Z069_WTR_WDEN;
> > +	reg = ena | (val & MEN_Z069_WTR_WDET_MASK);
> 
> Masking val is unnecessary here. val is already guaranteed to be
> smaller than the mask.
>
Yep, removed the mask.

 
> I would suggest to use
> 	.max_timeout = MEN_Z069_WDT_COUNTER_MAX / MEN_Z069_TIMER_FREQ;
> or define MAX_TIMEOUT as (MEN_Z069_WDT_COUNTER_MAX / MEN_Z069_TIMER_FREQ) and use it.

Went down the 1st route.

[...]

> > +	drv->base = devm_ioremap(&dev->dev, mem->start, resource_size(mem));
> > +	if (drv->base == NULL)
> > +		goto release_mem;
> 
> The proper errr to return here is -ENOMEM, or use devm_ioremap_resource()
> and return whatever error it reports.

Done.

> 
> > +
> > +	drv->mem = mem;
> > +
> > +	watchdog_init_timeout(&men_z069_wdt, 30, &dev->dev);
> 
> Please make '30' a define. Unless you know for sure that this will never be used
> in a devicetree system, I would suggest to set the default timeout in struct
> watchdog_device and pass 0 as argument here; this way the core picks the default
> timeout if set in devicetree.

Well it sits on a self describing bus so no device-tree needed here. Anyways made it 0.

> 
> > +	watchdog_set_nowayout(&men_z069_wdt, nowayout);
> > +	watchdog_set_drvdata(&men_z069_wdt, drv);
> > +	men_z069_wdt.parent = &dev->dev;
> > +	drv->wdt = men_z069_wdt;
> 
> This is unusual. I would suggest to drop men_z069_wdt and set the necessary fields
> in drv->wdt directly.

Well as I'm not really working on watchdogs often I just copy&pasted
it from mena21_wdt.c which was my first driver some years ago. So this
might be the reason for this oddity. Anyways fixed it.

> 
> > +	mcb_set_drvdata(dev, drv);
> > +
> > +	/* Set initial timeout to 65.5s and disable the watchdog */
> > +	writew(MEN_Z069_WDT_COUNTER_MAX, drv->base + MEN_Z069_WTR);
> > +
> 
> Hmm - above default is set to 30 seconds.
> 
> Another possibility would be to detect the current watchdog state
> (and possibly timeout) and inform the watchdog core that the watchdog
> is running. This way there is no gap in watchdog coverage if the
> watchdog was already enabled in BIOS/ROMMON.

This is a leftover from debugging the Qemu emulation of the device I
guess, removed it now.

[...]

> > +};
> > +module_mcb_driver(men_z069_driver);
> > +
> > +
> Double empty line.

Gone.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
