Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933290AbeCMMGK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933266AbeCMMGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:06:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1617121796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>, William Cohen <wcohen@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/31] perf vendor events: Drop support for unused topic directories
Date: Tue, 13 Mar 2018 09:04:50 -0300
Message-Id: <20180313120508.29327-14-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

Currently a topic subdirectory is supported in the pmu-events dir, in
the following sample structure: /arch/platform/subtopic/mysubtopic.json

Upto 256 levels of topic subdirectories are supported. So this means
that JSONs may be located in a topic dir as well as the platform dir.

This topic subdirectory causes problems if we want to add support for a
vendor dir in the pmu-events structure (in the form
arch/platform/vendor), in that we cannot differentiate between a vendor
dir and a topic dir.

Since the topic dir feature is not used, drop it so it does not block
adding vendor subdirectory support.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lkml.kernel.org/r/1520506716-197429-4-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index edff989fbcea..1d02fafdc34d 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -256,25 +256,18 @@ static const char *field_to_perf(struct map *table, char *map, jsmntok_t *val)
 	goto out_free;						\
 } } while (0)
 
-#define TOPIC_DEPTH 256
-static char *topic_array[TOPIC_DEPTH];
-static int   topic_level;
+static char *topic;
 
 static char *get_topic(void)
 {
-	char *tp_old, *tp = NULL;
+	char *tp;
 	int i;
 
-	for (i = 0; i < topic_level + 1; i++) {
-		int n;
-
-		tp_old = tp;
-		n = asprintf(&tp, "%s%s", tp ?: "", topic_array[i]);
-		if (n < 0) {
-			pr_info("%s: asprintf() error %s\n", prog);
-			return NULL;
-		}
-		free(tp_old);
+	/* tp is free'd in process_one_file() */
+	i = asprintf(&tp, "%s", topic);
+	if (i < 0) {
+		pr_info("%s: asprintf() error %s\n", prog);
+		return NULL;
 	}
 
 	for (i = 0; i < (int) strlen(tp); i++) {
@@ -291,25 +284,15 @@ static char *get_topic(void)
 	return tp;
 }
 
-static int add_topic(int level, char *bname)
+static int add_topic(char *bname)
 {
-	char *topic;
-
-	level -= 2;
-
-	if (level >= TOPIC_DEPTH)
-		return -EINVAL;
-
+	free(topic);
 	topic = strdup(bname);
 	if (!topic) {
 		pr_info("%s: strdup() error %s for file %s\n", prog,
 				strerror(errno), bname);
 		return -ENOMEM;
 	}
-
-	free(topic_array[topic_level]);
-	topic_array[topic_level] = topic;
-	topic_level              = level;
 	return 0;
 }
 
@@ -824,7 +807,7 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 		}
 	}
 
-	if (level > 1 && add_topic(level, bname))
+	if (level > 1 && add_topic(bname))
 		return -ENOMEM;
 
 	/*
-- 
2.14.3
