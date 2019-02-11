Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0972AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA45221479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfBKHze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:55:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:20504 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfBKHza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:55:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2019 23:55:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="115234951"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by orsmga006.jf.intel.com with ESMTP; 10 Feb 2019 23:55:26 -0800
Subject: Re: [RFC PATCH] perf, bpf: Retain kernel executable code in memory to
 aid Intel PT tracing
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20190207111901.2399-1-adrian.hunter@intel.com>
 <20190208232924.bpdjuaqufndigtd4@ast-mbp>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <85ebb8e5-97a0-801a-8d5f-bc09a72047bb@intel.com>
Date:   Mon, 11 Feb 2019 09:54:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208232924.bpdjuaqufndigtd4@ast-mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/02/19 1:29 AM, Alexei Starovoitov wrote:
> On Thu, Feb 07, 2019 at 01:19:01PM +0200, Adrian Hunter wrote:
>> Subject to memory pressure and other limits, retain executable code, such
>> as JIT-compiled bpf, in memory instead of freeing it immediately it is no
>> longer needed for execution.
>>
>> While perf is primarily aimed at statistical analysis, tools like Intel
>> PT can aim to provide a trace of exactly what happened. As such, corner
>> cases that can be overlooked statistically need to be addressed. For
>> example, there is a gap where JIT-compiled bpf can be freed from memory
>> before a tracer has a chance to read it out through the bpf syscall.
>> While that can be ignored statistically, it contributes to a death by
>> 1000 cuts for tracers attempting to assemble exactly what happened. This is
>> a bit gratuitous given that retaining the executable code is relatively
>> simple, and the amount of memory involved relatively small. The retained
>> executable code is then available in memory images such as /proc/kcore.
>>
>> This facility could perhaps be extended also to init sections.
>>
>> Note that this patch is compile tested only and, at present, is missing
>> the ability to retain symbols.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  arch/x86/Kconfig.cpu       |   1 +
>>  include/linux/filter.h     |   4 +
>>  include/linux/xc_retain.h  |  49 ++++++++++
>>  init/Kconfig               |   6 ++
>>  kernel/Makefile            |   1 +
>>  kernel/bpf/core.c          |  44 ++++++++-
>>  kernel/xc_retain.c         | 183 +++++++++++++++++++++++++++++++++++++
>>  net/core/sysctl_net_core.c |  62 +++++++++++++
>>  8 files changed, 349 insertions(+), 1 deletion(-)
>>  create mode 100644 include/linux/xc_retain.h
>>  create mode 100644 kernel/xc_retain.c
>>
>> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
>> index 6adce15268bd..21dcd064c272 100644
>> --- a/arch/x86/Kconfig.cpu
>> +++ b/arch/x86/Kconfig.cpu
>> @@ -389,6 +389,7 @@ menuconfig PROCESSOR_SELECT
>>  config CPU_SUP_INTEL
>>  	default y
>>  	bool "Support Intel processors" if PROCESSOR_SELECT
>> +	select XC_RETAIN if PERF_EVENTS && BPF_JIT
>>  	---help---
>>  	  This enables detection, tunings and quirks for Intel processors
>>  
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index d531d4250bff..40b9f601e18f 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -851,6 +851,10 @@ extern int bpf_jit_enable;
>>  extern int bpf_jit_harden;
>>  extern int bpf_jit_kallsyms;
>>  extern long bpf_jit_limit;
>> +extern unsigned int bpf_jit_retain_min;
>> +extern unsigned int bpf_jit_retain_max;
>> +
>> +void bpf_jit_retain_update_sz(void);
>>  
>>  typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
>>  
>> diff --git a/include/linux/xc_retain.h b/include/linux/xc_retain.h
>> new file mode 100644
>> index 000000000000..e79dc138bab8
>> --- /dev/null
>> +++ b/include/linux/xc_retain.h
>> @@ -0,0 +1,49 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2019 Intel Corporation.
>> + */
>> +#ifndef _LINUX_XC_RETAIN_H
>> +#define _LINUX_XC_RETAIN_H
>> +
>> +#include <linux/list.h>
>> +#include <linux/shrinker.h>
>> +#include <linux/spinlock.h>
>> +
>> +struct xc_retain_ops {
>> +	void (*free)(void *addr);
>> +};
>> +
>> +struct xc_retain {
>> +	struct list_head list;
>> +	struct list_head items;
>> +	const struct xc_retain_ops ops;
>> +	unsigned int min_pages;
>> +	unsigned int max_pages;
>> +	unsigned int current_pages;
>> +	unsigned int item_cnt;
>> +	spinlock_t lock;
>> +	struct shrinker shrinker;
>> +};
>> +
>> +#ifdef CONFIG_XC_RETAIN
>> +int xc_retain_register(struct xc_retain *xr);
>> +void xc_retain_binary(struct xc_retain *xr, void *addr, unsigned int pages);
>> +void xc_retain_set_min_pages(struct xc_retain *xr, unsigned int min_pages);
>> +void xc_retain_set_max_pages(struct xc_retain *xr, unsigned int max_pages);
>> +#else
>> +static inline int xc_retain_register(struct xc_retain *xr)
>> +{
>> +	return 0;
>> +}
>> +static inline void xc_retain_binary(struct xc_retain *xr, void *addr,
>> +				    unsigned int pages)
>> +{
>> +	xr->ops.free(addr);
>> +}
>> +static inline void xc_retain_set_max_pages(struct xc_retain *xr,
>> +					   unsigned int max_pages)
>> +{
>> +}
>> +#endif
>> +
>> +#endif
>> diff --git a/init/Kconfig b/init/Kconfig
>> index c9386a365eea..954c288cabdc 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1550,6 +1550,12 @@ config EMBEDDED
>>  	  an embedded system so certain expert options are available
>>  	  for configuration.
>>  
>> +config XC_RETAIN
>> +	bool
>> +	help
>> +	  Retain kernel executable code (e.g. jitted BPF) in memory after it
>> +	  would normally be freed.
>> +
>>  config HAVE_PERF_EVENTS
>>  	bool
>>  	help
>> diff --git a/kernel/Makefile b/kernel/Makefile
>> index 6aa7543bcdb2..5df40e2a934e 100644
>> --- a/kernel/Makefile
>> +++ b/kernel/Makefile
>> @@ -98,6 +98,7 @@ obj-$(CONFIG_TRACEPOINTS) += trace/
>>  obj-$(CONFIG_IRQ_WORK) += irq_work.o
>>  obj-$(CONFIG_CPU_PM) += cpu_pm.o
>>  obj-$(CONFIG_BPF) += bpf/
>> +obj-$(CONFIG_XC_RETAIN) += xc_retain.o
>>  
>>  obj-$(CONFIG_PERF_EVENTS) += events/
>>  
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 19c49313c709..7fd235d235c2 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -34,6 +34,7 @@
>>  #include <linux/kallsyms.h>
>>  #include <linux/rcupdate.h>
>>  #include <linux/perf_event.h>
>> +#include <linux/xc_retain.h>
>>  
>>  #include <asm/unaligned.h>
>>  
>> @@ -480,6 +481,10 @@ int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_ALWAYS_ON);
>>  int bpf_jit_harden   __read_mostly;
>>  int bpf_jit_kallsyms __read_mostly;
>>  long bpf_jit_limit   __read_mostly;
>> +#define BPF_JIT_RETAIN_MIN 0
>> +#define BPF_JIT_RETAIN_MAX 16
>> +unsigned int bpf_jit_retain_min __read_mostly = BPF_JIT_RETAIN_MIN;
>> +unsigned int bpf_jit_retain_max __read_mostly = BPF_JIT_RETAIN_MAX;
>>  
>>  static __always_inline void
>>  bpf_get_prog_addr_region(const struct bpf_prog *prog,
>> @@ -795,6 +800,43 @@ void bpf_jit_binary_free(struct bpf_binary_header *hdr)
>>  	bpf_jit_uncharge_modmem(pages);
>>  }
>>  
>> +#ifdef CONFIG_XC_RETAIN
>> +static struct xc_retain bpf_jit_retain = {
>> +	.min_pages = BPF_JIT_RETAIN_MIN,
>> +	.max_pages = BPF_JIT_RETAIN_MAX,
>> +	.ops = {
>> +		.free = module_memfree,
>> +	},
>> +};
>> +
>> +void bpf_jit_retain_update_sz(void)
>> +{
>> +	xc_retain_set_min_pages(&bpf_jit_retain, bpf_jit_retain_min);
>> +	xc_retain_set_max_pages(&bpf_jit_retain, bpf_jit_retain_max);
>> +}
>> +
>> +static int __init bpf_jit_retain_init(void)
>> +{
>> +	return xc_retain_register(&bpf_jit_retain);
>> +}
>> +subsys_initcall(bpf_jit_retain_init);
>> +
>> +static void bpf_jit_binary_retain(struct bpf_prog *fp,
>> +				  struct bpf_binary_header *hdr)
>> +{
>> +	u32 pages = hdr->pages;
>> +
>> +	xc_retain_binary(&bpf_jit_retain, hdr, pages);
>> +	bpf_jit_uncharge_modmem(pages);
>> +}
>> +#else
>> +static void bpf_jit_binary_retain(struct bpf_prog *fp,
>> +				  struct bpf_binary_header *hdr)
>> +{
>> +	return bpf_jit_binary_free(hdr);
>> +}
>> +#endif
> 
> I'm strongly against this approach.

