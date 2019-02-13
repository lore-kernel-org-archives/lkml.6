Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F31EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B04222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550061192;
	bh=DHI0KyreQtOP2A2foV49q1CjJSgR7TSEucInpThCzW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0dYot7yD0uh5gJOPGYTwASiOZhRjjqR3MObq6L7noVhn7cov2rkFwvkvSAuQI4iJf
	 ITCTlO+sRoK+h0Nv5bVAO7gD2Hr1sl4qyM17c1CGdL2JTqhJehFCKFZud0/KqxLfqe
	 pqcboTBfA3GJF0koUi9ml5KJV1ther1DA/K51gD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbfBMMdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:33:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388069AbfBMMdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:33:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CAE25A7DF;
        Wed, 13 Feb 2019 12:33:06 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A8CD60856;
        Wed, 13 Feb 2019 12:33:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 10/10] perf tools: Add perf_topo_numa object
Date:   Wed, 13 Feb 2019 13:32:46 +0100
Message-Id: <20190213123246.4015-11-jolsa@kernel.org>
In-Reply-To: <20190213123246.4015-1-jolsa@kernel.org>
References: <20190213123246.4015-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 13 Feb 2019 12:33:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_topo_numa object to return the list of numa
nodes together with their cpus. It will replace the numa
code in header.c and will be used from perf record code
in following patches.

Adding following interface functions to load numa details:

  struct perf_topo_numa *perf_topo_numa__new(void);
  void perf_topo_numa__free(struct perf_topo_numa *tp);

And replacing current (copied) local interface, with no
functional changes.

Link: http://lkml.kernel.org/n/tip-rn15st6hjj7txg2i88v7yff4@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/cputopo.c | 120 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cputopo.h |  16 +++++
 tools/perf/util/header.c  | 119 +++++++++----------------------------
 3 files changed, 162 insertions(+), 93 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 43e5e3292c34..45bd0e4eec36 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/param.h>
+#include <inttypes.h>
 
 #include "cputopo.h"
 #include "cpumap.h"
 #include "util.h"
+#include "env.h"
 
 
 #define CORE_SIB_FMT \
@@ -142,3 +144,121 @@ struct perf_topo_cpu *perf_topo_cpu__new(void)
 	}
 	return tp;
 }
+
+static int load_numa_node(struct perf_topo_node *node, int nr)
+{
+	char str[MAXPATHLEN];
+	char field[32];
+	char *buf = NULL, *p;
+	size_t len = 0;
+	int ret = -1;
+	FILE *fp;
+	u64 mem;
+
+	node->node = (u32) nr;
+
+	sprintf(str, "/sys/devices/system/node/node%d/meminfo", nr);
+	fp = fopen(str, "r");
+	if (!fp)
+		return -1;
+
+	while (getline(&buf, &len, fp) > 0) {
+		/* skip over invalid lines */
+		if (!strchr(buf, ':'))
+			continue;
+		if (sscanf(buf, "%*s %*d %31s %"PRIu64, field, &mem) != 2)
+			goto err;
+		if (!strcmp(field, "MemTotal:"))
+			node->mem_total = mem;
+		if (!strcmp(field, "MemFree:"))
+			node->mem_free = mem;
+		if (node->mem_total && node->mem_free)
+			break;
+	}
+
+	fclose(fp);
+	fp  = NULL;
+	buf = NULL;
+
+	ret = -1;
+	sprintf(str, "/sys/devices/system/node/node%d/cpulist", nr);
+
+	fp = fopen(str, "r");
+	if (!fp)
+		return -1;
+
+	if (getline(&buf, &len, fp) <= 0)
+		goto err;
+
+	p = strchr(buf, '\n');
+	if (p)
+		*p = '\0';
+
+	node->cpus = buf;
+	fclose(fp);
+	return 0;
+
+err:
+	free(buf);
+	if (fp)
+		fclose(fp);
+	return ret;
+}
+
+struct perf_topo_numa *perf_topo_numa__new(void)
+{
+	struct cpu_map *node_map = NULL;
+	struct perf_topo_numa *tp = NULL;
+	char *buf = NULL;
+	size_t len = 0;
+	u32 nr, i;
+	FILE *fp;
+	char *c;
+
+	fp = fopen("/sys/devices/system/node/online", "r");
+	if (!fp)
+		return NULL;
+
+	if (getline(&buf, &len, fp) <= 0)
+		goto out;
+
+	c = strchr(buf, '\n');
+	if (c)
+		*c = '\0';
+
+	node_map = cpu_map__new(buf);
+	if (!node_map)
+		goto out;
+
+	nr = (u32) node_map->nr;
+
+	tp = zalloc(sizeof(*tp) + sizeof(tp->nodes[0])*nr);
+	if (!tp)
+		goto out;
+
+	tp->nr = nr;
+
+	for (i = 0; i < nr; i++) {
+		if (load_numa_node(&tp->nodes[i], node_map->map[i])) {
+			perf_topo_numa__free(tp);
+			tp = NULL;
+			break;
+		}
+	}
+
+out:
+	free(buf);
+	fclose(fp);
+	cpu_map__put(node_map);
+	return tp;
+}
+
+void perf_topo_numa__free(struct perf_topo_numa *tp)
+{
+	u32 i;
+
+	for (i = 0; i < tp->nr; i++)
+		free(tp->nodes[i].cpus);
+
+	free(tp);
+}
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index 764e7f5289d8..b89da4bac8b6 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -3,6 +3,7 @@
 #define __PERF_CPUTOPO_H
 
 #include <linux/types.h>
