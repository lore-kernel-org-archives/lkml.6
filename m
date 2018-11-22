Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39C3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE9920864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE9920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404963AbeKVRov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:44:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbeKVRov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:44:51 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM76bK23691269
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:06:37 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM76bgn3691266;
        Wed, 21 Nov 2018 23:06:37 -0800
Date:   Wed, 21 Nov 2018 23:06:37 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-zc5n453sxxm0tz1zfwwelyti@git.kernel.org>
Cc:     hpa@zytor.com, namhyung@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        adrian.hunter@intel.com, jolsa@kernel.org, mingo@kernel.org,
        dsahern@gmail.com, wangnan0@huawei.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          acme@redhat.com, namhyung@kernel.org, hpa@zytor.com,
          dsahern@gmail.com, wangnan0@huawei.com, mingo@kernel.org,
          jolsa@kernel.org, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Fill in BPF "filtered_pids" map when
 present
Git-Commit-ID: a9964c432bccb9222b6ac671324f73d629ff7ac9
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

Commit-ID:  a9964c432bccb9222b6ac671324f73d629ff7ac9
Gitweb:     https://git.kernel.org/tip/a9964c432bccb9222b6ac671324f73d629ff7ac9
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 7 Nov 2018 10:08:00 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 12:00:31 -0300

perf trace: Fill in BPF "filtered_pids" map when present

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
@@ -2567,9 +2567,27 @@ out_enomem:
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
 
