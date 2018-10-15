Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E956C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060362089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060362089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeJPGNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:13:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbeJPGNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:13:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7142988311;
        Mon, 15 Oct 2018 22:25:49 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D47AC85686;
        Mon, 15 Oct 2018 22:25:48 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 6098D295E; Mon, 15 Oct 2018 19:25:46 -0300 (BRT)
Date:   Mon, 15 Oct 2018 19:25:46 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org
Subject: Re: perf's handling of unfindable user symbols...
Message-ID: <20181015222546.GA2159@redhat.com>
References: <20181014.004238.292485794143606801.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181014.004238.292485794143606801.davem@davemloft.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 15 Oct 2018 22:25:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Oct 14, 2018 at 12:42:38AM -0700, David Miller escreveu:
> 
> Perf has this hack where it uses the kernel symbol map as a backup
> when a symbol can't be found in the user's symbol table(s).

Right, I recall that, lemme find where this got introduced... there,
Ingo added it while perf lived in Documentation/:

commit ed966aac335a63083d3125198479447248637d9e
Author: Ingo Molnar <mingo@elte.hu>
Date:   Wed Jun 3 10:39:26 2009 +0200

    perf report: Handle vDSO symbols properly
    
    We were not looking up vDSO symbols properly, because they
    are in the kallsyms but are user-mode entries.
    
    Pass negative addresses to the kernel dso object, this
    way we resolve them properly:
    
         0.05%  [kernel]: vread_tsc
    
    Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Cc: Mike Galbraith <efault@gmx.de>
    Cc: Paul Mackerras <paulus@samba.org>
    Cc: Corey Ashford <cjashfor@linux.vnet.ibm.com>
    Cc: Marcelo Tosatti <mtosatti@redhat.com>
    Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: John Kacur <jkacur@redhat.com>
    LKML-Reference: <new-submission>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/Documentation/perf_counter/builtin-report.c b/Documentation/perf_counter/builtin-report.c
index a8d390596d8d..0f88d9ebb34a 100644
--- a/Documentation/perf_counter/builtin-report.c
+++ b/Documentation/perf_counter/builtin-report.c
@@ -728,6 +728,8 @@ static int __cmd_report(void)
                        event->ip.pid,
                        (void *)(long)ip);
 
+               dprintf(" ... thread: %s:%d\n", thread->comm, thread->pid);
+
                if (thread == NULL) {
                        fprintf(stderr, "problem processing %d event, skipping it.\n",
                                event->header.type);
@@ -740,6 +742,8 @@ static int __cmd_report(void)
 
                        dso = kernel_dso;
 
+                       dprintf(" ...... dso: %s\n", dso->name);
+
                } else if (event->header.misc & PERF_EVENT_MISC_USER) {
 
                        show = SHOW_USER;
@@ -749,11 +753,22 @@ static int __cmd_report(void)
                        if (map != NULL) {
                                dso = map->dso;
                                ip -= map->start + map->pgoff;
+                       } else {
+                               /*
+                                * If this is outside of all known maps,
+                                * and is a negative address, try to look it
+                                * up in the kernel dso, as it might be a
+                                * vsyscall (which executes in user-mode):
+                                */
+                               if ((long long)ip < 0)
+                                       dso = kernel_dso;
                        }
+                       dprintf(" ...... dso: %s\n", dso ? dso->name : "<not found>");
 
                }

 
> This causes problems because the tests driving this code path use
> machine__kernel_ip(), and that is completely meaningless on Sparc.  On

This machine__kernel_ip() got added later:

commit fbe2af45f6bd27ee69fd775303c936c3af4a4807
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Fri Aug 15 22:08:39 2014 +0300

    perf tools: Add machine__kernel_ip()
    
    Add a function to determine if an address is in the kernel.  This is
    based on the kernel function kernel_ip().
    
    Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Frederic Weisbecker <fweisbec@gmail.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Namhyung Kim <namhyung@gmail.com>
    Cc: Paul Mackerras <paulus@samba.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Stephane Eranian <eranian@google.com>
    Link: http://lkml.kernel.org/r/1408129739-17368-5-git-send-email-adrian.hunter@intel.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

