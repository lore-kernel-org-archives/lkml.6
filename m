Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbeC2N7K (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:59:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46643 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752374AbeC2N7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:59:09 -0400
Date: Thu, 29 Mar 2018 06:58:58 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-895e3b06fc2ce438adc62cb13d31ea001dcfda16@git.kernel.org>
Cc: dsahern@gmail.com, hpa@zytor.com, wangnan0@huawei.com,
        kan.liang@intel.com, acme@redhat.com, tglx@linutronix.de,
        jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org
Reply-To: adrian.hunter@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, dsahern@gmail.com,
        jolsa@kernel.org, namhyung@kernel.org, kan.liang@intel.com,
        wangnan0@huawei.com, acme@redhat.com, tglx@linutronix.de
In-Reply-To: <20180326144127.GF18897@kernel.org>
References: <20180326144127.GF18897@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf mmap: Be consistent when checking for an
 unmaped ring buffer
Git-Commit-ID: 895e3b06fc2ce438adc62cb13d31ea001dcfda16
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

Commit-ID:  895e3b06fc2ce438adc62cb13d31ea001dcfda16
Gitweb:     https://git.kernel.org/tip/895e3b06fc2ce438adc62cb13d31ea001dcfda16
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 26 Mar 2018 11:42:15 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 27 Mar 2018 13:13:38 -0300

perf mmap: Be consistent when checking for an unmaped ring buffer

The previous patch is insufficient to cure the reported 'perf trace'
segfault, as it only cures the perf_mmap__read_done() case, moving the
segfault to perf_mmap__read_init() functio, fix it by doing the same
refcount check.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 8872481bd048 ("perf mmap: Introduce perf_mmap__read_init()")
Link: https://lkml.kernel.org/r/20180326144127.GF18897@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index f6cfc52ff1fe..fc832676a798 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -234,7 +234,7 @@ static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
 /*
  * Report the start and end of the available data in ringbuffer
  */
-int perf_mmap__read_init(struct perf_mmap *md)
+static int __perf_mmap__read_init(struct perf_mmap *md)
 {
 	u64 head = perf_mmap__read_head(md);
 	u64 old = md->prev;
@@ -268,6 +268,17 @@ int perf_mmap__read_init(struct perf_mmap *md)
 	return 0;
 }
 
+int perf_mmap__read_init(struct perf_mmap *map)
+{
+	/*
+	 * Check if event was unmapped due to a POLLHUP/POLLERR.
+	 */
+	if (!refcount_read(&map->refcnt))
+		return -ENOENT;
+
+	return __perf_mmap__read_init(map);
+}
+
 int perf_mmap__push(struct perf_mmap *md, void *to,
 		    int push(void *to, void *buf, size_t size))
 {
