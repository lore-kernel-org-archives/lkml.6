Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5205AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BB12098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BB12098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbeIQUdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:33:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728437AbeIQUdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:33:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 79F8CF96C0871;
        Mon, 17 Sep 2018 23:05:52 +0800 (CST)
Received: from linux-work.huawei.com (10.67.189.174) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Mon, 17 Sep 2018 23:05:48 +0800
From:   nixiaoming <nixiaoming@huawei.com>
To:     <jack@suse.cz>, <amir73il@gmail.com>
CC:     <nixiaoming@huawei.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] fanotify reports the thread id of the event trigger
Date:   Mon, 17 Sep 2018 22:19:50 +0800
Message-ID: <20180917141950.111841-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to identify which thread triggered the event in the
multi-threaded program, add the FAN_EVENT_INFO_TID tag in fanotify_init
to select whether to report the event creator's thread id information.

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 fs/notify/fanotify/fanotify.c      | 5 ++++-
 fs/notify/fanotify/fanotify_user.c | 5 +++--
 include/linux/fsnotify_backend.h   | 1 +
 include/uapi/linux/fanotify.h      | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 94b5215..5a3af87 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -171,7 +171,10 @@ struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
 		goto out;
 init: __maybe_unused
 	fsnotify_init_event(&event->fse, inode, mask);
-	event->tgid = get_pid(task_tgid(current));
+	if (group->fanotify_data.should_report_tid)
+		event->tgid = get_pid(task_pid(current));
+	else
+		event->tgid = get_pid(task_tgid(current));
 	if (path) {
 		event->path = *path;
 		path_get(&event->path);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 6905488..3aa425b 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -693,9 +693,9 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		return -EPERM;
 
 #ifdef CONFIG_AUDITSYSCALL
-	if (flags & ~(FAN_ALL_INIT_FLAGS | FAN_ENABLE_AUDIT))
+	if (flags & ~(FAN_ALL_INIT_FLAGS | FAN_ENABLE_AUDIT | FAN_EVENT_INFO_TID))
 #else
-	if (flags & ~FAN_ALL_INIT_FLAGS)
+	if (flags & ~(FAN_ALL_INIT_FLAGS | FAN_EVENT_INFO_TID))
 #endif
 		return -EINVAL;
 
@@ -731,6 +731,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	}
 
 	group->fanotify_data.user = user;
+	group->fanotify_data.should_report_tid = (flags & FAN_EVENT_INFO_TID) ? true : false;
 	atomic_inc(&user->fanotify_listeners);
 	group->memcg = get_mem_cgroup_from_mm(current->mm);
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index b8f4182..44c659f 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -193,6 +193,7 @@ struct fsnotify_group {
 			unsigned int max_marks;
 			struct user_struct *user;
 			bool audit;
+			bool should_report_tid;
 		} fanotify_data;
 #endif /* CONFIG_FANOTIFY */
 	};
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 7424791..4eba41c 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -18,6 +18,7 @@
 
 #define FAN_ONDIR		0x40000000	/* event occurred against dir */
 
+#define FAN_EVENT_INFO_TID	0x02000000	/* reports the thread id of the event trigger */
 #define FAN_EVENT_ON_CHILD	0x08000000	/* interested in child events */
 
 /* helper events */
-- 
2.10.1

