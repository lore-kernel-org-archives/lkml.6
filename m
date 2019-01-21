Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F375BC37124
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7C421721
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115141;
	bh=E0lnm3IkhEWHTmv7ZrdBdsZxCi/30sKFpmwPj/I066A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ITOk/JfHV7ckxQjVX2PxLC4HyAYmh/dCDUIAOHku8jF21AmUjiVolTI/EZe95cAdu
	 Gt84Ke0zlJDs1CBz6HLhFkF2LCX/9/SHxVczLodS6DuNrhL8fptYqQsDdVwqgsdt5V
	 Wvu99zvUFIqSayMlpJVEYCCdARzCTWOUB6nE8YYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfAUX7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:59:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfAUX66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:58:58 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D149217D8;
        Mon, 21 Jan 2019 23:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548115137;
        bh=E0lnm3IkhEWHTmv7ZrdBdsZxCi/30sKFpmwPj/I066A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYifxWf79RzTlFCk+mbxOQJ/ws7aNb5rNxaz/7aI52q4Ub7iJbC+GyVzMbjRMReGw
         RI2jg1Ri1GWOtjiObqBSy4MmeIQkls++np4mg0VsRI3LOA+4xp/+J4vl1mCvfYmNid
         4nQGBD/LfxNsJcQZVYCTlEJkQsq3EyPsym7ZWRBA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        netdev@vger.kernel.org
Subject: [PATCH 19/24] perf tools: Handle PERF_RECORD_BPF_EVENT
Date:   Mon, 21 Jan 2019 20:57:01 -0300
Message-Id: <20190121235706.20005-20-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

This patch adds basic handling of PERF_RECORD_BPF_EVENT.  Tracking of
PERF_RECORD_BPF_EVENT is OFF by default. Option --bpf-event is added to
turn it on.

Committer notes:

Add dummy machine__process_bpf_event() variant that returns zero for
systems without HAVE_LIBBPF_SUPPORT, such as Alpine Linux, unbreaking
the build in such systems.

Remove the needless include <machine.h> from bpf->event.h, provide just
forward declarations for the structs and unions in the parameters, to
reduce compilation time and needless rebuilds when machine.h gets
changed.

Committer testing:

When running with:

 # perf record --bpf-event

On an older kernel where PERF_RECORD_BPF_EVENT and PERF_RECORD_KSYMBOL
is not present, we fallback to removing those two bits from
perf_event_attr, making the tool to continue to work on older kernels:

  perf_event_attr:
    size                             112
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|PERIOD
    read_format                      ID
    disabled                         1
    inherit                          1
    mmap                             1
    comm                             1
    freq                             1
    enable_on_exec                   1
    task                             1
    precise_ip                       3
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
  ------------------------------------------------------------
  sys_perf_event_open: pid 5779  cpu 0  group_fd -1  flags 0x8
  sys_perf_event_open failed, error -22
  switching off bpf_event
  ------------------------------------------------------------
  perf_event_attr:
    size                             112
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|PERIOD
    read_format                      ID
    disabled                         1
    inherit                          1
    mmap                             1
    comm                             1
    freq                             1
    enable_on_exec                   1
    task                             1
    precise_ip                       3
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
  ------------------------------------------------------------
  sys_perf_event_open: pid 5779  cpu 0  group_fd -1  flags 0x8
  sys_perf_event_open failed, error -22
  switching off ksymbol
  ------------------------------------------------------------
  perf_event_attr:
    size                             112
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|PERIOD
    read_format                      ID
    disabled                         1
    inherit                          1
    mmap                             1
    comm                             1
    freq                             1
    enable_on_exec                   1
    task                             1
    precise_ip                       3
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
  ------------------------------------------------------------

And then proceeds to work without those two features.

As passing --bpf-event is an explicit action performed by the user, perhaps we
should emit a warning telling that the kernel has no such feature, but this can
be done on top of this patch.

