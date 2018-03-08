Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeCHTvs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:51:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751893AbeCHTvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:51:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D532178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/54] perf mmap: Store mmap scope in struct perf_mmap()
Date: Thu,  8 Mar 2018 16:49:58 -0300
Message-Id: <20180308195029.14991-24-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

There is too much boilerplate in the perf_mmap__read*() interfaces.

The 'start' and 'end' variables should be stored in struct perf_mmap at
initialization. They will be used later.

The old 'startp' and 'endp' pointers are used by perf_mmap__read_event()
now.  They cannot be removed. So the old 'startp/endp' and new
'md->start/md->end' will exist simultaneously now.  The old one will be
removed later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1520350567-80082-2-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 12 ++++++++----
 tools/perf/util/mmap.h |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 4f27c464ce0b..09acaf7392bb 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -250,13 +250,15 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 
 	*startp = overwrite ? head : old;
 	*endp = overwrite ? old : head;
+	md->start = md->overwrite ? head : old;
+	md->end = md->overwrite ? old : head;
 
-	if (*startp == *endp)
+	if (md->start == md->end)
 		return -EAGAIN;
 
-	size = *endp - *startp;
+	size = md->end - md->start;
 	if (size > (unsigned long)(md->mask) + 1) {
-		if (!overwrite) {
+		if (!md->overwrite) {
 			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
 
 			md->prev = head;
@@ -268,8 +270,10 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 		 * Backward ring buffer is full. We still have a chance to read
 		 * most of data from it.
 		 */
-		if (overwrite_rb_find_range(data, md->mask, head, startp, endp))
+		if (overwrite_rb_find_range(data, md->mask, head, &md->start, &md->end))
 			return -EINVAL;
+		*startp = md->start;
+		*endp = md->end;
 	}
 
 	return 0;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 71137977af28..9359e934ab14 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -20,6 +20,8 @@ struct perf_mmap {
 	int		 fd;
 	refcount_t	 refcnt;
 	u64		 prev;
+	u64		 start;
+	u64		 end;
 	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
-- 
2.14.3
