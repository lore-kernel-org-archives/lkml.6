Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692B3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FA2218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbeLTSJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:09:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45251 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbeLTSJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:09:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKI8rXq3681503
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:08:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKI8rrd3681499;
        Thu, 20 Dec 2018 10:08:53 -0800
Date:   Thu, 20 Dec 2018 10:08:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-8bjsul8x7osw7nxjodnyfn14@git.kernel.org>
Cc:     namhyung@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        hpa@zytor.com, wangnan0@huawei.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
          wangnan0@huawei.com, hpa@zytor.com, jolsa@kernel.org,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Rename set_ev_qualifier_filter to
 clarify its a tracepoint filter
Git-Commit-ID: 246fbe03edaab9dfa5bd1f0e223c7c960d987982
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

Commit-ID:  246fbe03edaab9dfa5bd1f0e223c7c960d987982
Gitweb:     https://git.kernel.org/tip/246fbe03edaab9dfa5bd1f0e223c7c960d987982
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 12 Dec 2018 11:06:53 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:57 -0300

perf trace: Rename set_ev_qualifier_filter to clarify its a tracepoint filter

Rename it to trace__set_ev_qualifier_tp_filter(), as this just sets up
tracepoint filters on the raw_syscalls:sys_{enter,exit} tracepoints, and
since we're going to do the same for the augmented_raw_syscalls
codepath, when used, rename it to clarify.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-8bjsul8x7osw7nxjodnyfn14@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a14ee4ed2c9f..76e4fa04d824 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2553,7 +2553,7 @@ out_delete_sys_enter:
 	goto out;
 }
 
-static int trace__set_ev_qualifier_filter(struct trace *trace)
+static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 {
 	int err = -1;
 	struct perf_evsel *sys_exit;
@@ -2578,6 +2578,11 @@ out_enomem:
 	goto out;
 }
 
+static int trace__set_ev_qualifier_filter(struct trace *trace)
+{
+	return trace__set_ev_qualifier_tp_filter(trace);
+}
+
 static int bpf_map__set_filter_pids(struct bpf_map *map __maybe_unused,
 				    size_t npids __maybe_unused, pid_t *pids __maybe_unused)
 {
