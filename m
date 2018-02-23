Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeBWPOd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:14:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39962 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751913AbeBWPO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:14:27 -0500
From: John Garry <john.garry@huawei.com>
To: <jolsa@redhat.com>, <ak@linux.intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <wcohen@redhat.com>, <will.deacon@arm.com>,
        <ganapatrao.kulkarni@cavium.com>
CC: <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <zhangshaokun@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 02/11] perf vendor events: fix error code in json_events()
Date: Sat, 24 Feb 2018 00:05:23 +0800
Message-ID: <1519401932-205051-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
References: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When EXPECT macro fails an assertion, the error code is
not properly set after the first loop of tokens in function
json_events().

This is because err is set to the return value from func
function pointer call, which must be 0 to continue to loop,
yet it is not reset for for each loop. I assume that this was
not the intention, so change the code so err is set
appropriately in EXPECT macro itself.

In addition to this, the indention in EXPECT macro is
tidied. The current indention alludes that the 2 statements
following the if statement are in the body, which is not
true.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 9e0a21e..edff989 100644
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
-- 
1.9.1
