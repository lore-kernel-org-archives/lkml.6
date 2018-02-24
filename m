Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeBXKJA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 05:09:00 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36422 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeBXKI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 05:08:56 -0500
X-Google-Smtp-Source: AG47ELs2mEYb1Y6ICgMOVnwETOMVWwFOFHjVDJY8SSFqlQbCPnXM8JIziFtH2bgl0cd9u/GMm0PNFg==
Date: Sat, 24 Feb 2018 11:08:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andi Kleen <ak@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, linux-doc@vger.kernel.org,
        linux-edac@vger.kernel.org, oprofile-list@lists.sf.net
Subject: Re: [PATCH] x86: Add topology_hw_smt_threads() and remove
 smp_num_siblings
Message-ID: <20180224100851.k7jhef345zubykmm@gmail.com>
References: <20180104115204.17067-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180104115204.17067-1-prarit@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Prarit Bhargava <prarit@redhat.com> wrote:

> Commit bbb65d2d365e ("x86: use cpuid vector 0xb when available for
> detecting cpu topology") changed the value of smp_num_siblings from the
> active number of threads in a core to the maximum number threads in a
> core.  e.g.) On Intel Haswell and newer systems smp_num_siblings is
> two even if SMT is disabled.
> 
> topology_max_smt_threads() already returns the active number of threads.
> Introduce topology_hw_smt_threads() which returns the maximum number of
> threads.  These are used to fix and replace references to smp_num_siblings.

It's unclear to the reader of this changelog what the patch does:

 - is it a cleanup?
 - does it introduce some new facility to be used in a later patch?
 - ... or does it fix a real bug?

> diff --git a/arch/x86/include/asm/perf_event_p4.h b/arch/x86/include/asm/perf_event_p4.h
> index 94de1a05aeba..11afdadce9c2 100644
> --- a/arch/x86/include/asm/perf_event_p4.h
> +++ b/arch/x86/include/asm/perf_event_p4.h
> @@ -181,7 +181,7 @@ static inline u64 p4_clear_ht_bit(u64 config)
>  static inline int p4_ht_active(void)
>  {
>  #ifdef CONFIG_SMP
> -	return smp_num_siblings > 1;
> +	return topology_max_smt_threads() > 1;
>  #endif
>  	return 0;
>  }
> @@ -189,7 +189,7 @@ static inline int p4_ht_active(void)
>  static inline int p4_ht_thread(int cpu)
>  {
>  #ifdef CONFIG_SMP
> -	if (smp_num_siblings == 2)
> +	if (topology_max_smt_threads() == 2)
>  		return cpu != cpumask_first(this_cpu_cpumask_var_ptr(cpu_sibling_map));

This appears to change functionality - so I guess it fixes a real bug?

> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index c1d2a9892352..b5ff1c784eef 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -116,16 +116,16 @@ extern unsigned int __max_logical_packages;
>  #define topology_max_packages()			(__max_logical_packages)
>  
>  extern int __max_smt_threads;
> -
> -static inline int topology_max_smt_threads(void)
> -{
> -	return __max_smt_threads;
> -}
> +#define topology_max_smt_threads()		(__max_smt_threads)
> +extern int __hw_smt_threads;
> +#define topology_hw_smt_threads()		(__hw_smt_threads)

I general it's better to use C inline functions than CPP defines.

> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -332,16 +332,14 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
>  		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
>  
>  		node_id  = ecx & 0xff;
> -		smp_num_siblings = ((ebx >> 8) & 0xff) + 1;
> +		__hw_smt_threads = ((ebx >> 8) & 0xff) + 1;
>  
>  		if (c->x86 == 0x15)
>  			c->cu_id = ebx & 0xff;
>  
>  		if (c->x86 >= 0x17) {
>  			c->cpu_core_id = ebx & 0xff;
> -
> -			if (smp_num_siblings > 1)
> -				c->x86_max_cores /= smp_num_siblings;
> +			c->x86_max_cores /= topology_hw_smt_threads();
>  		}

> @@ -1228,6 +1228,10 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>  	/* Init Machine Check Exception if available. */
>  	mcheck_cpu_init(c);
>  
> +	/* Must be called before select_idle_routine */
> +	if (c != &boot_cpu_data)
> +		set_cpu_sibling_map(raw_smp_processor_id());
> +
>  	select_idle_routine(c);

This appears to be an unexplained change.

> --- a/arch/x86/kernel/cpu/mcheck/mce-inject.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce-inject.c
> @@ -420,7 +420,8 @@ static u32 get_nbc_for_node(int node_id)
>  	struct cpuinfo_x86 *c = &boot_cpu_data;
>  	u32 cores_per_node;
>  
> -	cores_per_node = (c->x86_max_cores * smp_num_siblings) / amd_get_nodes_per_socket();
> +	cores_per_node = (c->x86_max_cores * topology_hw_smt_threads()) /
> +			 amd_get_nodes_per_socket();

Please don't break lines that are just slightly over col80.

So all of this looks pretty complex, but is poorly explained. Please split it up 
into a series of well-explained patches where each patch does one specific thing. 
The cleanup and renaming patches should come first, the bug fixing patch(es) 
should come after them.

Thanks,

	Ingo
