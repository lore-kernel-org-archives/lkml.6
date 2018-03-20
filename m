Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeCTGeA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:34:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44781 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeCTGd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:33:56 -0400
Date: Mon, 19 Mar 2018 23:33:31 -0700
From: tip-bot for Yisheng Xie <tipbot@zytor.com>
Message-ID: <tip-699db111058798bcc9f92a93767062905a561bef@git.kernel.org>
Cc: acme@redhat.com, kan.liang@linux.intel.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        mingo@kernel.org, jolsa@redhat.com, xieyisheng1@huawei.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: kan.liang@linux.intel.com, acme@redhat.com, jolsa@redhat.com,
        mingo@kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        xieyisheng1@huawei.com, hpa@zytor.com
In-Reply-To: <1520944274-37001-1-git-send-email-xieyisheng1@huawei.com>
References: <1520944274-37001-1-git-send-email-xieyisheng1@huawei.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf mmap: Discard head in
 overwrite_rb_find_range()
Git-Commit-ID: 699db111058798bcc9f92a93767062905a561bef
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

Commit-ID:  699db111058798bcc9f92a93767062905a561bef
Gitweb:     https://git.kernel.org/tip/699db111058798bcc9f92a93767062905a561bef
Author:     Yisheng Xie <xieyisheng1@huawei.com>
AuthorDate: Tue, 13 Mar 2018 20:31:13 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 16:33:05 -0300

perf mmap: Discard head in overwrite_rb_find_range()

In overwrite mode, start will be set to head in perf_mmap__read_init().
Therefore, there is no need to set the start one more time in
overwrite_rb_find_range() and *start can be used as head instead of
passing head to overwrite_rb_find_range().

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1520944274-37001-1-git-send-email-xieyisheng1@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 074c4fd3b67e..38ca3ffb9d61 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -199,19 +199,18 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
 	return 0;
 }
 
-static int overwrite_rb_find_range(void *buf, int mask, u64 head, u64 *start, u64 *end)
+static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
 {
 	struct perf_event_header *pheader;
-	u64 evt_head = head;
+	u64 evt_head = *start;
 	int size = mask + 1;
 
-	pr_debug2("overwrite_rb_find_range: buf=%p, head=%"PRIx64"\n", buf, head);
-	pheader = (struct perf_event_header *)(buf + (head & mask));
-	*start = head;
+	pr_debug2("%s: buf=%p, start=%"PRIx64"\n", __func__, buf, *start);
+	pheader = (struct perf_event_header *)(buf + (*start & mask));
 	while (true) {
-		if (evt_head - head >= (unsigned int)size) {
+		if (evt_head - *start >= (unsigned int)size) {
 			pr_debug("Finished reading overwrite ring buffer: rewind\n");
-			if (evt_head - head > (unsigned int)size)
+			if (evt_head - *start > (unsigned int)size)
 				evt_head -= pheader->size;
 			*end = evt_head;
 			return 0;
@@ -262,7 +261,7 @@ int perf_mmap__read_init(struct perf_mmap *md)
 		 * Backward ring buffer is full. We still have a chance to read
 		 * most of data from it.
 		 */
-		if (overwrite_rb_find_range(data, md->mask, head, &md->start, &md->end))
+		if (overwrite_rb_find_range(data, md->mask, &md->start, &md->end))
 			return -EINVAL;
 	}
 
