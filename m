Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeCIIpT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:45:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53187 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbeCIIpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:45:15 -0500
Date: Fri, 9 Mar 2018 00:45:05 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-b9de0f6e507b2f0ee305aba338b79941deb5a461@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, namhyung@kernel.org, wangnan0@huawei.com,
        kan.liang@linux.intel.com, mingo@kernel.org, jolsa@kernel.org,
        ak@linux.intel.com, tglx@linutronix.de, hpa@zytor.com, acme@redhat.com
Reply-To: acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        ak@linux.intel.com, jolsa@kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, wangnan0@huawei.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1520350567-80082-4-git-send-email-kan.liang@linux.intel.com>
References: <1520350567-80082-4-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf mmap: Use the stored data in
 perf_mmap__read_event()
Git-Commit-ID: b9de0f6e507b2f0ee305aba338b79941deb5a461
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

Commit-ID:  b9de0f6e507b2f0ee305aba338b79941deb5a461
Gitweb:     https://git.kernel.org/tip/b9de0f6e507b2f0ee305aba338b79941deb5a461
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 6 Mar 2018 10:36:03 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 10:05:51 -0300

perf mmap: Use the stored data in perf_mmap__read_event()

Using the 'start', 'end' and 'overwrite' which are stored in
struct perf_mmap to replace the parameters of perf_mmap__read_event().
The parameters will be discarded later.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1520350567-80082-4-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 8c1d033638c2..2933942abfe2 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -76,8 +76,9 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
  * perf_mmap__read_done()
  */
 union perf_event *perf_mmap__read_event(struct perf_mmap *map,
-					bool overwrite,
-					u64 *startp, u64 end)
+					bool overwrite __maybe_unused,
+					u64 *startp __maybe_unused,
+					u64 end __maybe_unused)
 {
 	union perf_event *event;
 
@@ -87,17 +88,14 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map,
 	if (!refcount_read(&map->refcnt))
 		return NULL;
 
-	if (startp == NULL)
-		return NULL;
-
 	/* non-overwirte doesn't pause the ringbuffer */
-	if (!overwrite)
-		end = perf_mmap__read_head(map);
+	if (!map->overwrite)
+		map->end = perf_mmap__read_head(map);
 
-	event = perf_mmap__read(map, startp, end);
+	event = perf_mmap__read(map, &map->start, map->end);
 
-	if (!overwrite)
-		map->prev = *startp;
+	if (!map->overwrite)
+		map->prev = map->start;
 
 	return event;
 }
