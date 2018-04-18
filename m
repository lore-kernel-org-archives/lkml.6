Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeDRG3i (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 02:29:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34504 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752357AbeDRG3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 02:29:36 -0400
Smtp-Origin-Hostprefix: devbig
From: Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig102.frc2.facebook.com
To: <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Smtp-Origin-Cluster: frc2c02
Subject: [PATCH 2/2] perf/core: fix bad use of igrab in kernel/event/core.c
Date: Tue, 17 Apr 2018 23:29:07 -0700
Message-ID: <20180418062907.3210386-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180418062907.3210386-1-songliubraving@fb.com>
References: <20180418062907.3210386-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Miklos reported and suggested:

  This pattern repeats two times in trace_uprobe.c and in
  kernel/events/core.c as well:

      ret = kern_path(filename, LOOKUP_FOLLOW, &path);
      if (ret)
          goto fail_address_parse;

      inode = igrab(d_inode(path.dentry));
      path_put(&path);

  And it's wrong.  You can only hold a reference to the inode if you
  have an active ref to the superblock as well (which is normally
  through path.mnt) or holding s_umount.

  This way unmounting the containing filesystem while the tracepoint is
  active will give you the "VFS: Busy inodes after unmount..." message
  and a crash when the inode is finally put.

  Solution: store path instead of inode.

This patch fixes the issue in kernel/event/core.c.

NOTE: Based on my understanding, perf_addr_filter only supports intel_pt.
However, my test system doesn't support address filtering (or I made a
mistake?). Therefore, I have NOT tested this patch.

Could someone please help test it?

Fixes: 375637bc5249 ("perf/core: Introduce address range filtering")
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/events/intel/pt.c |  4 ++--
 include/linux/perf_event.h |  2 +-
 kernel/events/core.c       | 21 +++++++++------------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 3b99394..8d016ce 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1194,7 +1194,7 @@ static int pt_event_addr_filters_validate(struct list_head *filters)
 		    filter->action == PERF_ADDR_FILTER_ACTION_START)
 			return -EOPNOTSUPP;
 
-		if (!filter->inode) {
+		if (!filter->path.dentry) {
 			if (!valid_kernel_ip(filter->offset))
 				return -EINVAL;
 
@@ -1221,7 +1221,7 @@ static void pt_event_addr_filters_sync(struct perf_event *event)
 		return;
 
 	list_for_each_entry(filter, &head->list, entry) {
-		if (filter->inode && !offs[range]) {
+		if (filter->path.dentry && !offs[range]) {
 			msr_a = msr_b = 0;
 		} else {
 			/* apply the offset */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e71e99e..88922d8 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -467,7 +467,7 @@ enum perf_addr_filter_action_t {
  */
 struct perf_addr_filter {
 	struct list_head	entry;
-	struct inode		*inode;
+	struct path		path;
 	unsigned long		offset;
 	unsigned long		size;
 	enum perf_addr_filter_action_t	action;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d7af828..7d711ed 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6668,7 +6668,7 @@ static void perf_event_addr_filters_exec(struct perf_event *event, void *data)
 
 	raw_spin_lock_irqsave(&ifh->lock, flags);
 	list_for_each_entry(filter, &ifh->list, entry) {
-		if (filter->inode) {
+		if (filter->path.dentry) {
 			event->addr_filters_offs[count] = 0;
 			restart++;
 		}
@@ -7333,7 +7333,7 @@ static bool perf_addr_filter_match(struct perf_addr_filter *filter,
 				     struct file *file, unsigned long offset,
 				     unsigned long size)
 {
-	if (filter->inode != file_inode(file))
+	if (d_inode(filter->path.dentry) != file_inode(file))
 		return false;
 
 	if (filter->offset > offset + size)
@@ -8674,8 +8674,7 @@ static void free_filters_list(struct list_head *filters)
 	struct perf_addr_filter *filter, *iter;
 
 	list_for_each_entry_safe(filter, iter, filters, entry) {
-		if (filter->inode)
-			iput(filter->inode);
+		path_put(&filter->path);
 		list_del(&filter->entry);
 		kfree(filter);
 	}
@@ -8772,7 +8771,7 @@ static void perf_event_addr_filters_apply(struct perf_event *event)
 		 * Adjust base offset if the filter is associated to a binary
 		 * that needs to be mapped:
 		 */
-		if (filter->inode)
+		if (filter->path.dentry)
 			event->addr_filters_offs[count] =
 				perf_addr_filter_apply(filter, mm);
 
@@ -8846,7 +8845,6 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 {
 	struct perf_addr_filter *filter = NULL;
 	char *start, *orig, *filename = NULL;
-	struct path path;
 	substring_t args[MAX_OPT_ARGS];
 	int state = IF_STATE_ACTION, token;
 	unsigned int kernel = 0;
@@ -8959,19 +8957,18 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 					goto fail_free_name;
 
 				/* look up the path and grab its inode */
-				ret = kern_path(filename, LOOKUP_FOLLOW, &path);
+				ret = kern_path(filename, LOOKUP_FOLLOW,
+						&filter->path);
 				if (ret)
 					goto fail_free_name;
 
-				filter->inode = igrab(d_inode(path.dentry));
-				path_put(&path);
 				kfree(filename);
 				filename = NULL;
 
 				ret = -EINVAL;
-				if (!filter->inode ||
-				    !S_ISREG(filter->inode->i_mode))
-					/* free_filters_list() will iput() */
+				if (!filter->path.dentry ||
+				    !S_ISREG(d_inode(filter->path.dentry)
+					     ->i_mode))
 					goto fail;
 
 				event->addr_filters.nr_file_filters++;
-- 
2.9.5
