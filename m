Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBDAC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A89C2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A89C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbeIFR4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:56:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53119 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbeIFR4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:56:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DKXBx305594
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:20:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DKXha305591;
        Thu, 6 Sep 2018 06:20:33 -0700
Date:   Thu, 6 Sep 2018 06:20:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-us1mwsupxffs4jlm3uqm5dvj@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
        wangnan0@huawei.com, adrian.hunter@intel.com, jolsa@kernel.org,
        hpa@zytor.com, dsahern@gmail.com
Reply-To: namhyung@kernel.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
          wangnan0@huawei.com, adrian.hunter@intel.com, dsahern@gmail.com,
          hpa@zytor.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Show comm and tid for tracepoint events
Git-Commit-ID: c4191e55b8741f72d44c7c1435c340681ae1ea4e
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

Commit-ID:  c4191e55b8741f72d44c7c1435c340681ae1ea4e
Gitweb:     https://git.kernel.org/tip/c4191e55b8741f72d44c7c1435c340681ae1ea4e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 30 Aug 2018 13:37:28 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:21 -0300

perf trace: Show comm and tid for tracepoint events

So that all events have that info, improving reading by having
information better aligned, etc.

Before:

  # echo 1 > /proc/sys/vm/drop_caches
  # perf trace -e block:*,ext4:*,tools/perf/examples/bpf/augmented_syscalls.c,close cat tools/perf/examples/bpf/hello.c
       0.000 (         ): #include <stdio.h>

  int syscall_enter(openat)(void *args)
  {
  	puts("Hello, world\n");
  	return 0;
  }

  license(GPL);
  cat/2731 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
       0.025 (         ): syscalls:sys_exit_openat:0x3
       0.063 ( 0.022 ms): cat/2731 close(fd: 3) = 0
       0.110 (         ): cat/2731 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC)
       0.123 (         ): syscalls:sys_exit_openat:0x3
       0.243 ( 0.008 ms): cat/2731 close(fd: 3) = 0
       0.485 (         ): cat/2731 open(filename: /usr/lib/locale/locale-archive, flags: CLOEXEC)
       0.500 (         ): syscalls:sys_exit_open:0x3
       0.531 ( 0.017 ms): cat/2731 close(fd: 3) = 0
       0.587 (         ): cat/2731 openat(dfd: CWD, filename: tools/perf/examples/bpf/hello.c)
       0.601 (         ): syscalls:sys_exit_openat:0x3
       0.631 (         ): ext4:ext4_es_lookup_extent_enter:dev 253,2 ino 1311399 lblk 0
       0.639 (         ): ext4:ext4_es_lookup_extent_exit:dev 253,2 ino 1311399 found 1 [0/1) 5276651 W0x10
       0.654 (         ): block:block_bio_queue:253,2 R 42213208 + 8 [cat]
       0.663 (         ): block:block_bio_remap:8,0 R 58206040 + 8 <- (253,2) 42213208
       0.671 (         ): block:block_bio_remap:8,0 R 175570776 + 8 <- (8,6) 58206040
       0.678 (         ): block:block_bio_queue:8,0 R 175570776 + 8 [cat]
       0.692 (         ): block:block_getrq:8,0 R 175570776 + 8 [cat]
       0.700 (         ): block:block_plug:[cat]
       0.708 (         ): block:block_rq_insert:8,0 R 4096 () 175570776 + 8 [cat]
       0.713 (         ): block:block_unplug:[cat] 1
       0.716 (         ): block:block_rq_issue:8,0 R 4096 () 175570776 + 8 [cat]
       0.949 ( 0.007 ms): cat/2731 close(fd: 3) = 0
       0.969 ( 0.006 ms): cat/2731 close(fd: 1) = 0
       0.982 ( 0.006 ms): cat/2731 close(fd: 2) = 0
  #

