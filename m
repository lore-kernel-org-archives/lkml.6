Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AE2C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913FB2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913FB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJQCg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:36:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbeJQCg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:36:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68FEA30020AA;
        Tue, 16 Oct 2018 18:45:10 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 911C684B16;
        Tue, 16 Oct 2018 18:45:09 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 75E34295E; Tue, 16 Oct 2018 15:45:06 -0300 (BRT)
Date:   Tue, 16 Oct 2018 15:45:06 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: perf's handling of unfindable user symbols...
Message-ID: <20181016184506.GB3254@redhat.com>
References: <20181014.004238.292485794143606801.davem@davemloft.net>
 <20181015222546.GA2159@redhat.com>
 <20181015.160246.58484704665215987.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015.160246.58484704665215987.davem@davemloft.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 16 Oct 2018 18:45:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding some people to the CC list.

Em Mon, Oct 15, 2018 at 04:02:46PM -0700, David Miller escreveu:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Mon, 15 Oct 2018 19:25:46 -0300
 
> > But I think we should have it as a property of 'struct machine', because we may
> > be processing on, say, x86, a perf.data file recorded on a Sparc machine, so we
> > need to save this property on the perf.data file, humm, or we can derive that
> > from data already there, like the quick patch below. I'll cache that property
> > on machine->user_kernel_shared_address_space, to avoid having to do the
> > strcmp() lots of times.
 
> > Does that document the hack further? Defining the
> > machine__user_kernel_shared_address_space() function right besides the
> > machine__kernel_ip() inline should help as well?
 
> Your patch looks fine.
> 
> But, more deeply, the VDSO thing itself makes no sense to me.
 
> Why would we use the kernel map for something that is mapped into
> userspace and uses the user space virtual addresse range?
 
> As it is used by user applications, the VDSO isn't mapped into the
> kernel virtual address range, therefore no PC from userspace executing
> the VDSO will have a kernel range address.
 
> We will see normal userspace virtual addresses instead.  Test this
> assertion, if you like :-)
 
> So I am suggesting that we remove the hack, and don't try to use the
> kernel map for resolving the IP of user mode events.  If that is a
> valid change, we can toss all of this weird stuff that tries to
> interpret an address based upon what "range" it falls into.

Exec summary: yeah, drop that hack, I agree, patch at the end of the
message.

So, I thought something had changed and in the past we would somehow
find that address in the kallsyms, but I couldn't find anything to back
that up, the patch introducing this is over a decade old, lots of things
changed, so I was just thinking I was missing something.

I tried a gtod busy loop to generate vdso activity and added a 'perf
probe' at that branch, on x86_64 to see if it ever gets hit:

Made thread__find_map() noinline, as 'perf probe' in lines of inline
functions seems to not be working, only at function start. (Masami?)

