Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751043AbeEUSTY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:19:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54808 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750781AbeEUSTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:19:23 -0400
Date: Mon, 21 May 2018 19:19:49 +0100
From: Will Deacon <will.deacon@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v3 0/5]
Message-ID: <20180521181948.GB19122@arm.com>
References: <20180518143913.26306-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518143913.26306-1-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Thanks for this.

On Fri, May 18, 2018 at 03:39:08PM +0100, Marc Zyngier wrote:
> PMUv3 has been introduced with ARMv8 and, while it has only been used
> on 64bit systems so far, it would definitely be useful for 32bit
> guests running under KVM/arm64, for example.
> 
> There is also the case of people natively running 32bit kernels on
> 64bit HW and trying to upstream unspeakable hacks, hoping that the
> stars will align and that they'll win the lottery (see [1]).
> 
> So let's try again, and make the PMUv3 driver usable for everyone.
> 
> This is done in three steps:
> (1) Move the driver from arch/arm64 to drivers/perf
> (2) Add a handful of system register accessors so that we can reuse
>     the driver on 32bit
> (3) Provide the same accessors on 32bit, enable compilation, and
>     make it the default selection for mach-virt.
> 
> Tested on a Seattle box with 32bit guests.

I think we should go ahead with something like this, but I don't think
we're quite there with these patches. If we're going to move the arch code
out into drivers, let's do that for the perf_event* files under arch/arm/
as well. Then we could have a structure along the lines of:


  drivers/perf/arm_pmu.c			- As it is today
  drivers/perf/arm_cpu/xscale_pmu.c		- Only builds for 32-bit
  drivers/perf/arm_cpu/armv6_pmu.c		- Only builds for 32-bit
  drivers/perf/arm_cpu/arch_pmu.c		- Works for v7/v8 on
                                                  both 32-bit and 64-bit

The latter can then pull in whatever accessors it needs from the arch
code headers.

I know it's more of an invasive change, but this way we always end up
running the same code on the two architectures and it will be much easier
to maintain.

Will
