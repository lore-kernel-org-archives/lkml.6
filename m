Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeAaLqj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 06:46:39 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35948 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeAaLqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 06:46:38 -0500
Date: Wed, 31 Jan 2018 11:46:28 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arch/arm/Kconfig: enable ARM_MODULE_PLTS when LOCKDEP=y
Message-ID: <20180131114628.GG9418@n2100.armlinux.org.uk>
References: <20180129234900.11121-1-anders.roxell@linaro.org>
 <20180129235710.GA9418@n2100.armlinux.org.uk>
 <CAK8P3a1aN0M0hoOB4QJeyMD9zdT-G8Ap5-jV9M2-WpjC4Jo6Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1aN0M0hoOB4QJeyMD9zdT-G8Ap5-jV9M2-WpjC4Jo6Vw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 12:25:33PM +0100, Arnd Bergmann wrote:
> On Tue, Jan 30, 2018 at 12:57 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Tue, Jan 30, 2018 at 12:49:00AM +0100, Anders Roxell wrote:
> >> While testing multi_v7_defconfig with LOCKDEP enabled, the kernel
> >> fails to load simple modules, as reported by kselftest:
> >>
> >> [   34.107620] test_printf: section 4 reloc 2 sym 'memset': relocation
> >> 28 out of range (0xbf046044 -> 0xc109f720)
> >> selftests: printf.sh [FAIL]
> >>
> >> The problem that is seen when LOCKDEP is enabled without
> >> ARM_MODULE_PLTS, is that LOCKDEP eats so much memory that the top of the
> >> kernel gets out of reach from the bottom of the module area.
> >
> > This really doesn't follow IMHO - enabling various features can cause
> > this, and we're not going to end up stuffing the Kconfig full of these
> > select statements each time we find a combination of Kconfig symbols
> > that cause it.
> >
> > lockdep isn't that special - I can (and do) build kernels with lockdep
> > enabled, with modules, and I do not run into this problem.  So it's
> > not as simple as you make out in this commit description.
> >
> > It's likely that you have either a fairly full kernel configuration (it
> > must be to place memset() more than 16MB) or you are not placing the
> > kernel at 0xc0008000 due to memory reservations in the low memory.
> >
> >> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> >
> > I guess this was discussed privately with Arnd, since there's no record
> > of the discussion on the lists - which is even more reason why the
> > commit message needs to describe better why you need this change.
> 
> I don't remember the original discussion exactly, but it's clear that
> the addition of LOCKDEP to the build is what caused the size to
> grow dramatically and prevent module loading.

As I say above, it does not follow "lockdep is enabled" therefore "we
need module plts" so I don't accept this argument.

Yes, if you have a lot of features built in, then its entirely possible
that enabling lockdep will cause the kernel to overflow the non-plt
boundary.  It will also be true that enabling a few more other features
will also cause the kernel to overflow the non-plt boundary as well.
Should we add those other features to a Kconfig expression too?  At
what point do we stop adding these?

> There are two alternative ways to do this without forcing
> ARM_MODULE_PLTS on all the time (which also triggered
> the 0day bot warning):

Yes, 0day is pointing out yet again what a silly idea it is to select
symbols that (a) have dependencies and (b) are user visible, something
that I've long disagreed about.

> a) we could make ARM_MODULE_PLTS default to 'y' when
> LOCKDEP is anbled, making it a more reasonable default while
> also letting users turn it off when the lockdep-enabled kernel
> is still small enough

As I've said, I don't believe "LOCKDEP" therefore need "MODULE_PLTS"
follows.  It's just a symptom of an already large kernel.  I suspect
without lockdep, Ander's kernel is already approaching the
problematical 16MB mark.

Another option that causes the kernel to grow by a few megabytes is
the kernel protection options (ronx etc).  I suspect if Anders built
a kernel that had lockdep enabled and ronx etc disabled, that there
would be no need for module plts.  Should we turn on module plts if
lockdep or ronx is enabled?

I don't think there's a _sane_ solution to this other than defaulting
ARM_MODULE_PLTS to 'y' without any of these dependencies, and if people
want to turn it off, they still can if they're sure they won't run into
this situation.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
