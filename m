Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13C1C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733AD2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbfACNMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:12:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52883 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfACNMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:12:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DBoLh1383806
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:11:50 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DBoD91383803;
        Thu, 3 Jan 2019 05:11:50 -0800
Date:   Thu, 3 Jan 2019 05:11:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-2pqavrktqkliu5b9nzouio21@git.kernel.org>
Cc:     jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        acme@redhat.com, lclaudio@redhat.com, hpa@zytor.com,
        wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, adrian.hunter@intel.com
Reply-To: tglx@linutronix.de, namhyung@kernel.org, jolsa@kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, wangnan0@huawei.com, hpa@zytor.com,
          lclaudio@redhat.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Do not hardcode the size of the
 tracepoint common_ fields
Git-Commit-ID: b9b6a2ea2baf69204a6e5f311e0d24fe3b956f2e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b9b6a2ea2baf69204a6e5f311e0d24fe3b956f2e
Gitweb:     https://git.kernel.org/tip/b9b6a2ea2baf69204a6e5f311e0d24fe3b956f2e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 19 Dec 2018 18:54:36 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 21 Dec 2018 09:42:46 -0300

perf trace: Do not hardcode the size of the tracepoint common_ fields

We shouldn't hardcode the size of the tracepoint common_ fields, use the
offset of the 'id'/'__syscallnr' field in the sys_enter event instead.

This caused the augmented syscalls code to fail on a particular build of a
PREEMPT_RT_FULL kernel where these extra 'common_migrate_disable' and
'common_padding' fields were before the syscall id one:

  # cat /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/format
  name: sys_enter
  ID: 22
  format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;
	field:unsigned short common_migrate_disable;	offset:8;	size:2;	signed:0;
	field:unsigned short common_padding;	offset:10;	size:2;	signed:0;

	field:long id;	offset:16;	size:8;	signed:1;
	field:unsigned long args[6];	offset:24;	size:48;	signed:0;

  print fmt: "NR %ld (%lx, %lx, %lx, %lx, %lx, %lx)", REC->id, REC->args[0], REC->args[1], REC->args[2], REC->args[3], REC->args[4], REC->args[5]
  #

All those 'common_' prefixed fields are zeroed when they hit a BPF tracepoint
hook, we better just discard those, i.e. somehow pass an offset to the
BPF program from the start of the ctx and make adjustments in the 'perf trace'
handlers to adjust the offset of the syscall arg offsets obtained from tracefs.

Till then, fix it the quick way and add this to the augmented_raw_syscalls.c to
bet it to work in such kernels:

  diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
  index 53c233370fae..1f746f931e13 100644
  --- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
  +++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
  @@ -38,12 +38,14 @@ struct bpf_map SEC("maps") syscalls = {

   struct syscall_enter_args {
          unsigned long long common_tp_fields;
  +       long               rt_common_tp_fields;
          long               syscall_nr;
          unsigned long      args[6];
   };

   struct syscall_exit_args {
          unsigned long long common_tp_fields;
  +       long               rt_common_tp_fields;
          long               syscall_nr;
          long               ret;
   };

Just to check that this was the case. Fix it properly later, for now remove the
hardcoding of the offset in the 'perf trace' side and document the situation
with this patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2pqavrktqkliu5b9nzouio21@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 73 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6689c1a114fe..1e9e886b2811 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -112,8 +112,9 @@ struct trace {
 	} stats;
 	unsigned int		max_stack;
 	unsigned int		min_stack;
-	bool			sort_events;
+	int			raw_augmented_syscalls_args_size;
 	bool			raw_augmented_syscalls;
+	bool			sort_events;
 	bool			not_ev_qualifier;
 	bool			live;
 	bool			full_time;
@@ -283,12 +284,17 @@ out_delete:
 	return -ENOENT;
 }
 
