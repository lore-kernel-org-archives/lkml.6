Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeCOTDi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:03:38 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:45304 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeCOTDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:03:35 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "peterz@infradead.org" <peterz@infradead.org>
CC: "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: Re: arc_usr_cmpxchg and preemption
Thread-Topic: arc_usr_cmpxchg and preemption
Thread-Index: AQHTu7KSgtMaj81NvU2WaxKl+xOkrqPP4yWAgAAPhQCAAC4ZgIAAw4yAgAAO6wCAACYYgIAAfyOA
Date: Thu, 15 Mar 2018 19:03:32 +0000
Message-ID: <1521140611.6358.29.camel@synopsys.com>
References: <1521045375.11552.27.camel@synopsys.com>
         <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
         <20180314175352.GP4064@hirez.programming.kicks-ass.net>
         <1521059931.11552.51.camel@synopsys.com>
         <20180315081845.GS4064@hirez.programming.kicks-ass.net>
         <1521105128.11552.64.camel@synopsys.com>
         <20180315112829.GW4064@hirez.programming.kicks-ass.net>
In-Reply-To: <20180315112829.GW4064@hirez.programming.kicks-ass.net>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.67]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3C04FD266AAF24BAF3DD608B3D71863@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2FJ3jUJ008171

Hi Peter,

On Thu, 2018-03-15 at 12:28 +0100, Peter Zijlstra wrote:
> On Thu, Mar 15, 2018 at 09:12:09AM +0000, Alexey Brodkin wrote:
> > On Thu, 2018-03-15 at 09:18 +0100, Peter Zijlstra wrote:
> > > Also, it might make sense to stuff this implementation in some lib/ file
> > > somewhere and make all platforms that need it use the same code, afaict
> > > there really isn't anything platform specific to it.
> > 
> > Not clear which part do you mean here.
> > Are you talking about entire cmpxchg syscall implementation?
> 
> Yep.

Hm... new generic syscall doing something sane people are not supposed to do?
Let's see who's going to express his/her excitement about that :)

But even introduction of that new syscall is obviously not enough
as we'll need to fix-up libc for affected arches accordingly...

> > Do you think there're many users of that quite an inefficient
> > [compared to proper HW version] atomic exchange?
> 
> I think there's a bunch of architectures that are in the same boat.
> m68k, arm, mips was mentioned. Sure, the moment an arch has hardware
> support you don't need the syscall anymore.

Here's a brief analysis:
ARM:  Looks like they got rid of that stuff in v4.4, see
      commit db695c0509d6 ("ARM: remove user cmpxchg syscall").

M68K: That's even uglier implementation which is really asking for
      a facelift, look at sys_atomic_cmpxchg_32() here:
      https://elixir.bootlin.com/linux/latest/source/arch/m68k/kernel/sys_m68k.c#L461

MIPS: They do it via special sysmips syscall which among other things
      might handle MIPS_ATOMIC_SET with mips_atomic_set()

I don't immediately see if there're others but really I'm not sure if it even worth trying to
clean-up all that since efforts might be spent pointlessly.

> I was just thinking it would be good to have a common implementation (if
> possible) rather than 4-5 different copies of basically the same thing.

>From above I would conclude that only M68K might benefit from new library
implementation. BTW M68K uses a bit different ABI compared to ARC for that syscall so
it will be really atomic_cmpxchg_32() libfunction called from those syscalls,
but now I think that's exactly what you meant initially, correct?

-Alexey
