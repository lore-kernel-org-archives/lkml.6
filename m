Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeC2Klz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 06:41:55 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44899 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeC2Kly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 06:41:54 -0400
X-Google-Smtp-Source: AIpwx4/QBeBG71ZYFSbLP74/GG2Db98FaTg8mTIrM2k9wfXgeuXVmkDFDDJKXiHSLSkWhnpuzavYsw==
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
X-Google-Original-From: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-patch-test@lists.linaro.org
Subject: [PATCH v1] kernel/trace:check the val against the available mem
Date: Thu, 29 Mar 2018 18:41:44 +0800
Message-Id: <1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is reported that some user app would like to echo a huge
number to "/sys/kernel/debug/tracing/buffer_size_kb" regardless
 of the available memory, which will cause the coinstantaneous
page allocation failed and introduce OOM. The commit checking the
val against the available mem first to avoid the consequence allocation.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
---
 kernel/trace/trace.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2d0ffcc..a4a4237 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -43,6 +43,8 @@
 #include <linux/trace.h>
 #include <linux/sched/rt.h>
 
+#include <linux/mm.h>
+#include <linux/swap.h>
 #include "trace.h"
 #include "trace_output.h"
 
@@ -5967,6 +5969,39 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 	return ret;
 }
 
+static long get_available_mem(void)
+{
+	struct sysinfo i;
+	long available;
+	unsigned long pagecache;
+	unsigned long wmark_low = 0;
+	unsigned long pages[NR_LRU_LISTS];
+	struct zone *zone;
+	int lru;
+
+	si_meminfo(&i);
+	si_swapinfo(&i);
+
+	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
+		pages[lru] = global_page_state(NR_LRU_BASE + lru);
+
+	for_each_zone(zone)
+		wmark_low += zone->watermark[WMARK_LOW];
+
+	available = i.freeram - wmark_low;
+
+	pagecache = pages[LRU_ACTIVE_FILE] + pages[LRU_INACTIVE_FILE];
+	pagecache -= min(pagecache / 2, wmark_low);
+	available += pagecache;
+
+	available += global_page_state(NR_SLAB_RECLAIMABLE) -
+		min(global_page_state(NR_SLAB_RECLAIMABLE) / 2, wmark_low);
+
+	if (available < 0)
+		available = 0;
+	return available;
+}
+
 static ssize_t
 tracing_entries_write(struct file *filp, const char __user *ubuf,
 		      size_t cnt, loff_t *ppos)
@@ -5975,13 +6010,15 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 	struct trace_array *tr = inode->i_private;
 	unsigned long val;
 	int ret;
+	long available;
 
+	available = get_available_mem();
 	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
 	if (ret)
 		return ret;
 
 	/* must have at least 1 entry */
-	if (!val)
+	if (!val || (val > available))
 		return -EINVAL;
 
 	/* value is in KB */
-- 
1.9.1
