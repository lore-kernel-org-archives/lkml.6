Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbeDPRYK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:24:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34108 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751135AbeDPRYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:24:09 -0400
Date: Mon, 16 Apr 2018 12:24:07 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <kernel-team@lge.com>
Subject: Re: [PATCH] perf tools: set kernel end address properly
Message-Id: <20180416122407.0d90863b69fed80166384850@arm.com>
In-Reply-To: <20180416165800.GD3202@kernel.org>
References: <20180416042240.21528-1-namhyung@kernel.org>
        <20180416092345.GA23274@krava>
        <20180416135125.GA23802@kernel.org>
        <20180416110730.1dd12801e43be66ea5d0cc48@arm.com>
        <20180416165800.GD3202@kernel.org>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018 13:58:00 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Mon, Apr 16, 2018 at 11:07:30AM -0500, Kim Phillips escreveu:
> > On Mon, 16 Apr 2018 10:51:25 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > > Em Mon, Apr 16, 2018 at 11:23:45AM +0200, Jiri Olsa escreveu:
> > > > On Mon, Apr 16, 2018 at 01:22:40PM +0900, Namhyung Kim wrote:
> > > > > The map_groups__fixup_end() was called to set end addresses of kernel
> > > > > map and module maps.  But now machine__create_modules() is set the end
> > > > > address of modules properly so the only remaining piece is the kernel
> > > > > map.  We can set it with adjacent module's address directly instead of
> > > > > calling the map_groups__fixup_end().  If there's no module after the
> > > > > kernel map, the end address will be ~0ULL.
> > > 
> > > I wonder if it wouldn't be better to have it as last symbol + PAGE_SIZE
> > > or something like that...
> > > 
> > > But, anyway, Kim, does this fix things for you? Can I have your
> > > Tested-by?
> > 
> > No, perf test 1 still fails:
> > 
> > vmlinux symtab matches kallsyms: FAILED!
> 
> Ok, -vv please

a perf/urgent from last week (commit 918965d4897) + this patch:

$ sudo ./perf test -vv 1 |& head 
 1: vmlinux symtab matches kallsyms                       :
--- start ---
test child forked, pid 6194
Looking at the vmlinux_path (8 entries long)
Using /lib/modules/4.16.0+/build/vmlinux for symbols
ERR : 0xffff200008081000: do_undefinstr not on kallsyms
ERR : 0xffff2000080810b8: do_sysinstr not on kallsyms
ERR : 0xffff200008081258: do_debug_exception not on kallsyms
ERR : 0xffff200008081648: do_mem_abort not on kallsyms
ERR : 0xffff2000080818b8: do_el0_irq_bp_hardening not on kallsyms
$ sudo ./perf test -vv 1 |& tail
ERR : 0xffff20000a1d37c8: tramp_exit_native not on kallsyms
ERR : 0xffff20000a1d37e8: tramp_exit_compat not on kallsyms
ERR : 0xffff20000a1d4000: __entry_tramp_text_end not on kallsyms
WARN: Maps only in vmlinux:
 ffff200008080000-ffff200008081000 10000 [kernel].head.text
 ffff20000aec0000-ffff20000aff7548 2e50000 [kernel].init.text
 ffff20000aff7548-ffff20000b0126d4 2f87548 [kernel].exit.text
test child finished with -1
---- end ----
vmlinux symtab matches kallsyms: FAILED!
$ 

Kim
