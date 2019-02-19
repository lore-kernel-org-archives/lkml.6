Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63006C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3036A2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550570313;
	bh=+uGGsZCd2pfiHkypeiBSUoyS84sazZC8eL3I9mo55qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZftrEyQGTBw24tQTbfvfCHR+7fHifEPU4AikqP6at7x120AbieQn10URuMdLYuHr3
	 +sfihg1G83fiEwZvVO2QOzfnTu6gRtN0gGU0/xietXtrX0dG+JviN2mIVVKzgVVFWB
	 YISmJKuSuoOnSV48WTZPTQRWAtUhXH3se9tEmTZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfBSJ6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:58:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfBSJ60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:58:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7878181F19;
        Tue, 19 Feb 2019 09:58:26 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB2C16013C;
        Tue, 19 Feb 2019 09:58:24 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 4/4] perf tools: Use sysfs__mountpoint() when reading cpu topology
Date:   Tue, 19 Feb 2019 10:58:15 +0100
Message-Id: <20190219095815.15931-5-jolsa@kernel.org>
In-Reply-To: <20190219095815.15931-1-jolsa@kernel.org>
References: <20190219095815.15931-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 19 Feb 2019 09:58:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using sysfs__mountpoint() when reading sysfs files
for cpu/numa topology.

Also using scnprintf instead of sprintf as suggested
by Namhyung.

Link: http://lkml.kernel.org/n/tip-pny10k3m9459q6f2j7ot7uzs@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/cputopo.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 83ffca2ea9ee..ece0710249d4 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/param.h>
 #include <inttypes.h>
+#include <api/fs/fs.h>
 
 #include "cputopo.h"
 #include "cpumap.h"
@@ -9,9 +10,15 @@
 
 
 #define CORE_SIB_FMT \
-	"/sys/devices/system/cpu/cpu%d/topology/core_siblings_list"
+	"%s/devices/system/cpu/cpu%d/topology/core_siblings_list"
 #define THRD_SIB_FMT \
-	"/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list"
+	"%s/devices/system/cpu/cpu%d/topology/thread_siblings_list"
+#define NODE_ONLINE_FMT \
+	"%s/devices/system/node/online"
+#define NODE_MEMINFO_FMT \
+	"%s/devices/system/node/node%d/meminfo"
+#define NODE_CPULIST_FMT \
+	"%s/devices/system/node/node%d/cpulist"
 
 static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 {
@@ -23,7 +30,8 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	u32 i = 0;
 	int ret = -1;
 
-	sprintf(filename, CORE_SIB_FMT, cpu);
+	scnprintf(filename, MAXPATHLEN, CORE_SIB_FMT,
+		  sysfs__mountpoint(), cpu);
 	fp = fopen(filename, "r");
 	if (!fp)
 		goto try_threads;
@@ -50,7 +58,8 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	ret = 0;
 
 try_threads:
-	sprintf(filename, THRD_SIB_FMT, cpu);
+	scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT,
+		  sysfs__mountpoint(), cpu);
 	fp = fopen(filename, "r");
 	if (!fp)
 		goto done;
@@ -157,7 +166,8 @@ static int load_numa_node(struct numa_topology_node *node, int nr)
 
 	node->node = (u32) nr;
 
-	sprintf(str, "/sys/devices/system/node/node%d/meminfo", nr);
+	scnprintf(str, MAXPATHLEN, NODE_MEMINFO_FMT,
+		  sysfs__mountpoint(), nr);
 	fp = fopen(str, "r");
 	if (!fp)
 		return -1;
@@ -179,7 +189,8 @@ static int load_numa_node(struct numa_topology_node *node, int nr)
 	fclose(fp);
 	fp = NULL;
 
-	sprintf(str, "/sys/devices/system/node/node%d/cpulist", nr);
+	scnprintf(str, MAXPATHLEN, NODE_CPULIST_FMT,
+		  sysfs__mountpoint(), nr);
 
 	fp = fopen(str, "r");
 	if (!fp)
@@ -207,13 +218,17 @@ struct numa_topology *numa_topology__new(void)
 {
 	struct cpu_map *node_map = NULL;
 	struct numa_topology *tp = NULL;
+	char path[MAXPATHLEN];
 	char *buf = NULL;
 	size_t len = 0;
 	u32 nr, i;
 	FILE *fp;
 	char *c;
 
-	fp = fopen("/sys/devices/system/node/online", "r");
+	scnprintf(path, MAXPATHLEN, NODE_ONLINE_FMT,
+		  sysfs__mountpoint());
+
+	fp = fopen(path, "r");
 	if (!fp)
 		return NULL;
 
-- 
2.17.2

