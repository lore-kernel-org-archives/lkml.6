Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC87ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D5E214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D5E214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeIQP2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:28:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbeIQP2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:28:48 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AD45D280CFD22;
        Mon, 17 Sep 2018 18:02:03 +0800 (CST)
Received: from linux-work.huawei.com (10.67.189.174) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.399.0; Mon, 17 Sep 2018 18:01:57 +0800
From:   nixiaoming <nixiaoming@huawei.com>
To:     <jack@suse.cz>, <amir73il@gmail.com>
CC:     <nixiaoming@huawei.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] fanotify support save thread id
Date:   Mon, 17 Sep 2018 17:16:02 +0800
Message-ID: <20180917091602.21531-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added FAN_EVENT_INFO_TID to select the thread id of the event trigger

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 fs/notify/fanotify/fanotify.c      | 66 +++++++++++++++++++++++++-------------
 fs/notify/fanotify/fanotify.h      |  2 +-
 fs/notify/fanotify/fanotify_user.c |  4 +--
 include/uapi/linux/fanotify.h      |  1 +
 4 files changed, 48 insertions(+), 25 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 94b5215..cf6ff4e 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -89,14 +89,36 @@ static int fanotify_get_response(struct fsnotify_group *group,
 	return ret;
 }
 
+static void fanotify_iter_mask(struct fsnotify_iter_info *iter_info,
+		  u32 event_mask, __u32 *marks_mask, __u32 *marks_ignored_mask)
+{
+	int type;
+	struct fsnotify_mark *mark;
+
+	fsnotify_foreach_obj_type(type) {
+		if (!fsnotify_iter_should_report_type(iter_info, type))
+			continue;
+		mark = iter_info->marks[type];
+		/*
+		 * if the event is for a child and this inode doesn't care about
+		 * events on the child, don't send it!
+		 */
+		if (type == FSNOTIFY_OBJ_TYPE_INODE &&
+		    (event_mask & FS_EVENT_ON_CHILD) &&
+		    !(mark->mask & FS_EVENT_ON_CHILD))
+			continue;
+
+		*marks_mask |= mark->mask;
+		*marks_ignored_mask |= mark->ignored_mask;
+	}
+}
+
 static bool fanotify_should_send_event(struct fsnotify_iter_info *iter_info,
 				       u32 event_mask, const void *data,
 				       int data_type)
 {
 	__u32 marks_mask = 0, marks_ignored_mask = 0;
 	const struct path *path = data;
-	struct fsnotify_mark *mark;
-	int type;
 
 	pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
 		 __func__, iter_info->report_mask, event_mask, data, data_type);
@@ -110,23 +132,7 @@ static bool fanotify_should_send_event(struct fsnotify_iter_info *iter_info,
 	    !d_can_lookup(path->dentry))
 		return false;
 
-	fsnotify_foreach_obj_type(type) {
-		if (!fsnotify_iter_should_report_type(iter_info, type))
-			continue;
-		mark = iter_info->marks[type];
-		/*
-		 * if the event is for a child and this inode doesn't care about
-		 * events on the child, don't send it!
-		 */
-		if (type == FSNOTIFY_OBJ_TYPE_INODE &&
-		    (event_mask & FS_EVENT_ON_CHILD) &&
-		    !(mark->mask & FS_EVENT_ON_CHILD))
-			continue;
-
-		marks_mask |= mark->mask;
-		marks_ignored_mask |= mark->ignored_mask;
-	}
-
+	fanotify_iter_mask(iter_info, event_mask, &marks_mask, &marks_ignored_mask);
 	if (d_is_dir(path->dentry) &&
 	    !(marks_mask & FS_ISDIR & ~marks_ignored_mask))
 		return false;
@@ -138,9 +144,20 @@ static bool fanotify_should_send_event(struct fsnotify_iter_info *iter_info,
 	return false;
 }
 
+static bool fanotify_should_save_tid(struct fsnotify_iter_info *iter_info,
+		 u32 event_mask)
+{
+	__u32 marks_mask = 0, marks_ignored_mask = 0;
+
+	fanotify_iter_mask(iter_info, event_mask, &marks_mask, &marks_ignored_mask);
+	if (marks_mask & FAN_EVENT_INFO_TID)
+		return true;
+	return false;
+}
+
 struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
 						 struct inode *inode, u32 mask,
-						 const struct path *path)
+						 const struct path *path, bool should_save_tid)
 {
 	struct fanotify_event_info *event = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
@@ -171,7 +188,10 @@ struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
 		goto out;
 init: __maybe_unused
 	fsnotify_init_event(&event->fse, inode, mask);
-	event->tgid = get_pid(task_tgid(current));
+	if (should_save_tid)
+		event->tgid = get_pid(task_pid(current));
+	else
+		event->tgid = get_pid(task_tgid(current));
 	if (path) {
 		event->path = *path;
 		path_get(&event->path);
@@ -193,6 +213,7 @@ static int fanotify_handle_event(struct fsnotify_group *group,
 	int ret = 0;
 	struct fanotify_event_info *event;
 	struct fsnotify_event *fsn_event;
+	bool should_save_tid;
 
 	BUILD_BUG_ON(FAN_ACCESS != FS_ACCESS);
 	BUILD_BUG_ON(FAN_MODIFY != FS_MODIFY);
@@ -219,8 +240,9 @@ static int fanotify_handle_event(struct fsnotify_group *group,
 		if (!fsnotify_prepare_user_wait(iter_info))
 			return 0;
 	}
+	should_save_tid = fanotify_should_save_tid(iter_info, mask);
 
-	event = fanotify_alloc_event(group, inode, mask, data);
+	event = fanotify_alloc_event(group, inode, mask, data, should_save_tid);
 	ret = -ENOMEM;
 	if (unlikely(!event)) {
 		/*
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 8609ba0..c303c574 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -54,4 +54,4 @@ static inline struct fanotify_event_info *FANOTIFY_E(struct fsnotify_event *fse)
 
 struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
 						 struct inode *inode, u32 mask,
-						 const struct path *path);
+						 const struct path *path, bool should_save_tid);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 6905488..99d431b 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -734,7 +734,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	atomic_inc(&user->fanotify_listeners);
 	group->memcg = get_mem_cgroup_from_mm(current->mm);
 
-	oevent = fanotify_alloc_event(group, NULL, FS_Q_OVERFLOW, NULL);
+	oevent = fanotify_alloc_event(group, NULL, FS_Q_OVERFLOW, NULL, false);
 	if (unlikely(!oevent)) {
 		fd = -ENOMEM;
 		goto out_destroy_group;
@@ -805,7 +805,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	struct fsnotify_group *group;
 	struct fd f;
 	struct path path;
-	u32 valid_mask = FAN_ALL_EVENTS | FAN_EVENT_ON_CHILD;
+	u32 valid_mask = FAN_ALL_EVENTS | FAN_EVENT_ON_CHILD | FAN_EVENT_INFO_TID;
 	int ret;
 
 	pr_debug("%s: fanotify_fd=%d flags=%x dfd=%d pathname=%p mask=%llx\n",
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 7424791..d4fa336 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -18,6 +18,7 @@
 
 #define FAN_ONDIR		0x40000000	/* event occurred against dir */
 
+#define FAN_EVENT_INFO_TID	0x02000000	/* event save thread id replace tgid */
 #define FAN_EVENT_ON_CHILD	0x08000000	/* interested in child events */
 
 /* helper events */
-- 
2.10.1

