Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbeCHUHq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:07:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbeCHTur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:50:47 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E422178E
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
Subject: [PATCH 02/54] perf cgroup: Rename 'struct cgroup_sel' to 'struct cgroup'
Date: Thu,  8 Mar 2018 16:49:37 -0300
Message-Id: <20180308195029.14991-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

That name isn't used, is shorter, lets switch to it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-e51yphwgvepd1y4f5fjptmjq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 6 +++---
 tools/perf/util/cgroup.h | 5 +++--
 tools/perf/util/evsel.h  | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 2e2aa6c86107..6ce291f45f2d 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -93,7 +93,7 @@ static int open_cgroup(char *name)
 static int add_cgroup(struct perf_evlist *evlist, char *str)
 {
 	struct perf_evsel *counter;
-	struct cgroup_sel *cgrp = NULL;
+	struct cgroup *cgrp = NULL;
 	int n;
 	/*
 	 * check if cgrp is already defined, if so we reuse it
@@ -144,7 +144,7 @@ static int add_cgroup(struct perf_evlist *evlist, char *str)
 	return 0;
 }
 
-void close_cgroup(struct cgroup_sel *cgrp)
+void close_cgroup(struct cgroup *cgrp)
 {
 	if (cgrp && refcount_dec_and_test(&cgrp->refcnt)) {
 		close(cgrp->fd);
@@ -158,7 +158,7 @@ int parse_cgroups(const struct option *opt, const char *str,
 {
 	struct perf_evlist *evlist = *(struct perf_evlist **)opt->value;
 	struct perf_evsel *counter;
-	struct cgroup_sel *cgrp = NULL;
+	struct cgroup *cgrp = NULL;
 	const char *p, *e, *eos = str + strlen(str);
 	char *s;
 	int ret, i;
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index afafc87e9201..934daa8e4c19 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -6,7 +6,7 @@
 
 struct option;
 
-struct cgroup_sel {
+struct cgroup {
 	char *name;
 	int fd;
 	refcount_t refcnt;
@@ -14,7 +14,8 @@ struct cgroup_sel {
 
 
 extern int nr_cgroups; /* number of explicit cgroups defined */
-void close_cgroup(struct cgroup_sel *cgrp);
+void close_cgroup(struct cgroup *cgrp);
+
 int parse_cgroups(const struct option *opt, const char *str, int unset);
 
 #endif /* __CGROUP_H__ */
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a7487c6d1866..92ba001b627f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -30,7 +30,7 @@ struct perf_sample_id {
 	u64			period;
 };
 
-struct cgroup_sel;
+struct cgroup;
 
 /*
  * The 'struct perf_evsel_config_term' is used to pass event
@@ -107,7 +107,7 @@ struct perf_evsel {
 	struct perf_stat_evsel  *stats;
 	void			*priv;
 	u64			db_id;
-	struct cgroup_sel	*cgrp;
+	struct cgroup		*cgrp;
 	void			*handler;
 	struct cpu_map		*cpus;
 	struct cpu_map		*own_cpus;
-- 
2.14.3
