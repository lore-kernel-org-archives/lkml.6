Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbeEQCPy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 22:15:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751259AbeEQCPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 22:15:53 -0400
Date: Thu, 17 May 2018 10:15:47 +0800
From: Baoquan He <bhe@redhat.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 04/11] arm64: kexec_file: allocate memory walking
 through memblock list
Message-ID: <20180517021547.GJ24627@MiWiFi-R3L-srv>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-5-takahiro.akashi@linaro.org>
 <648656ef-1f1e-b0ac-581c-aba1e62f4eee@arm.com>
 <20180507055906.GE11326@linaro.org>
 <20180517021024.GI24627@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517021024.GI24627@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/18 at 10:10am, Baoquan He wrote:
> On 05/07/18 at 02:59pm, AKASHI Takahiro wrote:
> > James,
> > 
> > On Tue, May 01, 2018 at 06:46:09PM +0100, James Morse wrote:
> > > Hi Akashi,
> > > 
> > > On 25/04/18 07:26, AKASHI Takahiro wrote:
> > > > We need to prevent firmware-reserved memory regions, particularly EFI
> > > > memory map as well as ACPI tables, from being corrupted by loading
> > > > kernel/initrd (or other kexec buffers). We also want to support memory
> > > > allocation in top-down manner in addition to default bottom-up.
> > > > So let's have arm64 specific arch_kexec_walk_mem() which will search
> > > > for available memory ranges in usable memblock list,
> > > > i.e. !NOMAP & !reserved, 
> > > 
> > > > instead of system resource tree.
> > > 
> > > Didn't we try to fix the system-resource-tree in order to fix regular-kexec to
> > > be safe in the EFI-memory-map/ACPI-tables case?
> > > 
> > > It would be good to avoid having two ways of doing this, and I would like to
> > > avoid having extra arch code...
> > 
> > I know what you mean.
> > /proc/iomem or system resource is, in my opinion, not the best place to
> > describe memory usage of kernel but rather to describe *physical* hardware
> > layout. As we are still discussing about "reserved" memory, I don't want
> > to depend on it.
> > Along with memblock list, we will have more accurate control over memory
> > usage.
> 
> In kexec-tools, we see any usable memory as candidate which can be used

Here I said 'any', it's not accurate. Those memory which need be passed
to 2nd kernel for use need be excluded, just as we have done in
kexec-tools.

> to load kexec kernel image/initrd etc. However kexec loading is a
> preparation work, it just books those position for later kexec kernel
> jumping after "kexec -e", that is why we need kexec_buf to remember
> them and do the real content copy of kernel/initrd. Here you use
> memblock to search available memory, isn't it deviating too far away
> from the original design in kexec-tools. Assume kexec loading and
> kexec_file loading should be consistent on loading even though they are
> done in different space, kernel space and user space.
> 
> I didn't follow the earlier post, may miss something.
> 
> Thanks
> Baoquan
> 
> > 
> > > 
> > > > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > > > new file mode 100644
> > > > index 000000000000..f9ebf54ca247
> > > > --- /dev/null
> > > > +++ b/arch/arm64/kernel/machine_kexec_file.c
> > > > @@ -0,0 +1,57 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * kexec_file for arm64
> > > > + *
> > > > + * Copyright (C) 2018 Linaro Limited
> > > > + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > + *
> > > 
> > > > + * Most code is derived from arm64 port of kexec-tools
> > > 
> > > How does kexec-tools walk memblock?
> > 
> > Will remove this comment from this patch.
> > Obviously, this comment is for the rest of the code which will be
> > added to succeeding patches (patch #5 and #7).
> > 
> > 
> > > 
> > > > + */
> > > > +
> > > > +#define pr_fmt(fmt) "kexec_file: " fmt
> > > > +
> > > > +#include <linux/ioport.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/kexec.h>
> > > > +#include <linux/memblock.h>
> > > > +
> > > > +int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > > > +				int (*func)(struct resource *, void *))
> > > > +{
> > > > +	phys_addr_t start, end;
> > > > +	struct resource res;
> > > > +	u64 i;
> > > > +	int ret = 0;
> > > > +
> > > > +	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> > > > +		return func(&crashk_res, kbuf);
> > > > +
> > > > +	if (kbuf->top_down)
> > > > +		for_each_mem_range_rev(i, &memblock.memory, &memblock.reserved,
> > > > +				NUMA_NO_NODE, MEMBLOCK_NONE,
> > > > +				&start, &end, NULL) {
> > > 
> > > for_each_free_mem_range_reverse() is a more readable version of this helper.
> > 
> > OK. I used to use my own limited list of reserved memory instead of
> > memblock.reserved here to exclude verbose ranges.
> > 
> > 
> > > > +			if (!memblock_is_map_memory(start))
> > > > +				continue;
> > > 
> > > Passing MEMBLOCK_NONE means this walk will never find MEMBLOCK_NOMAP memory.
> > 
> > Sure, I confirmed it.
> > 
> > > 
> > > > +			res.start = start;
> > > > +			res.end = end;
> > > > +			ret = func(&res, kbuf);
> > > > +			if (ret)
> > > > +				break;
> > > > +		}
> > > > +	else
> > > > +		for_each_mem_range(i, &memblock.memory, &memblock.reserved,
> > > > +				NUMA_NO_NODE, MEMBLOCK_NONE,
> > > > +				&start, &end, NULL) {
> > > 
> > > for_each_free_mem_range()?
> > 
> > OK.
> > 
> > > > +			if (!memblock_is_map_memory(start))
> > > > +				continue;
> > > > +
> > > > +			res.start = start;
> > > > +			res.end = end;
> > > > +			ret = func(&res, kbuf);
> > > > +			if (ret)
> > > > +				break;
> > > > +		}
> > > > +
> > > > +	return ret;
> > > > +}
> > > > 
> > > 
> > > With these changes, what we have is almost:
> > > arch/powerpc/kernel/machine_kexec_file_64.c::arch_kexec_walk_mem() !
> > > (the difference being powerpc doesn't yet support crash-kernels here)
> > > 
> > > If the argument is walking memblock gives a better answer than the stringy
> > > walk_system_ram_res() thing, is there any mileage in moving this code into
> > > kexec_file.c, and using it if !IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK)?
> > > 
> > > This would save arm64/powerpc having near-identical implementations.
> > > 32bit arm keeps memblock if it has kexec, so it may be useful there too if
> > > kexec_file_load() support is added.
> > 
> > Thanks. I've forgot ppc.
> > 
> > -Takahiro AKASHI
> > 
> > 
> > > 
> > > Thanks,
> > > 
> > > James
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
