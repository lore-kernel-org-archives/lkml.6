Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeCIIjq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:39:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58623 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeCIIjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:39:45 -0500
Date: Fri, 9 Mar 2018 00:39:33 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4leugnuyqi10t98990o3xi1t@git.kernel.org>
Cc: wangnan0@huawei.com, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mingo@kernel.org, dsahern@gmail.com, hpa@zytor.com, jolsa@kernel.org,
        acme@redhat.com, eranian@google.com, adrian.hunter@intel.com,
        tglx@linutronix.de
Reply-To: adrian.hunter@intel.com, tglx@linutronix.de, hpa@zytor.com,
        acme@redhat.com, jolsa@kernel.org, eranian@google.com,
        wangnan0@huawei.com, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mingo@kernel.org, dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cgroup: Make the cgroup name be const char *
Git-Commit-ID: 3b5692864da3a8dec95d8c757147f436d19f8ff7
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

Commit-ID:  3b5692864da3a8dec95d8c757147f436d19f8ff7
Gitweb:     https://git.kernel.org/tip/3b5692864da3a8dec95d8c757147f436d19f8ff7
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Mar 2018 15:53:22 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:22:26 -0300

perf cgroup: Make the cgroup name be const char *

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
 
