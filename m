Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbeEVGu5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:50:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEVGu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:50:56 -0400
Date: Tue, 22 May 2018 08:50:51 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mike Galbraith <gleep@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86: UV: raw_spinlock conversion
Message-ID: <20180522065051.xy42nwvcxz2nekti@linutronix.de>
References: <20180504111459.24825-1-bigeasy@linutronix.de>
 <20180504111459.24825-2-bigeasy@linutronix.de>
 <alpine.DEB.2.21.1805061225550.1685@nanos.tec.linutronix.de>
 <1525604359.28142.3.camel@gmx.de>
 <20180507073928.shmtfpqyhgxya53b@linutronix.de>
 <1526738996.5365.1.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1526738996.5365.1.camel@gmx.de>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-19 16:09:56 [+0200], Mike Galbraith wrote:
> None of that patch is needed for a UV3000, but the below is.  It's
> likely still valid for now ancient UV boxen, but the UV100 the patch
> was originally written for (2011/2.6.33-rt) has apparently wandered off
> to become a beer keg or something meanwhile, so I can't test.

so the old patch can go. Noted.
Regarding the preempt_disable() in the original patch in uv_read_rtc():
This looks essential for PREEMPT configs. Is it possible to get this
tested by someone or else get rid of the UV code? It looks broken for
"uv_get_min_hub_revision_id() != 1".

> UV: Fix uv_bau_init() check_preemption_disabled() gripeage
> 
> [    2.851947] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> [    2.851951] caller is uv_bau_init+0x28/0xb62
> [    2.851954] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc5-0.g3e3e37b-rt_debug
> [    2.851956] Hardware name: SGI UV3000/UV3000, BIOS SGI UV 3000 series BIOS 01/15/2015
> [    2.851957] Call Trace:
> [    2.851964]  dump_stack+0x85/0xcb
> [    2.851969]  check_preemption_disabled+0x10c/0x120
> [    2.851972]  ? init_per_cpu+0x88c/0x88c
> [    2.851974]  uv_bau_init+0x28/0xb62
> [    2.851979]  ? lapic_cal_handler+0xbb/0xbb
> [    2.851982]  ? rt_mutex_unlock+0x35/0x50
> [    2.851985]  ? init_per_cpu+0x88c/0x88c
> [    2.851988]  ? set_debug_rodata+0x11/0x11
> [    2.851991]  do_one_initcall+0x46/0x249
> [    2.851995]  kernel_init_freeable+0x207/0x29c
> [    2.851999]  ? rest_init+0xd0/0xd0
> [    2.852000]  kernel_init+0xa/0x110
> [    2.852000]  ret_from_fork+0x3a/0x50
> 
> (gdb) list *uv_bau_init+0x28
> 0xffffffff824a4d96 is in uv_bau_init (./arch/x86/include/asm/uv/uv_hub.h:212).
> 207             return (struct uv_hub_info_s *)__uv_hub_info_list[node];
> 208     }
> 209
> 210     static inline struct uv_hub_info_s *_uv_hub_info(void)
> 211     {
> 212             return (struct uv_hub_info_s *)uv_cpu_info->p_uv_hub_info;
> 213     }
> 214     #define uv_hub_info     _uv_hub_info()
> 215
> 216     static inline struct uv_hub_info_s *uv_cpu_hub_info(int cpu)
> (gdb)
> 
> arch/x86/include/asm/uv/uv_hub.h:
> 197 #define uv_cpu_info             this_cpu_ptr(&__uv_cpu_info)
> 
> This and other substitutions make uv_bau_init() annoying for a PREEMPT
> kernel, but PREEMPT_RT can silence the lot with one migrate_disable().

Why does PREEMPT_RT require migrate_disable() but PREEMPT only is fine
as-is? This does not look right.

> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>  arch/x86/platform/uv/tlb_uv.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- a/arch/x86/platform/uv/tlb_uv.c
> +++ b/arch/x86/platform/uv/tlb_uv.c
> @@ -2213,6 +2213,8 @@ static int __init uv_bau_init(void)
>  	if (!is_uv_system())
>  		return 0;
>  
> +	migrate_disable();
> +
>  	if (is_uv4_hub())
>  		ops = uv4_bau_ops;
>  	else if (is_uv3_hub())
> @@ -2269,6 +2271,8 @@ static int __init uv_bau_init(void)
>  		}
>  	}
>  
> +	migrate_enable();
> +
>  	return 0;
>  
>  err_bau_disable:
> @@ -2276,6 +2280,7 @@ static int __init uv_bau_init(void)
>  	for_each_possible_cpu(cur_cpu)
>  		free_cpumask_var(per_cpu(uv_flush_tlb_mask, cur_cpu));
>  
> +	migrate_enable();
>  	set_bau_off();
>  	nobau_perm = 1;
>  

Sebastian
