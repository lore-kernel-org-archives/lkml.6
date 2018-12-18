Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D477DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A292721871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171197;
	bh=1WAe3RLGATyRZATDNg7g+J7dYK8Efb/DiVtWuP/TGV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DmnDD+uYItRtsYhQavCZ11tn7N8Q3IvsWg7ezeFb1YxLt+LL/LYxaUhz0fTANlJ1R
	 o/a/wvwD6wqyKr5Se+scLIQYT9sFooJrae39Ne7WaNf/8trS6be820OFuhzxdey7GN
	 V+03now+Yj9MyGHSP82W3HQtzEHoxU0IBadifVOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeLRWNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:13:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeLRWNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:13:15 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 098B9217D9;
        Tue, 18 Dec 2018 22:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171194;
        bh=1WAe3RLGATyRZATDNg7g+J7dYK8Efb/DiVtWuP/TGV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKvSeH5Pz8MlrrQZfq2F014N3B05yt5rNgsbf7Vj/paoFAtmymQ9N6kBtc7vwqE1p
         /Q56YGGHEqRNPklt39nOxEHTTOh3IuQlEUpSxOx2KmP+beLlhyTlaR4Lv0tZgHBZvs
         lS+H2KbAD5iZ1nlNchIi5Txx/dl/PpSOwO6C0vgw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 37/63] perf trace: Allow configuring if the syscall duration should be printed
Date:   Tue, 18 Dec 2018 19:07:07 -0300
Message-Id: <20181218220733.15839-38-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  # perf config trace.show_duration=no
  # perf config -l | grep trace
  trace.default_events=/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  trace.show_zeros=true
  trace.show_duration=no
  # trace -e *sleep sleep 1
     0.000 sleep/8729 nanosleep(rqtp: 0x7ffcb0b4c940, rmtp: 0) = 0
  # perf config trace.show_duration=yes
  # trace -e *sleep sleep 1
     0.000 (1000.212 ms): sleep/8735 nanosleep(rqtp: 0x7ffca15fa770, rmtp: 0) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2c7h1m8fhzb9puxtj9nlevi8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 4 ++++
 tools/perf/builtin-trace.c               | 9 +++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index b55bd16c77fe..0d641b0d15ae 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -528,6 +528,10 @@ trace.*::
 		The initial use case is to add augmented_raw_syscalls.o to
 		activate the 'perf trace' logic that looks for syscall
 		pointer contents after the normal tracepoint payload.
+
+	trace.show_duration::
+		Show syscall duration.
+
 	trace.show_zeros::
 		Do not suppress syscall arguments that are equal to zero.
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4d97bdac205c..4355dadad232 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -127,6 +127,7 @@ struct trace {
 	bool			show_tool_stats;
 	bool			trace_syscalls;
 	bool			kernel_syscallchains;
+	bool			show_duration;
 	bool			show_zeros;
 	bool			force;
 	bool			vfs_getname;
@@ -1215,7 +1216,8 @@ static size_t trace__fprintf_entry_head(struct trace *trace, struct thread *thre
 					u64 duration, bool duration_calculated, u64 tstamp, FILE *fp)
 {
 	size_t printed = trace__fprintf_tstamp(trace, tstamp, fp);
-	printed += fprintf_duration(duration, duration_calculated, fp);
+	if (trace->show_duration)
+		printed += fprintf_duration(duration, duration_calculated, fp);
 	return printed + trace__fprintf_comm_tid(trace, thread, fp);
 }
 
@@ -2190,7 +2192,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 	trace__printf_interrupted_entry(trace);
 	trace__fprintf_tstamp(trace, sample->time, trace->output);
 
-	if (trace->trace_syscalls)
+	if (trace->trace_syscalls && trace->show_duration)
 		fprintf(trace->output, "(         ): ");
 
 	if (thread)
@@ -3536,6 +3538,8 @@ static int trace__config(const char *var, const char *value, void *arg)
 					       "event selector. use 'perf list' to list available events",
 					       parse_events_option);
 		err = parse_events_option(&o, value, 0);
+	} else if (!strcmp(var, "trace.show_duration")) {
+		trace->show_duration = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_zeros")) {
 		trace->show_zeros = perf_config_bool(var, value);
 	}
@@ -3568,6 +3572,7 @@ int cmd_trace(int argc, const char **argv)
 		},
 		.output = stderr,
 		.show_comm = true,
+		.show_duration = true,
 		.trace_syscalls = false,
 		.kernel_syscallchains = false,
 		.max_stack = UINT_MAX,
-- 
2.19.2

