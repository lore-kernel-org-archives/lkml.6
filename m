Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeDSAiC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 20:38:02 -0400
Received: from foss.arm.com ([217.140.101.70]:60516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752326AbeDSAiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 20:38:01 -0400
Date: Wed, 18 Apr 2018 19:37:59 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <kernel-team@lge.com>
Subject: Re: [PATCH] perf tools: set kernel end address properly
Message-Id: <20180418193759.b63912fe5e5b8a9023ec80a8@arm.com>
In-Reply-To: <20180417022726.GA31947@sejong>
References: <20180416042240.21528-1-namhyung@kernel.org>
        <20180416092345.GA23274@krava>
        <20180416135125.GA23802@kernel.org>
        <20180416110730.1dd12801e43be66ea5d0cc48@arm.com>
        <20180416165800.GD3202@kernel.org>
        <20180416122407.0d90863b69fed80166384850@arm.com>
        <20180416174811.1aca9106364effe435f363c8@arm.com>
        <20180417022726.GA31947@sejong>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018 11:27:26 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> On Mon, Apr 16, 2018 at 05:48:11PM -0500, Kim Phillips wrote:
> > On Mon, 16 Apr 2018 12:24:07 -0500
> > Kim Phillips <kim.phillips@arm.com> wrote:
> > 
> > > On Mon, 16 Apr 2018 13:58:00 -0300
> > > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > 
> > > > Em Mon, Apr 16, 2018 at 11:07:30AM -0500, Kim Phillips escreveu:
> > > > > On Mon, 16 Apr 2018 10:51:25 -0300
> > > > > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > 
> > > > > > Em Mon, Apr 16, 2018 at 11:23:45AM +0200, Jiri Olsa escreveu:
> > > > > > > On Mon, Apr 16, 2018 at 01:22:40PM +0900, Namhyung Kim wrote:
> > > > > > > > The map_groups__fixup_end() was called to set end addresses of kernel
> > > > > > > > map and module maps.  But now machine__create_modules() is set the end
> > > > > > > > address of modules properly so the only remaining piece is the kernel
> > > > > > > > map.  We can set it with adjacent module's address directly instead of
> > > > > > > > calling the map_groups__fixup_end().  If there's no module after the
> > > > > > > > kernel map, the end address will be ~0ULL.
> > > > > > 
> > > > > > I wonder if it wouldn't be better to have it as last symbol + PAGE_SIZE
> > > > > > or something like that...
> > > > > > 
> > > > > > But, anyway, Kim, does this fix things for you? Can I have your
> > > > > > Tested-by?
> > > > > 
> > > > > No, perf test 1 still fails:
> > > > > 
> > > > > vmlinux symtab matches kallsyms: FAILED!
> > > > 
> > > > Ok, -vv please
> > > 
> > > a perf/urgent from last week (commit 918965d4897) + this patch:
> > > 
> > > $ sudo ./perf test -vv 1 |& head 
> > >  1: vmlinux symtab matches kallsyms                       :
> > > --- start ---
> > > test child forked, pid 6194
> > > Looking at the vmlinux_path (8 entries long)
> > > Using /lib/modules/4.16.0+/build/vmlinux for symbols
> > > ERR : 0xffff200008081000: do_undefinstr not on kallsyms
> > > ERR : 0xffff2000080810b8: do_sysinstr not on kallsyms
> > > ERR : 0xffff200008081258: do_debug_exception not on kallsyms
> > > ERR : 0xffff200008081648: do_mem_abort not on kallsyms
> > > ERR : 0xffff2000080818b8: do_el0_irq_bp_hardening not on kallsyms
> > > $ sudo ./perf test -vv 1 |& tail
> > > ERR : 0xffff20000a1d37c8: tramp_exit_native not on kallsyms
> > > ERR : 0xffff20000a1d37e8: tramp_exit_compat not on kallsyms
> > > ERR : 0xffff20000a1d4000: __entry_tramp_text_end not on kallsyms
> > > WARN: Maps only in vmlinux:
> > >  ffff200008080000-ffff200008081000 10000 [kernel].head.text
> > >  ffff20000aec0000-ffff20000aff7548 2e50000 [kernel].init.text
> > >  ffff20000aff7548-ffff20000b0126d4 2f87548 [kernel].exit.text
> > > test child finished with -1
> > > ---- end ----
> > > vmlinux symtab matches kallsyms: FAILED!
> > 
> > this patch's advertised "If there's no module after the kernel map, the
> > end address will be ~0ULL." doesn't seem to be working: the value it
> > gets for 'end' is 0xffff200008080000.
> 
> For the vmlinux, right?

yes, map__next(machine__kernel_map(machine)) has the start address
of the single module currently loaded:

ffff200002290000 t $x	[arm_ccn]
ffff200002290000 t arm_ccn_pmu_events_is_visible	[arm_ccn]

The beginning of the kernel is..later:

ffff200008080000 t _head
ffff200008080000 T _text

and its end according to grep -w _end /proc/kallsyms is:

ffff20000d5f9000 B _end

but end was assigned to the beginning of arm_ccn (0xffff200002290000),
which is upside-down.

> To be precise, it should be "If there's no map after the kernel map".

In numerical address order, in maps in map_groups__insert order, or
some other order?

> It seems vmlinux adds more maps after the kernel map for those .head,
> .init and .exit text sections.

those shouldn't matter, I don't think - x86 has .init and .exit also,
and I don't necessarily see the .head addresses being involved.  Let me
know if this is indeed going to be a problem.

> > I even hardcoded 'end' variable to the value for '_end' in kallsyms
> > prior to the machine__set_kernel_mmap() call, and test 1 still fails.
> 
> I guess it was overwritten by the machine__set_kernel_mmap() then.

Yes.

> > The problem is earlier on in the code, somewhere.
> 
> To be sure, could you please show me the /proc/kallsymb output around
> the missing symbols (do_undefinstr, ...)?

see below

> > I've moved to working on the updated perf/urgent.  Reverting the
> > original patch doesn't make test 1 resume succeeding anymore.
> >
> > Pointers appreciated.
> 
> The missing symbols are in the missing maps.  They should be in the
> kernel maps for the kallsyms case IMHO.  Could you please run the test
> with below patch?

Thanks!  Turns out that in the case of no modules loaded, commit
a257e02579e4270 "arm64/kernel: don't ban ADRP to work around Cortex-A53
erratum #843419" added a 'veneer' symbol with a different start
address, so instead of:

    ERR : 0xffff44eb0a6c9620: module_emit_adrp_veneer not on kallsyms

I got:

    ERR : 0xffff44eb0a6c9620: diff addr v: module_emit_adrp_veneer k: 0xffff44eb0a6c9500 module_emit_plt_entry
        : map v: [kernel] k: [kernel]

So it helped solve the no-modules-loaded case.  I've updated my perf
tool to the latest acme's perf/urgent (commit e6a0a610a60), added this
patch "perf tools: set kernel end address properly", and this diff,
enhanced/re-purposed it a bit, and included a fix for succeeding the
test 1 when there are no modules loaded - see the end of this email.  I
doubt it's acceptable as-is, so please take a look.

Meanwhile, in order to help debug the module(s) loaded case, I'm
providing:

- output of the above perf, called with 'test -vvvvv 1' with
  no modules loaded (now passes test):
 - http://paste.ubuntu.com/p/xBgpjTyjFp/

- output of the above perf, called with 'test -vvvvv 1' with
  the arm-ccn module loaded (does not pass test):
  - http://paste.ubuntu.com/p/nWYxC9c5y2/

- /proc/kallsyms with the module loaded:
  - http://paste.ubuntu.com/p/pKskqyqdsK/

Thanks for your help,

Kim

diff --git a/tools/perf/arch/arm64/util/sym-handling.c b/tools/perf/arch/arm64/util/sym-handling.c
index 0051b1ee8450..5c4a2e208bbc 100644
--- a/tools/perf/arch/arm64/util/sym-handling.c
+++ b/tools/perf/arch/arm64/util/sym-handling.c
@@ -20,3 +20,16 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
               ehdr.e_type == ET_DYN;
 }
 #endif
