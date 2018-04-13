Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523635912; cv=none;
        d=google.com; s=arc-20160816;
        b=rlYPMBxHJ+yZWVvKYoukACEodGGk3Q+/QqYm2e82NtduPl/xIXOwaFA1uAIwUinpHf
         CQJfth1D12FlJnwSePxuFfjwLQ3gN2IkDSyy33Sj8cnPdT3lFKTDfxlypbKFeilTN/Pf
         MqcAlV1t/MpCO44pxSSX70quuetVsuuOqk0TQQF6uz35ic/qonlfcN17Wg5nq+8/EOEK
         SrjGJBdBGk2eZ+te3fUU6Ugd4KLWVIh4OLlMKizc9x2QiR24lUTTQH+RbOtHZ+n/cIjI
         qpP2WEarHXxO1PzM9OXQoW6rqpZ8tEvB2MbJRuhVFtchk5mxbdu8OrpbYAgSigrvikLn
         wXwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=MyNoitWFzDCw8mxq7ZpdEBQKh+OqlNEmeY6GVZUUbkI=;
        b=hWs4/vb6juB+g7ZO7AGwwqUvrXu7K5idoi6oKf+V7a+aRK0GxEyHo7yO1gf63NmW2q
         I0cSOcUTLVWMt+yTUTlMkDcOstfsJiBYGlH3ToZ/j0sVmzInUegKgw1gmZa3W5Gk0Y8t
         tHIw3H3aD8EnIIuFKH0j9ktRP6rldjhtN8iiW9nZ8LvoKxGz3Ju0RtF2XKjJkXzi+mGD
         gS17HfUqyfvHPUzWUUBeYtoRujnYzDF0+mmJBdFmP0WDRXbWj/FIzCW7N+VmvMmWDe4w
         A7x6ZOjjbrSGkQG7C/omWZcrTQxuSJvI5wPVm4tcD0lZ15/hIuAnadadh2OUEZ8qFCmI
         k1CQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx49SL12swYktUVHZLRE5as06NpeSBjeBLV6fM/VZMgIpyHFCNLUP34ZG1Hzmk0xTAl0wIrKwqQ==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk,
	tglx@linutronix.de,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pombredanne@nexb.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	serge@hallyn.com
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 6/6] statfs: add ST_SLAVE
Date: Fri, 13 Apr 2018 18:11:26 +0200
Message-Id: <20180413161126.31313-7-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180413161126.31313-1-christian.brauner@ubuntu.com>
References: <20180413161126.31313-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597648050461227491?=
X-GMAIL-MSGID: =?utf-8?q?1597648050461227491?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This lets userspace query whether a mountpoint was made MS_SLAVE.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/statfs.c            | 10 +++++++++-
 include/linux/statfs.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/statfs.c b/fs/statfs.c
index 26cda2586d7e..86e957d16a68 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -10,6 +10,7 @@
 #include <linux/uaccess.h>
 #include <linux/compat.h>
 #include "internal.h"
+#include "pnode.h"
 
 static int flags_by_mnt(int mnt_flags)
 {
@@ -52,8 +53,15 @@ static int flags_by_sb(int s_flags)
 
 static int calculate_f_flags(struct vfsmount *mnt)
 {
-	return ST_VALID | flags_by_mnt(mnt->mnt_flags) |
+	int flags = 0;
+
+	flags = ST_VALID | flags_by_mnt(mnt->mnt_flags) |
 		flags_by_sb(mnt->mnt_sb->s_flags);
+
+	if (IS_MNT_SLAVE(real_mount(mnt)))
+		flags |= ST_SLAVE;
+
+	return flags;
 }
 
 static int statfs_by_dentry(struct dentry *dentry, struct kstatfs *buf)
diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index 1ea4a45aa6c3..663fa5498a7d 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -42,6 +42,7 @@ struct kstatfs {
 #define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime */
 #define ST_UNBINDABLE	(1<<17)	/* change to unbindable */
 #define ST_PRIVATE	(1<<18)	/* change to private */
+#define ST_SLAVE	(1<<19)	/* change to slave */
 #define ST_SHARED	(1<<20)	/* change to shared */
 
 #endif
-- 
2.17.0
