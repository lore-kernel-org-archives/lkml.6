Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C72C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DD420834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w+prUdEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DD420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeJYTn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeJYTn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:43:26 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14FB320847;
        Thu, 25 Oct 2018 11:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465867;
        bh=5P7Q3yYNnbEEeozMDN6jlD8ZfCZF0TuZjb+HeRKRXQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w+prUdEJCk0yt/v/KhBIsUsUTSm8xO+uD/YgczhHtI47XhGQh5dfwjlUZwPQ/j81b
         bX4DppD+/clPcdCIk4+m4ONUXQOfQLb7qUW9RiMEtK2MHv8dtfeYCUmaMIIWU1Aahv
         g/leJ5hexGntc78Q6uJ860+ku+8pFY9OfdLnkKmE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?q?Rud=C3=A1=20Moura?= <ruda.moura@gmail.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 07/37] perf trace: Introduce --max-events
Date:   Thu, 25 Oct 2018 08:10:01 -0300
Message-Id: <20181025111031.3440-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Allow stopping tracing after a number of events take place, considering
strace-like syscalls formatting as one event per enter/exit pair or when
in a multi-process tracing session a syscall is interrupted and printed
ending with '...'.

Examples included in the documentation:

Trace the first 4 open, openat or open_by_handle_at syscalls (in the future more syscalls may match here):

  $ perf trace -e open* --max-events 4
  [root@jouet perf]# trace -e open* --max-events 4
  2272.992 ( 0.037 ms): gnome-shell/1370 openat(dfd: CWD, filename: /proc/self/stat) = 31
  2277.481 ( 0.139 ms): gnome-shell/3039 openat(dfd: CWD, filename: /proc/self/stat) = 65
  3026.398 ( 0.076 ms): gnome-shell/3039 openat(dfd: CWD, filename: /proc/self/stat) = 65
  4294.665 ( 0.015 ms): sed/15879 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
  $

Trace the first minor page fault when running a workload:

  # perf trace -F min --max-stack=7 --max-events 1 sleep 1
     0.000 ( 0.000 ms): sleep/18006 minfault [__clear_user+0x1a] => 0x5626efa56080 (?k)
                                       __clear_user ([kernel.kallsyms])
                                       load_elf_binary ([kernel.kallsyms])
                                       search_binary_handler ([kernel.kallsyms])
                                       __do_execve_file.isra.33 ([kernel.kallsyms])
                                       __x64_sys_execve ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64 ([kernel.kallsyms])
  #

Trace the next min page page fault to take place on the first CPU:

  # perf trace -F min --call-graph=dwarf --max-events 1 --cpu 0
     0.000 ( 0.000 ms): Web Content/17136 minfault [js::gc::Chunk::fetchNextDecommittedArena+0x4b] => 0x7fbe6181b000 (?.)
                                       js::gc::FreeSpan::initAsEmpty (inlined)
                                       js::gc::Arena::setAsNotAllocated (inlined)
                                       js::gc::Chunk::fetchNextDecommittedArena (/usr/lib64/firefox/libxul.so)
                                       js::gc::Chunk::allocateArena (/usr/lib64/firefox/libxul.so)
                                       js::gc::GCRuntime::allocateArena (/usr/lib64/firefox/libxul.so)
                                       js::gc::ArenaLists::allocateFromArena (/usr/lib64/firefox/libxul.so)
                                       js::gc::GCRuntime::tryNewTenuredThing<JSString, (js::AllowGC)1> (inlined)
                                       js::AllocateString<JSString, (js::AllowGC)1> (/usr/lib64/firefox/libxul.so)
                                       js::Allocate<JSThinInlineString, (js::AllowGC)1> (inlined)
                                       JSThinInlineString::new_<(js::AllowGC)1> (inlined)
                                       AllocateInlineString<(js::AllowGC)1, unsigned char> (inlined)
                                       js::ConcatStrings<(js::AllowGC)1> (/usr/lib64/firefox/libxul.so)
                                       [0x18b26e6bc2bd] (/tmp/perf-17136.map)

