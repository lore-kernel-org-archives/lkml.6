Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753713AbeDQNsA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:48:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56893 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753575AbeDQNr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:47:57 -0400
Date: Tue, 17 Apr 2018 15:47:50 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: zoucao@linux.alibaba.com
cc: mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/e820: add new chareater "-" to free BIOS memory
 in memmap bootargs
In-Reply-To: <20180410025912.49830-2-zoucao@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1804171544290.1694@nanos.tec.linutronix.de>
References: <20180410025912.49830-1-zoucao@linux.alibaba.com> <20180410025912.49830-2-zoucao@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018, zoucao@linux.alibaba.com wrote:
> From: zoucao <zoucao@localhost.localdomain>

Interesting from ... Please use your real mail address for this.

> Normally every BIOS reserved memory is used for some features, we can't
> use them, but in some conditions,  users can ensure some BIOS memories
> are not used and reserved memory is well to free, they have not a good
> way to free these memories, here add a new chareater "-" in memmap to
> free reserved memory.

I'm not really convinced about this. How should anyone without detailed
BIOS knowledge know that this is really reusable?

The person who knows must have access to the BIOS developer, so why can't
the BIOS be fixed instead?

Thanks,

	tglx

> Signed-off-by: zou cao <zoucao@linux.alibaba.com>
> ---
>  7u/Documentation/kernel-parameters.txt | 6 ++++++
>  7u/arch/x86/kernel/e820.c              | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/7u/Documentation/kernel-parameters.txt b/7u/Documentation/kernel-parameters.txt
> index 9a1abb99a..dbea75e12 100644
> --- a/7u/Documentation/kernel-parameters.txt
> +++ b/7u/Documentation/kernel-parameters.txt
> @@ -1677,6 +1677,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			         or
>  			         memmap=0x10000$0x18690000
>  
> +	memmap=nn[KMG]-ss[KMG]
> +			Free E820 reserved memory, as specified by the user.
> +			Region of reserved memory to be free, from ss to ss+nn.
> +			Example: free reserved memory from 0x18690000-0x186a0000
> +					memmap=0x4101000-0x6aeff000
> +
>  	memory_corruption_check=0/1 [X86]
>  			Some BIOSes seem to corrupt the first 64k of
>  			memory when doing things like suspend/resume.
> diff --git a/7u/arch/x86/kernel/e820.c b/7u/arch/x86/kernel/e820.c
> index 174da5fc5..b8a042981 100644
> --- a/7u/arch/x86/kernel/e820.c
> +++ b/7u/arch/x86/kernel/e820.c
> @@ -875,6 +875,9 @@ static int __init parse_memmap_one(char *p)
>  	} else if (*p == '$') {
>  		start_at = memparse(p+1, &p);
>  		e820_add_region(start_at, mem_size, E820_RESERVED);
> +	} else if (*p == '-') {
> +		start_at = memparse(p+1, &p);
> +		e820_remove_range(start_at, mem_size, E820_RESERVED, E820_RAM);
>  	} else
>  		e820_remove_range(mem_size, ULLONG_MAX - mem_size, E820_RAM, 1);
>  
> -- 
> 2.14.1.40.g8e62ba1
> 
> 
