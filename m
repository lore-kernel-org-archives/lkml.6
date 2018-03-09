Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeCIIgZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:36:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36629 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeCIIgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:36:23 -0500
Date: Fri, 9 Mar 2018 00:36:12 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-5yqshcf5hm837n7c86u7lhjf@git.kernel.org>
Cc: namhyung@kernel.org, tglx@linutronix.de, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, eranian@google.com, acme@redhat.com,
        jolsa@kernel.org, hpa@zytor.com, mingo@kernel.org, wangnan0@huawei.com,
        adrian.hunter@intel.com
Reply-To: acme@redhat.com, jolsa@kernel.org, hpa@zytor.com, mingo@kernel.org,
        wangnan0@huawei.com, adrian.hunter@intel.com, namhyung@kernel.org,
        tglx@linutronix.de, dsahern@gmail.com, linux-kernel@vger.kernel.org,
        eranian@google.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cgroup: Introduce find_cgroup() method
Git-Commit-ID: b80271f76ac5fe498f8fb701b2745dcd841627cc
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

Commit-ID:  b80271f76ac5fe498f8fb701b2745dcd841627cc
Gitweb:     https://git.kernel.org/tip/b80271f76ac5fe498f8fb701b2745dcd841627cc
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Mar 2018 10:27:00 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:22:25 -0300

perf cgroup: Introduce find_cgroup() method

To break down complexity in add_cgroup().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-5yqshcf5hm837n7c86u7lhjf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 8ea964461eb7..84dfc34a6d0f 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -90,11 +90,10 @@ static int open_cgroup(char *name)
 	return fd;
 }
 
-static int add_cgroup(struct perf_evlist *evlist, char *str)
+static struct cgroup *evlist__find_cgroup(struct perf_evlist *evlist, char *str)
 {
 	struct perf_evsel *counter;
 	struct cgroup *cgrp = NULL;
-	int n;
 	/*
 	 * check if cgrp is already defined, if so we reuse it
 	 */
@@ -107,6 +106,15 @@ static int add_cgroup(struct perf_evlist *evlist, char *str)
 		}
 	}
 
+	return cgrp;
+}
+
+static int add_cgroup(struct perf_evlist *evlist, char *str)
+{
+	struct perf_evsel *counter;
+	struct cgroup *cgrp = evlist__find_cgroup(evlist, str);
+	int n;
+
 	if (!cgrp) {
 		cgrp = zalloc(sizeof(*cgrp));
 		if (!cgrp)
