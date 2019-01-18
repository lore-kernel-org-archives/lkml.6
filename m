Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D2BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A16C20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfARQKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:10:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfARQKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:10:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCAB2CA36D;
        Fri, 18 Jan 2019 16:10:03 +0000 (UTC)
Received: from krava (unknown [10.40.205.156])
        by smtp.corp.redhat.com (Postfix) with SMTP id CEB555C554;
        Fri, 18 Jan 2019 16:10:01 +0000 (UTC)
Date:   Fri, 18 Jan 2019 17:10:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC] Don't print sample_type bits in non-group events not set
 in the group's was Re: [PATCH] perf, script: Fix crash with printing mixed
 trace point and other events
Message-ID: <20190118161000.GC28346@krava>
References: <20190117194834.21940-1-andi@firstfloor.org>
 <20190118094919.GA28346@krava>
 <20190118125920.GG5823@kernel.org>
 <20190118130106.GH5823@kernel.org>
 <20190118134205.GI5823@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118134205.GI5823@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 18 Jan 2019 16:10:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 10:42:05AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 18, 2019 at 10:01:06AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Jan 18, 2019 at 09:59:20AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Thanks, tested and applied.
> 
> > > While testing I found something odd, the cycles events are not showing
> > > the CPU and the probe events shows a "negative" CPU column,
> > > investigating.
>  
> > The sample_type for those two events:
>  
> > [root@quaco wb]# perf evlist -v
> > cpu/cpu-cycles,period=10000/: type: 4, size: 112, config: 0x3c, { sample_period, sample_freq }: 10000, sample_type: IP|TID|TIME|READ|IDENTIFIER, read_format: ID|GROUP, disabled: 1, mmap: 1, comm: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1
> > probe_libc:malloc: type: 2, size: 112, config: 0x790, sample_type: IP|TID|TIME|READ|CPU|PERIOD|RAW|IDENTIFIER, read_format: ID|GROUP, sample_id_all: 1, exclude_guest: 1
> > # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events
> > [root@quaco wb]#
> 
> The output:
> 
>   # perf probe -l
>    probe_libc:malloc    (on __libc_malloc@malloc/malloc.c in /usr/lib64/libc-2.28.so)
>    # perf record -e '{cpu/cpu-cycles,period=10000/,probe_libc:*}:S' sleep 1
>    [ perf record: Woken up 1 times to write data ]
>    [ perf record: Captured and wrote 0.023 MB perf.data (40 samples) ]
>    # perf script
>    Segmentation fault (core dumped)
>    ^C
>    #
>  
>  After:
>  
>    # perf script | head -6
>       sleep 2888 94796.944981: 16198 cpu/cpu-cycles,period=10000/: ffffffff925dc04f get_random_u32+0x1f (/lib/modules/5.0.0-rc2+/build/vmlinux)
>       sleep 2888 [-01] 94796.944981: probe_libc:malloc:
>       sleep 2888 94796.944983:  4713 cpu/cpu-cycles,period=10000/: ffffffff922763af change_protection+0xcf (/lib/modules/5.0.0-rc2+/build/vmlinux)
>       sleep 2888 [-01] 94796.944983: probe_libc:malloc:
>       sleep 2888 94796.944986:  9934 cpu/cpu-cycles,period=10000/: ffffffff922777e0 move_page_tables+0x0 (/lib/modules/5.0.0-rc2+/build/vmlinux)
>       sleep 2888 [-01] 94796.944986: probe_libc:malloc:
>    #
> 
> For perf_sample->cpu to come out as -1 from perf_evsen__parse_sample() we would
> have to have evsel->attr.sample_type not having PERF_SAMPLE_CPU set, which,
> according to the 'perf evlist' output above, is not the case for
> probe_libc:malloc...
> 
> So, this is because in this case we have it in a group so we end up never calling
> perf_evsel__parse_sample for that probe_libc:malloc event, using the perf_sample
> parsed for the cpu/cpu-cycles/ event that indeed doesn't have CPU set.
> 
> So we need to auto-deselect the CPU printing for non group events if the group
> event doesn't have PERF_SAMPLE_CPU set, right Jiri?
> 
> See the details:
> 
> (gdb) b deliver_sample_value
> Breakpoint 1 at 0x539a81: file util/session.c, line 1177.
> (gdb) run script
> Starting program: /root/bin/perf script
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> [Detaching after fork from child process 20014]
> 
> Breakpoint 1, deliver_sample_value (evlist=0xab2ce0, tool=0x7fffffffc3e0, event=0x7ffff7fcd408, sample=0x7fffffffbd50, v=0x7ffff7fcd438,
>     machine=0xaaca60) at util/session.c:1177
> 1177	{
> (gdb) bt
> #0  deliver_sample_value (evlist=0xab2ce0, tool=0x7fffffffc3e0, event=0x7ffff7fcd408, sample=0x7fffffffbd50, v=0x7ffff7fcd438, machine=0xaaca60)
>     at util/session.c:1177
> #1  0x0000000000539bc6 in deliver_sample_group (evlist=0xab2ce0, tool=0x7fffffffc3e0, event=0x7ffff7fcd408, sample=0x7fffffffbd50,
>     machine=0xaaca60) at util/session.c:1205
> #2  0x0000000000539c9e in perf_evlist__deliver_sample (evlist=0xab2ce0, tool=0x7fffffffc3e0, event=0x7ffff7fcd408, sample=0x7fffffffbd50,
>     evsel=0xab3730, machine=0xaaca60) at util/session.c:1233
> #3  0x0000000000539e05 in machines__deliver_event (machines=0xaaca60, evlist=0xab2ce0, event=0x7ffff7fcd408, sample=0x7fffffffbd50,
>     tool=0x7fffffffc3e0, file_offset=21512) at util/session.c:1266
> #4  0x000000000053a219 in perf_session__deliver_event (session=0xaac960, event=0x7ffff7fcd408, tool=0x7fffffffc3e0, file_offset=21512)
>     at util/session.c:1335
> #5  0x0000000000536d22 in ordered_events__deliver_event (oe=0xab2bf0, event=0xad1da8) at util/session.c:113
> #6  0x000000000053da1c in do_flush (oe=0xab2bf0, show_progress=true) at util/ordered-events.c:243
> #7  0x000000000053dd4b in __ordered_events__flush (oe=0xab2bf0, how=OE_FLUSH__FINAL, timestamp=0) at util/ordered-events.c:320
> #8  0x000000000053de20 in ordered_events__flush (oe=0xab2bf0, how=OE_FLUSH__FINAL) at util/ordered-events.c:338
> #9  0x000000000053bb5c in __perf_session__process_events (session=0xaac960, data_offset=488, data_size=23424, file_size=23912)
>     at util/session.c:1925
> #10 0x000000000053bca5 in perf_session__process_events (session=0xaac960) at util/session.c:1955
> #11 0x0000000000463d3e in __cmd_script (script=0x7fffffffc3e0) at builtin-script.c:2388
> #12 0x0000000000468140 in cmd_script (argc=0, argv=0x7fffffffdb40) at builtin-script.c:3727
> #13 0x00000000004d4a1a in run_builtin (p=0x92ab18 <commands+408>, argc=1, argv=0x7fffffffdb40) at perf.c:302
> #14 0x00000000004d4c87 in handle_internal_command (argc=1, argv=0x7fffffffdb40) at perf.c:354
> #15 0x00000000004d4dd6 in run_argv (argcp=0x7fffffffd99c, argv=0x7fffffffd990) at perf.c:398
> #16 0x00000000004d5142 in main (argc=1, argv=0x7fffffffdb40) at perf.c:520
> (gdb) p (int)sample->cpu
> $1 = -1
> (gdb) info b
> Num     Type           Disp Enb Address            What
> 1       breakpoint     keep y   0x0000000000539a81 in deliver_sample_value at util/session.c:1177
> 	breakpoint already hit 1 time
> (gdb) condition 1 (int)sample->cpu != -1
> (gdb) c
> Continuing.
>     sleep  2888 94796.944981:      16198 cpu/cpu-cycles,period=10000/:  ffffffff925dc04f get_random_u32+0x1f (/lib/modules/5.0.0-rc2+/buil>
>     sleep  2888 [-01] 94796.944981:            probe_libc:malloc:
>     sleep  2888 94796.944983:       4713 cpu/cpu-cycles,period=10000/:  ffffffff922763af change_protection+0xcf (/lib/modules/5.0.0-rc2+/b>
>     sleep  2888 [-01] 94796.944983:            probe_libc:malloc:
> <SNIP>
> [Inferior 1 (process 20003) exited normally]
> (gdb)
> 
> 
> See? None of the perf_sample parsed have perf_sample->cpu set, its all -1, which
> is set in perf_evsel__parse_sample() to indicate that PERF_SAMPLE_TYPE wasn't found
> in evsel->attr.sample_type for the evsel being used to parse the perf_event payload.

well the probe_test::main is never sampled, we just read its value
and attach it to the sampling leader - cycles

I wonder if there's a point to actualy display it in perf script
output.. we should probably skip (something like below) that and
add script field that would output the sample_read values for the
leader

jirka


---
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f494f9aa0d06..85e76cec8a98 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1925,6 +1925,14 @@ static int cleanup_scripting(void)
 	return scripting_ops ? scripting_ops->stop_script() : 0;
 }
 
+static bool perf_evsel__should_skip(struct perf_evsel *evsel)
+{
+	struct perf_event_attr *attr = &evsel->attr;
+	struct perf_evsel *leader = evsel->leader;
+
+	return (leader != evsel) && !attr->freq && !attr->sample_freq;
+}
+
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -1934,6 +1942,9 @@ static int process_sample_event(struct perf_tool *tool,
 	struct perf_script *scr = container_of(tool, struct perf_script, tool);
 	struct addr_location al;
 
+	if (perf_evsel__should_skip(evsel))
+		return 0;
+
 	if (perf_time__ranges_skip_sample(scr->ptime_range, scr->range_num,
 					  sample->time)) {
 		return 0;
