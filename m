Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99594C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6013C20878
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoDQSJAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6013C20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404325AbeKVOOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404284AbeKVOOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:19 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662BE20821;
        Thu, 22 Nov 2018 03:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857813;
        bh=k4wf8aqsoGwWJafDWSWi1NlJ9G7lMHs4kuZTwuMSn9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UoDQSJAlcQm/939iM8A7LAx1QA/CyFRHOyzZz9uQHZOYOTr1lfjct32IW7U1s5Jdk
         tBmZEw3M6OmN/ztI/xXj8PdfOECy2u09XqeiwFe5J8wrNl8j/utr2PWa/XqREJoJhC
         uWbm3nMYLPDymUY2bXdKIIw2r6U+ZkLbDhrNkBIQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 10/28] perf trace: See if there is a map named "filtered_pids"
Date:   Thu, 22 Nov 2018 00:35:53 -0300
Message-Id: <20181122033611.15890-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Lookup for the first map named "filtered_pids" and, if augmenting
syscalls, i.e. if a BPF event is present and the
"__augmented_syscalls__" is present, then fill in that map with the pids
to filter, be it feedback loop ones (perf trace's pid, its father if it
is "sshd", more auto-filtered in the future) or the ones explicitely
stated in the tool command line via --filter-pids.

The code to actually fill in the map comes next.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-rhzytmw7qpe6lqyjxi1ded9t@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8f966c7a7d0d..c423a78b5ecd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -18,6 +18,7 @@
 
 #include <traceevent/event-parse.h>
 #include <api/fs/tracing_path.h>
+#include <bpf/bpf.h>
 #include "builtin.h"
 #include "util/cgroup.h"
 #include "util/color.h"
@@ -99,6 +100,7 @@ struct trace {
 	struct {
 		size_t		nr;
 		pid_t		*entries;
+		struct bpf_map  *map;
 	}			filter_pids;
 	double			duration_filter;
 	double			runtime_ms;
@@ -3315,6 +3317,25 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
 	return 0;
 }
 
+static struct bpf_map *bpf__find_map_by_name(const char *name)
+{
+	struct bpf_object *obj, *tmp;
+
+	bpf_object__for_each_safe(obj, tmp) {
+		struct bpf_map *map = bpf_object__find_map_by_name(obj, name);
+		if (map)
+			return map;
+
+	}
+
+	return NULL;
+}
+
+static void trace__set_bpf_map_filtered_pids(struct trace *trace)
+{
+	trace->filter_pids.map = bpf__find_map_by_name("pids_filtered");
+}
+
 int cmd_trace(int argc, const char **argv)
 {
 	const char *trace_usage[] = {
@@ -3451,8 +3472,10 @@ int cmd_trace(int argc, const char **argv)
 		goto out;
 	}
 
-	if (evsel)
+	if (evsel) {
 		trace.syscalls.events.augmented = evsel;
+		trace__set_bpf_map_filtered_pids(&trace);
+	}
 
 	err = bpf__setup_stdout(trace.evlist);
 	if (err) {
-- 
2.14.5

