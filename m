Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932112AbeEARtl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 13:49:41 -0400
Received: from foss.arm.com ([217.140.101.70]:49912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756300AbeEARtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 13:49:09 -0400
Subject: Re: [PATCH v9 04/11] arm64: kexec_file: allocate memory walking
 through memblock list
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-5-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <648656ef-1f1e-b0ac-581c-aba1e62f4eee@arm.com>
Date: Tue, 1 May 2018 18:46:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180425062629.29404-5-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 25/04/18 07:26, AKASHI Takahiro wrote:
> We need to prevent firmware-reserved memory regions, particularly EFI
> memory map as well as ACPI tables, from being corrupted by loading
> kernel/initrd (or other kexec buffers). We also want to support memory
> allocation in top-down manner in addition to default bottom-up.
> So let's have arm64 specific arch_kexec_walk_mem() which will search
> for available memory ranges in usable memblock list,
> i.e. !NOMAP & !reserved, 

> instead of system resource tree.

Didn't we try to fix the system-resource-tree in order to fix regular-kexec to
be safe in the EFI-memory-map/ACPI-tables case?

It would be good to avoid having two ways of doing this, and I would like to
avoid having extra arch code...


> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> new file mode 100644
> index 000000000000..f9ebf54ca247
> --- /dev/null
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * kexec_file for arm64
> + *
> + * Copyright (C) 2018 Linaro Limited
> + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + *

> + * Most code is derived from arm64 port of kexec-tools

How does kexec-tools walk memblock?


> + */
> +
> +#define pr_fmt(fmt) "kexec_file: " fmt
> +
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/kexec.h>
> +#include <linux/memblock.h>
> +
> +int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> +				int (*func)(struct resource *, void *))
> +{
> +	phys_addr_t start, end;
> +	struct resource res;
> +	u64 i;
> +	int ret = 0;
> +
> +	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> +		return func(&crashk_res, kbuf);
> +
> +	if (kbuf->top_down)
> +		for_each_mem_range_rev(i, &memblock.memory, &memblock.reserved,
> +				NUMA_NO_NODE, MEMBLOCK_NONE,
> +				&start, &end, NULL) {

for_each_free_mem_range_reverse() is a more readable version of this helper.

> +			if (!memblock_is_map_memory(start))
> +				continue;

Passing MEMBLOCK_NONE means this walk will never find MEMBLOCK_NOMAP memory.


> +			res.start = start;
> +			res.end = end;
> +			ret = func(&res, kbuf);
> +			if (ret)
> +				break;
> +		}
> +	else
> +		for_each_mem_range(i, &memblock.memory, &memblock.reserved,
> +				NUMA_NO_NODE, MEMBLOCK_NONE,
> +				&start, &end, NULL) {

for_each_free_mem_range()?

> +			if (!memblock_is_map_memory(start))
> +				continue;
> +
> +			res.start = start;
> +			res.end = end;
> +			ret = func(&res, kbuf);
> +			if (ret)
> +				break;
> +		}
> +
> +	return ret;
> +}
> 

With these changes, what we have is almost:
arch/powerpc/kernel/machine_kexec_file_64.c::arch_kexec_walk_mem() !
(the difference being powerpc doesn't yet support crash-kernels here)

If the argument is walking memblock gives a better answer than the stringy
walk_system_ram_res() thing, is there any mileage in moving this code into
kexec_file.c, and using it if !IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK)?

This would save arm64/powerpc having near-identical implementations.
32bit arm keeps memblock if it has kexec, so it may be useful there too if
kexec_file_load() support is added.


Thanks,

James
