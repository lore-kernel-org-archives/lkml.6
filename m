Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934691AbeEYMtx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:49:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38550 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934265AbeEYMtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:49:50 -0400
X-Google-Smtp-Source: ADUXVKLmNUQ6r9GAlK2IJfDG9ReJPUA7DD5S+lvTU16aIcIuQ2RB9jfOYGZim1Q1b6Ix1Cwv+cDmjw==
From: Christian Brauner <christian@brauner.io>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, linux-api@vger.kernel.org, ebiederm@xmission.com,
        seth.forshee@canonical.com, viro@zeniv.linux.org.uk,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 6/6 v1 resend] statfs: add ST_PRIVATE
Date: Fri, 25 May 2018 14:48:25 +0200
Message-Id: <20180525124825.23875-7-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525124825.23875-1-christian@brauner.io>
References: <20180525124825.23875-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently userspace can only determine whether a mountpoint is private
by parsing /proc/<pid>/mountinfo. It would be convenient to simply retrieve
this property with a statvfs() call.
This let's userspace avoid costly parsing, supports cases where /proc is
not mounted, and supports usecases where file descriptors to mountpoints are
passed between processes that are inspected via fstatvfs().
A mountpoint is considered ST_PRIVATE iff and it is neither ST_SLAVE nor
ST_SHARED.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
* non-functional changes: extend commit message
---
 fs/statfs.c            | 2 ++
 include/linux/statfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/statfs.c b/fs/statfs.c
index 35ad0402c9a3..899e899ee84c 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -58,6 +58,8 @@ static int calculate_f_flags(struct vfsmount *mnt)
 
 	if (IS_MNT_SLAVE(real_mount(mnt)))
 		flags |= ST_SLAVE;
+	else if (!(flags & ST_SHARED))
+		flags |= ST_PRIVATE;
 
 	return flags;
 }
diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index 048127effaad..663fa5498a7d 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -41,6 +41,7 @@ struct kstatfs {
 #define ST_NODIRATIME	(1<<11) /* do not update directory access times */
 #define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime */
 #define ST_UNBINDABLE	(1<<17)	/* change to unbindable */
+#define ST_PRIVATE	(1<<18)	/* change to private */
 #define ST_SLAVE	(1<<19)	/* change to slave */
 #define ST_SHARED	(1<<20)	/* change to shared */
 
-- 
2.17.0
