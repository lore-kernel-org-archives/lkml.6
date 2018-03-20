Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeCTGXB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:23:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33475 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCTGXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:23:00 -0400
Date: Mon, 19 Mar 2018 23:22:19 -0700
From: tip-bot for John Garry <tipbot@zytor.com>
Message-ID: <tip-6f2f2ca3454ec4fa03fcd4507bdd7fe97303065b@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, acme@redhat.com,
        zhangshaokun@hisilicon.com, tglx@linutronix.de, john.garry@huawei.com,
        ganapatrao.kulkarni@cavium.com, peterz@infradead.org,
        will.deacon@arm.com, wcohen@redhat.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, namhyung@kernel.org, ak@linux.intel.com,
        mingo@kernel.org, jolsa@kernel.org
Reply-To: jolsa@kernel.org, mingo@kernel.org, ak@linux.intel.com,
        namhyung@kernel.org, wcohen@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, zhangshaokun@hisilicon.com,
        ganapatrao.kulkarni@cavium.com, john.garry@huawei.com,
        tglx@linutronix.de, acme@redhat.com,
        alexander.shishkin@linux.intel.com
In-Reply-To: <1520506716-197429-4-git-send-email-john.garry@huawei.com>
References: <1520506716-197429-4-git-send-email-john.garry@huawei.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events: Drop support for unused topic
 directories
Git-Commit-ID: 6f2f2ca3454ec4fa03fcd4507bdd7fe97303065b
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

Commit-ID:  6f2f2ca3454ec4fa03fcd4507bdd7fe97303065b
Gitweb:     https://git.kernel.org/tip/6f2f2ca3454ec4fa03fcd4507bdd7fe97303065b
Author:     John Garry <john.garry@huawei.com>
AuthorDate: Thu, 8 Mar 2018 18:58:28 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:54:09 -0300

perf vendor events: Drop support for unused topic directories

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
