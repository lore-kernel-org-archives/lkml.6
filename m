Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF6DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C9421900
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550489985;
	bh=FSV0nj6tadsjTuNHiUxgHF1iK7vmKj9gjwnToGz2iOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HVSlMojqB21T7DgCh+JKNRnZ1wrc2DlJi8Qivul71TsKCeCkW5Njac38nvCsH1ib6
	 44GEVywCj/+1QYeC4B5SQTdHMZkc4lMs145wSjozf498wwKD57loHcwv9b45FArMBY
	 xtaLWPGPhxoUF5tcaEwFqPYfjsTWZf5QyomVNe3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfBRLji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:39:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbfBRLjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:39:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 184DD85360;
        Mon, 18 Feb 2019 11:39:33 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F2FB5D70A;
        Mon, 18 Feb 2019 11:39:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 2/3] perf tools: Add cpu_topology object
Date:   Mon, 18 Feb 2019 12:39:26 +0100
Message-Id: <20190218113927.30841-3-jolsa@kernel.org>
In-Reply-To: <20190218113927.30841-1-jolsa@kernel.org>
References: <20190218113927.30841-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 18 Feb 2019 11:39:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making struct cpu_topo global and renaming it to
struct cpu_topology, so it can be used from record
command in following patches.

Adding following interface functions to load/free
cpu topology details:
  struct cpu_topology *cpu_topology__new(void);
  void cpu_topology__delete(struct cpu_topology *tp);

Moving it into separate object file cputopo.c together
with numa related object in following patches.

No functional change, the new interface will be used
in upcoming changes.

Link: http://lkml.kernel.org/n/tip-4g1sdzg0bvd5la96xw06y3en@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/Build     |   1 +
 tools/perf/util/cputopo.c | 144 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/cputopo.h |  17 +++++
 tools/perf/util/header.c  | 150 +-------------------------------------
 4 files changed, 166 insertions(+), 146 deletions(-)
 create mode 100644 tools/perf/util/cputopo.c
 create mode 100644 tools/perf/util/cputopo.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index ca0741c91903..3008d49fa587 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -69,6 +69,7 @@ perf-y += hist.o
 perf-y += util.o
 perf-y += xyarray.o
 perf-y += cpumap.o
