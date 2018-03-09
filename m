Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeCIIiu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:38:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46135 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeCIIis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:38:48 -0500
Date: Fri, 9 Mar 2018 00:38:38 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-im1omevlihhyneiic4nl3g24@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, eranian@google.com,
        adrian.hunter@intel.com, mingo@kernel.org, dsahern@gmail.com,
        hpa@zytor.com, wangnan0@huawei.com, namhyung@kernel.org,
        acme@redhat.com, jolsa@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, wangnan0@huawei.com,
        dsahern@gmail.com, eranian@google.com, adrian.hunter@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cgroup: Add evlist__findnew_cgroup()
Git-Commit-ID: 69239ec81d596c57e0cf2d2f26cfe92e8cbd0929
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

Commit-ID:  69239ec81d596c57e0cf2d2f26cfe92e8cbd0929
Gitweb:     https://git.kernel.org/tip/69239ec81d596c57e0cf2d2f26cfe92e8cbd0929
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Mar 2018 15:27:08 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:22:26 -0300

perf cgroup: Add evlist__findnew_cgroup()

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
@@ -128,18 +128,21 @@ out_err:
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