+#include "env.h"
 
 struct perf_topo_cpu {
 	u32	  core_sib;
@@ -11,7 +12,22 @@ struct perf_topo_cpu {
 	char	**thread_siblings;
 };
 
+struct perf_topo_node {
+	char		*cpus;
+	u32		 node;
+	u64		 mem_total;
+	u64		 mem_free;
+};
+
+struct perf_topo_numa {
+	u32			nr;
+	struct perf_topo_node	nodes[0];
+};
+
 struct perf_topo_cpu *perf_topo_cpu__new(void);
 void perf_topo_cpu__free(struct perf_topo_cpu *tp);
 
+struct perf_topo_numa *perf_topo_numa__new(void);
+void perf_topo_numa__free(struct perf_topo_numa *tp);
+
 #endif /* __PERF_CPUTOPO_H */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index bf285319c5cd..4b40ac67320e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -639,112 +639,45 @@ static int write_total_mem(struct feat_fd *ff,
 	return ret;
 }
 
-static int write_topo_node(struct feat_fd *ff, int node)
-{
-	char str[MAXPATHLEN];
-	char field[32];
-	char *buf = NULL, *p;
-	size_t len = 0;
-	FILE *fp;
-	u64 mem_total, mem_free, mem;
-	int ret = -1;
-
-	sprintf(str, "/sys/devices/system/node/node%d/meminfo", node);
-	fp = fopen(str, "r");
-	if (!fp)
-		return -1;
-
-	while (getline(&buf, &len, fp) > 0) {
-		/* skip over invalid lines */
-		if (!strchr(buf, ':'))
-			continue;
-		if (sscanf(buf, "%*s %*d %31s %"PRIu64, field, &mem) != 2)
-			goto done;
-		if (!strcmp(field, "MemTotal:"))
-			mem_total = mem;
-		if (!strcmp(field, "MemFree:"))
-			mem_free = mem;
-	}
-
-	fclose(fp);
-	fp = NULL;
-
-	ret = do_write(ff, &mem_total, sizeof(u64));
-	if (ret)
-		goto done;
-
-	ret = do_write(ff, &mem_free, sizeof(u64));
-	if (ret)
-		goto done;
-
-	ret = -1;
-	sprintf(str, "/sys/devices/system/node/node%d/cpulist", node);
-
-	fp = fopen(str, "r");
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
-	ret = do_write_string(ff, buf);
-done:
-	free(buf);
-	if (fp)
-		fclose(fp);
-	return ret;
-}
-
 static int write_numa_topology(struct feat_fd *ff,
 			       struct perf_evlist *evlist __maybe_unused)
 {
-	char *buf = NULL;
-	size_t len = 0;
-	FILE *fp;
-	struct cpu_map *node_map = NULL;
-	char *c;
-	u32 nr, i, j;
+	struct perf_topo_numa *tp;
 	int ret = -1;
+	u32 i;
 
-	fp = fopen("/sys/devices/system/node/online", "r");
-	if (!fp)
-		return -1;
+	tp = perf_topo_numa__new();
+	if (!tp)
+		return -ENOMEM;
 
-	if (getline(&buf, &len, fp) <= 0)
-		goto done;
+	ret = do_write(ff, &tp->nr, sizeof(u32));
+	if (ret < 0)
+		goto err;
 
-	c = strchr(buf, '\n');
-	if (c)
-		*c = '\0';
+	for (i = 0; i < tp->nr; i++) {
+		struct perf_topo_node *n = &tp->nodes[i];
 
-	node_map = cpu_map__new(buf);
-	if (!node_map)
-		goto done;
-
-	nr = (u32)node_map->nr;
+		ret = do_write(ff, &n->node, sizeof(u32));
+		if (ret < 0)
+			goto err;
 
-	ret = do_write(ff, &nr, sizeof(nr));
-	if (ret < 0)
-		goto done;
+		ret = do_write(ff, &n->mem_total, sizeof(u64));
+		if (ret)
+			goto err;
 
-	for (i = 0; i < nr; i++) {
-		j = (u32)node_map->map[i];
-		ret = do_write(ff, &j, sizeof(j));
-		if (ret < 0)
-			break;
+		ret = do_write(ff, &n->mem_free, sizeof(u64));
+		if (ret)
+			goto err;
 
-		ret = write_topo_node(ff, j);
+		ret = do_write_string(ff, n->cpus);
 		if (ret < 0)
-			break;
+			goto err;
 	}
-done:
-	free(buf);
-	fclose(fp);
-	cpu_map__put(node_map);
+
+	ret = 0;
+
+err:
+	perf_topo_numa__free(tp);
 	return ret;
 }
 
-- 
2.17.2