+
+const char *arch__normalize_symbol_name(const char *name)
+{
+       /* 
+        * arm64 kernels compensating for a CPU erratum can put up a 
+        * module_emit_adrp_veneer in place of a module_emit_plt_entry
+        */
+       if (name && strlen(name) >= 23 &&
+           !strncmp(name, "module_emit_adrp_veneer", 23))
+               return "module_emit_plt_entry";
+
+       return name;
+}
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 1e5adb65632a..07064e76947d 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -163,6 +163,29 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 
                                continue;
                        }
+               } else if (pair) {
+                       s64 skew = mem_start - UM(pair->start);
+                       struct map *kmap = map_groups__find(&kallsyms.kmaps, type, mem_start);
+                       struct map *vmap = map_groups__find(&vmlinux.kmaps, type, mem_start);
+
+                       /* 
+                        * arm64 kernels compensating for a CPU erratum can put up a 
+                        * module_emit_adrp_veneer in place of a module_emit_plt_entry
+                        */
+                       if (llabs(skew) < page_size)
+                       {
+                               pr_debug("NO ERR FOR SKEW %ld: %#" PRIx64 ": diff start addr v: %s k: %#" PRIx64 " %s\n",
+                                        skew, mem_start, sym->name, UM(pair->start), pair->name);
+                               continue;
+                       }
+
+                       pr_debug("ERR : %#" PRIx64 ": diff start addr v: %s k: %#" PRIx64 " %s\n",
+                                mem_start, sym->name, UM(pair->start), pair->name);
+
+                       if (kmap && vmap) {
+                               pr_debug("    : map v: %s k: %s\n",
+                                        vmap->dso->short_name, kmap->dso->short_name);
+                       }
                } else
                        pr_debug("ERR : %#" PRIx64 ": %s not on kallsyms\n",
                                 mem_start, sym->name);
