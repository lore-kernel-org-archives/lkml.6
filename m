Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeBASQ1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:16:27 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:42899 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752894AbeBASQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:16:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0SxX0U2T_1517508959;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: tglx@linutronix.de, longman@redhat.com
Cc: yang.shi@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2 v5] lib: debugobjects: export max loops counter
Date: Fri,  2 Feb 2018 02:15:58 +0800
Message-Id: <1517508959-63958-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently max chain counter is exported to debugfs, it just record the
counter of inner loop, however, there might be significant iterations of
external loop then it may take significant amount of time to finish all
of the checks. This may cause lockup on !CONFIG_PREEMPT kernel build
occasionally.

Record the counter of the max loops then export to sysfs so that the
user can be aware of the real overhead.

Then the output of /sys/kernel/debug/debug_objects/stats looks like:

max_chain     :121
max_loops     :543267
warnings      :0
fixups        :0
pool_free     :1764
pool_min_free :341
pool_used     :86438
pool_max_used :268887
objs_allocated:6068254
objs_freed    :5981076

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
v1 --> v2:
 * Correct the typo in the commit log

 lib/debugobjects.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 2f5349c..166488d 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -50,6 +50,7 @@ struct debug_bucket {
 static struct kmem_cache	*obj_cache;
 
 static int			debug_objects_maxchain __read_mostly;
+static int			debug_objects_maxloops __read_mostly;
 static int			debug_objects_fixups __read_mostly;
 static int			debug_objects_warnings __read_mostly;
 static int			debug_objects_enabled __read_mostly
@@ -720,7 +721,7 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
-	int cnt;
+	int cnt, max_loops = 0;
 
 	saddr = (unsigned long) address;
 	eaddr = saddr + size;
@@ -765,7 +766,12 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
 		if (cnt > debug_objects_maxchain)
 			debug_objects_maxchain = cnt;
+
+		max_loops += cnt;
 	}
+
+	if (max_loops > debug_objects_maxloops)
+		debug_objects_maxloops = max_loops;
 }
 
 void debug_check_no_obj_freed(const void *address, unsigned long size)
@@ -780,6 +786,7 @@ void debug_check_no_obj_freed(const void *address, unsigned long size)
 static int debug_stats_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "max_chain     :%d\n", debug_objects_maxchain);
+	seq_printf(m, "max_loops     :%d\n", debug_objects_maxloops);
 	seq_printf(m, "warnings      :%d\n", debug_objects_warnings);
 	seq_printf(m, "fixups        :%d\n", debug_objects_fixups);
 	seq_printf(m, "pool_free     :%d\n", obj_pool_free);
-- 
1.8.3.1
