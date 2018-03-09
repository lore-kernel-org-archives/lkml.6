Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeCIIpo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:45:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39157 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbeCIIpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:45:42 -0500
Date: Fri, 9 Mar 2018 00:45:33 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-bdec8b2f7eed4f16b764ca258487d26f8079f5ff@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kan.liang@linux.intel.com, ak@linux.intel.com, acme@redhat.com,
        namhyung@kernel.org, hpa@zytor.com, wangnan0@huawei.com,
        jolsa@kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        jolsa@kernel.org, ak@linux.intel.com, kan.liang@linux.intel.com,
        acme@redhat.com, namhyung@kernel.org, hpa@zytor.com,
        wangnan0@huawei.com
In-Reply-To: <1520350567-80082-5-git-send-email-kan.liang@linux.intel.com>
References: <1520350567-80082-5-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf mmap: Use stored 'overwrite' in
 perf_mmap__consume()
Git-Commit-ID: bdec8b2f7eed4f16b764ca258487d26f8079f5ff
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

Commit-ID:  bdec8b2f7eed4f16b764ca258487d26f8079f5ff
Gitweb:     https://git.kernel.org/tip/bdec8b2f7eed4f16b764ca258487d26f8079f5ff
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 6 Mar 2018 10:36:04 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 10:05:52 -0300

perf mmap: Use stored 'overwrite' in perf_mmap__consume()

The 'overwrite' is set at allocation. It will not be changed.  Using it
to replace the parameter of perf_mmap__consume().  The parameters will
be discarded later.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1520350567-80082-5-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 2933942abfe2..8a2dac90056c 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -118,9 +118,9 @@ void perf_mmap__put(struct perf_mmap *map)
 		perf_mmap__munmap(map);
 }
 
-void perf_mmap__consume(struct perf_mmap *map, bool overwrite)
+void perf_mmap__consume(struct perf_mmap *map, bool overwrite __maybe_unused)
 {
-	if (!overwrite) {
+	if (!map->overwrite) {
 		u64 old = map->prev;
 
 		perf_mmap__write_tail(map, old);
