Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D88C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52DF2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dex2QK2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52DF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeIFChN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFChN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:13 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19BB62083D;
        Wed,  5 Sep 2018 22:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185101;
        bh=tvYuGRfPeWQUIItiSRIjKl2dOFZzYH0L9YqbIz4qF0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dex2QK2OVcI9S4a6EzPLEtNKtxkNL9zdpeFqfCmQjZVWdPV4VI/2D2F0S5704JCDT
         mRjZqHxKHel4f0kBEK2guct11qhC6Cc3+QB8NiLkcdnEBVP7qbNbUHQCsllncL04Fh
         TpAEiO4lneW6f45MXsVYQYAYidZ+dZ05Xxr12My0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 03/77] perf trace: Print the syscall name for augmented_syscalls
Date:   Wed,  5 Sep 2018 19:03:26 -0300
Message-Id: <20180905220440.20256-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

