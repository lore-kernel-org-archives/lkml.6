Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524043655; cv=none;
        d=google.com; s=arc-20160816;
        b=YZ7C7TTbFfKi5QVDlYCfTUae2Id8EN2At+ZxYu+9BVtjXrMAkBItf4vvbvnuDMNwQa
         XEsuyCSq/0y2U1FvWP0RN3U2wTG5OuWIUl4LuXf7uPNo3hANaql/DkbJaTt8X1tYQZhH
         cJOvQpe9evI1ohJbw3G9krinv9/s0lA8P8zyfGfoD/DJZNxaHeTqt38aZai17X/HAtVZ
         E4MW1Kkllih8vykXHy9sHqfoMqtFXgEpuKHT9Q+RUvRJe2jq4PWWDF4RckPzsbO0Nedl
         W2NgyiVcENeZo4f6kaSjzXbREBg4Xz8RB0SEfbCs+z3TKHfOL28DVLqjOVqigvAmDlsS
         g2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/ljlQcH11j1bUHA9GNlsgAv8aiUBf50wifdt2PyMs6s=;
        b=H6qOmhA1qa5/WOU5C/uEa8Slk7YBTXo5YfoVYPIYdGJlzNLRsNEau0pFt+kGuZwlj/
         KWw27ej4nneQQWcI8uUfdHfwbZamUFzcph0N8TJgIvhdNGq5Fl7MXvUF8OC4FP+6MxKC
         pbWL1SlbJmCQ5ZBRaObjhhYrmoOoBEBRCOMeHBzKBRfmSti5lVr/U+qER2hx+Y/S8ga/
         2LXXiYpneNzusZdA4ynfEE8AVaXAc3KeA47GPYOpjQ0rH5V9ChfAC6U4EmUnRtN2HBnD
         N6G4e9ZokCUUeVS0O9JUrWOg6OvV+4b/5sxfNBt0pjcJzCTnV4A1qM5gt9gXNpyedJ3T
         U3JA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx4/iJhzXHdNKs1NwyZ4nALc8Nbauvp81pqbMEE7+gVJ0wMdiYV6yvwuTAGtDZg8dNWbPr0tG5g==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk,
	kstewart@linuxfoundation.org,
	tglx@linutronix.de,
	pombredanne@nexb.com,
	gregkh@linuxfoundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 6/6 RESEND] statfs: add ST_SLAVE
Date: Wed, 18 Apr 2018 11:27:22 +0200
Message-Id: <20180418092722.20136-7-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180418092722.20136-1-christian.brauner@ubuntu.com>
References: <20180418092722.20136-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598075599775667210?=
X-GMAIL-MSGID: =?utf-8?q?1598075599775667210?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This lets userspace query whether a mountpoint was made MS_SLAVE.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
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
