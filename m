Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbeCHTu5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:50:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751030AbeCHTux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:50:53 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC46E2177B
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
Subject: [PATCH 04/54] perf cgroup: Rename close_cgroup() to cgroup__put()
Date: Thu,  8 Mar 2018 16:49:39 -0300
Message-Id: <20180308195029.14991-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It is not really closing the cgroup, but instead dropping a reference
count and if it hits zero, then calling delete, which will, among other
cleanup shores, close the cgroup fd.

So it is really dropping a reference to that cgroup, and the method name
for that is "put", so rename close_cgroup() to cgroup__put() to follow
this naming convention.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-sccxpnd7bgwc1llgokt6fcey@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 5 ++---
 tools/perf/util/cgroup.h | 3 ++-
 tools/perf/util/evsel.c  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 4dd52feb1ae6..b078d54d4245 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -135,9 +135,8 @@ static int add_cgroup(struct perf_evlist *evlist, char *str)
 			goto found;
 		n++;
 	}
-	if (refcount_dec_and_test(&cgrp->refcnt))
-		free(cgrp);
 
+	cgroup__put(cgrp);
 	return -1;
 found:
 	counter->cgrp = cgrp;
@@ -151,7 +150,7 @@ static void cgroup__delete(struct cgroup *cgroup)
 	free(cgroup);
 }
 
-void close_cgroup(struct cgroup *cgrp)
+void cgroup__put(struct cgroup *cgrp)
 {
 	if (cgrp && refcount_dec_and_test(&cgrp->refcnt)) {
 		cgroup__delete(cgrp);
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 934daa8e4c19..69169fbf8d13 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -14,7 +14,8 @@ struct cgroup {
 
 
 extern int nr_cgroups; /* number of explicit cgroups defined */
-void close_cgroup(struct cgroup *cgrp);
+
+void cgroup__put(struct cgroup *cgroup);
 
 int parse_cgroups(const struct option *opt, const char *str, int unset);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b56e1c2ddaee..f1f883bb41a8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1233,7 +1233,7 @@ void perf_evsel__exit(struct perf_evsel *evsel)
 	perf_evsel__free_fd(evsel);
 	perf_evsel__free_id(evsel);
 	perf_evsel__free_config_terms(evsel);
-	close_cgroup(evsel->cgrp);
+	cgroup__put(evsel->cgrp);
 	cpu_map__put(evsel->cpus);
 	cpu_map__put(evsel->own_cpus);
 	thread_map__put(evsel->threads);
-- 
2.14.3
