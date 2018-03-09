Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeCIIf4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:35:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60909 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeCIIfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:35:55 -0500
Date: Fri, 9 Mar 2018 00:35:45 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-14ynvrl7y2cz8gyuy5q5v41g@git.kernel.org>
Cc: acme@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jolsa@kernel.org, eranian@google.com,
        namhyung@kernel.org, wangnan0@huawei.com, dsahern@gmail.com,
        mingo@kernel.org, adrian.hunter@intel.com
Reply-To: mingo@kernel.org, adrian.hunter@intel.com, wangnan0@huawei.com,
        dsahern@gmail.com, eranian@google.com, namhyung@kernel.org,
        tglx@linutronix.de, acme@redhat.com, hpa@zytor.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cgroup: Introduce cgroup__get()
Git-Commit-ID: fc9ffb9cf085c78f49d4d1a602d723504c0d9c75
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

Commit-ID:  fc9ffb9cf085c78f49d4d1a602d723504c0d9c75
Gitweb:     https://git.kernel.org/tip/fc9ffb9cf085c78f49d4d1a602d723504c0d9c75
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Mar 2018 10:18:40 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:22:25 -0300

perf cgroup: Introduce cgroup__get()

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
