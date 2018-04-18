Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524043653; cv=none;
        d=google.com; s=arc-20160816;
        b=G/iGE1RsGG2tXDI/nk4rsMtjz848xpkbyO+/aIdXk9LAgU7bbx9jJkb4OMLxo5dyHK
         70BWYxEtNDPvh6gFiI7b4aTFZEAXZRNoX29WqlB0synxauOaCSt2ORx9s4ToYgBALcFg
         7U4ucGZozrdYmu6VA9nEZeoLRzA7qTcugw6+ZWKDDgsErABOosyEjTteXpJTnyzIMj4+
         cHSKndwiiLZKGgcG5owNMLfMEMN4CGKYT+N82VRwvZApeMaF1Qkmp+dVrPUHxlaqCwIN
         O4YwiH/Y6QbCBydUyr4V5e5omsdl3iNeAjVGrMqZANDwt7463iPmyAXCrc+QkoUWiTdx
         Pzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=OjSgXUJrj4Kl//T21+dGr0qKeq18DnNW8jojiyem2z4=;
        b=tCZopQnbTBuTva1U2Wy1Cdgv/+WFf/ZoxWOWJNKbmSg1UzXCYswJ3WQrzzmDD8s7hh
         q9hP0zt8zn+YLx909NfjBYH+z1VtZgyHu+334EqEY3+EwK1GJ3ZdOlHiHPmo0MmPnhBj
         NrVSaz9kr6vAf3TjHrPEKAKFizuMcRqiPSQqY0FX/IKcueOyOSTVHHhXQ3h3cOWOGBGq
         EkB0H0em8KKCc7a3AaoRDaZ5iGqIZliPuR/Gpx6OjRa8vxG440x0Gl2ooG1loayJF2fP
         6b6v5m/JJ56G/uUnJGv8kWxQmt6N/Df18e0pzNUNLcjC1IC4On7T3GiL4gK5OckDimBA
         jrDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx4+VVfY2vRaJ6ZrQwOXt9jpooQnLf6F+OrIYIFZOoCGLS5SidqCinCHRB5SfK96Y7CLs4nyA8w==
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
Subject: [PATCH 4/6 RESEND] statfs: add ST_SHARED
Date: Wed, 18 Apr 2018 11:27:20 +0200
Message-Id: <20180418092722.20136-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180418092722.20136-1-christian.brauner@ubuntu.com>
References: <20180418092722.20136-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598075597838671209?=
X-GMAIL-MSGID: =?utf-8?q?1598075597838671209?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This lets userspace query whether a mountpoint was made MS_SHARED.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/statfs.c            | 2 ++
 include/linux/statfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/statfs.c b/fs/statfs.c
index 61b3063d3921..2fc6f9c3793c 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -31,6 +31,8 @@ static int flags_by_mnt(int mnt_flags)
 		flags |= ST_RELATIME;
 	if (mnt_flags & MNT_UNBINDABLE)
 		flags |= ST_UNBINDABLE;
+	if (mnt_flags & MNT_SHARED)
+		flags |= ST_SHARED;
 	return flags;
 }
 
diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index e1b84d0388c1..5416b2936dd9 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -41,5 +41,6 @@ struct kstatfs {
 #define ST_NODIRATIME	(1<<11) /* do not update directory access times */
 #define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime */
 #define ST_UNBINDABLE	(1<<17)	/* change to unbindable */
+#define ST_SHARED	(1<<20)	/* change to shared */
 
 #endif
-- 
2.17.0
