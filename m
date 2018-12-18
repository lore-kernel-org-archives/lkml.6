Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173E7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE46521871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171232;
	bh=LJYlyRFBCbwbp8G9eET2hUx04SXMsjQwM4G/NE0ofF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FBTph/G8X2JQbb3xmRk5y06eNXh+ol4j9tw0v+2/p/XKSdsMjks3y3/GuBtRSDTJI
	 JRewpFJGwioi4ZRI20y8aRRWWA+XRmr+yKCIKhfW37zpU7Ttl0Owu58+VcMJp/KCro
	 IoVUD4ez01GKFQlJZCrxbwghufTPVDmOMn1OKyBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbeLRWNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:13:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbeLRWNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:13:49 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92B2F21871;
        Tue, 18 Dec 2018 22:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171229;
        bh=LJYlyRFBCbwbp8G9eET2hUx04SXMsjQwM4G/NE0ofF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WjwMjSbOmo3EcIZwKk75PhdwqFVTtWHKhffNCYDCPBmTvE4OlbzigqeX2o/Hm9F3p
         QUmowMEbT92/P92TafzxL34oGZw6JlfgeulpEt6LwoeqBlyxDLH/qhs1hjsYXKeGu+
         Ld0foSGCpLNweipFK/r+WMOn4SlbZq0NXZYPlXEo=
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
Subject: [PATCH 42/63] perf trace: Make the alignment of the syscall args be configurable
Date:   Tue, 18 Dec 2018 19:07:12 -0300
Message-Id: <20181218220733.15839-43-acme@kernel.org>
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

Since the start 'perf trace' aligns the parens enclosing the list of
syscall args to align the syscall results, allow this to be
configurable, keeping the default of 70. Using:

  # perf config
  llvm.dump-obj=true
  trace.add_events=/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  trace.show_zeros=yes
  trace.show_duration=no
  trace.no_inherit=yes
  trace.show_timestamp=no
  trace.show_arg_names=no
  trace.args_alignment=0
  # trace -e open*,close,*sleep sleep 1
  openat(CWD, /etc/ld.so.cache, CLOEXEC) = 3
  close(3) = 0
  openat(CWD, /lib64/libc.so.6, CLOEXEC) = 3
  close(3) = 0
  openat(CWD, /usr/lib/locale/locale-archive, CLOEXEC) = 3
  close(3) = 0
  nanosleep(0x7ffc00de66f0, 0) = 0
  close(1) = 0
  close(2) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-r8cbhoz1lr5npq9tutpvoigr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt |  4 ++++
 tools/perf/builtin-trace.c               | 12 +++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 35108fd61fa6..0098eab8e5b1 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -529,6 +529,10 @@ trace.*::
 		activate the 'perf trace' logic that looks for syscall
 		pointer contents after the normal tracepoint payload.
 
+	trace.args_alignment::
+		Number of columns to align the argument list, default is 70,
+		use 40 for the strace default, zero to no alignment.
+
 	trace.no_inherit::
 		Do not follow children threads.
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 95dfcb851604..2d8fd48a4727 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -127,6 +127,7 @@ struct trace {
 	bool			show_tool_stats;
 	bool			trace_syscalls;
 	bool			kernel_syscallchains;
+	s16			args_alignment;
 	bool			show_tstamp;
 	bool			show_duration;
 	bool			show_zeros;
@@ -1731,7 +1732,7 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 		return 0;
 
 	printed  = trace__fprintf_entry_head(trace, trace->current, 0, false, ttrace->entry_time, trace->output);
-	printed += fprintf(trace->output, "%-70s) ...\n", ttrace->entry_str);
+	printed += fprintf(trace->output, "%-*s) ...\n", trace->args_alignment, ttrace->entry_str);
 	ttrace->entry_pending = false;
 
 	++trace->nr_events_printed;
@@ -1838,7 +1839,7 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 	if (sc->is_exit) {
 		if (!(trace->duration_filter || trace->summary_only || trace->failure_only || trace->min_stack)) {
 			trace__fprintf_entry_head(trace, thread, 0, false, ttrace->entry_time, trace->output);
-			fprintf(trace->output, "%-70s)\n", ttrace->entry_str);
+			fprintf(trace->output, "%-*s)\n", trace->args_alignment, ttrace->entry_str);
 		}
 	} else {
 		ttrace->entry_pending = true;
@@ -1981,7 +1982,7 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 	trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
 
 	if (ttrace->entry_pending) {
-		fprintf(trace->output, "%-70s", ttrace->entry_str);
+		fprintf(trace->output, "%-*s", trace->args_alignment, ttrace->entry_str);
 	} else {
 		fprintf(trace->output, " ... [");
 		color_fprintf(trace->output, PERF_COLOR_YELLOW, "continued");
@@ -3563,6 +3564,10 @@ static int trace__config(const char *var, const char *value, void *arg)
 		trace->show_zeros = new_show_zeros;
 	} else if (!strcmp(var, "trace.no_inherit")) {
 		trace->opts.no_inherit = perf_config_bool(var, value);
+	} else if (!strcmp(var, "trace.args_alignment")) {
+		int args_alignment = 0;
+		if (perf_config_int(&args_alignment, var, value) == 0)
+			trace->args_alignment = args_alignment;
 	}
 out:
 	return err;
@@ -3596,6 +3601,7 @@ int cmd_trace(int argc, const char **argv)
 		.show_tstamp = true,
 		.show_duration = true,
 		.show_arg_names = true,
+		.args_alignment = 70,
 		.trace_syscalls = false,
 		.kernel_syscallchains = false,
 		.max_stack = UINT_MAX,
-- 
2.19.2

