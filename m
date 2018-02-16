Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932621AbeBPJt7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:49:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48125 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932579AbeBPJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:49:55 -0500
Date: Fri, 16 Feb 2018 01:34:54 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-dc6c35c679e96987dc83a003f30bc2cc33c84c00@git.kernel.org>
Cc: tglx@linutronix.de, peterz@infradead.org, acme@redhat.com,
        wangnan0@huawei.com, kan.liang@intel.com, hpa@zytor.com,
        namhyung@kernel.org, yao.jin@linux.intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, ak@linux.intel.com
Reply-To: mingo@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
        yao.jin@linux.intel.com, jolsa@kernel.org, wangnan0@huawei.com,
        namhyung@kernel.org, hpa@zytor.com, kan.liang@intel.com,
        peterz@infradead.org, acme@redhat.com, tglx@linutronix.de
In-Reply-To: <1516310792-208685-3-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-3-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf mmap: Recalculate size for overwrite mode
Git-Commit-ID: dc6c35c679e96987dc83a003f30bc2cc33c84c00
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

Commit-ID:  dc6c35c679e96987dc83a003f30bc2cc33c84c00
Gitweb:     https://git.kernel.org/tip/dc6c35c679e96987dc83a003f30bc2cc33c84c00
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:17 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Feb 2018 09:51:57 -0300

perf mmap: Recalculate size for overwrite mode

In perf_mmap__push(), the 'size' need to be recalculated, otherwise the
invalid data might be pushed to the record in overwrite mode.

The issue is introduced by commit 7fb4b407a124 ("perf mmap: Don't
discard prev in backward mode").

When the ring buffer is full in overwrite mode, backward_rb_find_range()
will be called to recalculate the 'start' and 'end'. The 'size' needs to
be recalculated accordingly.

Unconditionally recalculate the 'size', not just for full ring buffer in
overwrite mode. Because:

- There is no harmful to recalculate the 'size' for other cases.
- The code of calculating 'start' and 'end' will be factored out later.
  The new function does not need to return 'size'.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 7fb4b407a124 ("perf mmap: Don't discard prev in backward mode")
Link: http://lkml.kernel.org/r/1516310792-208685-3-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 05076e6..97cf4fa 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -302,6 +302,8 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 			return -1;
 	}
 
+	size = end - start;
+
 	if ((start & md->mask) + size != (end & md->mask)) {
 		buf = &data[start & md->mask];
 		size = md->mask + 1 - (start & md->mask);
