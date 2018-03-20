Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeCTIth (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:49:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeCTItf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:49:35 -0400
Date: Tue, 20 Mar 2018 09:49:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liu, Changcheng" <changcheng.liu@intel.com>
Cc: tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/ioapic: don't use unstable TSC to detect timer IRQ
Message-ID: <20180320084929.GP4043@hirez.programming.kicks-ass.net>
References: <20180320084255.GA187704@sofia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320084255.GA187704@sofia>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 04:42:55PM +0800, Liu, Changcheng wrote:
> In rare case, the TSC is every unstable or can't sync with
> real time hardware clock. 

However did you manage that? Please provide _FAR_ more details.

> diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
> index cf5d53c..dcfc5b9 100644
> --- a/arch/x86/include/asm/tsc.h
> +++ b/arch/x86/include/asm/tsc.h
> @@ -17,6 +17,7 @@ typedef unsigned long long cycles_t;
>  
>  extern unsigned int cpu_khz;
>  extern unsigned int tsc_khz;
> +extern int tsc_unstable;
>  
>  extern void disable_TSC(void);
>  
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 7c55387..0809ec6 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -1643,7 +1643,7 @@ static int __init timer_irq_works(void)
>  	local_save_flags(flags);
>  	local_irq_enable();
>  
> -	if (boot_cpu_has(X86_FEATURE_TSC))
> +	if (boot_cpu_has(X86_FEATURE_TSC) && !tsc_unstable)
>  		delay_with_tsc();
>  	else
>  		delay_without_tsc();
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index fb43027..27b1bae 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -36,7 +36,8 @@ EXPORT_SYMBOL(tsc_khz);
>  /*
>   * TSC can be unstable due to cpufreq or due to unsynced TSCs
>   */
> -static int __read_mostly tsc_unstable;
> +int __read_mostly tsc_unstable;
> +EXPORT_SYMBOL(tsc_unstable);
>  
>  /* native_sched_clock() is called before tsc_init(), so
>     we must start with the TSC soft disabled to prevent

No, absolutely not. Even when the TSC is normally deemed unstable, which
typically means it is not sync'ed between cores, it is still perfectly
suitable to be used for delay loops.
