Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeCIItQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:49:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51031 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeCIIoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:44:46 -0500
Date: Fri, 9 Mar 2018 00:44:37 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-07a9461da67292ffdf3f4a02522caf475b1151d7@git.kernel.org>
Cc: hpa@zytor.com, kan.liang@linux.intel.com, namhyung@kernel.org,
        tglx@linutronix.de, ak@linux.intel.com, mingo@kernel.org,
        acme@redhat.com, wangnan0@huawei.com, jolsa@kernel.org,
        jolsa@redhat.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, namhyung@kernel.org, kan.liang@linux.intel.com,
        hpa@zytor.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, mingo@kernel.org, acme@redhat.com,
        wangnan0@huawei.com, ak@linux.intel.com
In-Reply-To: <1520350567-80082-3-git-send-email-kan.liang@linux.intel.com>
References: <1520350567-80082-3-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf mmap: Use the stored scope data in
 perf_mmap__push()
Git-Commit-ID: 07a9461da67292ffdf3f4a02522caf475b1151d7
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

Commit-ID:  07a9461da67292ffdf3f4a02522caf475b1151d7
Gitweb:     https://git.kernel.org/tip/07a9461da67292ffdf3f4a02522caf475b1151d7
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 6 Mar 2018 10:36:02 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 10:05:51 -0300

perf mmap: Use the stored scope data in perf_mmap__push()

Using the 'start' and 'end' which are stored in struct perf_mmap to
replace the temporary 'start' and 'end'.
The temporary variables will be discarded later.

It doesn't need to pass 'overwrite' to perf_mmap__push(). It's stored in
struct perf_mmap.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1520350567-80082-3-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c |  2 +-
 tools/perf/util/mmap.c      | 24 ++++++++++++------------
 tools/perf/util/mmap.h      |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 14d82f0fe5cc..753ffcecf254 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -533,7 +533,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		struct auxtrace_mmap *mm = &maps[i].auxtrace_mmap;
 
 		if (maps[i].base) {
-			if (perf_mmap__push(&maps[i], overwrite, rec, record__pushfn) != 0) {
+			if (perf_mmap__push(&maps[i], rec, record__pushfn) != 0) {
 				rc = -1;
 				goto out;
 			}
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 09acaf7392bb..8c1d033638c2 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -279,8 +279,8 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 	return 0;
 }
 
-int perf_mmap__push(struct perf_mmap *md, bool overwrite,
-		    void *to, int push(void *to, void *buf, size_t size))
+int perf_mmap__push(struct perf_mmap *md, void *to,
+		    int push(void *to, void *buf, size_t size))
 {
 	u64 head = perf_mmap__read_head(md);
 	u64 end, start;
@@ -289,16 +289,16 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 	void *buf;
 	int rc = 0;
 
-	rc = perf_mmap__read_init(md, overwrite, &start, &end);
+	rc = perf_mmap__read_init(md, md->overwrite, &start, &end);
 	if (rc < 0)
 		return (rc == -EAGAIN) ? 0 : -1;
 
-	size = end - start;
+	size = md->end - md->start;
 
-	if ((start & md->mask) + size != (end & md->mask)) {
-		buf = &data[start & md->mask];
-		size = md->mask + 1 - (start & md->mask);
-		start += size;
+	if ((md->start & md->mask) + size != (md->end & md->mask)) {
+		buf = &data[md->start & md->mask];
+		size = md->mask + 1 - (md->start & md->mask);
+		md->start += size;
 
 		if (push(to, buf, size) < 0) {
 			rc = -1;
@@ -306,9 +306,9 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 		}
 	}
 
-	buf = &data[start & md->mask];
-	size = end - start;
-	start += size;
+	buf = &data[md->start & md->mask];
+	size = md->end - md->start;
+	md->start += size;
 
 	if (push(to, buf, size) < 0) {
 		rc = -1;
@@ -316,7 +316,7 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 	}
 
 	md->prev = head;
-	perf_mmap__consume(md, overwrite);
+	perf_mmap__consume(md, md->overwrite);
 out:
 	return rc;
 }
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 9359e934ab14..65f5b26d8668 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -93,8 +93,8 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map,
 					bool overwrite,
 					u64 *startp, u64 end);
 
-int perf_mmap__push(struct perf_mmap *md, bool backward,
-		    void *to, int push(void *to, void *buf, size_t size));
+int perf_mmap__push(struct perf_mmap *md, void *to,
+		    int push(void *to, void *buf, size_t size));
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
