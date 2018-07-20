Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A17ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BFF20671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BFF20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeGTUiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:38:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35120 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbeGTUiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:38:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A4A5020733; Fri, 20 Jul 2018 21:48:22 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.220.171])
        by mail.bootlin.com (Postfix) with ESMTPSA id 16A7A206D8;
        Fri, 20 Jul 2018 21:48:11 +0200 (CEST)
Date:   Fri, 20 Jul 2018 21:48:08 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [RFC PATCH 8/8] mtd: rawnand: ams-delta: Use GPIO callbacks for
 data I/O
Message-ID: <20180720214808.0c19234e@bbrezillon>
In-Reply-To: <2165137.iTHcPHRtIn@z50>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
        <20180718235710.18242-9-jmkrzyszt@gmail.com>
        <20180719084749.25ca96a6@bbrezillon>
        <2165137.iTHcPHRtIn@z50>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Janusz,

On Fri, 20 Jul 2018 20:38:15 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> On Thursday, July 19, 2018 8:47:49 AM CEST Boris Brezillon wrote:
> > On Thu, 19 Jul 2018 01:57:10 +0200
> > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> >   
> > > Don't readw()/writew() data directly from/to GPIO port which is under
> > > control of gpio-omap driver, use GPIO chip callbacks instead.
> > > 
> > > Thanks to utilization of get/set_multiple() callbacks, performance
> > > degrade is minor for typical data transfers.  
> > 
> > Same comment here, don't use the gpio_chip hooks directly, use the
> > consumer API instead.  
> 
> I tired but performance was not acceptable.

You tried to use gpiod_{get,set}_array_value(), right? Did you
investigate on where the overhead comes from?

> 
> I see your point but please understand, what I'm trying to do here is not to 
> develop a shiny general purpose fully GPIO based NAND driver, I'm trying to 
> resolve issues with NAND driver for Amstrad Delta I like to play with, without 
> loosing much performance.

That's not a reason to violate the consumer/driver separation provided
by the GPIO framework. I'm not saying the current consumer APIs are
good enough for what you want to do (bit-bang a parallel data bus in
an efficient way), but bypassing the GPIO core like you do is
definitely not a good thing. Maybe you should discuss with Linus the
possibility of introducing a gpio_bitbang API that would provide you
some guarantees on the access time by making sure the pins all belong
to the same bank (and can thus be accessed in an atomic way). And maybe
provide a way to read/write several bytes by defining a delay between
each access, the size of the bus and the control pin if any (in
our case NRE/NWE). 

> 
> I'm going to reconsider all possible options, not only doing data I/O over 
> GPIO inside the driver, to have the task completed.  Once done,  I can get 
> back to the GPIO based code I developed so far and create a new generic driver 
> as my free time permits, or anyone can do that if needed, the code is open 
> source after all.

Let's forget the generic nand-gpio driver for now. All I'm asking is
that you do not bypass the GPIO framework like you intend do in this
patch.

Regards,

Boris
