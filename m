Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6128C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1C520821
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK7HCj1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1C520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404339AbeKVOOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404284AbeKVOOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:22 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 473592080F;
        Thu, 22 Nov 2018 03:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857816;
        bh=8+rEe+HClOE3869VdrL6vRWFVrgu9FUiMM0Ey60x/zQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jK7HCj1J62PFL2Lm2gRJT7fTmfQCpOUEE82TjnNZ8EC3a/v6Y7Lm16OeyJD6/wnmw
         a8OsTO2CWXDt4ujdmJvqFvmIDSidNxGG/m4a4Prc6Vrivu7Lt0QwrGK2bYkLZpvvdf
         ynDwCxldWKC3153zLOGsPnAv4ICmlLJ1xWx8cRTg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 11/28] perf trace: Fill in BPF "filtered_pids" map when present
Date:   Thu, 22 Nov 2018 00:35:54 -0300
Message-Id: <20181122033611.15890-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This makes the augmented_syscalls support the --filter-pids and
auto-filtered feedback loop pids just like when working without BPF,
i.e. with just raw_syscalls:sys_{enter,exit} and tracepoint filters.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zc5n453sxxm0tz1zfwwelyti@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 61 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c423a78b5ecd..8e3c3f74a3a4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2567,9 +2567,27 @@ static int trace__set_ev_qualifier_filter(struct trace *trace)
 	goto out;
 }
 
+static int bpf_map__set_filter_pids(struct bpf_map *map __maybe_unused,
+				    size_t npids __maybe_unused, pid_t *pids __maybe_unused)
+{
+	int err = 0;
+#ifdef HAVE_LIBBPF_SUPPORT
+	bool value = true;
+	int map_fd = bpf_map__fd(map);
+	size_t i;
+
+	for (i = 0; i < npids; ++i) {
+		err = bpf_map_update_elem(map_fd, &pids[i], &value, BPF_ANY);
+		if (err)
+			break;
+	}
+#endif
+	return err;
+}
+
 static int trace__set_filter_loop_pids(struct trace *trace)
 {
-	unsigned int nr = 1;
+	unsigned int nr = 1, err;
 	pid_t pids[32] = {
 		getpid(),
 	};
@@ -2588,7 +2606,34 @@ static int trace__set_filter_loop_pids(struct trace *trace)
 		thread = parent;
 	}
 
-	return perf_evlist__set_tp_filter_pids(trace->evlist, nr, pids);
+	err = perf_evlist__set_tp_filter_pids(trace->evlist, nr, pids);
+	if (!err && trace->filter_pids.map)
+		err = bpf_map__set_filter_pids(trace->filter_pids.map, nr, pids);
+
+	return err;
+}
+
+static int trace__set_filter_pids(struct trace *trace)
+{
+	int err = 0;
+	/*
+	 * Better not use !target__has_task() here because we need to cover the
+	 * case where no threads were specified in the command line, but a
+	 * workload was, and in that case we will fill in the thread_map when
+	 * we fork the workload in perf_evlist__prepare_workload.
+	 */
+	if (trace->filter_pids.nr > 0) {
+		err = perf_evlist__set_tp_filter_pids(trace->evlist, trace->filter_pids.nr,
+						      trace->filter_pids.entries);
+		if (!err && trace->filter_pids.map) {
+			err = bpf_map__set_filter_pids(trace->filter_pids.map, trace->filter_pids.nr,
+						       trace->filter_pids.entries);
+		}
+	} else if (thread_map__pid(trace->evlist->threads, 0) == -1) {
+		err = trace__set_filter_loop_pids(trace);
+	}
+
+	return err;
 }
 
 static int trace__run(struct trace *trace, int argc, const char **argv)
@@ -2697,17 +2742,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		goto out_error_open;
 	}
 
-	/*
-	 * Better not use !target__has_task() here because we need to cover the
-	 * case where no threads were specified in the command line, but a
-	 * workload was, and in that case we will fill in the thread_map when
-	 * we fork the workload in perf_evlist__prepare_workload.
-	 */
-	if (trace->filter_pids.nr > 0)
-		err = perf_evlist__set_tp_filter_pids(evlist, trace->filter_pids.nr, trace->filter_pids.entries);
-	else if (thread_map__pid(evlist->threads, 0) == -1)
-		err = trace__set_filter_loop_pids(trace);
-
+	err = trace__set_filter_pids(trace);
 	if (err < 0)
 		goto out_error_mem;
 
-- 
2.14.5

