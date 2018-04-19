Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeDSElC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 00:41:02 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:64998
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750737AbeDSElA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 00:41:00 -0400
X-IronPort-AV: E=Sophos;i="5.48,467,1517871600";
   d="scan'208";a="262567389"
Date: Thu, 19 Apr 2018 06:40:56 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
cc: yuankuiz@codeaurora.org, Julia Lawall <julia.lawall@lip6.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm-owner@vger.kernel.org
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
In-Reply-To: <5341b3b1945c4c1dbf7b356b1a7a4bd6ce304287.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1804190639410.2830@hadrien>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>  <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>  <20180410123305.GF4082@hirez.programming.kicks-ass.net>  <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
 <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>  <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>  <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>  <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>
 <20180411081502.GJ4082@hirez.programming.kicks-ass.net>  <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org>  <1c9f185f6086e9d89659f93720a27b660ee17c13.camel@perches.com>  <alpine.DEB.2.20.1804120816130.3559@hadrien>
 <b2087cac13c3a1d01ebe1a17e66351f3777bc397.camel@perches.com>  <alpine.DEB.2.20.1804142315300.2750@hadrien>  <e7cbe275136b86083ff70d9af26f41bf@codeaurora.org> <5341b3b1945c4c1dbf7b356b1a7a4bd6ce304287.camel@perches.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Apr 2018, Joe Perches wrote:

> On Tue, 2018-04-17 at 17:07 +0800, yuankuiz@codeaurora.org wrote:
> > Hi julia,
> >
> > On 2018-04-15 05:19 AM, Julia Lawall wrote:
> > > On Wed, 11 Apr 2018, Joe Perches wrote:
> > >
> > > > On Thu, 2018-04-12 at 08:22 +0200, Julia Lawall wrote:
> > > > > On Wed, 11 Apr 2018, Joe Perches wrote:
> > > > > > On Wed, 2018-04-11 at 09:29 -0700, Andrew Morton wrote:
> > > > > > > We already have some 500 bools-in-structs
> > > > > >
> > > > > > I got at least triple that only in include/
> > > > > > so I expect there are at probably an order
> > > > > > of magnitude more than 500 in the kernel.
> > > > > >
> > > > > > I suppose some cocci script could count the
> > > > > > actual number of instances.  A regex can not.
> > > > >
> > > > > I got 12667.
> > > >
> > > > Could you please post the cocci script?
> > > >
> > > > > I'm not sure to understand the issue.  Will using a bitfield help if there
> > > > > are no other bitfields in the structure?
> > > >
> > > > IMO, not really.
> > > >
> > > > The primary issue is described by Linus here:
> > > > https://lkml.org/lkml/2017/11/21/384
> > > >
> > > > I personally do not find a significant issue with
> > > > uncontrolled sizes of bool in kernel structs as
> > > > all of the kernel structs are transitory and not
> > > > written out to storage.
> > > >
> > > > I suppose bool bitfields are also OK, but for the
> > > > RMW required.
> > > >
> > > > Using unsigned int :1 bitfield instead of bool :1
> > > > has the negative of truncation so that the uint
> > > > has to be set with !! instead of a simple assign.
> > >
> > > At least with gcc 5.4.0, a number of structures become larger with
> > > unsigned int :1. bool:1 seems to mostly solve this problem.  The
> > > structure
> > > ichx_desc, defined in drivers/gpio/gpio-ich.c seems to become larger
> > > with
> > > both approaches.
> >
> > [ZJ] Hopefully, this could make it better in your environment.
> >       IMHO, this is just for double check.
>
> I doubt this is actually better or smaller code.
>
> Check the actual object code using objdump and the
> struct alignment using pahole.

I didn't have a chance to try it, but it looks quite likely to result in a
smaller data structure based on the other examples that I looked at.

julia

>
> > diff --git a/drivers/gpio/gpio-ich.c b/drivers/gpio/gpio-ich.c
> > index 4f6d643..b46e170 100644
> > --- a/drivers/gpio/gpio-ich.c
> > +++ b/drivers/gpio/gpio-ich.c
> > @@ -70,6 +70,18 @@ static const u8 avoton_reglen[3] = {
> >   #define ICHX_READ(reg, base_res)       inl((reg) + (base_res)->start)
> >
> >   struct ichx_desc {
> > +       /* GPO_BLINK is available on this chipset */
> > +       bool uses_gpe0:1;
> > +
> > +       /* Whether the chipset has GPIO in GPE0_STS in the PM IO region
> > */
> > +        bool uses_gpe0:1;
> > +
> > +        /*
> > +         * Some chipsets don't let reading output values on GPIO_LVL
> > register
> > +         * this option allows driver caching written output values
> > +         */
> > +        bool use_outlvl_cache:1;
> > +
> >          /* Max GPIO pins the chipset can have */
> >          uint ngpio;
> >
> > @@ -77,24 +89,12 @@ struct ichx_desc {
> >          const u8 (*regs)[3];
> >          const u8 *reglen;
> >
> > -       /* GPO_BLINK is available on this chipset */
> > -       bool have_blink;
> > -
> > -       /* Whether the chipset has GPIO in GPE0_STS in the PM IO region
> > */
> > -       bool uses_gpe0;
> > -
> >          /* USE_SEL is bogus on some chipsets, eg 3100 */
> >          u32 use_sel_ignore[3];
> >
> >          /* Some chipsets have quirks, let these use their own
> > request/get */
> >          int (*request)(struct gpio_chip *chip, unsigned offset);
> >          int (*get)(struct gpio_chip *chip, unsigned offset);
> > -
> > -       /*
> > -        * Some chipsets don't let reading output values on GPIO_LVL
> > register
> > -        * this option allows driver caching written output values
> > -        */
> > -       bool use_outlvl_cache;
> >   };
> >
> >
> > ZJ
>
