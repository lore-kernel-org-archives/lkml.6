Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeCHTvQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751244AbeCHTvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:51:13 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3102C2177C
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
Subject: [PATCH 11/54] perf cgroup: Add evlist__findnew_cgroup()
Date: Thu,  8 Mar 2018 16:49:46 -0300
Message-Id: <20180308195029.14991-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Similar to machine__findnew_thread(), etc, i.e. try to find, get a
refcount if found and return it, otherwise return a new cgroup object.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-im1omevlihhyneiic4nl3g24@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 17 ++++++++++-------
 tools/perf/util/cgroup.h |  4 ++++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 26a837037797..6fd33ffc2488 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -128,18 +128,21 @@ static struct cgroup *cgroup__new(char *name)
 	return NULL;
 }
 
+struct cgroup *evlist__findnew_cgroup(struct perf_evlist *evlist, char *name)
+{
+	struct cgroup *cgroup = evlist__find_cgroup(evlist, name);
+
+	return cgroup ?: cgroup__new(name);
+}
+
 static int add_cgroup(struct perf_evlist *evlist, char *str)
 {
 	struct perf_evsel *counter;
-	struct cgroup *cgrp = evlist__find_cgroup(evlist, str);
+	struct cgroup *cgrp = evlist__findnew_cgroup(evlist, str);
 	int n;
 
-	if (!cgrp) {
-		cgrp = cgroup__new(str);
-		if (!cgrp)
-			return -1;
-	}
-
+	if (!cgrp)
+		return -1;
 	/*
 	 * find corresponding event
 	 * if add cgroup N, then need to find event N
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 34a6c11543dc..0e377e6340dd 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -18,6 +18,10 @@ extern int nr_cgroups; /* number of explicit cgroups defined */
 struct cgroup *cgroup__get(struct cgroup *cgroup);
 void cgroup__put(struct cgroup *cgroup);
 
+struct perf_evlist;
+
+struct cgroup *evlist__findnew_cgroup(struct perf_evlist *evlist, char *name);
+
 int parse_cgroups(const struct option *opt, const char *str, int unset);
 
 #endif /* __CGROUP_H__ */
-- 
2.14.3
