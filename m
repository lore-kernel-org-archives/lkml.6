Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25437C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EBD20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EBD20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404936AbeKVRoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:44:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51729 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbeKVRoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:44:17 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM7633I3691222
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:06:04 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM763QP3691219;
        Wed, 21 Nov 2018 23:06:03 -0800
Date:   Wed, 21 Nov 2018 23:06:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-rhzytmw7qpe6lqyjxi1ded9t@git.kernel.org>
Cc:     namhyung@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        acme@redhat.com, dsahern@gmail.com, adrian.hunter@intel.com,
        hpa@zytor.com, wangnan0@huawei.com
Reply-To: namhyung@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          jolsa@kernel.org, acme@redhat.com, dsahern@gmail.com,
          adrian.hunter@intel.com, hpa@zytor.com, wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: See if there is a map named
 "filtered_pids"
Git-Commit-ID: 744fafc787deebf26a39e6b5be36026bb2ff65fb
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

Commit-ID:  744fafc787deebf26a39e6b5be36026bb2ff65fb
Gitweb:     https://git.kernel.org/tip/744fafc787deebf26a39e6b5be36026bb2ff65fb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 7 Nov 2018 10:04:51 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 12:00:31 -0300

perf trace: See if there is a map named "filtered_pids"

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