Tracing the next four ext4 operations on a specific CPU:

  # perf trace -e ext4:*/call-graph=fp/ --max-events 4 --cpu 3
     0.000 mutt/3849 ext4:ext4_es_lookup_extent_enter:dev 253,2 ino 57277 lblk 0
                                       ext4_es_lookup_extent ([kernel.kallsyms])
                                       read (/usr/lib64/libc-2.26.so)
     0.097 mutt/3849 ext4:ext4_es_lookup_extent_exit:dev 253,2 ino 57277 found 0 [0/0) 0
                                       ext4_es_lookup_extent ([kernel.kallsyms])
                                       read (/usr/lib64/libc-2.26.so)
     0.141 mutt/3849 ext4:ext4_ext_map_blocks_enter:dev 253,2 ino 57277 lblk 0 len 1 flags
                                       ext4_ext_map_blocks ([kernel.kallsyms])
                                       read (/usr/lib64/libc-2.26.so)
     0.184 mutt/3849 ext4:ext4_ext_load_extent:dev 253,2 ino 57277 lblk 1516511 pblk 18446744071750013657
                                       __read_extent_tree_block ([kernel.kallsyms])
                                       __read_extent_tree_block ([kernel.kallsyms])
                                       ext4_find_extent ([kernel.kallsyms])
                                       ext4_ext_map_blocks ([kernel.kallsyms])
                                       ext4_map_blocks ([kernel.kallsyms])
                                       ext4_mpage_readpages ([kernel.kallsyms])
                                       read_pages ([kernel.kallsyms])
                                       __do_page_cache_readahead ([kernel.kallsyms])
                                       ondemand_readahead ([kernel.kallsyms])
                                       generic_file_read_iter ([kernel.kallsyms])
                                       __vfs_read ([kernel.kallsyms])
                                       vfs_read ([kernel.kallsyms])
                                       ksys_read ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64 ([kernel.kallsyms])
                                       read (/usr/lib64/libc-2.26.so)
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Rudá Moura <ruda.moura@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-sweh107bs7ol5bzls0m4tqdz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-trace.txt | 47 +++++++++++++++++++++++++++++++++
 tools/perf/builtin-trace.c              | 21 +++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 115db9e06ecd..0d1a1cd4d328 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -171,6 +171,11 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 --kernel-syscall-graph::
 	 Show the kernel callchains on the syscall exit path.
 
+--max-events=N::
+	Stop after processing N events. Note that strace-like events are considered
+	only at exit time or when a syscall is interrupted, i.e. in those cases this
+	option is equivalent to the number of lines printed.
+
 --max-stack::
         Set the stack depth limit when parsing the callchain, anything
         beyond the specified depth will be ignored. Note that at this point
@@ -238,6 +243,48 @@ Trace syscalls, major and minor pagefaults:
   As you can see, there was major pagefault in python process, from
   CRYPTO_push_info_ routine which faulted somewhere in libcrypto.so.
 