Now with a kernel that supports these events, start the 'record --bpf-event -a'
and then run 'perf trace sleep 10000' that will use the BPF
augmented_raw_syscalls.o prebuilt (for another kernel version even) and thus
should generate PERF_RECORD_BPF_EVENT events:

  [root@quaco ~]# perf record -e dummy -a --bpf-event
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.713 MB perf.data ]

  [root@quaco ~]# bpftool prog
  13: cgroup_skb  tag 7be49e3934a125ba  gpl
  	loaded_at 2019-01-19T09:09:43-0300  uid 0
  	xlated 296B  jited 229B  memlock 4096B  map_ids 13,14
  14: cgroup_skb  tag 2a142ef67aaad174  gpl
  	loaded_at 2019-01-19T09:09:43-0300  uid 0
  	xlated 296B  jited 229B  memlock 4096B  map_ids 13,14
  15: cgroup_skb  tag 7be49e3934a125ba  gpl
  	loaded_at 2019-01-19T09:09:43-0300  uid 0
  	xlated 296B  jited 229B  memlock 4096B  map_ids 15,16
  16: cgroup_skb  tag 2a142ef67aaad174  gpl
  	loaded_at 2019-01-19T09:09:43-0300  uid 0
  	xlated 296B  jited 229B  memlock 4096B  map_ids 15,16
  17: cgroup_skb  tag 7be49e3934a125ba  gpl
  	loaded_at 2019-01-19T09:09:44-0300  uid 0
  	xlated 296B  jited 229B  memlock 4096B  map_ids 17,18
  18: cgroup_skb  tag 2a142ef67aaad174  gpl
  	loaded_at 2019-01-19T09:09:44-0300  uid 0
  	xlated 296B  jited 229B  memlock 4096B  map_ids 17,18
  21: cgroup_skb  tag 7be49e3934a125ba  gpl
  	loaded_at 2019-01-19T09:09:45-0300  uid 0
  	xlated 296B  jited 229B  memlock 4096B  map_ids 21,22
  22: cgroup_skb  tag 2a142ef67aaad174  gpl
  	loaded_at 2019-01-19T09:09:45-0300  uid 0
  	xlated 296B  jited 229B  memlock 4096B  map_ids 21,22
  31: tracepoint  name sys_enter  tag 12504ba9402f952f  gpl
  	loaded_at 2019-01-19T09:19:56-0300  uid 0
  	xlated 512B  jited 374B  memlock 4096B  map_ids 30,29,28
  32: tracepoint  name sys_exit  tag c1bd85c092d6e4aa  gpl
  	loaded_at 2019-01-19T09:19:56-0300  uid 0
  	xlated 256B  jited 191B  memlock 4096B  map_ids 30,29
  # perf report -D | grep PERF_RECORD_BPF_EVENT | nl
     1	0 55834574849 0x4fc8 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 13
     2	0 60129542145 0x5118 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 14
     3	0 64424509441 0x5268 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 15
     4	0 68719476737 0x53b8 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 16
     5	0 73014444033 0x5508 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 17
     6	0 77309411329 0x5658 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 18
     7	0 90194313217 0x57a8 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 21
     8	0 94489280513 0x58f8 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 22
     9	7 620922484360 0xb6390 [0x30]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 29
    10	7 620922486018 0xb6410 [0x30]: PERF_RECORD_BPF_EVENT bpf event with type 2, flags 0, id 29
    11	7 620922579199 0xb6490 [0x30]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 30
    12	7 620922580240 0xb6510 [0x30]: PERF_RECORD_BPF_EVENT bpf event with type 2, flags 0, id 30
    13	7 620922765207 0xb6598 [0x30]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 31
    14	7 620922874543 0xb6620 [0x30]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 32
  #

There, the 31 and 32 tracepoint BPF programs put in place by 'perf trace'.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@fb.com
Cc: netdev@vger.kernel.org
Link: http://lkml.kernel.org/r/20190117161521.1341602-7-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c |  1 +
 tools/perf/perf.h           |  1 +
 tools/perf/util/Build       |  2 ++
 tools/perf/util/bpf-event.c | 15 +++++++++++++++
 tools/perf/util/bpf-event.h | 22 ++++++++++++++++++++++
 tools/perf/util/event.c     | 20 ++++++++++++++++++++
 tools/perf/util/event.h     | 16 ++++++++++++++++
 tools/perf/util/evsel.c     | 11 ++++++++++-
 tools/perf/util/evsel.h     |  1 +
 tools/perf/util/machine.c   |  3 +++
 tools/perf/util/session.c   |  4 ++++
 tools/perf/util/tool.h      |  3 ++-
 12 files changed, 97 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/bpf-event.c
 create mode 100644 tools/perf/util/bpf-event.h

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 882285fb9f64..deaf9b902094 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1839,6 +1839,7 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "tail-synthesize", &record.opts.tail_synthesize,
 		    "synthesize non-sample events at the end of output"),
 	OPT_BOOLEAN(0, "overwrite", &record.opts.overwrite, "use overwrite mode"),