[root@jouet ~]# perf probe -x ~/bin/perf -L thread__find_map:57
<thread__find_map@/home/acme/git/perf/tools/perf/util/event.c:57>
     57                 if (cpumode == PERF_RECORD_MISC_USER && machine &&
     58                     mg != &machine->kmaps &&
     59                     machine__kernel_ip(machine, al->addr)) {
     60                         mg = &machine->kmaps;
     61                         load_map = true;
     62                         goto try_again;
                        }
                } else {
                        /*
                         * Kernel maps might be changed when loading
                         * symbols so loading
                         * must be done prior to using kernel maps.
                         */
     69                 if (load_map)
     70                         map__load(al->map);
     71                 al->addr = al->map->map_ip(al->map, al->addr);

[root@jouet ~]# perf probe -x ~/bin/perf thread__find_map:60
Added new event:
  probe_perf:thread__find_map (on thread__find_map:60 in /home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:thread__find_map -aR sleep 1

[root@jouet ~]#

Then used this to see if, system wide, those probe points were being hit:

[root@jouet ~]# perf trace -e *perf:thread*/max-stack=8/
^C[root@jouet ~]#

No hits when running 'perf top' and:

[root@jouet c]# cat gtod.c
#include <sys/time.h>

int main(void)
{
	struct timeval tv;

	while (1)
		gettimeofday(&tv, 0);

	return 0;
}
[root@jouet c]# ./gtod 
^C

Pressed 'P' in 'perf top' and the [vdso] samples are there:

  62.84%  [vdso]                    [.] __vdso_gettimeofday
   8.13%  gtod                      [.] main
   7.51%  [vdso]                    [.] 0x0000000000000914
   5.78%  [vdso]                    [.] 0x0000000000000917
   5.43%  gtod                      [.] _init
   2.71%  [vdso]                    [.] 0x000000000000092d
   0.35%  [kernel]                  [k] native_io_delay
   0.33%  libc-2.26.so              [.] __memmove_avx_unaligned_erms
   0.20%  [vdso]                    [.] 0x000000000000091d
   0.17%  [i2c_i801]                [k] i801_access
   0.06%  firefox                   [.] free
   0.06%  libglib-2.0.so.0.5400.3   [.] g_source_iter_next
   0.05%  [vdso]                    [.] 0x0000000000000919
   0.05%  libpthread-2.26.so        [.] __pthread_mutex_lock
   0.05%  libpixman-1.so.0.34.0     [.] 0x000000000006d3a7
   0.04%  [kernel]                  [k] entry_SYSCALL_64_trampoline
   0.04%  libxul.so                 [.] style::dom_apis::query_selector_slow
   0.04%  [kernel]                  [k] module_get_kallsym
   0.04%  firefox                   [.] malloc
   0.04%  [vdso]                    [.] 0x0000000000000910

I added a 'perf probe' to thread__find_map:69, and that surely got tons
of hits, i.e. for every map found, just to make sure the 'perf probe'
command was really working.

In the process I noticed a bug, we're only have records for '[vdso]' for
pre-existing commands, i.e. ones that are running when we start 'perf top',
when we will generate the PERF_RECORD_MMAP by looking at /perf/PID/maps.

I.e. like this, for preexisting processes with a vdso map, again,
tracing for all the system, only pre-existing processes get a [vdso] map
(when having one):

[root@jouet ~]# perf probe -x ~/bin/perf __machine__addnew_vdso
Added new event:
  probe_perf:__machine__addnew_vdso (on __machine__addnew_vdso in /home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:__machine__addnew_vdso -aR sleep 1

[root@jouet ~]# perf trace -e probe_perf:__machine__addnew_vdso/max-stack=8/
     0.000 probe_perf:__machine__addnew_vdso:(568eb3)
                                       __machine__addnew_vdso (/home/acme/bin/perf)
                                       map__new (/home/acme/bin/perf)
                                       machine__process_mmap2_event (/home/acme/bin/perf)
                                       machine__process_event (/home/acme/bin/perf)
                                       perf_event__process (/home/acme/bin/perf)
                                       perf_tool__process_synth_event (/home/acme/bin/perf)
                                       perf_event__synthesize_mmap_events (/home/acme/bin/perf)
                                       __event__synthesize_thread (/home/acme/bin/perf)

The kernel doesn't seem to be generating a PERF_RECORD_MMAP for vDSOs...  And
we can't do this in 'perf record' because we don't process event by event, just
dump things from the ring buffer to a file...

For 'perf top', since we process the PERF_RECORD_MMAPs, we can piggyback and
read the smaps file to hack around this limitation somehow... Peter?

Anyway, two bugs found in this exercise...

The patch is the obvious one and with it we also continue to resolve
vdso symbols (for pre-existing processes).

- Arnaldo

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0988eb3b844b..bc646185f8d9 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1561,26 +1561,9 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 
 		return NULL;
 	}
-try_again:
+
 	al->map = map_groups__find(mg, al->addr);
-	if (al->map == NULL) {
-		/*
-		 * If this is outside of all known maps, and is a negative
-		 * address, try to look it up in the kernel dso, as it might be
-		 * a vsyscall or vdso (which executes in user-mode).
-		 *
-		 * XXX This is nasty, we should have a symbol list in the
-		 * "[vdso]" dso, but for now lets use the old trick of looking
-		 * in the whole kernel symbol list.
-		 */
-		if (cpumode == PERF_RECORD_MISC_USER && machine &&
-		    mg != &machine->kmaps &&
-		    machine__kernel_ip(machine, al->addr)) {
-			mg = &machine->kmaps;
-			load_map = true;
-			goto try_again;
-		}
-	} else {
+	if (al->map != NULL) {
 		/*
 		 * Kernel maps might be changed when loading symbols so loading
 		 * must be done prior to using kernel maps.