+Trace the first 4 open, openat or open_by_handle_at syscalls (in the future more syscalls may match here):
+
+  $ perf trace -e open* --max-events 4
+  [root@jouet perf]# trace -e open* --max-events 4
+  2272.992 ( 0.037 ms): gnome-shell/1370 openat(dfd: CWD, filename: /proc/self/stat) = 31
+  2277.481 ( 0.139 ms): gnome-shell/3039 openat(dfd: CWD, filename: /proc/self/stat) = 65
+  3026.398 ( 0.076 ms): gnome-shell/3039 openat(dfd: CWD, filename: /proc/self/stat) = 65
+  4294.665 ( 0.015 ms): sed/15879 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
+  $
+
+Trace the first minor page fault when running a workload:
+
+  # perf trace -F min --max-stack=7 --max-events 1 sleep 1
+     0.000 ( 0.000 ms): sleep/18006 minfault [__clear_user+0x1a] => 0x5626efa56080 (?k)
+                                       __clear_user ([kernel.kallsyms])
+                                       load_elf_binary ([kernel.kallsyms])
+                                       search_binary_handler ([kernel.kallsyms])
+                                       __do_execve_file.isra.33 ([kernel.kallsyms])
+                                       __x64_sys_execve ([kernel.kallsyms])
+                                       do_syscall_64 ([kernel.kallsyms])
+                                       entry_SYSCALL_64 ([kernel.kallsyms])
+  #
+
+Trace the next min page page fault to take place on the first CPU:
+
+  # perf trace -F min --call-graph=dwarf --max-events 1 --cpu 0
+     0.000 ( 0.000 ms): Web Content/17136 minfault [js::gc::Chunk::fetchNextDecommittedArena+0x4b] => 0x7fbe6181b000 (?.)
+                                       js::gc::FreeSpan::initAsEmpty (inlined)
+                                       js::gc::Arena::setAsNotAllocated (inlined)
+                                       js::gc::Chunk::fetchNextDecommittedArena (/usr/lib64/firefox/libxul.so)
+                                       js::gc::Chunk::allocateArena (/usr/lib64/firefox/libxul.so)
+                                       js::gc::GCRuntime::allocateArena (/usr/lib64/firefox/libxul.so)
+                                       js::gc::ArenaLists::allocateFromArena (/usr/lib64/firefox/libxul.so)
+                                       js::gc::GCRuntime::tryNewTenuredThing<JSString, (js::AllowGC)1> (inlined)
+                                       js::AllocateString<JSString, (js::AllowGC)1> (/usr/lib64/firefox/libxul.so)
+                                       js::Allocate<JSThinInlineString, (js::AllowGC)1> (inlined)
+                                       JSThinInlineString::new_<(js::AllowGC)1> (inlined)
+                                       AllocateInlineString<(js::AllowGC)1, unsigned char> (inlined)
+                                       js::ConcatStrings<(js::AllowGC)1> (/usr/lib64/firefox/libxul.so)
+                                       [0x18b26e6bc2bd] (/tmp/perf-17136.map)
+  #
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script[1]
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 90289f31dd87..74638034861c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -89,6 +89,8 @@ struct trace {
 	u64			base_time;
 	FILE			*output;
 	unsigned long		nr_events;
+	unsigned long		nr_events_printed;
+	unsigned long		max_events;
 	struct strlist		*ev_qualifier;
 	struct {
 		size_t		nr;
@@ -1664,6 +1666,8 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 	printed += fprintf(trace->output, "%-70s) ...\n", ttrace->entry_str);
 	ttrace->entry_pending = false;
 
+	++trace->nr_events_printed;
+
 	return printed;
 }
 
@@ -1940,6 +1944,13 @@ errno_print: {
 
 	fputc('\n', trace->output);
 
+	/*
+	 * We only consider an 'event' for the sake of --max-events a non-filtered
+	 * sys_enter + sys_exit and other tracepoint events.
+	 */
+	if (++trace->nr_events_printed == trace->max_events && trace->max_events != ULONG_MAX)
+		interrupted = true;
+
 	if (callchain_ret > 0)
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
@@ -2072,6 +2083,7 @@ static void bpf_output__fprintf(struct trace *trace,
 {
 	binary__fprintf(sample->raw_data, sample->raw_size, 8,
 			bpf_output__printer, NULL, trace->output);
+	++trace->nr_events_printed;
 }
 
 static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
@@ -2127,6 +2139,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 			event_format__fprintf(evsel->tp_format, sample->cpu,
 					      sample->raw_data, sample->raw_size,
 					      trace->output);
+			++trace->nr_events_printed;
 		}
 	}
 
@@ -2225,6 +2238,8 @@ static int trace__pgfault(struct trace *trace,
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
 		pr_err("Problem processing %s callchain, skipping...\n", perf_evsel__name(evsel));
+
+	++trace->nr_events_printed;
 out:
 	err = 0;
 out_put:
@@ -2402,6 +2417,9 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
 		tracepoint_handler handler = evsel->handler;
 		handler(trace, evsel, event, sample);
 	}
+
+	if (trace->nr_events_printed >= trace->max_events && trace->max_events != ULONG_MAX)
+		interrupted = true;
 }
 
 static int trace__add_syscall_newtp(struct trace *trace)
@@ -3249,6 +3267,7 @@ int cmd_trace(int argc, const char **argv)
 		.trace_syscalls = false,
 		.kernel_syscallchains = false,
 		.max_stack = UINT_MAX,
+		.max_events = ULONG_MAX,
 	};
 	const char *output_name = NULL;
 	const struct option trace_options[] = {
@@ -3301,6 +3320,8 @@ int cmd_trace(int argc, const char **argv)
 		     &record_parse_callchain_opt),
 	OPT_BOOLEAN(0, "kernel-syscall-graph", &trace.kernel_syscallchains,
 		    "Show the kernel callchains on the syscall exit path"),
+	OPT_ULONG(0, "max-events", &trace.max_events,
+		"Set the maximum number of events to print, exit after that is reached. "),
 	OPT_UINTEGER(0, "min-stack", &trace.min_stack,
 		     "Set the minimum stack depth when parsing the callchain, "
 		     "anything below the specified depth will be ignored."),
-- 
2.14.4

