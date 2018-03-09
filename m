Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeCIIf3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:35:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48197 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeCIIf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:35:27 -0500
Date: Fri, 9 Mar 2018 00:35:17 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-sccxpnd7bgwc1llgokt6fcey@git.kernel.org>
Cc: acme@redhat.com, mingo@kernel.org, wangnan0@huawei.com,
        adrian.hunter@intel.com, dsahern@gmail.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: jolsa@kernel.org, eranian@google.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        acme@redhat.com, mingo@kernel.org, dsahern@gmail.com,
        wangnan0@huawei.com, adrian.hunter@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cgroup: Rename close_cgroup() to cgroup__put()
Git-Commit-ID: a53b646030ee6f65accdc49e772823b8134a37f6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a53b646030ee6f65accdc49e772823b8134a37f6
Gitweb:     https://git.kernel.org/tip/a53b646030ee6f65accdc49e772823b8134a37f6
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Mar 2018 10:10:45 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:22:25 -0300

perf cgroup: Rename close_cgroup() to cgroup__put()

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
