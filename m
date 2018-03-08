Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbeCHTvW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:51:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751244AbeCHTvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:51:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6782177C
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
Subject: [PATCH 13/54] perf cgroup: Make the cgroup name be const char *
Date: Thu,  8 Mar 2018 16:49:48 -0300
Message-Id: <20180308195029.14991-14-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The usual thing is for a constructor to allocate space for its members,
not to require that the caller pass a pre-allocated 'name' and then, at
its destructor, to free something not allocated by it.

Fix it by making cgroup__new() to receive a const char pointer, then
allocate cgroup->name that then can continue to be freed at
cgroup__delete(), balancing the alloc/free operations inside the cgroup
struct methods.

This eases calling evlist__findnew_cgroup() from the custom 'perf trace'
cgroup parser, that will only call parse_cgroups() when the '-G cgroup'
is passed on the command line after '-e event' entries, when it'll
behave just like 'perf stat' and 'perf record', i.e. the previous
parse_cgroup() users that mandate that -G only can come after a -e.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4leugnuyqi10t98990o3xi1t@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 24 ++++++++++++++----------
 tools/perf/util/cgroup.h |  2 +-
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index d8cd0e601c56..78408f5c4bad 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -71,7 +71,7 @@ cgroupfs_find_mountpoint(char *buf, size_t maxlen)
 	return -1;
 }
 
-static int open_cgroup(char *name)
+static int open_cgroup(const char *name)
 {
 	char path[PATH_MAX + 1];
 	char mnt[PATH_MAX + 1];
@@ -90,7 +90,7 @@ static int open_cgroup(char *name)
 	return fd;
 }
 
-static struct cgroup *evlist__find_cgroup(struct perf_evlist *evlist, char *str)
+static struct cgroup *evlist__find_cgroup(struct perf_evlist *evlist, const char *str)
 {
 	struct perf_evsel *counter;
 	struct cgroup *cgrp = NULL;
@@ -109,33 +109,38 @@ static struct cgroup *evlist__find_cgroup(struct perf_evlist *evlist, char *str)
 	return cgrp;
 }
 
-static struct cgroup *cgroup__new(char *name)
+static struct cgroup *cgroup__new(const char *name)
 {
 	struct cgroup *cgroup = zalloc(sizeof(*cgroup));
 
 	if (cgroup != NULL) {
-		cgroup->name = name;
 		refcount_set(&cgroup->refcnt, 1);
 
+		cgroup->name = strdup(name);
+		if (!cgroup->name)
+			goto out_err;
 		cgroup->fd = open_cgroup(name);
 		if (cgroup->fd == -1)
-			goto out_err;
+			goto out_free_name;
 	}
 
 	return cgroup;
+
+out_free_name:
+	free(cgroup->name);
 out_err:
 	free(cgroup);
 	return NULL;
 }
 
-struct cgroup *evlist__findnew_cgroup(struct perf_evlist *evlist, char *name)
+struct cgroup *evlist__findnew_cgroup(struct perf_evlist *evlist, const char *name)
 {
 	struct cgroup *cgroup = evlist__find_cgroup(evlist, name);
 
 	return cgroup ?: cgroup__new(name);
 }
 
-static int add_cgroup(struct perf_evlist *evlist, char *str)
+static int add_cgroup(struct perf_evlist *evlist, const char *str)
 {
 	struct perf_evsel *counter;
 	struct cgroup *cgrp = evlist__findnew_cgroup(evlist, str);
@@ -222,10 +227,9 @@ int parse_cgroups(const struct option *opt, const char *str,
 			if (!s)
 				return -1;
 			ret = add_cgroup(evlist, s);
-			if (ret) {
-				free(s);
+			free(s);
+			if (ret)
 				return -1;
-			}
 		}
 		/* nr_cgroups is increased een for empty cgroups */
 		nr_cgroups++;
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index b213f5e9a3ed..f033a80c1b14 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -20,7 +20,7 @@ void cgroup__put(struct cgroup *cgroup);
 
 struct perf_evlist;
 
-struct cgroup *evlist__findnew_cgroup(struct perf_evlist *evlist, char *name);
+struct cgroup *evlist__findnew_cgroup(struct perf_evlist *evlist, const char *name);
 
 void evlist__set_default_cgroup(struct perf_evlist *evlist, struct cgroup *cgroup);
 
-- 
2.14.3
