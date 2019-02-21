Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E99C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B43021734
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550712382;
	bh=nz739urgN8zE0GgftxEOQoaznm4Kk3fHCbUTbWSI/5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d1gm2HxGO0odMzo3Exww+agTbaY7ziT+6YREkFvche3lryLex12mx20U8jtsmVj+U
	 wij/OnR0+EyBPvBRw5MXrz5VX9scoQjp+bQi4VM0/mjKSgI6lYrjnjb37ssSBbLEQU
	 4zZcJ/Pd/yAJp9kWH2WT8g6sbMi7DAon4zw4vuqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfBUB0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:26:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbfBUB0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:26:17 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.102.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B45D021908;
        Thu, 21 Feb 2019 01:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550712376;
        bh=nz739urgN8zE0GgftxEOQoaznm4Kk3fHCbUTbWSI/5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVRtlogsiS3/LDK/RDYxd+biiWoCVMIkkIstCuoicNVgBWNpEnR+D8aXBAB4D0M1e
         l4AfHs9KZoOYHJzSurorRggxqYki2+CbsjkqU6VhC1BGg+qiBTsV1Bob/vfxYZFMhN
         lIHrjTkEYnxBhmetmcyeEgG7npUOXOqdMY5hc/QY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/17] perf tools: Use sysfs__mountpoint() when reading cpu topology
Date:   Wed, 20 Feb 2019 22:25:37 -0300
Message-Id: <20190221012549.4069-6-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Use sysfs__mountpoint() when reading sysfs files to obtain cpu/numa
topologies.

Also use scnprintf instead of sprintf as suggested by Namhyung.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190219095815.15931-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.19.1

