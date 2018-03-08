Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeCHTvC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:51:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751030AbeCHTu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:50:59 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27B82177B
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
Subject: [PATCH 06/54] perf cgroup: Introduce find_cgroup() method
Date: Thu,  8 Mar 2018 16:49:41 -0300
Message-Id: <20180308195029.14991-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
