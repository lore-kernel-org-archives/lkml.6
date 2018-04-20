Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbeDTALI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 20:11:08 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:41568 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753581AbeDTALH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 20:11:07 -0400
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Fri, 20 Apr 2018 09:11:05 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [PATCH] perf tools: set kernel end address properly
Message-ID: <20180420001105.GB19067@sejong>
References: <20180416092345.GA23274@krava>
 <20180416135125.GA23802@kernel.org>
 <20180416110730.1dd12801e43be66ea5d0cc48@arm.com>
 <20180416165800.GD3202@kernel.org>
 <20180416122407.0d90863b69fed80166384850@arm.com>
 <20180416174811.1aca9106364effe435f363c8@arm.com>
 <20180417022726.GA31947@sejong>
 <20180418193759.b63912fe5e5b8a9023ec80a8@arm.com>
 <20180419025424.GC13370@sejong>
 <20180419183313.db3e3a105191a7f30b7650b2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180419183313.db3e3a105191a7f30b7650b2@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 06:33:13PM -0500, Kim Phillips wrote:
> On Thu, 19 Apr 2018 11:54:24 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > On Wed, Apr 18, 2018 at 07:37:59PM -0500, Kim Phillips wrote:
> > > diff --git a/tools/perf/arch/arm64/util/sym-handling.c b/tools/perf/arch/arm64/util/sym-handling.c
> > > index 0051b1ee8450..5c4a2e208bbc 100644
> > > --- a/tools/perf/arch/arm64/util/sym-handling.c
> > > +++ b/tools/perf/arch/arm64/util/sym-handling.c
> > > @@ -20,3 +20,16 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
> > >                ehdr.e_type == ET_DYN;
> > >  }
> > >  #endif
> > > +
> > > +const char *arch__normalize_symbol_name(const char *name)
> > > +{
> > > +       /* 
> > > +        * arm64 kernels compensating for a CPU erratum can put up a 
> > > +        * module_emit_adrp_veneer in place of a module_emit_plt_entry
> > > +        */
> > > +       if (name && strlen(name) >= 23 &&
> > > +           !strncmp(name, "module_emit_adrp_veneer", 23))
> > > +               return "module_emit_plt_entry";
> > > +
> > > +       return name;
> > > +}
> > 
> > I don't know it's always preferable or just for the test.  It it's the
> > latter it may be better to move it to the test code.
> 
> AFACT, the veneer is a moniker and doesn't technically exist, and
> shouldn't be being looked-up.  Both chunks of this diff are needed to
> pass perf test 1: this chunk above is because in
> arch__normalize_symbol_name(), we squash the perf test 1's "<veneer>
> not in *kallsyms*" problem, and in the below chunk, we prevent it
> coming up when the test code iterates over the *vmlinux* symbols. I.e.
> we need to prevent the veneer from coming up in both kallsyms *and*
> vmlinux.
> 
> > > diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
> > > index 1e5adb65632a..07064e76947d 100644
> > > --- a/tools/perf/tests/vmlinux-kallsyms.c
> > > +++ b/tools/perf/tests/vmlinux-kallsyms.c
> > > @@ -163,6 +163,29 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
> > >  
> > >                                 continue;
> > >                         }
> > > +               } else if (pair) {
> > > +                       s64 skew = mem_start - UM(pair->start);
> > > +                       struct map *kmap = map_groups__find(&kallsyms.kmaps, type, mem_start);
> > > +                       struct map *vmap = map_groups__find(&vmlinux.kmaps, type, mem_start);
> > > +
> > > +                       /* 
> > > +                        * arm64 kernels compensating for a CPU erratum can put up a 
> > > +                        * module_emit_adrp_veneer in place of a module_emit_plt_entry
> > > +                        */
> > > +                       if (llabs(skew) < page_size)
> > 
> > It seems that we needs to check it's the ARM64 at least.  If it's a
> 
> OK.
> 
> > rare case we might need to add more paranoid checks.
> 
> It's certainly rare: Adding the authors of the veneer to cc for
> comments:
> 
> Will, Ard, how probable are veneer-style symbols such as the
> one introduced in commit a257e0257 "arm64/kernel: don't ban ADRP to
> work around Cortex-A53 erratum #843419" to happen again in the future?
> 
> I would have thought WARNing on within-a-pagesize would be OK,
> Namhyung.  Are you suggesting checking instead for a hardcoded veneer
> symbol string?

Anything to prevent false-negatives (possibly on other archs).

Thanks,
Namhyung


> 
> Thanks,
> 
> Kim
> 
> > > +                       {
> > > +                               pr_debug("NO ERR FOR SKEW %ld: %#" PRIx64 ": diff start addr v: %s k: %#" PRIx64 " %s\n",
> > > +                                        skew, mem_start, sym->name, UM(pair->start), pair->name);
> > > +                               continue;
> > > +                       }
> > > +
> > > +                       pr_debug("ERR : %#" PRIx64 ": diff start addr v: %s k: %#" PRIx64 " %s\n",
> > > +                                mem_start, sym->name, UM(pair->start), pair->name);
> > > +
> > > +                       if (kmap && vmap) {
> > > +                               pr_debug("    : map v: %s k: %s\n",
> > > +                                        vmap->dso->short_name, kmap->dso->short_name);
> > > +                       }
> > >                 } else
> > >                         pr_debug("ERR : %#" PRIx64 ": %s not on kallsyms\n",
> > >                                  mem_start, sym->name);
