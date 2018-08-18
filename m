Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B689C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31FE21878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31FE21878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeHRO1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:27:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33593 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRO1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:27:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBJlTt1283448
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:19:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBJlvx1283445;
        Sat, 18 Aug 2018 04:19:47 -0700
Date:   Sat, 18 Aug 2018 04:19:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-jehyd2zwhw00z3p7v7mg9632@git.kernel.org>
Cc:     namhyung@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, jolsa@kernel.org, acme@redhat.com,
        wangnan0@huawei.com, dsahern@gmail.com, tglx@linutronix.de,
        rostedt@goodmis.org, mingo@kernel.org
Reply-To: wangnan0@huawei.com, dsahern@gmail.com, tglx@linutronix.de,
          rostedt@goodmis.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          adrian.hunter@intel.com, hpa@zytor.com, jolsa@kernel.org,
          acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Use beautifiers on
 syscalls:sys_enter_ handlers
Git-Commit-ID: a98392bb1e169a04aad83ed28f2b7a63010104ec
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

Commit-ID:  a98392bb1e169a04aad83ed28f2b7a63010104ec
Gitweb:     https://git.kernel.org/tip/a98392bb1e169a04aad83ed28f2b7a63010104ec
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 2 Aug 2018 14:05:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 Aug 2018 15:07:19 -0300

perf trace: Use beautifiers on syscalls:sys_enter_ handlers

We were using the beautifiers only when processing the
raw_syscalls:sys_enter events, but we can as well use them for the
syscalls:sys_enter_NAME events, as the layout is the same.

Some more tweaking is needed as we're processing them straight away,
i.e. there is no buffering in the sys_enter_NAME event to wait for
things like vfs_getname to provide pointer contents and then flushing
at sys_exit_NAME, so we need to state in the syscall_arg that this
is unbuffered, just print the pointer values, beautifying just
non-pointer syscall args.

This just shows an alternative way of processing tracepoints, that we
will end up using when creating "tracepoint" payloads that already copy
pointer contents (or chunks of it, i.e. not the whole filename, but just
the end of it, not all the bf for a read/write, but just the start,
etc), directly in the kernel using eBPF.

E.g.:

  # perf trace -e syscalls:*enter*sleep,*sleep sleep 1
     0.303 (         ): syscalls:sys_enter_nanosleep:rqtp: 0x7ffc93d5ecc0
     0.305 (1000.229 ms): sleep/8746 nanosleep(rqtp: 0x7ffc93d5ecc0) = 0
  # perf trace -e syscalls:*_*sleep,*sleep sleep 1
     0.288 (         ): syscalls:sys_enter_nanosleep:rqtp: 0x7ffecde87e40
     0.289 (         ): sleep/8748 nanosleep(rqtp: 0x7ffecde87e40) ...
  1000.479 (         ): syscalls:sys_exit_nanosleep:0x0
     0.289 (1000.208 ms): sleep/8748  ... [continued]: nanosleep()) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-jehyd2zwhw00z3p7v7mg9632@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 47 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2a85f5198da0..7336552c22cf 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1666,6 +1666,44 @@ out_put:
 	return err;
 }
 
+static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evsel,
+				    struct perf_sample *sample)
+{
+	struct format_field *field = perf_evsel__field(evsel, "__syscall_nr");
+	struct thread_trace *ttrace;
+	struct thread *thread;
+	struct syscall *sc;
+	char msg[1024];
+	int id, err = -1;
+	void *args;
+
+	if (field == NULL)
+		return -1;
+
+	id = format_field__intval(field, sample, evsel->needs_swap);
+	sc = trace__syscall_info(trace, evsel, id);
+
+	if (sc == NULL)
+		return -1;
+
+	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
+	ttrace = thread__trace(thread, trace->output);
+	/*
+	 * We need to get ttrace just to make sure it is there when syscall__scnprintf_args()
+	 * and the rest of the beautifiers accessing it via struct syscall_arg touches it.
+	 */
+	if (ttrace == NULL)
+		goto out_put;
+
+	args = sample->raw_data + field->offset + sizeof(u64); /* skip __syscall_nr, there is where args are */
+	syscall__scnprintf_args(sc, msg, sizeof(msg), args, trace, thread);
+	fprintf(trace->output, "%s", msg);
+	err = 0;
+out_put:
+	thread__put(thread);
+	return err;
+}
+
 static int trace__resolve_callchain(struct trace *trace, struct perf_evsel *evsel,
 				    struct perf_sample *sample,
 				    struct callchain_cursor *cursor)
@@ -1964,9 +2002,12 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 	if (perf_evsel__is_bpf_output(evsel)) {
 		bpf_output__fprintf(trace, sample);
 	} else if (evsel->tp_format) {
-		event_format__fprintf(evsel->tp_format, sample->cpu,
-				      sample->raw_data, sample->raw_size,
-				      trace->output);
+		if (strncmp(evsel->tp_format->name, "sys_enter_", 10) ||
+		    trace__fprintf_sys_enter(trace, evsel, sample)) {
+			event_format__fprintf(evsel->tp_format, sample->cpu,
+					      sample->raw_data, sample->raw_size,
+					      trace->output);
+		}
 	}
 
 	fprintf(trace->output, "\n");
