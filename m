Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeDSChQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 22:37:16 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:40794 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbeDSChP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 22:37:15 -0400
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Thu, 19 Apr 2018 11:37:12 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [PATCH] perf tools: set kernel end address properly
Message-ID: <20180419023712.GB13370@sejong>
References: <20180416042240.21528-1-namhyung@kernel.org>
 <20180416092345.GA23274@krava>
 <20180416135125.GA23802@kernel.org>
 <20180416110730.1dd12801e43be66ea5d0cc48@arm.com>
 <20180416165800.GD3202@kernel.org>
 <20180416122407.0d90863b69fed80166384850@arm.com>
 <20180416174811.1aca9106364effe435f363c8@arm.com>
 <20180417022726.GA31947@sejong>
 <20180418193759.b63912fe5e5b8a9023ec80a8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180418193759.b63912fe5e5b8a9023ec80a8@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 07:37:59PM -0500, Kim Phillips wrote:
> On Tue, 17 Apr 2018 11:27:26 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> > On Mon, Apr 16, 2018 at 05:48:11PM -0500, Kim Phillips wrote:
> > > > a perf/urgent from last week (commit 918965d4897) + this patch:
> > > > 
> > > > $ sudo ./perf test -vv 1 |& head 
> > > >  1: vmlinux symtab matches kallsyms                       :
> > > > --- start ---
> > > > test child forked, pid 6194
> > > > Looking at the vmlinux_path (8 entries long)
> > > > Using /lib/modules/4.16.0+/build/vmlinux for symbols
> > > > ERR : 0xffff200008081000: do_undefinstr not on kallsyms
> > > > ERR : 0xffff2000080810b8: do_sysinstr not on kallsyms
> > > > ERR : 0xffff200008081258: do_debug_exception not on kallsyms
> > > > ERR : 0xffff200008081648: do_mem_abort not on kallsyms
> > > > ERR : 0xffff2000080818b8: do_el0_irq_bp_hardening not on kallsyms
> > > > $ sudo ./perf test -vv 1 |& tail
> > > > ERR : 0xffff20000a1d37c8: tramp_exit_native not on kallsyms
> > > > ERR : 0xffff20000a1d37e8: tramp_exit_compat not on kallsyms
> > > > ERR : 0xffff20000a1d4000: __entry_tramp_text_end not on kallsyms
> > > > WARN: Maps only in vmlinux:
> > > >  ffff200008080000-ffff200008081000 10000 [kernel].head.text
> > > >  ffff20000aec0000-ffff20000aff7548 2e50000 [kernel].init.text
> > > >  ffff20000aff7548-ffff20000b0126d4 2f87548 [kernel].exit.text
> > > > test child finished with -1
> > > > ---- end ----
> > > > vmlinux symtab matches kallsyms: FAILED!
> > > 
> > > this patch's advertised "If there's no module after the kernel map, the
> > > end address will be ~0ULL." doesn't seem to be working: the value it
> > > gets for 'end' is 0xffff200008080000.
> > 
> > For the vmlinux, right?
> 
> yes, map__next(machine__kernel_map(machine)) has the start address
> of the single module currently loaded:
> 
> ffff200002290000 t $x	[arm_ccn]
> ffff200002290000 t arm_ccn_pmu_events_is_visible	[arm_ccn]
> 
> The beginning of the kernel is..later:
> 
> ffff200008080000 t _head
> ffff200008080000 T _text
> 
> and its end according to grep -w _end /proc/kallsyms is:
> 
> ffff20000d5f9000 B _end
> 
> but end was assigned to the beginning of arm_ccn (0xffff200002290000),
> which is upside-down.

So ARM64 has modules below the kernel.

> 
> > To be precise, it should be "If there's no map after the kernel map".
> 
> In numerical address order, in maps in map_groups__insert order, or
> some other order?

The map_groups__insert() also sorts the map by address, so they should
be identical.  I think the problem is perf assumes the kernel is the
first map in the kmaps.  When it calls maps_groups__insert() it uses
start address of 0 for the kernel map.  It seems always true for x86
but not for ARM64.

While it changes the start address in machine__set_kernel_mmap() it
doesn't change the order in the kmaps.

Could you please test below patch (on top) then?

Thanks,
Namhyung


---8<---

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index be328416de61..0f3c4bc7b90f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1228,7 +1228,6 @@ int machine__create_kernel_maps(struct machine *machine)
        const char *name = NULL;
        struct map *map;
        u64 addr = 0;
-       u64 end = ~0ULL;
        int ret;
 
        if (kernel == NULL)
@@ -1254,14 +1253,25 @@ int machine__create_kernel_maps(struct machine *machine)
                        machine__destroy_kernel_maps(machine);
                        return -1;
                }
+
+               /* we have a real start address now, so re-order the kmaps */
+               map = machine__kernel_map(machine);
+
+               map__get(map);
+               map_groups__remove(&machine->kmaps, map);
+
+               /* assume it's the last in the kmaps */
+               machine__set_kernel_mmap(machine, addr, ~0ULL);
+
+               map_groups__insert(&machine->kmaps, map);
+               map__put(map);
        }
 
        /* update end address of the kernel map using adjacent module address */
        map = map__next(machine__kernel_map(machine));
        if (map)
-               end = map->start;
+               machine__set_kernel_mmap(machine, addr, map->start);
 
-       machine__set_kernel_mmap(machine, addr, end);
        return 0;
 }
 
