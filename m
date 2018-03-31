Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeCaWrQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 18:47:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52736 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751766AbeCaWrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 18:47:12 -0400
X-Google-Smtp-Source: AIpwx49Zt96JFaAZ+GyYrsWeP4eX16KS2hCyM6wuoqoC69FUJvLtYUgAWtFE9kmWbsAn+7Qi+6i40lRaXxVPHNy7P/M=
MIME-Version: 1.0
In-Reply-To: <20180329023024.GA32659@andestech.com>
References: <1522051075-6442-1-git-send-email-alankao@andestech.com>
 <1522051075-6442-2-git-send-email-alankao@andestech.com> <CAJ2AOiNQuMJoPZPxy2CDFD0vnxk8E+N-8xiir2nPYKjWJKxshQ@mail.gmail.com>
 <20180329023024.GA32659@andestech.com>
From: Alex Solomatnikov <sols@sifive.com>
Date: Sat, 31 Mar 2018 15:47:10 -0700
Message-ID: <CAJ2AOiPNquo1hGrYjsDcCM4st5Exa7x_-xUV=QW_MCBVCCCkBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf: riscv: preliminary RISC-V support
To: Alan Kao <alankao@andestech.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Hu <nickhu@andestech.com>, Greentime Hu <greentime@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can add a skew between cores in qemu, something like this:

case CSR_INSTRET:
        core_id()*return cpu_get_host_ticks()/10;
    break;
case CSR_CYCLE:
        return cpu_get_host_ticks();
    break;

Alex

