Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424738AbeE1LQt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424517AbeE1LQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:16:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>, Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 231/272] fanotify: Avoid lost events due to ENOMEM for unlimited queues
Date: Mon, 28 May 2018 12:04:24 +0200
Message-Id: <20180528100259.797799079@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

[ Upstream commit 1f5eaa90010ed7cf0ae90a526c48657d02c6086f ]

Fanotify queues of unlimited length do not expect events can be lost.
Since these queues are used for system auditing and other security
related tasks, loosing events can even have security implications.
Currently, since the allocation is small (32-bytes), it cannot fail
however when we start accounting events in memcgs, allocation can start
failing. So avoid loosing events due to failure to allocate memory by
making event allocation use __GFP_NOFAIL.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/notify/fanotify/fanotify.c      |   19 ++++++++++++++-----
 fs/notify/fanotify/fanotify.h      |    3 ++-
 fs/notify/fanotify/fanotify_user.c |    2 +-
 3 files changed, 17 insertions(+), 7 deletions(-)

--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -135,23 +135,32 @@ static bool fanotify_should_send_event(s
 	return false;
 }
 
-struct fanotify_event_info *fanotify_alloc_event(struct inode *inode, u32 mask,
+struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
+						 struct inode *inode, u32 mask,
 						 const struct path *path)
 {
 	struct fanotify_event_info *event;
+	gfp_t gfp = GFP_KERNEL;
+
+	/*
+	 * For queues with unlimited length lost events are not expected and
+	 * can possibly have security implications. Avoid losing events when
+	 * memory is short.
+	 */
+	if (group->max_events == UINT_MAX)
+		gfp |= __GFP_NOFAIL;
 
 	if (fanotify_is_perm_event(mask)) {
 		struct fanotify_perm_event_info *pevent;
 
-		pevent = kmem_cache_alloc(fanotify_perm_event_cachep,
-					  GFP_KERNEL);
+		pevent = kmem_cache_alloc(fanotify_perm_event_cachep, gfp);
 		if (!pevent)
 			return NULL;
 		event = &pevent->fae;
 		pevent->response = 0;
 		goto init;
 	}
-	event = kmem_cache_alloc(fanotify_event_cachep, GFP_KERNEL);
+	event = kmem_cache_alloc(fanotify_event_cachep, gfp);
 	if (!event)
 		return NULL;
 init: __maybe_unused
@@ -206,7 +215,7 @@ static int fanotify_handle_event(struct
 			return 0;
 	}
 
-	event = fanotify_alloc_event(inode, mask, data);
+	event = fanotify_alloc_event(group, inode, mask, data);
 	ret = -ENOMEM;
 	if (unlikely(!event))
 		goto finish;
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -52,5 +52,6 @@ static inline struct fanotify_event_info
 	return container_of(fse, struct fanotify_event_info, fse);
 }
 
-struct fanotify_event_info *fanotify_alloc_event(struct inode *inode, u32 mask,
+struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
+						 struct inode *inode, u32 mask,
 						 const struct path *path);
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -757,7 +757,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned
 	group->fanotify_data.user = user;
 	atomic_inc(&user->fanotify_listeners);
 
-	oevent = fanotify_alloc_event(NULL, FS_Q_OVERFLOW, NULL);
+	oevent = fanotify_alloc_event(group, NULL, FS_Q_OVERFLOW, NULL);
 	if (unlikely(!oevent)) {
 		fd = -ENOMEM;
 		goto out_destroy_group;
