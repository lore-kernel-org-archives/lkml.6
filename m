Return-Path: <fthain@telegraphics.com.au>
X-Google-Smtp-Source: AB8JxZppMXSzKcepy1ZeOaVIONj2x1uq18m3zslPnA9Kkzh7OX+f3xOzW5BS23KCYuTl07/3AfpN
ARC-Seal: i=1; a=rsa-sha256; t=1525586425; cv=none;
        d=google.com; s=arc-20160816;
        b=pNLRW4Pl/2Loh1zTlK4bbhjhPgfvxW+xtNHV1e8CRfsUTixdNyE45vXLxbTp0JdOcE
         yvWfpIe498Bv+Fw3j8KnImvWvyrzVg1aaLd6c/pkiFIUFFaPmLu62pZdkGH5QP4KY+0z
         oXW2mUWarhF82XZtXio/x+mymcRWPmqfLRfM+M28Anb7Wbud7LAUVnHplTWIIpWw0jeh
         E6jZGR2hiLmAiFqR9ngBqrYSLkfeaFPAmh0Bkqwj3mFrJXK580NmGYcbbYyBiW3GNQn8
         SHmBmr3LwABZV2CCboq8wXipUKveEdIEZkqi/HC1OTrOcEqbW//U8DanKZ3flcD6M/ED
         f8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:arc-authentication-results;
        bh=PfjB/rePYjUH1QpAGh80hQA856VyRT/L6cQDaiif+L4=;
        b=zSf2xjFoevgFCLcYzfCuo1O2xJ2O4/ZBNPq+Nvifs4JuPSea6RGO8JQ5u5b3cKEpAA
         8bmVGaHvGvQ+Q0/La+ETiAprviWltX/+v9+qZTS1kJkEwt0msdZ5nrOiCZkVqmxDr0lb
         QLuXtMqudhG788+Df+V7fP7edbqhsyXfSo2FmoTnxd0h1KNZ99QAMCY4ckQ3WNLMFCid
         rOS71V+c1gD6eOrltQL4tdlhCUnvgHyVC5AHmt92fFRlsH+uOb6ix2wWWxc1mjZeEjuj
         EXQpJYZHZw6dN13JbTAJZMubkVlIVsmC7+7VY4o+mgYXtbNHIE4eR3cJmGL3OE0NT1mg
         YcCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Date: Sun, 6 May 2018 16:00:15 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nubus: Unconditionally register bus type
In-Reply-To: <20180506045530.GA5328@kroah.com>
Message-ID: <alpine.LNX.2.21.1805061544550.8@nippy.intranet>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com> <20180506045530.GA5328@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599677433904135296?=
X-GMAIL-MSGID: =?utf-8?q?1599693311902302866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 5 May 2018, Greg Kroah-Hartman wrote:

> On Sun, May 06, 2018 at 11:47:52AM +1000, Finn Thain wrote:
> > Loading a NuBus driver module on a non-NuBus machine triggers the
> > BUG_ON(!drv->bus->p) in driver_register() because the bus does not get
> > registered unless MACH_IS_MAC(). Avoid this by registering the bus
> > unconditionally using postcore_initcall().
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reported-by: Michael Schmitz <schmitzmic@gmail.com>
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Fixes: 7f86c765a6a2 ("nubus: Add support for the driver model")
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > ---
> >  drivers/nubus/bus.c   | 3 ++-
> >  drivers/nubus/nubus.c | 5 -----
> >  include/linux/nubus.h | 1 -
> >  3 files changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
> > index d306c348c857..27ca9f1a281b 100644
> > --- a/drivers/nubus/bus.c
> > +++ b/drivers/nubus/bus.c
> > @@ -63,7 +63,7 @@ static struct device nubus_parent = {
> >  	.init_name	= "nubus",
> >  };
> >  
> > -int __init nubus_bus_register(void)
> > +static int __init nubus_bus_register(void)
> >  {
> >  	int err;
> >  
> > @@ -78,6 +78,7 @@ int __init nubus_bus_register(void)
> >  	device_unregister(&nubus_parent);
> >  	return err;
> >  }
> > +postcore_initcall(nubus_bus_register);
> 
> Why not just have an "bus is registered" flag in your driver register
> function that refuses to let drivers register with the driver core if it
> isn't set? 

Perhaps that should happen in the core driver_register() function. BUG_ON 
is frowned upon, after all. Would that be acceptable?

I found a few drivers that set a flag the way you describe, which could 
then be simplified.

But that pattern is rare. Most buses use the postcore_initcall() pattern, 
and so my patch took the conventional approach.

> And then fix your linking error, the bus should come first in link 
> order, before your drivers :)
> 

I didn't encounter any errors. How shall I reproduce this?

Thanks.

-- 

> thanks,
> 
> greg k-h
