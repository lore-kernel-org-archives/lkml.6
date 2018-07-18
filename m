Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB765ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB65420850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB65420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbeGRO4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:56:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55371 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729185AbeGRO4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:56:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5CA7820904; Wed, 18 Jul 2018 16:18:14 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2EE38203EC;
        Wed, 18 Jul 2018 16:18:04 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP1: ams-delta: Complete driver gpiod migration
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
        <20180717231448.14958-1-jmkrzyszt@gmail.com>
Date:   Wed, 18 Jul 2018 16:18:04 +0200
In-Reply-To: <20180717231448.14958-1-jmkrzyszt@gmail.com> (Janusz
        Krzysztofik's message of "Wed, 18 Jul 2018 01:14:45 +0200")
Message-ID: <87a7qoaaqr.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,
 
 On mer., juil. 18 2018, Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> This is a follow up of initial submission of a series consisted of 
> 6 changes, 3 of which have been already applied or reworkeed.
>
> V2 changelog:
> [PATCH 1/6] ARM: OMAP1: ams-delta: add GPIO lookup tables
> 	- already in mainline, commit 68e62a15a914
> [PATCH 2/6] Input: ams_delta_serio: use GPIO lookup table
> 	- reworked and submitted as a series, already in linux-omap,
> 	  commit 68e62a15a914 ("ARM: OMAP1: ams-delta: drop GPIO lookup
> 	  table for serio device") followed by 9 more
> [PATCH 3/6] ASoC: ams_delta: use GPIO lookup table
> 	- already in mainline, commit d65777d1a2cd
> [PATCH 4/6] fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
> 	- resubmitting as [PATCH v2 1/3 v2]
> 	v2: Remove problematic error code conversion no longer
> 	    needed if used on top of commit d08605a64e67 ("ARM: OMAP1:
> 	    ams-delta: move late devices back to init_machine")
> 	    and commit 8853daf3b4ac ("gpiolib: Defer on non-DT
> 	    find_chip_by_name() failure") already in linux-next
> [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup table
> 	- resubmitting as [PATCH v2 2/3 v4]
> 	v2: Fix handling of devm_gpiod_get_optional() return values -
> 	    thanks to Andy Shevchenko.
> 	v3: Remove problematic error code conversion no longer needed
> 	    if used on top of commit d08605a64e67 ("ARM: OMAP1:
> 	    ams-delta: move late devices back to init_machine") and
> 	    commit 8853daf3b4ac ("gpiolib: Defer on non-DT
> 	    find_chip_by_name() failure") already in linux-next - thanks
> 	    to Boris Brezillon
> 	v4: fix style issue - thanks to Boris Brezillon
> [PATCH 6/6] ARM: OMAP1: ams-delta: make board header file local to
> 	mach-omap1
> 	- resending as [PATCH v2 3/3]
>
> Dependency on commit 8853daf3b4ac ("gpiolib: Defer on non-DT
> find_chip_by_name() failure") is not critical - it is not needed for
> clean build or run, it only prevents from potential future changes to
> driver initializaton order during device_initcall.
>
> I'm submitting the three patches in series because the last one depends
> on the other two.

I think that being in CC in this series is a mistake as I don't see
anything related what I have done in this series.

Gregory

>
> Thanks,
> Janusz
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
