Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeCHTvE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:51:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751170AbeCHTvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:51:02 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1D2205F4
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
Subject: [PATCH 07/54] perf cgroup: Introduce cgroup__new() out of open coded equivalent
Date: Thu,  8 Mar 2018 16:49:42 -0300
Message-Id: <20180308195029.14991-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