static inline bool kernel_ip(unsigned long ip)
{
#ifdef CONFIG_X86_32
        return ip > PAGE_OFFSET;
#else
        return (long)ip < 0;
#endif
}

But this is in:

arch/x86/events/perf_event.h

totally x86 specific:

[acme@jouet perf]$ find . -name "*.[ch]" | xargs grep -w kernel_ip
./arch/x86/events/perf_event.h:static inline bool kernel_ip(unsigned long ip)
./arch/x86/events/perf_event.h:	regs->cs = kernel_ip(ip) ? __KERNEL_CS : __USER_CS;
./arch/x86/events/intel/pt.c:	return virt_addr_valid(ip) && kernel_ip(ip);
./arch/x86/events/intel/ds.c:		    (kernel_ip(at->from) || kernel_ip(at->to)))
./arch/x86/events/intel/ds.c:		    (kernel_ip(at->from) || kernel_ip(at->to)))
./arch/x86/events/intel/ds.c:	if (kernel_ip(ip) != kernel_ip(to))
./arch/x86/events/intel/ds.c:	if (!kernel_ip(ip)) {
./arch/x86/events/intel/ds.c:		is_64bit = kernel_ip(to) || !test_thread_flag(TIF_IA32);
./arch/x86/events/intel/lbr.c:	to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
./arch/x86/events/intel/lbr.c:	from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
./arch/x86/events/intel/lbr.c:	is64 = kernel_ip((unsigned long)addr) || !test_thread_flag(TIF_IA32);
[acme@jouet perf]$

> sparc64 the kernel and user live in physically separate virtual
> address spaces, rather than a shared one.  And the kernel lives at a
> virtual address that overlaps common userspace addresses.  So this
> test passes almost all the time when a user symbol lookup fails.
> 
> The consequence of this is that, if the unfound user virtual address
> in the sample doesn't match up to a kernel symbol either, we trigger
> things like this code in builtin-top.c:
> 
> 	if (al.sym == NULL && al.map != NULL) {
> 		const char *msg = "Kernel samples will not be resolved.\n";
> 		/*
> 		 * As we do lazy loading of symtabs we only will know if the
> 		 * specified vmlinux file is invalid when we actually have a
> 		 * hit in kernel space and then try to load it. So if we get
> 		 * here and there are _no_ symbols in the DSO backing the
> 		 * kernel map, bail out.
> 		 *
> 		 * We may never get here, for instance, if we use -K/
> 		 * --hide-kernel-symbols, even if the user specifies an
> 		 * invalid --vmlinux ;-)
> 		 */
> 		if (!machine->kptr_restrict_warned && !top->vmlinux_warned &&
> 		    __map__is_kernel(al.map) && map__has_symbols(al.map)) {
> 			if (symbol_conf.vmlinux_name) {
> 				char serr[256];
> 				dso__strerror_load(al.map->dso, serr, sizeof(serr));
> 				ui__warning("The %s file can't be used: %s\n%s",
> 					    symbol_conf.vmlinux_name, serr, msg);
> 			} else {
> 				ui__warning("A vmlinux file was not found.\n%s",
> 					    msg);
> 			}
> 
> 			if (use_browser <= 0)
> 				sleep(5);
> 			top->vmlinux_warned = true;
> 		}
> 	}
> 
> When I fire up a compilation on sparc, this triggers immediately.
> 
> I'm trying to figure out what the "backup to kernel map" code is
> accomplishing.
 
> I see some language in the current code and in the changes that have
> happened in this area talking about vdso.  Does that really happen?
> 
> The vdso is mapped into userspace virtual addresses, not kernel ones.
> 
> More history.  This didn't cause problems on sparc some time ago,
> because the kernel IP check used to be "ip < 0" :-) Sparc kernel
> addresses are not negative.  But now with machine__kernel_ip(), which
> works using the symbol table determined kernel address range, it does
> trigger.
> 
> What it all boils down to is that on architectures like sparc,
> machine__kernel_ip() should always return false in this scenerio, and
> therefore this kind of logic:
> 
> 		if (cpumode == PERF_RECORD_MISC_USER && machine &&
> 		    mg != &machine->kmaps &&
> 		    machine__kernel_ip(machine, al->addr)) {
> 
> is basically invalid.  PERF_RECORD_MISC_USER implies no kernel address
> can possibly match for the sample/event in question (no matter how
> hard you try!) :-)
> 
> At the very least there should be an arch way to disable this logic,
> or even formalize in some way the situation.  Have some kind of
> "user_kernel_shared_address_space" boolean, and then
> machine__kernel_ip() can take a cpumode parameter and it can thus say:
> 
> 	if (cpumode == PERF_RECORD_MISC_USER &&
> 	    !user_kernel_shared_address_space)
> 		return false;
> 
> Comments?

