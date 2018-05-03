Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeECNkl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbeECNkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:40:40 -0400
Date: Thu, 3 May 2018 10:40:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf tools: allow overriding MAX_NR_CPUS at compile time
Message-ID: <20180503134037.GB8442@kernel.org>
References: <20170922112043.8349468C57@po15668-vm-win7.idsi0.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170922112043.8349468C57@po15668-vm-win7.idsi0.si.c-s.fr>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 22, 2017 at 01:20:43PM +0200, Christophe Leroy escreveu:
> After update of kernel, perf tool doesn't run anymore on my
> 32MB RAM powerpc board, but still runs on a 128MB RAM board:

Cleaning up my inbox, found this one, simple enough, still applies,
applied.

These all needs to be dynamicly allocated, but still, with this one can
get a functioning tool, apply it.

- Arnaldo
 
> ~# strace perf
> execve("/usr/sbin/perf", ["perf"], [/* 12 vars */]) = -1 ENOMEM (Cannot allocate memory)
> --- SIGSEGV {si_signo=SIGSEGV, si_code=SI_KERNEL, si_addr=0} ---
> +++ killed by SIGSEGV +++
> Segmentation fault
> 
> objdump -x shows that .bss section has a huge size of 24Mbytes:
> 
>  27 .bss          016baca8  101cebb8  101cebb8  001cd988  2**3
> 
> With especially the following objects having quite big size
> 
> 10205f80 l     O .bss	00140000              runtime_cycles_stats
> 10345f80 l     O .bss	00140000              runtime_stalled_cycles_front_stats
> 10485f80 l     O .bss	00140000              runtime_stalled_cycles_back_stats
> 105c5f80 l     O .bss	00140000              runtime_branches_stats
> 10705f80 l     O .bss	00140000              runtime_cacherefs_stats
> 10845f80 l     O .bss	00140000              runtime_l1_dcache_stats
> 10985f80 l     O .bss	00140000              runtime_l1_icache_stats
> 10ac5f80 l     O .bss	00140000              runtime_ll_cache_stats
> 10c05f80 l     O .bss	00140000              runtime_itlb_cache_stats
> 10d45f80 l     O .bss	00140000              runtime_dtlb_cache_stats
> 10e85f80 l     O .bss	00140000              runtime_cycles_in_tx_stats
> 10fc5f80 l     O .bss	00140000              runtime_transaction_stats
> 11105f80 l     O .bss	00140000              runtime_elision_stats
> 11245f80 l     O .bss	00140000              runtime_topdown_total_slots
> 11385f80 l     O .bss	00140000              runtime_topdown_slots_retired
> 114c5f80 l     O .bss	00140000              runtime_topdown_slots_issued
> 11605f80 l     O .bss	00140000              runtime_topdown_fetch_bubbles
> 11745f80 l     O .bss	00140000              runtime_topdown_recovery_bubbles
> 
> This is due to commit 4d255766d28b1 ("perf: Bump max number of cpus
> to 1024"), because many tables are sized with MAX_NR_CPUS
> 
> This patch gives the opportunity to redefine MAX_NR_CPUS via
> 
> make EXTRA_CFLAGS=-DMAX_NR_CPUS=1
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  tools/perf/perf.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index dc442ba21bf6..a9db563da0a9 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -23,7 +23,9 @@ static inline unsigned long long rdclock(void)
>  	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
>  }
>  
> +#ifndef MAX_NR_CPUS
>  #define MAX_NR_CPUS			1024
> +#endif
>  
>  extern const char *input_name;
>  extern bool perf_host, perf_guest;
> -- 
> 2.13.3
