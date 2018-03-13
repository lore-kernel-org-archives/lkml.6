Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520960139; cv=none;
        d=google.com; s=arc-20160816;
        b=TTpcfeDJkuCRt8bR6tzx1MJjmGTtc0ZHgTtSGc1njvi087U9eUdFpw4FCY3KxTEy9R
         axKqXdxLonIZW0is8K8yoSbkTSQK6z4N0kK7FNThqczS0uJNjVNYZsNX5nDdXxlS7HDG
         r7+C/z3nHCetGY/pxC2a/MWpd+uzsxbJdwQVtFIuX1dnf+7LBpRjBZ0ZvNa+c7e1fni1
         q8Trgj7Z0UMvNng5va8zEEY9q9EY9fzRdx9d91vT0+iMcKvkhUPDZjzJWlzNVetak8cL
         9IkmORVYHvMZvx/e+PsPLEAWDOIUeccCgPsdKvYOCqPju5Re6ZVzUpH1Xy9SZ4aEkqD/
         DI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=XhNiE2qqWHPiwfvp94IDzinS4JriIaG0mN0SWjhf1lI=;
        b=DLPwewFGqCyuxU8Uac6w/hPvzhrh3mUItyuYifGbqzJJPniCRvdnyGaz3u3TEpyk8R
         4FZtxerkzyCl/rwGwmsrluvEDFsF+c9AzfMoniw/xMaojyNu1c+srcVhPrURq9EQ5exo
         qzb6HWlUE1USZYVD65WTGJUDOiWmvw+WoEMnw+KSp2Ku0/Syx+Jr2mThyIhUB/mfNi29
         Xm6Af688Df7CPpWIYtwn26V/eS1PDmi//gtC4OHMvwE3Ji5GL00Cvr+Aoya1WtQoXG+J
         h7tc7TgP1W3rd+Jz9FnJ+eYWOqbsioyreY+Md6yeRefwSUj22yB08LQaEt5jmiwcMfso
         kR6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AG47ELuxR3cdCJkESw9cywzU7WMhYUA86bz7PziwbXPbTMK+YZznpmXTn6yysvWMItQLy1NYW8fKEQ==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org,
	ebiederm@xmission.com,
	torvalds@linux-foundation.org,
	gregkh@linuxfoundation.org
Cc: containers@lists.linux-foundation.org,
	Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/4 v5 RESEND] devpts: comment devpts_mntget()
Date: Tue, 13 Mar 2018 17:55:26 +0100
Message-Id: <20180313165527.24038-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180313165527.24038-1-christian.brauner@ubuntu.com>
References: <20180313165527.24038-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594842299960773653?=
X-GMAIL-MSGID: =?utf-8?q?1594842299960773653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
---
ChangeLog v4->v5:
* patch added
ChangeLog v3->v4:
* patch not present
ChangeLog v2->v3:
* patch not present
ChangeLog v1->v2:
* patch not present
ChangeLog v0->v1:
* patch not present
---
 fs/devpts/inode.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 542364bf923e..e072e955ce33 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -152,6 +152,24 @@ static int devpts_ptmx_path(struct path *path)
 	return 0;
 }
 
+/*
+ * Try to find a suitable devpts filesystem. We support the following
+ * scenarios:
+ * - The ptmx device node is located in the same directory as the devpts
+ *   mount where the pts device nodes are located.
+ *   This is e.g. the case when calling open on the /dev/pts/ptmx device
+ *   node when the devpts filesystem is mounted at /dev/pts.
+ * - The ptmx device node is located outside the devpts filesystem mount
+ *   where the pts device nodes are located. For example, the ptmx device
+ *   is a symlink, separate device node, or bind-mount.
+ *   A supported scenario is bind-mounting /dev/pts/ptmx to /dev/ptmx and
+ *   then calling open on /dev/ptmx. In this case a suitable pts
+ *   subdirectory can be found in the common parent directory /dev of the
+ *   devpts mount and the ptmx bind-mount, after resolving the /dev/ptmx
+ *   bind-mount.
+ *   If no suitable pts subdirectory can be found this function will fail.
+ *   This is e.g. the case when bind-mounting /dev/pts/ptmx to /ptmx.
+ */
 struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
 {
 	struct path path;
-- 
2.15.1