+	OPT_BOOLEAN(0, "bpf-event", &record.opts.bpf_event, "record bpf events"),
 	OPT_BOOLEAN(0, "strict-freq", &record.opts.strict_freq,
 		    "Fail if the specified frequency can't be used"),
 	OPT_CALLBACK('F', "freq", &record.opts, "freq or 'max'",
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 388c6dd128b8..5941fb6eccfc 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -66,6 +66,7 @@ struct record_opts {
 	bool	     ignore_missing_thread;
 	bool	     strict_freq;
 	bool	     sample_id;
+	bool	     bpf_event;
 	unsigned int freq;
 	unsigned int mmap_pages;
 	unsigned int auxtrace_mmap_pages;
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 3ad6a800948d..c359af408334 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -154,6 +154,8 @@ endif
 
 libperf-y += perf-hooks.o
 
+libperf-$(CONFIG_LIBBPF) += bpf-event.o
+
 libperf-$(CONFIG_CXX) += c++/
 
 CFLAGS_config.o   += -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
new file mode 100644
index 000000000000..87004706874f
--- /dev/null
+++ b/tools/perf/util/bpf-event.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <bpf/bpf.h>
+#include "bpf-event.h"
+#include "debug.h"
+#include "symbol.h"
+
+int machine__process_bpf_event(struct machine *machine __maybe_unused,
+			       union perf_event *event,
+			       struct perf_sample *sample __maybe_unused)
+{
+	if (dump_trace)
+		perf_event__fprintf_bpf_event(event, stdout);
+	return 0;
+}
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
new file mode 100644
index 000000000000..da0dfc035fc6
--- /dev/null
+++ b/tools/perf/util/bpf-event.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_BPF_EVENT_H
+#define __PERF_BPF_EVENT_H
+
+#include <linux/compiler.h>
+
+struct machine;
+union perf_event;
+struct perf_sample;
+
+#ifdef HAVE_LIBBPF_SUPPORT
+int machine__process_bpf_event(struct machine *machine, union perf_event *event,
+			       struct perf_sample *sample);
+#else
+static inline int machine__process_bpf_event(struct machine *machine __maybe_unused,
+					     union perf_event *event __maybe_unused,
+					     struct perf_sample *sample __maybe_unused)
+{
+	return 0;
+}
+#endif // HAVE_LIBBPF_SUPPORT
+#endif
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 3c8a6a8dd260..3b646d27374e 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -25,6 +25,7 @@
 #include "asm/bug.h"
 #include "stat.h"
 #include "session.h"
+#include "bpf-event.h"
 
 #define DEFAULT_PROC_MAP_PARSE_TIMEOUT 500
 
@@ -47,6 +48,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_SWITCH_CPU_WIDE]		= "SWITCH_CPU_WIDE",
 	[PERF_RECORD_NAMESPACES]		= "NAMESPACES",
 	[PERF_RECORD_KSYMBOL]			= "KSYMBOL",
+	[PERF_RECORD_BPF_EVENT]			= "BPF_EVENT",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
@@ -1339,6 +1341,14 @@ int perf_event__process_ksymbol(struct perf_tool *tool __maybe_unused,
 	return machine__process_ksymbol(machine, event, sample);
 }
 
+int perf_event__process_bpf_event(struct perf_tool *tool __maybe_unused,
+				  union perf_event *event,
+				  struct perf_sample *sample __maybe_unused,
+				  struct machine *machine)
+{
+	return machine__process_bpf_event(machine, event, sample);
+}
+
 size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, " %d/%d: [%#" PRIx64 "(%#" PRIx64 ") @ %#" PRIx64 "]: %c %s\n",
@@ -1479,6 +1489,13 @@ size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
 		       event->ksymbol_event.flags, event->ksymbol_event.name);
 }
 
