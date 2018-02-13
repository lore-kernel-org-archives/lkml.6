Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933061AbeBMAtx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 19:49:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:7122 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932736AbeBMAtw (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 19:49:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,504,1511856000";
   d="scan'208";a="17179126"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf report: Fix a memory corrupton issue when enabling --branch-history
Date: Tue, 13 Feb 2018 16:44:28 +0800
Message-Id: <1518511468-32737-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following command lines will cause perf crash.

perf record -j call -g -a <application>
perf report --branch-history

*** Error in `perf': double free or corruption (!prev): 0x00000000104aa040 ***
======= Backtrace: =========
/lib/x86_64-linux-gnu/libc.so.6(+0x77725)[0x7f6b37254725]
/lib/x86_64-linux-gnu/libc.so.6(+0x7ff4a)[0x7f6b3725cf4a]
/lib/x86_64-linux-gnu/libc.so.6(cfree+0x4c)[0x7f6b37260abc]
perf[0x51b914]
perf(hist_entry_iter__add+0x1e5)[0x51f305]
perf[0x43cf01]
perf[0x4fa3bf]
perf[0x4fa923]
perf[0x4fd396]
perf[0x4f9614]
perf(perf_session__process_events+0x89e)[0x4fc38e]
perf(cmd_report+0x15d2)[0x43f202]
perf[0x4a059f]
perf(main+0x631)[0x427b71]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf0)[0x7f6b371fd830]
perf(_start+0x29)[0x427d89]

The memory corruption happens at:

iter_add_next_cumulative_entry()
{
        ...
        for (i = 0; i < iter->curr; i++) {
        ...
}

Whatever in iter_next_cumulative_entry() or in iter_add_next_cumulative_entry(),
they all don't check if iter->curr exceeds the array 'he_cache[]'.

If there are too many nodes in callchain, it's possible that iter->curr >
iter->max_stack, then memory corruption occurs.

This patch will reallocate array 'he_cache[]' in iter_next_cumulative_entry()
if necessary (the case of too many nodes in callchain).

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/hist.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index b614095..71f07d2 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -926,11 +926,32 @@ iter_next_cumulative_entry(struct hist_entry_iter *iter,
 			   struct addr_location *al)
 {
 	struct callchain_cursor_node *node;
+	struct hist_entry **tmp;
+	int i;
 
 	node = callchain_cursor_current(&callchain_cursor);
 	if (node == NULL)
 		return 0;
 
+	/*
+	 * If there are too many nodes in callchain,
+	 * increase the size of he_cache[].
+	 */
+	if (iter->curr == iter->max_stack) {
+		i = 2 * iter->max_stack + 1;
+		tmp = realloc(iter->priv, sizeof(struct hist_entry *) * i);
+		if (tmp == NULL) {
+			/*
+			 * No need to free iter->priv here. It will be
+			 * freed in iter_finish_cumulative_entry.
+			 */
+			return 0;
+		}
+
+		iter->priv = tmp;
+		iter->max_stack = i;
+	}
+
 	return fill_callchain_info(al, node, iter->hide_unresolved);
 }
 
-- 
2.7.4