+perf-y += cputopo.o
 perf-y += cgroup.o
 perf-y += target.o
 perf-y += rblist.o
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
new file mode 100644
index 000000000000..84470ed4e707
--- /dev/null
+++ b/tools/perf/util/cputopo.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/param.h>
+
+#include "cputopo.h"
+#include "cpumap.h"
+#include "util.h"
+
+
+#define CORE_SIB_FMT \
+	"/sys/devices/system/cpu/cpu%d/topology/core_siblings_list"
+#define THRD_SIB_FMT \
+	"/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list"
+
+static int build_cpu_topology(struct cpu_topology *tp, int cpu)
+{
+	FILE *fp;
+	char filename[MAXPATHLEN];
+	char *buf = NULL, *p;
+	size_t len = 0;
+	ssize_t sret;
+	u32 i = 0;
+	int ret = -1;
+
+	sprintf(filename, CORE_SIB_FMT, cpu);
+	fp = fopen(filename, "r");
+	if (!fp)
+		goto try_threads;
+
+	sret = getline(&buf, &len, fp);
+	fclose(fp);
+	if (sret <= 0)
+		goto try_threads;
+
+	p = strchr(buf, '\n');
+	if (p)
+		*p = '\0';
+
+	for (i = 0; i < tp->core_sib; i++) {
+		if (!strcmp(buf, tp->core_siblings[i]))
+			break;
+	}
+	if (i == tp->core_sib) {
+		tp->core_siblings[i] = buf;
+		tp->core_sib++;
+		buf = NULL;
+		len = 0;
+	}
+	ret = 0;
+
+try_threads:
+	sprintf(filename, THRD_SIB_FMT, cpu);
+	fp = fopen(filename, "r");
+	if (!fp)
+		goto done;
+
+	if (getline(&buf, &len, fp) <= 0)
+		goto done;
+
+	p = strchr(buf, '\n');
+	if (p)
+		*p = '\0';
+
+	for (i = 0; i < tp->thread_sib; i++) {
+		if (!strcmp(buf, tp->thread_siblings[i]))
+			break;
+	}
+	if (i == tp->thread_sib) {
+		tp->thread_siblings[i] = buf;
+		tp->thread_sib++;
+		buf = NULL;
+	}
+	ret = 0;
+done:
+	if (fp)
+		fclose(fp);
+	free(buf);
+	return ret;
+}
+
+void cpu_topology__delete(struct cpu_topology *tp)
+{
+	u32 i;
+
+	if (!tp)
+		return;
+
+	for (i = 0 ; i < tp->core_sib; i++)
+		zfree(&tp->core_siblings[i]);
+
+	for (i = 0 ; i < tp->thread_sib; i++)
+		zfree(&tp->thread_siblings[i]);
+
+	free(tp);
+}
+
+struct cpu_topology *cpu_topology__new(void)
+{
+	struct cpu_topology *tp = NULL;
+	void *addr;
+	u32 nr, i;
+	size_t sz;
+	long ncpus;
+	int ret = -1;
+	struct cpu_map *map;
+
+	ncpus = cpu__max_present_cpu();
+
+	/* build online CPU map */
+	map = cpu_map__new(NULL);
+	if (map == NULL) {
+		pr_debug("failed to get system cpumap\n");
+		return NULL;
+	}
+
+	nr = (u32)(ncpus & UINT_MAX);
+
+	sz = nr * sizeof(char *);
+	addr = calloc(1, sizeof(*tp) + 2 * sz);
+	if (!addr)
+		goto out_free;
+
+	tp = addr;
+	addr += sizeof(*tp);
+	tp->core_siblings = addr;
+	addr += sz;
+	tp->thread_siblings = addr;
+
+	for (i = 0; i < nr; i++) {
+		if (!cpu_map__has(map, i))
+			continue;
+
+		ret = build_cpu_topology(tp, i);
+		if (ret < 0)
+			break;
+	}
+
+out_free:
+	cpu_map__put(map);
+	if (ret) {
+		cpu_topology__delete(tp);
+		tp = NULL;
+	}
+	return tp;
+}
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
new file mode 100644
index 000000000000..4b5f4112b6f8
--- /dev/null
+++ b/tools/perf/util/cputopo.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_CPUTOPO_H
+#define __PERF_CPUTOPO_H
+
+#include <linux/types.h>
+
+struct cpu_topology {
+	u32	  core_sib;
+	u32	  thread_sib;
+	char	**core_siblings;
+	char	**thread_siblings;
+};
+
+struct cpu_topology *cpu_topology__new(void);
+void cpu_topology__delete(struct cpu_topology *tp);
+
+#endif /* __PERF_CPUTOPO_H */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c66f26ec557a..80ac57e6d38f 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -39,6 +39,7 @@
 #include "tool.h"
 #include "time-utils.h"
 #include "units.h"
+#include "cputopo.h"
 
 #include "sane_ctype.h"
 
@@ -557,158 +558,15 @@ static int write_cmdline(struct feat_fd *ff,
 	return 0;
 }
 