+size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp)
+{
+	return fprintf(fp, " bpf event with type %u, flags %u, id %u\n",
+		       event->bpf_event.type, event->bpf_event.flags,
+		       event->bpf_event.id);
+}
+
 size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 {
 	size_t ret = fprintf(fp, "PERF_RECORD_%s",
@@ -1517,6 +1534,9 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 	case PERF_RECORD_KSYMBOL:
 		ret += perf_event__fprintf_ksymbol(event, fp);
 		break;
+	case PERF_RECORD_BPF_EVENT:
+		ret += perf_event__fprintf_bpf_event(event, fp);
+		break;
 	default:
 		ret += fprintf(fp, "\n");
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 018322f2a13e..dad32b81fe71 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -98,6 +98,16 @@ struct ksymbol_event {
 	char name[KSYM_NAME_LEN];
 };
 
+struct bpf_event {
+	struct perf_event_header header;
+	u16 type;
+	u16 flags;
+	u32 id;
+
+	/* for bpf_prog types */
+	u8 tag[BPF_TAG_SIZE];  // prog tag
+};
+
 #define PERF_SAMPLE_MASK				\
 	(PERF_SAMPLE_IP | PERF_SAMPLE_TID |		\
 	 PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR |		\
@@ -666,6 +676,7 @@ union perf_event {
 	struct time_conv_event		time_conv;
 	struct feature_event		feat;
 	struct ksymbol_event		ksymbol_event;
+	struct bpf_event		bpf_event;
 };
 
 void perf_event__print_totals(void);
@@ -767,6 +778,10 @@ int perf_event__process_ksymbol(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
 				struct machine *machine);
+int perf_event__process_bpf_event(struct perf_tool *tool,
+				  union perf_event *event,
+				  struct perf_sample *sample,
+				  struct machine *machine);
 int perf_tool__process_synth_event(struct perf_tool *tool,
 				   union perf_event *event,
 				   struct machine *machine,
@@ -831,6 +846,7 @@ size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, FILE *fp);
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9c8dc6d1aa7f..684c893ca6bc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1036,6 +1036,8 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	attr->mmap2 = track && !perf_missing_features.mmap2;
 	attr->comm  = track;
 	attr->ksymbol = track && !perf_missing_features.ksymbol;
+	attr->bpf_event = track && opts->bpf_event &&
+		!perf_missing_features.bpf_event;
 
 	if (opts->record_namespaces)
 		attr->namespaces  = track;
@@ -1654,6 +1656,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(write_backward, p_unsigned);
 	PRINT_ATTRf(namespaces, p_unsigned);
 	PRINT_ATTRf(ksymbol, p_unsigned);
+	PRINT_ATTRf(bpf_event, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
@@ -1815,6 +1818,8 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 		evsel->attr.read_format &= ~(PERF_FORMAT_GROUP|PERF_FORMAT_ID);
 	if (perf_missing_features.ksymbol)
 		evsel->attr.ksymbol = 0;
+	if (perf_missing_features.bpf_event)
+		evsel->attr.bpf_event = 0;
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
 		evsel->attr.sample_id_all = 0;
@@ -1934,7 +1939,11 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.ksymbol && evsel->attr.ksymbol) {
+	if (!perf_missing_features.bpf_event && evsel->attr.bpf_event) {
+		perf_missing_features.bpf_event = true;
+		pr_debug2("switching off bpf_event\n");
+		goto fallback_missing_features;
+	} else if (!perf_missing_features.ksymbol && evsel->attr.ksymbol) {
 		perf_missing_features.ksymbol = true;
 		pr_debug2("switching off ksymbol\n");
 		goto fallback_missing_features;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 4a8c3e7f4808..29c5eb68c44b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -169,6 +169,7 @@ struct perf_missing_features {
 	bool write_backward;
 	bool group_read;
 	bool ksymbol;
+	bool bpf_event;
 };
 
 extern struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 9bca61c7d5bf..ae85106bb5bf 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -21,6 +21,7 @@
 #include "unwind.h"
 #include "linux/hash.h"
 #include "asm/bug.h"
+#include "bpf-event.h"
 
 #include "sane_ctype.h"
 #include <symbol/kallsyms.h>
@@ -1867,6 +1868,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 		ret = machine__process_switch_event(machine, event); break;
 	case PERF_RECORD_KSYMBOL:
 		ret = machine__process_ksymbol(machine, event, sample); break;
+	case PERF_RECORD_BPF_EVENT:
+		ret = machine__process_bpf_event(machine, event, sample); break;
 	default:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index dcfacfb036a3..24fd62528a33 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -381,6 +381,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->context_switch = perf_event__process_switch;
 	if (tool->ksymbol == NULL)
 		tool->ksymbol = perf_event__process_ksymbol;
+	if (tool->bpf_event == NULL)
+		tool->bpf_event = perf_event__process_bpf_event;
 	if (tool->read == NULL)
 		tool->read = process_event_sample_stub;
 	if (tool->throttle == NULL)
@@ -1314,6 +1316,8 @@ static int machines__deliver_event(struct machines *machines,
 		return tool->context_switch(tool, event, sample, machine);
 	case PERF_RECORD_KSYMBOL:
 		return tool->ksymbol(tool, event, sample, machine);
+	case PERF_RECORD_BPF_EVENT:
+		return tool->bpf_event(tool, event, sample, machine);
 	default:
 		++evlist->stats.nr_unknown_events;
 		return -1;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 9c81ca2f3cf7..250391672f9f 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -54,7 +54,8 @@ struct perf_tool {
 			context_switch,
 			throttle,
 			unthrottle,
-			ksymbol;
+			ksymbol,
+			bpf_event;
 
 	event_attr_op	attr;
 	event_attr_op	event_update;
-- 
2.20.1