I think your solution is valid and fixes the problem for architectures with
this property, but we need some way of saying hey, I know I'm not in sparc, check
that like on x86 to cope with things like:

        kernel = machine__kernel_ip(machine, start);
        if (kernel)
                *cpumode = PERF_RECORD_MISC_KERNEL;
        else
                *cpumode = PERF_RECORD_MISC_USER;

That we have in builtin-script.c to handle addresses in branch stacks where
cpumode isn't available and is being derived from the address itself. I have to
look at this deeper to see how much change would be needed to do this in some
other fashion, i.e. is the cpumode really only derivable from looking just at
the address in the branch stack?

tools/perf/util/intel-bts.c does the same trick:

static int intel_bts_get_next_insn(struct intel_bts_queue *btsq, u64 ip)
{
        struct machine *machine = btsq->bts->machine;
        struct thread *thread;
        struct addr_location al;
        unsigned char buf[INTEL_PT_INSN_BUF_SZ];
        ssize_t len;
        int x86_64;
        uint8_t cpumode;
        int err = -1;

        if (machine__kernel_ip(machine, ip))
                cpumode = PERF_RECORD_MISC_KERNEL;
        else
                cpumode = PERF_RECORD_MISC_USER;



------------------------------------------------------------------------------------------

But I think we should have it as a property of 'struct machine', because we may
be processing on, say, x86, a perf.data file recorded on a Sparc machine, so we
need to save this property on the perf.data file, humm, or we can derive that
from data already there, like the quick patch below. I'll cache that property
on machine->user_kernel_shared_address_space, to avoid having to do the
strcmp() lots of times.

Does that document the hack further? Defining the
machine__user_kernel_shared_address_space() function right besides the
machine__kernel_ip() inline should help as well?

- Arnaldo

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0cd42150f712..243dd9241339 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1573,6 +1573,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 		 * in the whole kernel symbol list.
 		 */
 		if (cpumode == PERF_RECORD_MISC_USER && machine &&
+		    !machine__user_kernel_shared_address_space(machine) &&
 		    mg != &machine->kmaps &&
 		    machine__kernel_ip(machine, al->addr)) {
 			mg = &machine->kmaps;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index d856b85862e2..b8645f16710b 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -6,6 +6,7 @@
 #include <linux/rbtree.h>
 #include "map.h"
 #include "dso.h"
+#include "env.h"
 #include "event.h"
 #include "rwsem.h"
 
@@ -99,6 +100,12 @@ static inline bool machine__kernel_ip(struct machine *machine, u64 ip)
 	return ip >= kernel_start;
 }
 
+static inline bool machine__user_kernel_shared_address_space(struct machine *machine)
+{
+	const char *arch = perf_env__arch(machine->env);
+	return arch && strcmp(arch, "sparc") == 0;
+}
+
 struct thread *machine__find_thread(struct machine *machine, pid_t pid,
 				    pid_t tid);
 struct comm *machine__thread_exec_comm(struct machine *machine,