-#define CORE_SIB_FMT \
-	"/sys/devices/system/cpu/cpu%d/topology/core_siblings_list"
-#define THRD_SIB_FMT \
-	"/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list"
-
-struct cpu_topo {
-	u32 core_sib;
-	u32 thread_sib;
-	char **core_siblings;
-	char **thread_siblings;
-};
-
-static int build_cpu_topo(struct cpu_topo *tp, int cpu)
-{
-	FILE *fp;
-	char filename[MAXPATHLEN];
-	char *buf = NULL, *p;
-	size_t len = 0;
-	ssize_t sret;
-	u32 i = 0;
-	int ret = -1;
-
-	sprintf(filename, CORE_SIB_FMT, cpu);
-	fp = fopen(filename, "r");
-	if (!fp)
-		goto try_threads;
-
-	sret = getline(&buf, &len, fp);
-	fclose(fp);
-	if (sret <= 0)
-		goto try_threads;
-
-	p = strchr(buf, '\n');
-	if (p)
-		*p = '\0';
-
-	for (i = 0; i < tp->core_sib; i++) {
-		if (!strcmp(buf, tp->core_siblings[i]))
-			break;
-	}
-	if (i == tp->core_sib) {
-		tp->core_siblings[i] = buf;
-		tp->core_sib++;
-		buf = NULL;
-		len = 0;
-	}
-	ret = 0;
-
-try_threads:
-	sprintf(filename, THRD_SIB_FMT, cpu);
-	fp = fopen(filename, "r");
-	if (!fp)
-		goto done;
-
-	if (getline(&buf, &len, fp) <= 0)
-		goto done;
-
-	p = strchr(buf, '\n');
-	if (p)
-		*p = '\0';
-
-	for (i = 0; i < tp->thread_sib; i++) {
-		if (!strcmp(buf, tp->thread_siblings[i]))
-			break;
-	}
-	if (i == tp->thread_sib) {
-		tp->thread_siblings[i] = buf;
-		tp->thread_sib++;
-		buf = NULL;
-	}
-	ret = 0;
-done:
-	if(fp)
-		fclose(fp);
-	free(buf);
-	return ret;
-}
-
-static void free_cpu_topo(struct cpu_topo *tp)
-{
-	u32 i;
-
-	if (!tp)
-		return;
-
-	for (i = 0 ; i < tp->core_sib; i++)
-		zfree(&tp->core_siblings[i]);
-
-	for (i = 0 ; i < tp->thread_sib; i++)
-		zfree(&tp->thread_siblings[i]);
-
-	free(tp);
-}
-
-static struct cpu_topo *build_cpu_topology(void)
-{
-	struct cpu_topo *tp = NULL;
-	void *addr;
-	u32 nr, i;
-	size_t sz;
-	long ncpus;
-	int ret = -1;
-	struct cpu_map *map;
-
-	ncpus = cpu__max_present_cpu();
-
-	/* build online CPU map */
-	map = cpu_map__new(NULL);
-	if (map == NULL) {
-		pr_debug("failed to get system cpumap\n");
-		return NULL;
-	}
-
-	nr = (u32)(ncpus & UINT_MAX);
-
-	sz = nr * sizeof(char *);
-	addr = calloc(1, sizeof(*tp) + 2 * sz);
-	if (!addr)
-		goto out_free;
-
-	tp = addr;
-	addr += sizeof(*tp);
-	tp->core_siblings = addr;
-	addr += sz;
-	tp->thread_siblings = addr;
-
-	for (i = 0; i < nr; i++) {
-		if (!cpu_map__has(map, i))
-			continue;
-
-		ret = build_cpu_topo(tp, i);
-		if (ret < 0)
-			break;
-	}
-
-out_free:
-	cpu_map__put(map);
-	if (ret) {
-		free_cpu_topo(tp);
-		tp = NULL;
-	}
-	return tp;
-}
 
 static int write_cpu_topology(struct feat_fd *ff,
 			      struct perf_evlist *evlist __maybe_unused)
 {
-	struct cpu_topo *tp;
+	struct cpu_topology *tp;
 	u32 i;
 	int ret, j;
 
-	tp = build_cpu_topology();
+	tp = cpu_topology__new();
 	if (!tp)
 		return -1;
 
@@ -746,7 +604,7 @@ static int write_cpu_topology(struct feat_fd *ff,
 			return ret;
 	}
 done:
-	free_cpu_topo(tp);
+	cpu_topology__delete(tp);
 	return ret;
 }
 
-- 
2.17.2

