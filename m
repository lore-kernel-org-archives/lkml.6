Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbeCIIoV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:44:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54039 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeCIIoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:44:19 -0500
Date: Fri, 9 Mar 2018 00:44:09 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-4fda3459e3c2e5ca35d304646aeeb811242537b2@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, wangnan0@huawei.com, tglx@linutronix.de,
        acme@redhat.com, mingo@kernel.org, namhyung@kernel.org,
        kan.liang@linux.intel.com, hpa@zytor.com, jolsa@kernel.org,
        ak@linux.intel.com
Reply-To: hpa@zytor.com, kan.liang@linux.intel.com, jolsa@kernel.org,
        ak@linux.intel.com, wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, tglx@linutronix.de, namhyung@kernel.org,
        mingo@kernel.org
In-Reply-To: <1520350567-80082-2-git-send-email-kan.liang@linux.intel.com>
References: <1520350567-80082-2-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf mmap: Store mmap scope in struct perf_mmap()
Git-Commit-ID: 4fda3459e3c2e5ca35d304646aeeb811242537b2
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

Commit-ID:  4fda3459e3c2e5ca35d304646aeeb811242537b2
Gitweb:     https://git.kernel.org/tip/4fda3459e3c2e5ca35d304646aeeb811242537b2
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 6 Mar 2018 10:36:01 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 10:05:50 -0300

perf mmap: Store mmap scope in struct perf_mmap()

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
