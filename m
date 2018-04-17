Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDQC1r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 22:27:47 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:54734 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeDQC1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 22:27:46 -0400
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Tue, 17 Apr 2018 11:27:26 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [PATCH] perf tools: set kernel end address properly
Message-ID: <20180417022726.GA31947@sejong>
References: <20180416042240.21528-1-namhyung@kernel.org>
 <20180416092345.GA23274@krava>
 <20180416135125.GA23802@kernel.org>
 <20180416110730.1dd12801e43be66ea5d0cc48@arm.com>
 <20180416165800.GD3202@kernel.org>
 <20180416122407.0d90863b69fed80166384850@arm.com>
 <20180416174811.1aca9106364effe435f363c8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180416174811.1aca9106364effe435f363c8@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 05:48:11PM -0500, Kim Phillips wrote:
> On Mon, 16 Apr 2018 12:24:07 -0500
> Kim Phillips <kim.phillips@arm.com> wrote:
> 
> > On Mon, 16 Apr 2018 13:58:00 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > > Em Mon, Apr 16, 2018 at 11:07:30AM -0500, Kim Phillips escreveu:
> > > > On Mon, 16 Apr 2018 10:51:25 -0300
> > > > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > 
> > > > > Em Mon, Apr 16, 2018 at 11:23:45AM +0200, Jiri Olsa escreveu:
> > > > > > On Mon, Apr 16, 2018 at 01:22:40PM +0900, Namhyung Kim wrote:
> > > > > > > The map_groups__fixup_end() was called to set end addresses of kernel
> > > > > > > map and module maps.  But now machine__create_modules() is set the end
> > > > > > > address of modules properly so the only remaining piece is the kernel
> > > > > > > map.  We can set it with adjacent module's address directly instead of
> > > > > > > calling the map_groups__fixup_end().  If there's no module after the
> > > > > > > kernel map, the end address will be ~0ULL.
> > > > > 
> > > > > I wonder if it wouldn't be better to have it as last symbol + PAGE_SIZE
> > > > > or something like that...
> > > > > 
> > > > > But, anyway, Kim, does this fix things for you? Can I have your
> > > > > Tested-by?
> > > > 
> > > > No, perf test 1 still fails:
> > > > 
> > > > vmlinux symtab matches kallsyms: FAILED!
> > > 
> > > Ok, -vv please
> > 
> > a perf/urgent from last week (commit 918965d4897) + this patch:
> > 
> > $ sudo ./perf test -vv 1 |& head 
> >  1: vmlinux symtab matches kallsyms                       :
> > --- start ---
> > test child forked, pid 6194
> > Looking at the vmlinux_path (8 entries long)
> > Using /lib/modules/4.16.0+/build/vmlinux for symbols
> > ERR : 0xffff200008081000: do_undefinstr not on kallsyms
> > ERR : 0xffff2000080810b8: do_sysinstr not on kallsyms
> > ERR : 0xffff200008081258: do_debug_exception not on kallsyms
> > ERR : 0xffff200008081648: do_mem_abort not on kallsyms
> > ERR : 0xffff2000080818b8: do_el0_irq_bp_hardening not on kallsyms
> > $ sudo ./perf test -vv 1 |& tail
> > ERR : 0xffff20000a1d37c8: tramp_exit_native not on kallsyms
> > ERR : 0xffff20000a1d37e8: tramp_exit_compat not on kallsyms
> > ERR : 0xffff20000a1d4000: __entry_tramp_text_end not on kallsyms
> > WARN: Maps only in vmlinux:
> >  ffff200008080000-ffff200008081000 10000 [kernel].head.text
> >  ffff20000aec0000-ffff20000aff7548 2e50000 [kernel].init.text
> >  ffff20000aff7548-ffff20000b0126d4 2f87548 [kernel].exit.text
> > test child finished with -1
> > ---- end ----
> > vmlinux symtab matches kallsyms: FAILED!
> 
> this patch's advertised "If there's no module after the kernel map, the
> end address will be ~0ULL." doesn't seem to be working: the value it
> gets for 'end' is 0xffff200008080000.

For the vmlinux, right?

To be precise, it should be "If there's no map after the kernel map".
It seems vmlinux adds more maps after the kernel map for those .head,
.init and .exit text sections.

> 
> I even hardcoded 'end' variable to the value for '_end' in kallsyms
> prior to the machine__set_kernel_mmap() call, and test 1 still fails.

I guess it was overwritten by the machine__set_kernel_mmap() then.


> 
> The problem is earlier on in the code, somewhere.

To be sure, could you please show me the /proc/kallsymb output around
the missing symbols (do_undefinstr, ...)?


> 
> I've moved to working on the updated perf/urgent.  Reverting the
> original patch doesn't make test 1 resume succeeding anymore.
> 
> Pointers appreciated.

The missing symbols are in the missing maps.  They should be in the
kernel maps for the kallsyms case IMHO.  Could you please run the test
with below patch?

Thanks,
Namhyung


---------------8<----------------

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 1e5adb65632a..b14ed70fa440 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -163,6 +163,17 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 
                                continue;
                        }
+               } else if (pair) {
+                       struct map *kmap = map_groups__find(&kallsyms.kmaps, type, mem_start);
+                       struct map *vmap = map_groups__find(&vmlinux.kmaps, type, mem_start);
+
+                       pr_debug("ERR : %#" PRIx64 ": diff addr v: %s k: %#" PRIx64 " %s\n",
+                                mem_start, sym->name, UM(pair->start), pair->name);
+
+                       if (kmap && vmap) {
+                               pr_debug("    : map v: %s k: %s\n",
+                                        vmap->dso->short_name, kmap->dso->short_name);
+                       }
                } else
                        pr_debug("ERR : %#" PRIx64 ": %s not on kallsyms\n",
                                 mem_start, sym->name);