After:

  # echo 1 > /proc/sys/vm/drop_caches
  # perf trace -e block:*,ext4:*,tools/perf/examples/bpf/augmented_syscalls.c,close cat tools/perf/examples/bpf/hello.c
       0.000 (         ): cat/1380 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)#include <stdio.h>

  int syscall_enter(openat)(void *args)
  {
  	puts("Hello, world\n");
  	return 0;
  }

  license(GPL);

       0.024 (         ): cat/1380 syscalls:sys_exit_openat:0x3
       0.063 ( 0.024 ms): cat/1380 close(fd: 3) = 0
       0.114 (         ): cat/1380 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC)
       0.127 (         ): cat/1380 syscalls:sys_exit_openat:0x3
       0.247 ( 0.009 ms): cat/1380 close(fd: 3) = 0
       0.484 (         ): cat/1380 open(filename: /usr/lib/locale/locale-archive, flags: CLOEXEC)
       0.499 (         ): cat/1380 syscalls:sys_exit_open:0x3
       0.613 ( 0.010 ms): cat/1380 close(fd: 3) = 0
       0.662 (         ): cat/1380 openat(dfd: CWD, filename: tools/perf/examples/bpf/hello.c)
       0.678 (         ): cat/1380 syscalls:sys_exit_openat:0x3
       0.712 (         ): cat/1380 ext4:ext4_es_lookup_extent_enter:dev 253,2 ino 1311399 lblk 0
       0.721 (         ): cat/1380 ext4:ext4_es_lookup_extent_exit:dev 253,2 ino 1311399 found 1 [0/1) 5276651 W0x10
       0.734 (         ): cat/1380 block:block_bio_queue:253,2 R 42213208 + 8 [cat]
       0.745 (         ): cat/1380 block:block_bio_remap:8,0 R 58206040 + 8 <- (253,2) 42213208
       0.754 (         ): cat/1380 block:block_bio_remap:8,0 R 175570776 + 8 <- (8,6) 58206040
       0.761 (         ): cat/1380 block:block_bio_queue:8,0 R 175570776 + 8 [cat]
       0.780 (         ): cat/1380 block:block_getrq:8,0 R 175570776 + 8 [cat]
       0.791 (         ): cat/1380 block:block_plug:[cat]
       0.802 (         ): cat/1380 block:block_rq_insert:8,0 R 4096 () 175570776 + 8 [cat]
       0.806 (         ): cat/1380 block:block_unplug:[cat] 1
       0.810 (         ): cat/1380 block:block_rq_issue:8,0 R 4096 () 175570776 + 8 [cat]
       1.005 ( 0.011 ms): cat/1380 close(fd: 3) = 0
       1.031 ( 0.008 ms): cat/1380 close(fd: 1) = 0
       1.048 ( 0.008 ms): cat/1380 close(fd: 2) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-us1mwsupxffs4jlm3uqm5dvj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 759d14e3fe6b..97ace635bed8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2049,6 +2049,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 				union perf_event *event __maybe_unused,
 				struct perf_sample *sample)
 {
+	struct thread *thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
 	int callchain_ret = 0;
 
 	if (sample->callchain) {
@@ -2066,21 +2067,18 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 	if (trace->trace_syscalls)
 		fprintf(trace->output, "(         ): ");
 
+	if (thread)
+		trace__fprintf_comm_tid(trace, thread, trace->output);
+
 	if (evsel == trace->syscalls.events.augmented) {
 		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
 		struct syscall *sc = trace__syscall_info(trace, evsel, id);
 
 		if (sc) {
-			struct thread *thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
-
-			if (thread) {
-				trace__fprintf_comm_tid(trace, thread, trace->output);
-				fprintf(trace->output, "%s(", sc->name);
-				trace__fprintf_sys_enter(trace, evsel, sample);
-				fputc(')', trace->output);
-				thread__put(thread);
-				goto newline;
-			}
+			fprintf(trace->output, "%s(", sc->name);
+			trace__fprintf_sys_enter(trace, evsel, sample);
+			fputc(')', trace->output);
+			goto newline;
 		}
 
 		/*
@@ -2110,6 +2108,7 @@ newline:
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
 		pr_err("Problem processing %s callchain, skipping...\n", perf_evsel__name(evsel));
+	thread__put(thread);
 out:
 	return 0;
 }