Thanks for commenting, but Peter wrote that he prefers this option:

	https://lkml.kernel.org/r/20190109101808.GG1900@hirez.programming.kicks-ass.net

> I understand that it's under CONFIG, but changing kernel
> into garbage collection nightmare even under config
> or sysctl is not an option.
> In many cases bpf progs are loaded/unloaded a lot.
> Consider CI test system that runs tests 24/7.
> bpf progs are loaded/unloaded in huge numbers.

Which is not really a real use-case.

For PT, the data recorded is generally too large (e.g. 100MB per cpu per second)
to record continuously.  But there is a "snapshot" mode that just captures
the PT data that is currently buffered.  In that case we want to have a
kernel image that reflects what was running for the last small period of
time.

> Such system will suffer non deterministic test and
> performance results due to shrinkers.

The default was 16 pages, after that everything gets freed immediately. 
That is assuming you don't turn it off for test purposes.  That would
not have an effect on your tests.

Also, why would copying it out of memory be less intrusive that keeping it
in memory.  Copying every bpf jit to disk for every load would be much more
intrusive.

> perf analysis with PT becomes inaccurate and main goal
> of retaining accurate instruction info is not achieved.

For the majority of real use-cases, yes it is.

> bpf_jit_retain_min/max tunables is not an option either.
> Please see how perf record is handling bpf prog/unload.
> What stops you from doing the same for PT?

Opens the door for the bpf program to be unloaded before it is copied out. 
All the corner cases where it is not possible to get accurate decoding start
to add up.
