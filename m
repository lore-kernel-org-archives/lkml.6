Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935647AbeCHK7s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:59:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755732AbeCHK7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:59:44 -0500
From: John Garry <john.garry@huawei.com>
To: <jolsa@redhat.com>, <ak@linux.intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <wcohen@redhat.com>, <will.deacon@arm.com>,
        <ganapatrao.kulkarni@cavium.com>
CC: <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <zhangshaokun@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v3 03/11] perf vendor events: drop support for unused topic directories
Date: Thu, 8 Mar 2018 18:58:28 +0800
Message-ID: <1520506716-197429-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520506716-197429-1-git-send-email-john.garry@huawei.com>
References: <1520506716-197429-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a topic subdirectory is supported in the
pmu-events dir, in the following sample structure:
/arch/platform/subtopic/mysubtopic.json

Upto 256 levels of topic subdirectories are supported. So this
means that JSONs may be located in a topic dir as well as the
platform dir.

This topic subdirectory causes problems if we want to add support
for a vendor dir in the pmu-events structure (in the form
arch/platform/vendor), in that we cannot differentiate between
a vendor dir and a topic dir.

Since the topic dir feature is not used, drop it so it
does not block adding vendor subdirectory support.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
NOTE: There was a bug in this code with how add_topic()
sets topic_level. Also a delimiter could be added in printing
the "topic" in get_topic().

 tools/perf/pmu-events/jevents.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index edff989..1d02faf 100644
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
1.9.1
