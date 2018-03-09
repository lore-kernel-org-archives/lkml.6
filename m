Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932082AbeCIIjR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:39:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48633 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbeCIIjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:39:15 -0500
Date: Fri, 9 Mar 2018 00:39:05 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-zf9jjsbj661r3lk6qb7g8j70@git.kernel.org>
Cc: namhyung@kernel.org, dsahern@gmail.com, adrian.hunter@intel.com,
        jolsa@kernel.org, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        eranian@google.com, wangnan0@huawei.com
Reply-To: mingo@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        dsahern@gmail.com, adrian.hunter@intel.com, wangnan0@huawei.com,
        eranian@google.com, hpa@zytor.com, tglx@linutronix.de, acme@redhat.com,
        linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cgroup: Add evlist__add_default_cgroup()
Git-Commit-ID: 483322dda03a7ad807e82f9c25fac315a4eee1c5
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

Commit-ID:  483322dda03a7ad807e82f9c25fac315a4eee1c5
Gitweb:     https://git.kernel.org/tip/483322dda03a7ad807e82f9c25fac315a4eee1c5
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Mar 2018 15:48:10 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:22:26 -0300

perf cgroup: Add evlist__add_default_cgroup()

So that tools like 'perf trace' can allow the user to set a cgroup
to be used for all the evsels still without a crgroup setup by
parse_cgroups(), such as the one to use for the syscalls, vfs_getname
and other events involved in strace like syscall tracing.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zf9jjsbj661r3lk6qb7g8j70@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 14 ++++++++++++++
 tools/perf/util/cgroup.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 6fd33ffc2488..d8cd0e601c56 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -182,6 +182,20 @@ struct cgroup *cgroup__get(struct cgroup *cgroup)
        return cgroup;
 }
 
+static void evsel__set_default_cgroup(struct perf_evsel *evsel, struct cgroup *cgroup)
+{
+	if (evsel->cgrp == NULL)
+		evsel->cgrp = cgroup__get(cgroup);
+}
+
+void evlist__set_default_cgroup(struct perf_evlist *evlist, struct cgroup *cgroup)
+{
+	struct perf_evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel)
+		evsel__set_default_cgroup(evsel, cgroup);
+}
+
 int parse_cgroups(const struct option *opt, const char *str,
 		  int unset __maybe_unused)
 {
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 0e377e6340dd..b213f5e9a3ed 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -22,6 +22,8 @@ struct perf_evlist;
 
 struct cgroup *evlist__findnew_cgroup(struct perf_evlist *evlist, char *name);
 
+void evlist__set_default_cgroup(struct perf_evlist *evlist, struct cgroup *cgroup);
+
 int parse_cgroups(const struct option *opt, const char *str, int unset);
 
 #endif /* __CGROUP_H__ */
