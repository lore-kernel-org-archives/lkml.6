Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934434AbeBMKEI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:04:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933877AbeBMKEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:04:00 -0500
Date: Tue, 13 Feb 2018 02:03:51 -0800
From: tip-bot for Yang Shi <tipbot@zytor.com>
Message-ID: <tip-bd9dcd046509cd5355605e43791eacee8bf5e40f@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com,
        hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de
Reply-To: yang.shi@linux.alibaba.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <1517872708-24207-2-git-send-email-yang.shi@linux.alibaba.com>
References: <1517872708-24207-2-git-send-email-yang.shi@linux.alibaba.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/debugobjects] debugobjects: Export max loops counter
Git-Commit-ID: bd9dcd046509cd5355605e43791eacee8bf5e40f
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

Commit-ID:  bd9dcd046509cd5355605e43791eacee8bf5e40f
Gitweb:     https://git.kernel.org/tip/bd9dcd046509cd5355605e43791eacee8bf5e40f
Author:     Yang Shi <yang.shi@linux.alibaba.com>
AuthorDate: Tue, 6 Feb 2018 07:18:25 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 13 Feb 2018 10:58:58 +0100

debugobjects: Export max loops counter

__debug_check_no_obj_freed() can be an expensive operation depending on the
size of memory freed. It already exports the maximum chain walk length via
debugfs, but this only records the maximum of a single memory chunk.

Though there is no information about the total number of objects inspected
for a __debug_check_no_obj_freed() operation, which might be significantly
larger when a huge memory region is freed.

Aggregate the number of objects inspected for a single invocation of
__debug_check_no_obj_freed() and export it via sysfs.

The resulting output of /sys/kernel/debug/debug_objects/stats looks like:

max_chain     :121
max_checked   :543267
warnings      :0
fixups        :0
pool_free     :1764
pool_min_free :341
pool_used     :86438
pool_max_used :268887
objs_allocated:6068254
objs_freed    :5981076

[ tglx: Renamed the variable to max_checked and adjusted changelog ]

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: longman@redhat.com
Link: https://lkml.kernel.org/r/1517872708-24207-2-git-send-email-yang.shi@linux.alibaba.com

---
 lib/debugobjects.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 2f5349c..f6d57a1 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -50,6 +50,7 @@ static int			obj_pool_max_used;
 static struct kmem_cache	*obj_cache;
 
 static int			debug_objects_maxchain __read_mostly;
+static int			debug_objects_maxchecked __read_mostly;
 static int			debug_objects_fixups __read_mostly;
 static int			debug_objects_warnings __read_mostly;
 static int			debug_objects_enabled __read_mostly
@@ -720,7 +721,7 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
-	int cnt;
+	int cnt, objs_checked = 0;
 
 	saddr = (unsigned long) address;
 	eaddr = saddr + size;
@@ -765,7 +766,12 @@ repeat:
 
 		if (cnt > debug_objects_maxchain)
 			debug_objects_maxchain = cnt;
+
+		objs_checked += cnt;
 	}
+
+	if (objs_checked > debug_objects_maxchecked)
+		debug_objects_maxchecked = objs_checked;
 }
 
 void debug_check_no_obj_freed(const void *address, unsigned long size)
@@ -780,6 +786,7 @@ void debug_check_no_obj_freed(const void *address, unsigned long size)
 static int debug_stats_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "max_chain     :%d\n", debug_objects_maxchain);
+	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);
 	seq_printf(m, "warnings      :%d\n", debug_objects_warnings);
 	seq_printf(m, "fixups        :%d\n", debug_objects_fixups);
 	seq_printf(m, "pool_free     :%d\n", obj_pool_free);
