Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeCUM34 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 08:29:56 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:30090 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeCUM3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 08:29:53 -0400
Date: Wed, 21 Mar 2018 17:58:54 +0530
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Indranil Choudhury <indranil@chelsio.com>
Subject: Re: [RFC PATCH 2/3] x86/io: implement 256-bit IO read and write
Message-ID: <20180321122853.GC3245@chelsio.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <6ec3e7e0c70e85a804933f27bb4275d5363c044b.1521469118.git.rahul.lakkireddy@chelsio.com>
 <alpine.DEB.2.21.1803191525010.2010@nanos.tec.linutronix.de>
 <20180320133206.GB25574@chelsio.com>
 <CAKgT0UeTHPVrxEUbEszxm1MyJsQDSLfyM8txHq=r7GVkPD37nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UeTHPVrxEUbEszxm1MyJsQDSLfyM8txHq=r7GVkPD37nQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 03/20/18, 2018 at 20:12:15 +0530, Alexander Duyck wrote:
> On Tue, Mar 20, 2018 at 6:32 AM, Rahul Lakkireddy
> <rahul.lakkireddy@chelsio.com> wrote:
> > On Monday, March 03/19/18, 2018 at 20:13:10 +0530, Thomas Gleixner wrote:
> >> On Mon, 19 Mar 2018, Rahul Lakkireddy wrote:
> >>
> >> > Use VMOVDQU AVX CPU instruction when available to do 256-bit
> >> > IO read and write.
> >>
> >> That's not what the patch does. See below.
> >>
> >> > Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
> >> > Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
> >>
> >> That Signed-off-by chain is wrong....
> >>
> >> > +#ifdef CONFIG_AS_AVX
> >> > +#include <asm/fpu/api.h>
> >> > +
> >> > +static inline u256 __readqq(const volatile void __iomem *addr)
> >> > +{
> >> > +   u256 ret;
> >> > +
> >> > +   kernel_fpu_begin();
> >> > +   asm volatile("vmovdqu %0, %%ymm0" :
> >> > +                : "m" (*(volatile u256 __force *)addr));
> >> > +   asm volatile("vmovdqu %%ymm0, %0" : "=m" (ret));
> >> > +   kernel_fpu_end();
> >> > +   return ret;
> >>
> >> You _cannot_ assume that the instruction is available just because
> >> CONFIG_AS_AVX is set. The availability is determined by the runtime
> >> evaluated CPU feature flags, i.e. X86_FEATURE_AVX.
> >>
> >
> > Ok.  Will add boot_cpu_has(X86_FEATURE_AVX) check as well.
> >
> >> Aside of that I very much doubt that this is faster than 4 consecutive
> >> 64bit reads/writes as you have the full overhead of
> >> kernel_fpu_begin()/end() for each access.
> >>
> >> You did not provide any numbers for this so its even harder to
> >> determine.
> >>
> >
> > Sorry about that.  Here are the numbers with and without this series.
> >
> > When reading up to 2 GB on-chip memory via MMIO, the time taken:
> >
> > Without Series        With Series
> > (64-bit read)         (256-bit read)
> >
> > 52 seconds            26 seconds
> >
> > As can be seen, we see good improvement with doing 256-bits at a
> > time.
> 
> Instead of framing this as an enhanced version of the read/write ops
> why not look at replacing or extending something like the
> memcpy_fromio or memcpy_toio operations? It would probably be more
> comparable to what you are doing if you are wanting to move large
> chunks of memory from one region to another, and it should translate
> into something like AVX instructions once the CPU optimizations kick
> in for a memcpy.
> 

Ok. Will look into this approach.

Thanks,
Rahul
