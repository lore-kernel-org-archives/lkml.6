Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A77FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F411D21841
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550712406;
	bh=eQsFJ4ta6QcKrEfKA1qvHa8R6TEzhEbKBJlhyNAoz0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DHPHkDS1Ogz2UizG4duWRAmrkE8AAdJGU8q9DO4Y6+EhswfPXrEpq4Py/rC1SJHqc
	 PDVRfJkA9PJvtXN6GVZoNZsPI5KeQy6OB2Px2dvzn6LHOCWhPhURP0JQg0URI8/myg
	 m9U9lUXjnigGeXPWxTpbtL8fbOjUxvi1J60tnuhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfBUB0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:26:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbfBUB0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:26:42 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.102.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24186214AF;
        Thu, 21 Feb 2019 01:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550712401;
        bh=eQsFJ4ta6QcKrEfKA1qvHa8R6TEzhEbKBJlhyNAoz0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uvdgwg7EeRpNycQML9uqfXupv2oKAeY8BcwQnh5HMw+o0ZpIt+R95K3k+JhQ91sTX
         az7qhAxC6e/DhCplHyMLYdlObeVfMx+1K03KmqznQG3COFcZEG+Ijsxjcd1skRwEy4
         M804NfJbktxKr6rWwyymJnvMVUtWou/8wKKYFioA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 11/17] perf trace: Allow dumping a BPF map after setting up BPF events
Date:   Wed, 20 Feb 2019 22:25:43 -0300
Message-Id: <20190221012549.4069-12-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Initial use case:

Dumping the maps setup by tools/perf/examples/bpf/augmented_raw_syscalls.c,
which so far are just booleans, showing just non-zeroed entries:

  # cat ~/.perfconfig
  [llvm]
	dump-obj = true
	clang-opt = -g
  [trace]
	#add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
	add_events = /wb/augmented_raw_syscalls.o
  $ date
  Tue Feb 19 16:29:33 -03 2019
  $ ls -la /wb/augmented_raw_syscalls.o
  -rwxr-xr-x. 1 root root 14048 Jan 24 12:09 /wb/augmented_raw_syscalls.o
  $ file /wb/augmented_raw_syscalls.o
  /wb/augmented_raw_syscalls.o: ELF 64-bit LSB relocatable, eBPF, version 1 (SYSV), with debug_info, not stripped
  $
  # trace -e recvmmsg,sendmmsg --map-dump foobar
  ERROR: BPF map "foobar" not found
  # trace -e recvmmsg,sendmmsg --map-dump filtered_pids
  ERROR: BPF map "filtered_pids" not found
  # trace -e recvmmsg,sendmmsg --map-dump pids_filtered
  [2583] = 1,
  [2267] = 1,
  ^Z
  [1]+  Stopped                 trace -e recvmmsg,sendmmsg --map-dump pids_filtered
  # pidof trace
  2267
  # ps ax|grep gnome-terminal|grep -v grep
  2583 ?        Ssl   58:33 /usr/libexec/gnome-terminal-server
  ^C
  # trace -e recvmmsg,sendmmsg --map-dump syscalls
  [299] = 1,
  [307] = 1,
  ^C
  # grep x64_recvmmsg arch/x86/entry/syscalls/syscall_64.tbl
  299	64	recvmmsg		__x64_sys_recvmmsg
  # grep x64_sendmmsg arch/x86/entry/syscalls/syscall_64.tbl
  307	64	sendmmsg		__x64_sys_sendmmsg
  #

Next step probably will be something like 'perf stat's --interval-print and
--interval-clear.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-ztxj25rtx37ixo9cfajt8ocy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-trace.txt |  8 ++++++++
 tools/perf/builtin-trace.c              | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 631e687be4eb..fc6e43262c41 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -210,6 +210,14 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	may happen, for instance, when a thread gets migrated to a different CPU
 	while processing a syscall.
 
+--map-dump::
+	Dump BPF maps setup by events passed via -e, for instance the augmented_raw_syscalls
+	living in tools/perf/examples/bpf/augmented_raw_syscalls.c. For now this
+	dumps just boolean map values and integer keys, in time this will print in hex
+	by default and use BTF when available, as well as use functions to do pretty
+	printing using the existing 'perf trace' syscall arg beautifiers to map integer
+	arguments to strings (pid to comm, syscall id to syscall name, etc).
+
 
 PAGEFAULTS
 ----------
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 68a01e624ad3..1a11fe656afc 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -19,6 +19,7 @@
 #include <traceevent/event-parse.h>
 #include <api/fs/tracing_path.h>
 #include <bpf/bpf.h>
+#include "util/bpf_map.h"
 #include "builtin.h"
 #include "util/cgroup.h"
 #include "util/color.h"
@@ -87,6 +88,9 @@ struct trace {
 					  *augmented;
 		}		events;
 	} syscalls;
+	struct {
+		struct bpf_map *map;
+	} dump;
 	struct record_opts	opts;
 	struct perf_evlist	*evlist;
 	struct machine		*host;
@@ -2997,6 +3001,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (err < 0)
 		goto out_error_apply_filters;
 
+	if (trace->dump.map)
+		bpf_map__fprintf(trace->dump.map, trace->output);
+
 	err = perf_evlist__mmap(evlist, trace->opts.mmap_pages);
 	if (err < 0)
 		goto out_error_mmap;
@@ -3686,6 +3693,7 @@ int cmd_trace(int argc, const char **argv)
 		.max_stack = UINT_MAX,
 		.max_events = ULONG_MAX,
 	};
+	const char *map_dump_str = NULL;
 	const char *output_name = NULL;
 	const struct option trace_options[] = {
 	OPT_CALLBACK('e', "event", &trace, "event",
@@ -3718,6 +3726,9 @@ int cmd_trace(int argc, const char **argv)
 	OPT_CALLBACK(0, "duration", &trace, "float",
 		     "show only events with duration > N.M ms",
 		     trace__set_duration),
+#ifdef HAVE_LIBBPF_SUPPORT
+	OPT_STRING(0, "map-dump", &map_dump_str, "BPF map", "BPF map to periodically dump"),
+#endif
 	OPT_BOOLEAN(0, "sched", &trace.sched, "show blocking scheduler events"),
 	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 	OPT_BOOLEAN('T', "time", &trace.full_time,
@@ -3812,6 +3823,14 @@ int cmd_trace(int argc, const char **argv)
 
 	err = -1;
 
+	if (map_dump_str) {
+		trace.dump.map = bpf__find_map_by_name(map_dump_str);
+		if (trace.dump.map == NULL) {
+			pr_err("ERROR: BPF map \"%s\" not found\n", map_dump_str);
+			goto out;
+		}
+	}
+
 	if (trace.trace_pgfaults) {
 		trace.opts.sample_address = true;
 		trace.opts.sample_time = true;
-- 
2.19.1

