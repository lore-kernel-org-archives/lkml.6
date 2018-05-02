Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525275941; cv=none;
        d=google.com; s=arc-20160816;
        b=FBkX1mZZJkaeMJBov0ngnl2UkJ3Um10azf0497/FnaxU2E0Ffg4sm7nFje50ZjTCdQ
         RTvFWIyo3Y4y9AxtFX6wLc3eCBz4Hlm/Z9yb98KdUm3iFaWa2NXLwoJXWY5ErbFL7vtt
         i6G0Rb8T+gUg6sQX8N5phiTgPvks89EXmHnyOkA06tsOJWUXVudrkka94nhv8gn4ZBhI
         aMG/KSZaCGebkUqQgVV2Cd+8aAzXI2ynKKvSLahUEUSfCeAqO4wQ0tovpzIYWolQokzf
         M2ZA2ghfve9C8VFBtpP1V3o+3aRi8N9QWOmmm1N5WE3cw/GpAXilrU+6U1v22zcllHZq
         6aXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=4HWO4KsdDhMpVuT6Ip08U41WBV/ZH0R1wkEpLENMUDk=;
        b=rK4+UXRb/WnTke5odxFg9S0fOF3F2MmfABm6NokOnZ+KlLldX4t44ouSRKhsd2hSqK
         dbf3KGow8WJ3xttyk89oxwazRSUd9eZPvRA+Y6GnPPMXjO/db+DKr/cWHv6F2uz0/ktA
         LapMLL1EiG2wZNLCZI1u9nHqLY52FLGO4Ha9CGn3YYir+iYK0bNAvUWIQ1E7bozjP3J9
         MMzF3mfALxsUlJK8aNyNGGLAWMLq0y8nqbcddHkIOaSnWRKpdXFZWLZJY3HclLAYwjvM
         abbDaaF9H9r50RdxJa0tF5DtZ43Z/5lKBNx/FKjsqmOcYUh2cbFDPLudI/cB2DkQh6yN
         qI8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZpaVsl7/g47jl3G0EJv3JPj7+5pEJkYQdYEuQXDN6YFo2W9Q/G2pnEVU9Xv79/L7r0JWUGJGA==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk,
	torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@infradead.org
Cc: tglx@linutronix.de,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pombredanne@nexb.com,
	Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 5/6 resend] statfs: add ST_SLAVE
Date: Wed,  2 May 2018 17:42:38 +0200
Message-Id: <20180502154239.14013-6-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502154239.14013-1-christian.brauner@ubuntu.com>
References: <20180502154239.14013-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599367745879606462?=
X-GMAIL-MSGID: =?utf-8?q?1599367745879606462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/statfs.c            | 10 +++++++++-
 include/linux/statfs.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/statfs.c b/fs/statfs.c
index 2fc6f9c3793c..35ad0402c9a3 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -10,6 +10,7 @@
 #include <linux/uaccess.h>
 #include <linux/compat.h>
 #include "internal.h"
+#include "pnode.h"
 
 static int flags_by_mnt(int mnt_flags)
 {
@@ -50,8 +51,15 @@ static int flags_by_sb(int s_flags)
 
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
index 5416b2936dd9..048127effaad 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -41,6 +41,7 @@ struct kstatfs {
 #define ST_NODIRATIME	(1<<11) /* do not update directory access times */
 #define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime */
 #define ST_UNBINDABLE	(1<<17)	/* change to unbindable */
+#define ST_SLAVE	(1<<19)	/* change to slave */
 #define ST_SHARED	(1<<20)	/* change to shared */
 
 #endif
-- 
2.17.0
