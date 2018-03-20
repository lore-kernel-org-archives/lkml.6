Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeCTGWb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:22:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53733 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbeCTGWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:22:24 -0400
Date: Mon, 19 Mar 2018 23:21:50 -0700
From: tip-bot for John Garry <tipbot@zytor.com>
Message-ID: <tip-931ef5dc5c18717d24e5b8d8a968e35638508051@git.kernel.org>
Cc: acme@redhat.com, zhangshaokun@hisilicon.com, jolsa@kernel.org,
        tglx@linutronix.de, ganapatrao.kulkarni@cavium.com,
        namhyung@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, mingo@kernel.org,
        john.garry@huawei.com, hpa@zytor.com, wcohen@redhat.com,
        will.deacon@arm.com, alexander.shishkin@linux.intel.com
Reply-To: tglx@linutronix.de, namhyung@kernel.org,
        ganapatrao.kulkarni@cavium.com, peterz@infradead.org, mingo@kernel.org,
        ak@linux.intel.com, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, hpa@zytor.com, will.deacon@arm.com,
        wcohen@redhat.com, alexander.shishkin@linux.intel.com, acme@redhat.com,
        zhangshaokun@hisilicon.com, jolsa@kernel.org
In-Reply-To: <1520506716-197429-3-git-send-email-john.garry@huawei.com>
References: <1520506716-197429-3-git-send-email-john.garry@huawei.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events: Fix error code in json_events()
Git-Commit-ID: 931ef5dc5c18717d24e5b8d8a968e35638508051
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

Commit-ID:  931ef5dc5c18717d24e5b8d8a968e35638508051
Gitweb:     https://git.kernel.org/tip/931ef5dc5c18717d24e5b8d8a968e35638508051
Author:     John Garry <john.garry@huawei.com>
AuthorDate: Thu, 8 Mar 2018 18:58:27 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:54:03 -0300

perf vendor events: Fix error code in json_events()

When EXPECT macro fails an assertion, the error code is not properly set
after the first loop of tokens in function json_events().

This is because err is set to the return value from func function
pointer call, which must be 0 to continue to loop, yet it is not reset
for for each loop. I assume that this was not the intention, so change
the code so err is set appropriately in EXPECT macro itself.

In addition to this, the indention in EXPECT macro is tidied. The
current indention alludes that the 2 statements following the if
statement are in the body, which is not true.

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
Link: http://lkml.kernel.org/r/1520506716-197429-3-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 9e0a21e74a67..edff989fbcea 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -249,9 +249,10 @@ static const char *field_to_perf(struct map *table, char *map, jsmntok_t *val)
 	jsmntok_t *loc = (t);					\
 	if (!(t)->start && (t) > tokens)			\
 		loc = (t) - 1;					\
-		pr_err("%s:%d: " m ", got %s\n", fn,		\
-			json_line(map, loc),			\
-			json_name(t));				\
+	pr_err("%s:%d: " m ", got %s\n", fn,			\
+	       json_line(map, loc),				\
+	       json_name(t));					\
+	err = -EIO;						\
 	goto out_free;						\
 } } while (0)
 
@@ -416,7 +417,7 @@ int json_events(const char *fn,
 		      char *metric_name, char *metric_group),
 	  void *data)
 {
-	int err = -EIO;
+	int err;
 	size_t size;
 	jsmntok_t *tokens, *tok;
 	int i, j, len;
