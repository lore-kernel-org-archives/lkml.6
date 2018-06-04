Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeFDXaq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:30:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33566 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbeFDXap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:30:45 -0400
Date: Tue, 5 Jun 2018 01:30:32 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
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
Message-ID: <20180605013032.1b0f4de4@bbrezillon>
In-Reply-To: <20180605010932.5c97b1de@bbrezillon>
References: <CAHp75Ved2nw1JKnXT2Jxnw4XLsby1eVJU6cfBjE2sp4LP4Kwmg@mail.gmail.com>
        <1582841.uoaVdad1fL@z50>
        <20180604115543.3be75717@bbrezillon>
        <1716431.jBl9UCSIdH@z50>
        <20180605010932.5c97b1de@bbrezillon>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2018 01:09:32 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Mon, 04 Jun 2018 18:48:08 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > On Monday, June 4, 2018 11:55:43 AM CEST Boris Brezillon wrote:  
> > > On Wed, 30 May 2018 22:39:03 +0200
> > > 
> > > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:    
> > > > On Wednesday, May 30, 2018 7:52:20 PM CEST Boris Brezillon wrote:    
> > > > > On Wed, 30 May 2018 19:43:09 +0200
> > > > > 
> > > > > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:    
> > > > > > On Wednesday, May 30, 2018 11:05:00 AM CEST Boris Brezillon wrote:    
> > > > > > > Hi Janusz,    
> > > > > > 
> > > > > > Hi Boris,
> > > > > >     
> > > > > > > On Sat, 26 May 2018 00:20:45 +0200
> > > > > > > 
> > > > > > > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:    
> > > > > > > > ...
> > > > > > > > Changes since v1:
> > > > > > > > - fix handling of devm_gpiod_get_optional() return values - thanks
> > > > > > > > to
> > > > > > > > 
> > > > > > > >   Andy Shevchenko.    
> > > > > > > 
> > > > > > > Can you put the changelog after the "---" separator so that it does
> > > > > > > not
> > > > > > > appear in the final commit message?    
> > > > > > 
> > > > > > Yes, sure, sorry for that.
> > > > > >     
> > > > > > > > +err_gpiod:
> > > > > > > > +	if (err == -ENODEV || err == -ENOENT)
> > > > > > > > +		err = -EPROBE_DEFER;    
> > > > > > > 
> > > > > > > Hm, isn't it better to make gpiod_find() return
> > > > > > > ERR_PTR(-EPROBE_DEFER)
> > > > > > > here [1]? At least, ENOENT should not be turned into EPROBE_DEFER,
> > > > > > > because it's returned when there's no entry matching the requested
> > > > > > > gpio
> > > > > > > in the lookup table, and deferring the probe won't solve this
> > > > > > > problem.    
> > > > > > 
> > > > > > ENOENT is also returned when no matching lookup table is found. That
> > > > > > may
> > > > > > happen if consumer dev_name stored in the table differs from dev_name
> > > > > > assigned to the consumer by its bus, the platform bus in this case.
> > > > > > For
> > > > > > that reason I think the consumer dev_name should be initialized in the
> > > > > > table after the device is registered, when its actual dev_name can be
> > > > > > obtained. If that device registration happens after the driver is
> > > > > > already
> > > > > > registered, e.g., at late_initcall, the device is probed before its
> > > > > > lookup table is ready. For that reason returning EPROBE_DEFER seems
> > > > > > better to me even in the ENOENT case.    
> > > > > 
> > > > > Sorry, I don't get it. Aren't GPIO lookup tables supposed to be declared
> > > > > in board files, especially if the GPIO is used by a platform device?
> > > > > When would you have a lookup table registered later in the init/boot
> > > > > process?    
> > > > 
> > > > When e.g. I'd like to register my GPIO consumer platform device at
> > > > late_initcall for some reason, and I'm not sure what exact dev_name my
> > > > consomer will be registered with by the platform bus.    
> > > 
> > > You should know the name before the device is registered.    
> > 
> > What if I use PLATFORM_DEVID_AUTO?

Just had a quick look at board-ams-delta.c and you don't have a single
device setting pdev->id to PLATFORM_DEVID_AUTO. It's either set to
PLATFORM_DEVID_NONE (-1) or assigned a specific id, so the problem does
not exist, really. Just set the name .dev_id to the appropriate value
at declaration time and register the lookup tables before registering
the pdevs.
