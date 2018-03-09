Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeCIIgx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:36:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49881 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeCIIgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:36:50 -0500
Date: Fri, 9 Mar 2018 00:36:40 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-jaalyl6bkvvji4r5u8wqw4n4@git.kernel.org>
Cc: jolsa@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, dsahern@gmail.com, adrian.hunter@intel.com,
        wangnan0@huawei.com, hpa@zytor.com, tglx@linutronix.de,
        eranian@google.com, namhyung@kernel.org
Reply-To: adrian.hunter@intel.com, hpa@zytor.com, wangnan0@huawei.com,
        eranian@google.com, tglx@linutronix.de, namhyung@kernel.org,
        jolsa@kernel.org, acme@redhat.com, dsahern@gmail.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cgroup: Introduce cgroup__new() out of open
 coded equivalent
Git-Commit-ID: 923a0fb332f8ee49b063df07129b2686f78ec9c3
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

Commit-ID:  923a0fb332f8ee49b063df07129b2686f78ec9c3
Gitweb:     https://git.kernel.org/tip/923a0fb332f8ee49b063df07129b2686f78ec9c3
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Mar 2018 10:33:04 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:22:25 -0300

perf cgroup: Introduce cgroup__new() out of open coded equivalent

To follow the namespacing convention in tools/perf.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-jaalyl6bkvvji4r5u8wqw4n4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 84dfc34a6d0f..26a837037797 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -109,6 +109,25 @@ static struct cgroup *evlist__find_cgroup(struct perf_evlist *evlist, char *str)
 	return cgrp;
 }
 
+static struct cgroup *cgroup__new(char *name)
+{
+	struct cgroup *cgroup = zalloc(sizeof(*cgroup));
+
+	if (cgroup != NULL) {
+		cgroup->name = name;
+		refcount_set(&cgroup->refcnt, 1);
+
+		cgroup->fd = open_cgroup(name);
+		if (cgroup->fd == -1)
+			goto out_err;
+	}
+
+	return cgroup;
+out_err:
+	free(cgroup);
+	return NULL;
+}
+
 static int add_cgroup(struct perf_evlist *evlist, char *str)
 {
 	struct perf_evsel *counter;
@@ -116,18 +135,9 @@ static int add_cgroup(struct perf_evlist *evlist, char *str)
 	int n;
 
 	if (!cgrp) {
-		cgrp = zalloc(sizeof(*cgrp));
+		cgrp = cgroup__new(str);
 		if (!cgrp)
 			return -1;
-
-		cgrp->name = str;
-		refcount_set(&cgrp->refcnt, 1);
-
-		cgrp->fd = open_cgroup(str);
-		if (cgrp->fd == -1) {
-			free(cgrp);
-			return -1;
-		}
 	}
 
 	/*
