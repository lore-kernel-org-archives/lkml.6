Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112E8C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7D720844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7D720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeIFRoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:44:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45831 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeIFRoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:44:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86D8mlP303744
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:08:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86D8liP303740;
        Thu, 6 Sep 2018 06:08:47 -0700
Date:   Thu, 6 Sep 2018 06:08:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-epz6y9i0eavmerc5ha98t7gn@git.kernel.org>
Cc:     jolsa@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
        wangnan0@huawei.com, dsahern@gmail.com, namhyung@kernel.org,
        acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          namhyung@kernel.org, dsahern@gmail.com, wangnan0@huawei.com,
          acme@redhat.com, tglx@linutronix.de, adrian.hunter@intel.com,
          jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Print the syscall name for
 augmented_syscalls
Git-Commit-ID: 1cdf618f23867dd1dae58f10f1f82839f2bf73b4
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

Commit-ID:  1cdf618f23867dd1dae58f10f1f82839f2bf73b4
Gitweb:     https://git.kernel.org/tip/1cdf618f23867dd1dae58f10f1f82839f2bf73b4
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 Aug 2018 11:44:23 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:19 -0300

perf trace: Print the syscall name for augmented_syscalls

Since we copy all the payload for raw_syscalls:sys_enter plus add
expanded pointers, we can use the syscall id to get its name, etc:

  # grep 'field:.* id' /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/format
	field:long id;	offset:8;	size:8;	signed:1;
  #

Before:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): __augmented_syscalls__:dfd: CWD, filename: 0xec9f9da8, flags: CLOEXEC
     0.006 ( 0.006 ms): cat/2395 openat(dfd: CWD, filename: 0xec9f9da8, flags: CLOEXEC) = 3
     0.041 (         ): __augmented_syscalls__:dfd: CWD, filename: 0xecc01ce0, flags: CLOEXEC
     0.042 ( 0.007 ms): cat/2395 openat(dfd: CWD, filename: 0xecc01ce0, flags: CLOEXEC) = 3
     0.376 (         ): __augmented_syscalls__:dfd: CWD, filename: 0xac0a806b
     0.379 ( 0.006 ms): cat/2395 openat(dfd: CWD, filename: 0xac0a806b) = 3
  #

After:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): openat(dfd: CWD, filename: 0x31b6dda8, flags: CLOEXEC)
     0.009 ( 0.009 ms): cat/3619 openat(dfd: CWD, filename: 0x31b6dda8, flags: CLOEXEC) = 3
     0.051 (         ): openat(dfd: CWD, filename: 0x31d75ce0, flags: CLOEXEC)
     0.054 ( 0.010 ms): cat/3619 openat(dfd: CWD, filename: 0x31d75ce0, flags: CLOEXEC) = 3
     0.539 (         ): openat(dfd: CWD, filename: 0xca71506b)
     0.543 ( 0.115 ms): cat/3619 openat(dfd: CWD, filename: 0xca71506b) = 3
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-epz6y9i0eavmerc5ha98t7gn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7deae6c8cb25..bcf882afd6d0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2055,13 +2055,33 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 	if (trace->trace_syscalls)
 		fprintf(trace->output, "(         ): ");
 
+	if (evsel == trace->syscalls.events.augmented) {
+		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
+		struct syscall *sc = trace__syscall_info(trace, evsel, id);
+
+		if (sc) {
+			struct thread *thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
+
+			if (thread) {
+				fprintf(trace->output, "%s(", sc->name);
+				trace__fprintf_sys_enter(trace, evsel, sample);
+				fputc(')', trace->output);
+				thread__put(thread);
+				goto newline;
+			}
+		}
+
+		/*
+		 * XXX: Not having the associated syscall info or not finding/adding
+		 * 	the thread should never happen, but if it does...
+		 * 	fall thru and print it as a bpf_output event.
+		 */
+	}
+
 	fprintf(trace->output, "%s:", evsel->name);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
-		if (evsel == trace->syscalls.events.augmented)
-			trace__fprintf_sys_enter(trace, evsel, sample);
-		else
-			bpf_output__fprintf(trace, sample);
+		bpf_output__fprintf(trace, sample);
 	} else if (evsel->tp_format) {
 		if (strncmp(evsel->tp_format->name, "sys_enter_", 10) ||
 		    trace__fprintf_sys_enter(trace, evsel, sample)) {
@@ -2071,6 +2091,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 		}
 	}
 
+newline:
 	fprintf(trace->output, "\n");
 
 	if (callchain_ret > 0)
