Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B24C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D512083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D512083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeJVRsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:48:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbeJVRsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:48:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3477783F44;
        Mon, 22 Oct 2018 09:30:18 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03DA35D6A9;
        Mon, 22 Oct 2018 09:30:15 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH] perf stat: Poll for monitored tasks being alive
Date:   Mon, 22 Oct 2018 11:30:15 +0200
Message-Id: <20181022093015.9106-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 22 Oct 2018 09:30:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the check for tasks we monitor via -p/-t options,
and finish stat if there's no longer task to monitor.

Cc: Jin Yao <yao.jin@linux.intel.com>
Requested-by: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/n/tip-dfqvnvz0oqu5zg149aquz1jb@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b86aba1c8028..d1028d7755bb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -409,6 +409,28 @@ static struct perf_evsel *perf_evsel__reset_weak_group(struct perf_evsel *evsel)
 	return leader;
 }
 
+static bool is_target_alive(struct target *_target,
+			    struct thread_map *threads)
+{
+	struct stat st;
+	int i;
+
+	if (!target__has_task(_target))
+		return true;
+
+	for (i = 0; i < threads->nr; i++) {
+		char path[PATH_MAX];
+
+		scnprintf(path, PATH_MAX, "%s/%d", procfs__mountpoint(),
+			  threads->map[i].pid);
+
+		if (!stat(path, &st))
+			return true;
+	}
+
+	return false;
+}
+
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
@@ -579,6 +601,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		enable_counters();
 		while (!done) {
 			nanosleep(&ts, NULL);
+			if (!is_target_alive(&target, evsel_list->threads))
+				break;
 			if (timeout)
 				break;
 			if (interval) {
-- 
2.17.2