-static int perf_evsel__init_augmented_syscall_tp(struct perf_evsel *evsel)
+static int perf_evsel__init_augmented_syscall_tp(struct perf_evsel *evsel, struct perf_evsel *tp)
 {
 	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
 
-	if (evsel->priv != NULL) {       /* field, sizeof_field, offsetof_field */
-		if (__tp_field__init_uint(&sc->id, sizeof(long), sizeof(long long), evsel->needs_swap))
+	if (evsel->priv != NULL) {
+		struct tep_format_field *syscall_id = perf_evsel__field(tp, "id");
+		if (syscall_id == NULL)
+			syscall_id = perf_evsel__field(tp, "__syscall_nr");
+		if (syscall_id == NULL)
+			goto out_delete;
+		if (__tp_field__init_uint(&sc->id, syscall_id->size, syscall_id->offset, evsel->needs_swap))
 			goto out_delete;
 
 		return 0;
@@ -1768,16 +1774,16 @@ static int trace__fprintf_sample(struct trace *trace, struct perf_evsel *evsel,
 	return printed;
 }
 
-static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sample, int *augmented_args_size, bool raw_augmented)
+static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sample, int *augmented_args_size, int raw_augmented_args_size)
 {
 	void *augmented_args = NULL;
 	/*
 	 * For now with BPF raw_augmented we hook into raw_syscalls:sys_enter
-	 * and there we get all 6 syscall args plus the tracepoint common
-	 * fields (sizeof(long)) and the syscall_nr (another long). So we check
-	 * if that is the case and if so don't look after the sc->args_size,
-	 * but always after the full raw_syscalls:sys_enter payload, which is
-	 * fixed.
+	 * and there we get all 6 syscall args plus the tracepoint common fields
+	 * that gets calculated at the start and the syscall_nr (another long).
+	 * So we check if that is the case and if so don't look after the
+	 * sc->args_size but always after the full raw_syscalls:sys_enter payload,
+	 * which is fixed.
 	 *
 	 * We'll revisit this later to pass s->args_size to the BPF augmenter
 	 * (now tools/perf/examples/bpf/augmented_raw_syscalls.c, so that it
@@ -1785,7 +1791,7 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
 	 * use syscalls:sys_enter_NAME, so that we reduce the kernel/userspace
 	 * traffic to just what is needed for each syscall.
 	 */
-	int args_size = raw_augmented ? (8 * (int)sizeof(long)) : sc->args_size;
+	int args_size = raw_augmented_args_size ?: sc->args_size;
 
 	*augmented_args_size = sample->raw_size - args_size;
 	if (*augmented_args_size > 0)
@@ -1839,7 +1845,7 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 	 * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
 	 */
 	if (evsel != trace->syscalls.events.sys_enter)
-		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls);
+		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
 	ttrace->entry_time = sample->time;
 	msg = ttrace->entry_str;
 	printed += scnprintf(msg + printed, trace__entry_str_size - printed, "%s(", sc->name);
@@ -1897,7 +1903,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evse
 		goto out_put;
 
 	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
-	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls);
+	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
 	syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
 	fprintf(trace->output, "%s", msg);
 	err = 0;
@@ -3814,13 +3820,6 @@ int cmd_trace(int argc, const char **argv)
 	 * syscall.
 	 */
 	if (trace.syscalls.events.augmented) {
-		evsel = trace.syscalls.events.augmented;
-
-		if (perf_evsel__init_augmented_syscall_tp(evsel) ||
-		    perf_evsel__init_augmented_syscall_tp_args(evsel))
-			goto out;
-		evsel->handler = trace__sys_enter;
-
 		evlist__for_each_entry(trace.evlist, evsel) {
 			bool raw_syscalls_sys_exit = strcmp(perf_evsel__name(evsel), "raw_syscalls:sys_exit") == 0;
 
@@ -3829,9 +3828,41 @@ int cmd_trace(int argc, const char **argv)
 				goto init_augmented_syscall_tp;
 			}
 
+			if (strcmp(perf_evsel__name(evsel), "raw_syscalls:sys_enter") == 0) {
+				struct perf_evsel *augmented = trace.syscalls.events.augmented;
+				if (perf_evsel__init_augmented_syscall_tp(augmented, evsel) ||
+				    perf_evsel__init_augmented_syscall_tp_args(augmented))
+					goto out;
+				augmented->handler = trace__sys_enter;
+			}
+
 			if (strstarts(perf_evsel__name(evsel), "syscalls:sys_exit_")) {
+				struct syscall_tp *sc;
 init_augmented_syscall_tp:
-				perf_evsel__init_augmented_syscall_tp(evsel);
+				if (perf_evsel__init_augmented_syscall_tp(evsel, evsel))
+					goto out;
+				sc = evsel->priv;
+				/*
+				 * For now with BPF raw_augmented we hook into
+				 * raw_syscalls:sys_enter and there we get all
+				 * 6 syscall args plus the tracepoint common
+				 * fields and the syscall_nr (another long).
+				 * So we check if that is the case and if so
+				 * don't look after the sc->args_size but
+				 * always after the full raw_syscalls:sys_enter
+				 * payload, which is fixed.
+				 *
+				 * We'll revisit this later to pass
+				 * s->args_size to the BPF augmenter (now
+				 * tools/perf/examples/bpf/augmented_raw_syscalls.c,
+				 * so that it copies only what we need for each
+				 * syscall, like what happens when we use
+				 * syscalls:sys_enter_NAME, so that we reduce
+				 * the kernel/userspace traffic to just what is
+				 * needed for each syscall.
+				 */
+				if (trace.raw_augmented_syscalls)
+					trace.raw_augmented_syscalls_args_size = (6 + 1) * sizeof(long) + sc->id.offset;
 				perf_evsel__init_augmented_syscall_tp_ret(evsel);
 				evsel->handler = trace__sys_exit;
 			}
