Return-Path: <schmitzmic@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525643473; cv=none;
        d=google.com; s=arc-20160816;
        b=w2hGQV1Is8kSoTC3K0s+qCgASzrblOBudVT3FG8nJxiRZfk9aP35Ai/Wk2vov/OkuY
         KJjO+lk/LdL1BobKz0kGy5luSowwuhU14slxiZPpLzJU1aJbhD4+65pwQRttIbUYIVki
         VVxYye34AuJZ2g4x6C7QIUAtMphqJnBJUXk2zY2yM/clHRyXjQ4H3H53mRd+7gPSS5xc
         vLVK/CFnZawzmQhArnk5zga6YfZ7zxh3ukG/fvoya+TEElJjjqpARwvQTgTs1T5MtYYY
         BypOX8p6vzLcwdouWohEymzXSgGLdMY1WMENaOpv2x5vH+lQUhANHcd8LEyguCKDYJiG
         xKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=PPDWKA/XVOkEWgsk8BGDlaw/4KsHwqawyNjcEaxGi5Q=;
        b=lpwNYCedeTaTu8Xnew9VGD99AmYr3lElppU2VvSiv7TBpjI8D/nnVVZGCxpw8sc2eJ
         pVIB4LXGtPJBExGyaYM94E/S4wbCqauDY8dLUj49owHRhAGjunpsJ2fa+rYXr2ASdKBr
         bj45ct1pgYfRZfihSEg3Q1ptVyIGKc/iP6b/Ni8CY3jTnAk3H2wdjlmZMLOUeo8PHsxu
         MdcENcFoJsmoUbznAzSqqoD0PzbLkwNJ6BwR3vVZCM918gGavhCdL7J4h3pKUBIocguJ
         0nGdOkkmjqlQbZWAehK9Zz8hS2GlelssWWvlxtOe6AkmAioMuavpp4cNCUST/vZ9GfV9
         G2iw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=m1hgoTiQ;
       spf=pass (google.com: domain of schmitzmic@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=schmitzmic@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=m1hgoTiQ;
       spf=pass (google.com: domain of schmitzmic@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=schmitzmic@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZq/qih5VfmqiZn68Gk2rTIpAUzd1Lw8j3er9VWcyw0dNzahgFC1iUJ8pfiz+R2ytvLOS0dkno7SJ3hzjP3ysns=
MIME-Version: 1.0
In-Reply-To: <20180506202018.GC8924@kroah.com>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com>
 <20180506045530.GA5328@kroah.com> <alpine.LNX.2.21.1805061544550.8@nippy.intranet>
 <20180506202018.GC8924@kroah.com>
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Mon, 7 May 2018 09:51:12 +1200
Message-ID: <CAOmrzk+bY5wUxJhNAwO-pf+O--HiqJ63rB3BmxRsY8qq_PeLmw@mail.gmail.com>
Subject: Re: [PATCH] nubus: Unconditionally register bus type
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Finn Thain <fthain@telegraphics.com.au>, Geert Uytterhoeven <geert@linux-m68k.org>,
	"Linux/m68k" <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599677433904135296?=
X-GMAIL-MSGID: =?utf-8?q?1599753131140460397?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

the BUG() was triggered by loading a Mac Nubus network card module on
a multiplatform kernel running on an Amiga machine. Up to Finn's Nubus
core rewrite (this February), we've seen no errors. Since then, Nubus
drivers fail to register because the Nubus bus is only registered on
Macs.

Can't see link order involved here at all.

Safeguarding against this bug could be done by checking a
bus-is-registered flag, or checking what machine model the kernel runs
on. Simply registering the Nubus bus driver regardless of machine
model seemed the easiest way.

Cheers,

  Michael


On Mon, May 7, 2018 at 8:20 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sun, May 06, 2018 at 04:00:15PM +1000, Finn Thain wrote:
>> On Sat, 5 May 2018, Greg Kroah-Hartman wrote:
>>
>> > On Sun, May 06, 2018 at 11:47:52AM +1000, Finn Thain wrote:
>> > > Loading a NuBus driver module on a non-NuBus machine triggers the
>> > > BUG_ON(!drv->bus->p) in driver_register() because the bus does not get
>> > > registered unless MACH_IS_MAC(). Avoid this by registering the bus
>> > > unconditionally using postcore_initcall().
>> > >
>> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > > Reported-by: Michael Schmitz <schmitzmic@gmail.com>
>> > > Tested-by: Stan Johnson <userm57@yahoo.com>
>> > > Fixes: 7f86c765a6a2 ("nubus: Add support for the driver model")
>> > > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>> > > ---
>> > >  drivers/nubus/bus.c   | 3 ++-
>> > >  drivers/nubus/nubus.c | 5 -----
>> > >  include/linux/nubus.h | 1 -
>> > >  3 files changed, 2 insertions(+), 7 deletions(-)
>> > >
>> > > diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
>> > > index d306c348c857..27ca9f1a281b 100644
>> > > --- a/drivers/nubus/bus.c
>> > > +++ b/drivers/nubus/bus.c
>> > > @@ -63,7 +63,7 @@ static struct device nubus_parent = {
>> > >   .init_name      = "nubus",
>> > >  };
>> > >
>> > > -int __init nubus_bus_register(void)
>> > > +static int __init nubus_bus_register(void)
>> > >  {
>> > >   int err;
>> > >
>> > > @@ -78,6 +78,7 @@ int __init nubus_bus_register(void)
>> > >   device_unregister(&nubus_parent);
>> > >   return err;
>> > >  }
>> > > +postcore_initcall(nubus_bus_register);
>> >
>> > Why not just have an "bus is registered" flag in your driver register
>> > function that refuses to let drivers register with the driver core if it
>> > isn't set?
>>
>> Perhaps that should happen in the core driver_register() function. BUG_ON
>> is frowned upon, after all. Would that be acceptable?
>
> I don't understand what you mean here, perhaps make a patch to show it?
>
>> I found a few drivers that set a flag the way you describe, which could
>> then be simplified.
>>
>> But that pattern is rare. Most buses use the postcore_initcall() pattern,
>> and so my patch took the conventional approach.
>
> It all depends on link order, not necessarily the postcore stuff.
>
>> > And then fix your linking error, the bus should come first in link
>> > order, before your drivers :)
>> >
>>
>> I didn't encounter any errors. How shall I reproduce this?
>
> If you have not seen this error, then why change the code at all if it
> is working properly?  Most busses do not need this as they have their
> link order set up correctly, no need to mess with stuff that is not
> broken :)
>
> thanks,
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