On Wed, Mar 28, 2018 at 7:30 PM, Alan Kao <alankao@andestech.com> wrote:
> Hi Alex,
>
> I'm appreciated for your reply and tests.
>
> On Wed, Mar 28, 2018 at 03:58:41PM -0700, Alex Solomatnikov wrote:
>> Did you test this code?
>
> I did test this patch on QEMU's virt model with multi-hart, which is the only
> RISC-V machine I have for now.  But as I mentioned in
> https://github.com/riscv/riscv-qemu/pull/115 , the hardware counter support
> in QEMU is not fully conformed to the 1.10 Priv-Spec, so I had to slightly
> tweak the code to make reading work.
>
> Specifically, the read to cycle and instret in QEMU looks like this:
> ...
> case CSR_INSTRET:
> case CSR_CYCLE:
> //  if (ctr_ok) {
>         return cpu_get_host_ticks();
> //  }
>     break;
> ...
> and the two lines of comment was the tweak.
>
> On such environment, I did not get anything unexpected.  No matter which of them
> is requested, QEMU returns the host's tick.
>
>>
>> I got funny numbers when I tried to run it on HiFive Unleashed:
>>
>> perf stat mem-latency
>> ...
>>
>>  Performance counter stats for 'mem-latency':
>>
>>         157.907000      task-clock (msec)         #    0.940 CPUs utilized
>>
>>                  1      context-switches          #    0.006 K/sec
>>
>>                  1      cpu-migrations            #    0.006 K/sec
>>
>>               4102      page-faults               #    0.026 M/sec
>>
>>          157923752      cycles                    #    1.000 GHz
>>
>> 9223372034948899840      instructions              # 58403957087.78  insn
>> per cycle
>>    <not supported>      branches
>>
>>    <not supported>      branch-misses
>>
>>
>>        0.168046000 seconds time elapsed
>>
>>
>> Tracing read_counter(), I see this:
>>
>> Jan  1 00:41:50 buildroot user.info kernel: [ 2510.058809] CPU 3:
>> read_counter  idx=0 val=2528358954912
>> Jan  1 00:41:50 buildroot user.info kernel: [ 2510.063339] CPU 3:
>> read_counter  idx=1 val=53892244920
>> Jan  1 00:41:50 buildroot user.info kernel: [ 2510.118160] CPU 3:
>> read_counter  idx=0 val=2528418303035
>> Jan  1 00:41:50 buildroot user.info kernel: [ 2510.122694] CPU 3:
>> read_counter  idx=1 val=53906699665
>> Jan  1 00:41:50 buildroot user.info kernel: [ 2510.216736] CPU 1:
>> read_counter  idx=0 val=2528516878664
>> Jan  1 00:41:50 buildroot user.info kernel: [ 2510.221270] CPU 1:
>> read_counter  idx=1 val=51986369142
>>
>> It looks like the counter values from different cores are subtracted and
>> wraparound occurs.
>>
>
> Thanks for the hint.  It makes sense.  9223372034948899840 is 7fffffff8e66a400,
> which should be a wraparound with the mask I set (63-bit) in the code.
>
> I will try this direction.  Ideally, we can solve it by explicitly syncing the
> hwc->prev_count when a cpu migration event happens.
>
>>
>> Also, core IDs and socket IDs are wrong in perf report:
>>
>
> As Palmer has replied to this, I have no comment here.
>
>> perf report --header -I
>> Error:
>> The perf.data file has no samples!
>> # ========
>> # captured on: Thu Jan  1 02:52:07 1970
>> # hostname : buildroot
>> # os release : 4.15.0-00045-g0d7c030-dirty
>> # perf version : 4.15.0
>> # arch : riscv64
>> # nrcpus online : 4
>> # nrcpus avail : 5
>> # total memory : 8188340 kB
>> # cmdline : /usr/bin/perf record -F 1000 lat_mem_rd -P 1 -W 1 -N 1 -t 10
>> # event : name = cycles:ppp, , size = 112, { sample_period, sample_freq } =
>> 1000, sample_type = IP|TID|TIME|PERIOD, disabled = 1, inherit = 1, mmap =
>> 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, precise_ip = 3,
>> sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1
>> # sibling cores   : 1
>> # sibling cores   : 2
>> # sibling cores   : 3
>> # sibling cores   : 4
>> # sibling threads : 1
>> # sibling threads : 2
>> # sibling threads : 3
>> # sibling threads : 4
>> # CPU 0: Core ID -1, Socket ID -1
>> # CPU 1: Core ID 0, Socket ID -1
>> # CPU 2: Core ID 0, Socket ID -1
>> # CPU 3: Core ID 0, Socket ID -1
>> # CPU 4: Core ID 0, Socket ID -1
>> # pmu mappings: cpu = 4, software = 1
>> # CPU cache info:
>> #  L1 Instruction          32K [1]
>> #  L1 Data                 32K [1]
>> #  L1 Instruction          32K [2]
>> #  L1 Data                 32K [2]
>> #  L1 Instruction          32K [3]
>> #  L1 Data                 32K [3]
>> # missing features: TRACING_DATA BUILD_ID CPUDESC CPUID NUMA_TOPOLOGY
>> BRANCH_STACK GROUP_DESC AUXTRACE STAT
>> # ========
>>
>>
>> Alex
>>
>
> Many thanks,
> Alan
>
>> On Mon, Mar 26, 2018 at 12:57 AM, Alan Kao <alankao@andestech.com> wrote:
>>
>> > This patch provide a basic PMU, riscv_base_pmu, which supports two
>> > general hardware event, instructions and cycles.  Furthermore, this
>> > PMU serves as a reference implementation to ease the portings in
>> > the future.
>> >
>> > riscv_base_pmu should be able to run on any RISC-V machine that
>> > conforms to the Priv-Spec.  Note that the latest qemu model hasn't
>> > fully support a proper behavior of Priv-Spec 1.10 yet, but work
>> > around should be easy with very small fixes.  Please check
>> > https://github.com/riscv/riscv-qemu/pull/115 for future updates.
>> >
>> > Cc: Nick Hu <nickhu@andestech.com>
>> > Cc: Greentime Hu <greentime@andestech.com>
>> > Signed-off-by: Alan Kao <alankao@andestech.com>
>> > ---
>> >  arch/riscv/Kconfig                  |  12 +
>> >  arch/riscv/include/asm/perf_event.h |  76 +++++-
>> >  arch/riscv/kernel/Makefile          |   1 +
>> >  arch/riscv/kernel/perf_event.c      | 469 ++++++++++++++++++++++++++++++
>> > ++++++
>> >  4 files changed, 554 insertions(+), 4 deletions(-)
>> >  create mode 100644 arch/riscv/kernel/perf_event.c
>> >
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > index 310b9a5d6737..dd4aecfb5265 100644
>> > --- a/arch/riscv/Kconfig
>> > +++ b/arch/riscv/Kconfig
>> > @@ -195,6 +195,18 @@ config RISCV_ISA_C
>> >  config RISCV_ISA_A
>> >         def_bool y
>> >
>> > +menu "PMU type"
>> > +       depends on PERF_EVENTS
>> > +
>> > +config RISCV_BASE_PMU
>> > +       bool "Base Performance Monitoring Unit"
>> > +       def_bool y
>> > +       help
>> > +         A base PMU that serves as a reference implementation and has
>> > limited
>> > +         feature of perf.
>> > +
>> > +endmenu
>> > +
>> >  endmenu
>> >
>> >  menu "Kernel type"
>> > diff --git a/arch/riscv/include/asm/perf_event.h
>> > b/arch/riscv/include/asm/perf_event.h
>> > index e13d2ff29e83..98e2efb02d25 100644
>> > --- a/arch/riscv/include/asm/perf_event.h
>> > +++ b/arch/riscv/include/asm/perf_event.h
>> > @@ -1,13 +1,81 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 */
>> >  /*
>> >   * Copyright (C) 2018 SiFive
>> > + * Copyright (C) 2018 Andes Technology Corporation
>> >   *
>> > - * This program is free software; you can redistribute it and/or
>> > - * modify it under the terms of the GNU General Public Licence
>> > - * as published by the Free Software Foundation; either version
>> > - * 2 of the Licence, or (at your option) any later version.
>> >   */
>> >
>> >  #ifndef _ASM_RISCV_PERF_EVENT_H
>> >  #define _ASM_RISCV_PERF_EVENT_H
>> >
>> > +#include <linux/perf_event.h>
>> > +#include <linux/ptrace.h>
>> > +
>> > +#define RISCV_BASE_COUNTERS    2
>> > +
>> > +/*
>> > + * The RISCV_MAX_COUNTERS parameter should be specified.
>> > + */
>> > +
>> > +#ifdef CONFIG_RISCV_BASE_PMU
>> > +#define RISCV_MAX_COUNTERS     2
>> > +#endif
>> > +
>> > +#ifndef RISCV_MAX_COUNTERS
>> > +#error "Please provide a valid RISCV_MAX_COUNTERS for the PMU."
>> > +#endif
>> > +
>> > +/*
>> > + * These are the indexes of bits in counteren register *minus* 1,
>> > + * except for cycle.  It would be coherent if it can directly mapped
>> > + * to counteren bit definition, but there is a *time* register at
>> > + * counteren[1].  Per-cpu structure is scarce resource here.
>> > + *
>> > + * According to the spec, an implementation can support counter up to
>> > + * mhpmcounter31, but many high-end processors has at most 6 general
>> > + * PMCs, we give the definition to MHPMCOUNTER8 here.
>> > + */
>> > +#define RISCV_PMU_CYCLE                0
>> > +#define RISCV_PMU_INSTRET      1
>> > +#define RISCV_PMU_MHPMCOUNTER3 2
>> > +#define RISCV_PMU_MHPMCOUNTER4 3
>> > +#define RISCV_PMU_MHPMCOUNTER5 4
>> > +#define RISCV_PMU_MHPMCOUNTER6 5
>> > +#define RISCV_PMU_MHPMCOUNTER7 6
>> > +#define RISCV_PMU_MHPMCOUNTER8 7
>> > +
>> > +#define RISCV_OP_UNSUPP                (-EOPNOTSUPP)
>> > +
>> > +struct cpu_hw_events {
>> > +       /* # currently enabled events*/
>> > +       int                     n_events;
>> > +       /* currently enabled events */
>> > +       struct perf_event       *events[RISCV_MAX_COUNTERS];
>> > +       /* vendor-defined PMU data */
>> > +       void                    *platform;
>> > +};
>> > +
>> > +struct riscv_pmu {
>> > +       struct pmu      *pmu;
>> > +
>> > +       /* generic hw/cache events table */
>> > +       const int       *hw_events;
>> > +       const int       (*cache_events)[PERF_COUNT_HW_CACHE_MAX]
>> > +                                      [PERF_COUNT_HW_CACHE_OP_MAX]
>> > +                                      [PERF_COUNT_HW_CACHE_RESULT_MAX];
>> > +       /* method used to map hw/cache events */
>> > +       int             (*map_hw_event)(u64 config);
>> > +       int             (*map_cache_event)(u64 config);
>> > +
>> > +       /* max generic hw events in map */
>> > +       int             max_events;
>> > +       /* number total counters, 2(base) + x(general) */
>> > +       int             num_counters;
>> > +       /* the width of the counter */
>> > +       int             counter_width;
>> > +
>> > +       /* vendor-defined PMU features */
>> > +       void            *platform;
>> > +};
>> > +
>> >  #endif /* _ASM_RISCV_PERF_EVENT_H */
>> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> > index 196f62ffc428..849c38d9105f 100644
>> > --- a/arch/riscv/kernel/Makefile
>> > +++ b/arch/riscv/kernel/Makefile
>> > @@ -36,5 +36,6 @@ obj-$(CONFIG_SMP)             += smp.o
>> >  obj-$(CONFIG_MODULES)          += module.o
>> >  obj-$(CONFIG_FUNCTION_TRACER)  += mcount.o
>> >  obj-$(CONFIG_FUNCTION_GRAPH_TRACER)    += ftrace.o
>> > +obj-$(CONFIG_PERF_EVENTS)      += perf_event.o
>> >
>> >  clean:
>> > diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_
>> > event.c
>> > new file mode 100644
>> > index 000000000000..b78cb486683b
>> > --- /dev/null
>> > +++ b/arch/riscv/kernel/perf_event.c
>> > @@ -0,0 +1,469 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 */
>> > +/*
>> > + * Copyright (C) 2008 Thomas Gleixner <tglx@linutronix.de>
>> > + * Copyright (C) 2008-2009 Red Hat, Inc., Ingo Molnar
>> > + * Copyright (C) 2009 Jaswinder Singh Rajput
>> > + * Copyright (C) 2009 Advanced Micro Devices, Inc., Robert Richter
>> > + * Copyright (C) 2008-2009 Red Hat, Inc., Peter Zijlstra
>> > + * Copyright (C) 2009 Intel Corporation, <markus.t.metzger@intel.com>
>> > + * Copyright (C) 2009 Google, Inc., Stephane Eranian
>> > + * Copyright 2014 Tilera Corporation. All Rights Reserved.
>> > + * Copyright (C) 2018 Andes Technology Corporation
>> > + *
>> > + * Perf_events support for RISC-V platforms.
>> > + *
>> > + * Since the spec. (as of now, Priv-Spec 1.10) does not provide enough
>> > + * functionality for perf event to fully work, this file provides
>> > + * the very basic framework only.
>> > + *
>> > + * For platform portings, please check Documentations/riscv/pmu.txt.
>> > + *
>> > + * The Copyright line includes x86 and tile ones.
>> > + */
>> > +
>> > +#include <linux/kprobes.h>
>> > +#include <linux/kernel.h>
>> > +#include <linux/kdebug.h>
>> > +#include <linux/mutex.h>
>> > +#include <linux/bitmap.h>
>> > +#include <linux/irq.h>
>> > +#include <linux/interrupt.h>
>> > +#include <linux/perf_event.h>
>> > +#include <linux/atomic.h>
>> > +#include <asm/perf_event.h>
>> > +
>> > +static const struct riscv_pmu *riscv_pmu __read_mostly;
>> > +static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
>> > +
>> > +/*
>> > + * Hardware & cache maps and their methods
>> > + */
>> > +
>> > +static const int riscv_hw_event_map[] = {
>> > +       [PERF_COUNT_HW_CPU_CYCLES]              = RISCV_PMU_CYCLE,
>> > +       [PERF_COUNT_HW_INSTRUCTIONS]            = RISCV_PMU_INSTRET,
>> > +       [PERF_COUNT_HW_CACHE_REFERENCES]        = RISCV_OP_UNSUPP,
>> > +       [PERF_COUNT_HW_CACHE_MISSES]            = RISCV_OP_UNSUPP,
>> > +       [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     = RISCV_OP_UNSUPP,
>> > +       [PERF_COUNT_HW_BRANCH_MISSES]           = RISCV_OP_UNSUPP,
>> > +       [PERF_COUNT_HW_BUS_CYCLES]              = RISCV_OP_UNSUPP,
>> > +};
>> > +
>> > +#define C(x) PERF_COUNT_HW_CACHE_##x
>> > +static const int riscv_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
>> > +[PERF_COUNT_HW_CACHE_OP_MAX]
>> > +[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
>> > +       [C(L1D)] = {
>> > +               [C(OP_READ)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +               [C(OP_WRITE)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +               [C(OP_PREFETCH)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +       },
>> > +       [C(L1I)] = {
>> > +               [C(OP_READ)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +               [C(OP_WRITE)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +               [C(OP_PREFETCH)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +       },
>> > +       [C(LL)] = {
>> > +               [C(OP_READ)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +               [C(OP_WRITE)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +               [C(OP_PREFETCH)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +       },
>> > +       [C(DTLB)] = {
>> > +               [C(OP_READ)] = {
>> > +                       [C(RESULT_ACCESS)] =  RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] =  RISCV_OP_UNSUPP,
>> > +               },
>> > +               [C(OP_WRITE)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +               [C(OP_PREFETCH)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +       },
>> > +       [C(ITLB)] = {
>> > +               [C(OP_READ)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +               [C(OP_WRITE)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +               [C(OP_PREFETCH)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +       },
>> > +       [C(BPU)] = {
>> > +               [C(OP_READ)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +               [C(OP_WRITE)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +               [C(OP_PREFETCH)] = {
>> > +                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
>> > +                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
>> > +               },
>> > +       },
>> > +};
>> > +
>> > +static int riscv_map_hw_event(u64 config)
>> > +{
>> > +       if (config >= riscv_pmu->max_events)
>> > +               return -EINVAL;
>> > +
>> > +       return riscv_pmu->hw_events[config];
>> > +}
>> > +
>> > +int riscv_map_cache_decode(u64 config, unsigned int *type,
>> > +                          unsigned int *op, unsigned int *result)
>> > +{
>> > +       return -ENOENT;
>> > +}
>> > +
>> > +static int riscv_map_cache_event(u64 config)
>> > +{
>> > +       unsigned int type, op, result;
>> > +       int err = -ENOENT;
>> > +               int code;
>> > +
>> > +       err = riscv_map_cache_decode(config, &type, &op, &result);
>> > +       if (!riscv_pmu->cache_events || err)
>> > +               return err;
>> > +
>> > +       if (type >= PERF_COUNT_HW_CACHE_MAX ||
>> > +           op >= PERF_COUNT_HW_CACHE_OP_MAX ||
>> > +           result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
>> > +               return -EINVAL;
>> > +
>> > +       code = (*riscv_pmu->cache_events)[type][op][result];
>> > +       if (code == RISCV_OP_UNSUPP)
>> > +               return -EINVAL;
>> > +
>> > +       return code;
>> > +}
>> > +
>> > +/*
>> > + * Low-level functions: reading/writing counters
>> > + */
>> > +
>> > +static inline u64 read_counter(int idx)
>> > +{
>> > +       u64 val = 0;
>> > +
>> > +       switch (idx) {
>> > +       case RISCV_PMU_CYCLE:
>> > +               val = csr_read(cycle);
>> > +               break;
>> > +       case RISCV_PMU_INSTRET:
>> > +               val = csr_read(instret);
>> > +               break;
>> > +       default:
>> > +               WARN_ON_ONCE(idx < 0 || idx > RISCV_MAX_COUNTERS);
>> > +               return -EINVAL;
>> > +       }
>> > +
>> > +       return val;
>> > +}
>> > +
>> > +static inline void write_counter(int idx, u64 value)
>> > +{
>> > +       /* currently not supported */
>> > +}
>> > +
>> > +/*
>> > + * pmu->read: read and update the counter
>> > + *
>> > + * Other architectures' implementation often have a xxx_perf_event_update
>> > + * routine, which can return counter values when called in the IRQ, but
>> > + * return void when being called by the pmu->read method.
>> > + */
>> > +static void riscv_pmu_read(struct perf_event *event)
>> > +{
>> > +       struct hw_perf_event *hwc = &event->hw;
>> > +       u64 prev_raw_count, new_raw_count;
>> > +       u64 oldval;
>> > +       int idx = hwc->idx;
>> > +       u64 delta;
>> > +
>> > +       do {
>> > +               prev_raw_count = local64_read(&hwc->prev_count);
>> > +               new_raw_count = read_counter(idx);
>> > +
>> > +               oldval = local64_cmpxchg(&hwc->prev_count, prev_raw_count,
>> > +                                        new_raw_count);
>> > +       } while (oldval != prev_raw_count);
>> > +
>> > +       /*
>> > +        * delta is the value to update the counter we maintain in the
>> > kernel.
>> > +        */
>> > +       delta = (new_raw_count - prev_raw_count) &
>> > +               ((1ULL << riscv_pmu->counter_width) - 1);
>> > +       local64_add(delta, &event->count);
>> > +       /*
>> > +        * Something like local64_sub(delta, &hwc->period_left) here is
>> > +        * needed if there is an interrupt for perf.
>> > +        */
>> > +}
>> > +
>> > +/*
>> > + * State transition functions:
>> > + *
>> > + * stop()/start() & add()/del()
>> > + */
>> > +
>> > +/*
>> > + * pmu->stop: stop the counter
>> > + */
>> > +static void riscv_pmu_stop(struct perf_event *event, int flags)
>> > +{
>> > +       struct hw_perf_event *hwc = &event->hw;
>> > +
>> > +       WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
>> > +       hwc->state |= PERF_HES_STOPPED;
>> > +
>> > +       if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE))
>> > {
>> > +               riscv_pmu_read(event);
>> > +               hwc->state |= PERF_HES_UPTODATE;
>> > +       }
>> > +}
>> > +
>> > +/*
>> > + * pmu->start: start the event.
>> > + */
>> > +static void riscv_pmu_start(struct perf_event *event, int flags)
>> > +{
>> > +       struct hw_perf_event *hwc = &event->hw;
>> > +
>> > +       if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
>> > +               return;
>> > +
>> > +       if (flags & PERF_EF_RELOAD) {
>> > +               WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
>> > +
>> > +               /*
>> > +                * Set the counter to the period to the next interrupt
>> > here,
>> > +                * if you have any.
>> > +                */
>> > +       }
>> > +
>> > +       hwc->state = 0;
>> > +       perf_event_update_userpage(event);
>> > +
>> > +       /*
>> > +        * Since we cannot write to counters, this serves as an
>> > initialization
>> > +        * to the delta-mechanism in pmu->read(); otherwise, the delta
>> > would be
>> > +        * wrong when pmu->read is called for the first time.
>> > +        */
>> > +       if (local64_read(&hwc->prev_count) == 0)
>> > +               local64_set(&hwc->prev_count, read_counter(hwc->idx));
>> > +}
>> > +
>> > +/*
>> > + * pmu->add: add the event to PMU.
>> > + */
>> > +static int riscv_pmu_add(struct perf_event *event, int flags)
>> > +{
>> > +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> > +       struct hw_perf_event *hwc = &event->hw;
>> > +
>> > +       if (cpuc->n_events == riscv_pmu->num_counters)
>> > +               return -ENOSPC;
>> > +
>> > +       /*
>> > +        * We don't have general conunters, so no binding-event-to-counter
>> > +        * process here.
>> > +        *
>> > +        * Indexing using hwc->config generally not works, since config may
>> > +        * contain extra information, but here the only info we have in
>> > +        * hwc->config is the event index.
>> > +        */
>> > +       hwc->idx = hwc->config;
>> > +       cpuc->events[hwc->idx] = event;
>> > +       cpuc->n_events++;
>> > +
>> > +       hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
>> > +
>> > +       if (flags & PERF_EF_START)
>> > +               riscv_pmu_start(event, PERF_EF_RELOAD);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +/*
>> > + * pmu->del: delete the event from PMU.
>> > + */
>> > +static void riscv_pmu_del(struct perf_event *event, int flags)
>> > +{
>> > +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> > +       struct hw_perf_event *hwc = &event->hw;
>> > +
>> > +       cpuc->events[hwc->idx] = NULL;
>> > +       cpuc->n_events--;
>> > +       riscv_pmu_stop(event, PERF_EF_UPDATE);
>> > +       perf_event_update_userpage(event);
>> > +}
>> > +
>> > +/*
>> > + * Interrupt
>> > + */
>> > +
>> > +static DEFINE_MUTEX(pmc_reserve_mutex);
>> > +typedef void (*perf_irq_t)(void *riscv_perf_irq);
>> > +perf_irq_t perf_irq;
>> > +
>> > +void riscv_pmu_handle_irq(void *riscv_perf_irq)
>> > +{
>> > +}
>> > +
>> > +static perf_irq_t reserve_pmc_hardware(void)
>> > +{
>> > +       perf_irq_t old;
>> > +
>> > +       mutex_lock(&pmc_reserve_mutex);
>> > +       old = perf_irq;
>> > +       perf_irq = &riscv_pmu_handle_irq;
>> > +       mutex_unlock(&pmc_reserve_mutex);
>> > +
>> > +       return old;
>> > +}
>> > +
>> > +void release_pmc_hardware(void)
>> > +{
>> > +       mutex_lock(&pmc_reserve_mutex);
>> > +       perf_irq = NULL;
>> > +       mutex_unlock(&pmc_reserve_mutex);
>> > +}
>> > +
>> > +/*
>> > + * Event Initialization
>> > + */
>> > +
>> > +static atomic_t riscv_active_events;
>> > +
>> > +static void riscv_event_destroy(struct perf_event *event)
>> > +{
>> > +       if (atomic_dec_return(&riscv_active_events) == 0)
>> > +               release_pmc_hardware();
>> > +}
>> > +
>> > +static int riscv_event_init(struct perf_event *event)
>> > +{
>> > +       struct perf_event_attr *attr = &event->attr;
>> > +       struct hw_perf_event *hwc = &event->hw;
>> > +       perf_irq_t old_irq_handler = NULL;
>> > +       int code;
>> > +
>> > +       if (atomic_inc_return(&riscv_active_events) == 1)
>> > +               old_irq_handler = reserve_pmc_hardware();
>> > +
>> > +       if (old_irq_handler) {
>> > +               pr_warn("PMC hardware busy (reserved by oprofile)\n");
>> > +               atomic_dec(&riscv_active_events);
>> > +               return -EBUSY;
>> > +       }
>> > +
>> > +       switch (event->attr.type) {
>> > +       case PERF_TYPE_HARDWARE:
>> > +               code = riscv_pmu->map_hw_event(attr->config);
>> > +               break;
>> > +       case PERF_TYPE_HW_CACHE:
>> > +               code = riscv_pmu->map_cache_event(attr->config);
>> > +               break;
>> > +       case PERF_TYPE_RAW:
>> > +               return -EOPNOTSUPP;
>> > +       default:
>> > +               return -ENOENT;
>> > +       }
>> > +
>> > +       event->destroy = riscv_event_destroy;
>> > +       if (code < 0) {
>> > +               event->destroy(event);
>> > +               return code;
>> > +       }
>> > +
>> > +       /*
>> > +        * idx is set to -1 because the index of a general event should
>> > not be
>> > +        * decided until binding to some counter in pmu->add().
>> > +        *
>> > +        * But since we don't have such support, later in pmu->add(), we
>> > just
>> > +        * use hwc->config as the index instead.
>> > +        */
>> > +       hwc->config = code;
>> > +       hwc->idx = -1;
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +/*
>> > + * Initialization
>> > + */
>> > +
>> > +static struct pmu min_pmu = {
>> > +       .name           = "riscv-base",
>> > +       .event_init     = riscv_event_init,
>> > +       .add            = riscv_pmu_add,
>> > +       .del            = riscv_pmu_del,
>> > +       .start          = riscv_pmu_start,
>> > +       .stop           = riscv_pmu_stop,
>> > +       .read           = riscv_pmu_read,
>> > +};
>> > +
>> > +static const struct riscv_pmu riscv_base_pmu = {
>> > +       .pmu = &min_pmu,
>> > +       .max_events = ARRAY_SIZE(riscv_hw_event_map),
>> > +       .map_hw_event = riscv_map_hw_event,
>> > +       .hw_events = riscv_hw_event_map,
>> > +       .map_cache_event = riscv_map_cache_event,
>> > +       .cache_events = &riscv_cache_event_map,
>> > +       .counter_width = 63,
>> > +       .num_counters = RISCV_BASE_COUNTERS + 0,
>> > +};
>> > +
>> > +struct pmu * __weak __init riscv_init_platform_pmu(void)
>> > +{
>> > +       riscv_pmu = &riscv_base_pmu;
>> > +       return riscv_pmu->pmu;
>> > +}
>> > +
>> > +int __init init_hw_perf_events(void)
>> > +{
>> > +       struct pmu *pmu = riscv_init_platform_pmu();
>> > +
>> > +       perf_irq = NULL;
>> > +       perf_pmu_register(pmu, "cpu", PERF_TYPE_RAW);
>> > +       return 0;
>> > +}
>> > +arch_initcall(init_hw_perf_events);
>> > --
>> > 2.16.2
>> >
>> >
