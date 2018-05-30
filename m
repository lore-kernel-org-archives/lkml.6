Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932280AbeE3Ujy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:39:54 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43725 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932176AbeE3Ujx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:39:53 -0400
X-Google-Smtp-Source: ADUXVKKgpU2hIIRPlkI2rUBGbnvCa1OTttq+DkYASrjpmCN87u/7E37279D5fR7awg8YCnedkmzN/w==
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 5/6 v2] mtd: rawnand: ams-delta: use GPIO lookup table
Date: Wed, 30 May 2018 22:39:03 +0200
Message-ID: <1582841.uoaVdad1fL@z50>
In-Reply-To: <20180530195220.3527f0fc@bbrezillon>
References: <CAHp75Ved2nw1JKnXT2Jxnw4XLsby1eVJU6cfBjE2sp4LP4Kwmg@mail.gmail.com> <1543045.tPZatK9yHU@z50> <20180530195220.3527f0fc@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 30, 2018 7:52:20 PM CEST Boris Brezillon wrote:
> On Wed, 30 May 2018 19:43:09 +0200
> 
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> > On Wednesday, May 30, 2018 11:05:00 AM CEST Boris Brezillon wrote:
> > > Hi Janusz,
> > 
> > Hi Boris,
> > 
> > > On Sat, 26 May 2018 00:20:45 +0200
> > > 
> > > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> > > > ...
> > > > Changes since v1:
> > > > - fix handling of devm_gpiod_get_optional() return values - thanks to
> > > > 
> > > >   Andy Shevchenko.
> > > 
> > > Can you put the changelog after the "---" separator so that it does not
> > > appear in the final commit message?
> > 
> > Yes, sure, sorry for that.
> > 
> > > > +err_gpiod:
> > > > +	if (err == -ENODEV || err == -ENOENT)
> > > > +		err = -EPROBE_DEFER;
> > > 
> > > Hm, isn't it better to make gpiod_find() return ERR_PTR(-EPROBE_DEFER)
> > > here [1]? At least, ENOENT should not be turned into EPROBE_DEFER,
> > > because it's returned when there's no entry matching the requested gpio
> > > in the lookup table, and deferring the probe won't solve this problem.
> > 
> > ENOENT is also returned when no matching lookup table is found. That may
> > happen if consumer dev_name stored in the table differs from dev_name
> > assigned to the consumer by its bus, the platform bus in this case. For
> > that reason I think the consumer dev_name should be initialized in the
> > table after the device is registered, when its actual dev_name can be
> > obtained. If that device registration happens after the driver is already
> > registered, e.g., at late_initcall, the device is probed before its
> > lookup table is ready. For that reason returning EPROBE_DEFER seems
> > better to me even in the ENOENT case.
> Sorry, I don't get it. Aren't GPIO lookup tables supposed to be declared
> in board files, especially if the GPIO is used by a platform device?
> When would you have a lookup table registered later in the init/boot
> process?

When e.g. I'd like to register my GPIO consumer platform device at 
late_initcall for some reason, and I'm not sure what exact dev_name my 
consomer will be registered with by the platform bus. In that case I think I 
should assign dev_name to the lookup table after the consumer device is 
registered and its exact dev_name can be obtained, then register the table,

Am I missing something?

Thanks,
Janusz
