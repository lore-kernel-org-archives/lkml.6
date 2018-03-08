Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeCHUHR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:07:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751082AbeCHTu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:50:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67EB20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 05/54] perf cgroup: Introduce cgroup__get()
Date: Thu,  8 Mar 2018 16:49:40 -0300
Message-Id: <20180308195029.14991-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The refcount operation counterpart to cgroup__put(), use it when reusing
a cgroup.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-14ynvrl7y2cz8gyuy5q5v41g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 16 ++++++++++------
 tools/perf/util/cgroup.h |  1 +
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index b078d54d4245..8ea964461eb7 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -99,15 +99,12 @@ static int add_cgroup(struct perf_evlist *evlist, char *str)
 	 * check if cgrp is already defined, if so we reuse it
 	 */
 	evlist__for_each_entry(evlist, counter) {
-		cgrp = counter->cgrp;
-		if (!cgrp)
+		if (!counter->cgrp)
 			continue;
-		if (!strcmp(cgrp->name, str)) {
-			refcount_inc(&cgrp->refcnt);
+		if (!strcmp(counter->cgrp->name, str)) {
+			cgrp = cgroup__get(counter->cgrp);
 			break;
 		}
-
-		cgrp = NULL;
 	}
 
 	if (!cgrp) {
@@ -157,6 +154,13 @@ void cgroup__put(struct cgroup *cgrp)
 	}
 }
 
+struct cgroup *cgroup__get(struct cgroup *cgroup)
+{
+       if (cgroup)
+		refcount_inc(&cgroup->refcnt);
+       return cgroup;
+}
+
 int parse_cgroups(const struct option *opt, const char *str,
 		  int unset __maybe_unused)
 {
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 69169fbf8d13..34a6c11543dc 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -15,6 +15,7 @@ struct cgroup {
 
 extern int nr_cgroups; /* number of explicit cgroups defined */
 
+struct cgroup *cgroup__get(struct cgroup *cgroup);
 void cgroup__put(struct cgroup *cgroup);
 
 int parse_cgroups(const struct option *opt, const char *str, int unset);
-- 
2.14.3
