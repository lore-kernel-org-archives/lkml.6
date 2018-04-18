Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524043652; cv=none;
        d=google.com; s=arc-20160816;
        b=iwHdJI6al9pJe4zhT+H04PxIgjAw5lGJOs5HD4FAA6SNwojPNybHNm0un5/MWceyMV
         t1cDzpUWX1iLl/LJUM45KcP4LQs5aP159/awFIX4PWDfxmy/SDCPuQKAQD0YbCT2ye+a
         4DB/k2KmwaNAubk8cfX8rI8A0RKpuREJDi0U27PxXG1PktRbK4FMhFasH5RokvmQXIDF
         V8ttNBrzWDPjptr3vxAuqRedHnBEjwQMxDhsY1yjV/JjMr0vF8av8dvE+o6sjv//aCIq
         A6aNJDIxg/KkYR7j6yy4sxHSjj6X1hDPMNsS7SRgWfi8tVxijlVMWpmK0qsgwvECUS7D
         DeMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=UfVDXE6N2zMIeXCLEWCZBeiBG+DoZb7R1q4NmrPJP0c=;
        b=BhPcbwFhGlQpTo7pvuB5byg3iGCWehH2m+NlUpoqzJG2bsJWlPcpOCyu+OeFwzwJsq
         PYUzjL47fsJUVtPatzI2bQ1ij6mCkAJzlmdbG3GzGWYykZLTh8g6EneqYPUxspj0yRE7
         UdL1IgIwE1tXTHMopaiqpB7V0GF4a/Pg06ZGKlG4ZJq/FR9quH3Xg7HcWXfGH/YbzUaM
         rgqBQyQn/mJVIdIfwggaIC7cw16Bf19jfX0/+yXqyHa/h/pF8Eiq5DRqMKU8pnESrPeg
         0zVfYGHskzvDDM1veWO5RTwOMfIcR0suDfUsaNs1SLIyYZWBqeVBRWlh73tSe+vGysYi
         lkpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx494hSX5yOhJ1fn2RjPy8uPw3qXpbYl3dxodMEFoRqCp9CGYVLxmfa8Wi8vW3d4Qne6MJS4bJw==
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
Subject: [PATCH 3/6 RESEND] statfs: add ST_UNBINDABLE
Date: Wed, 18 Apr 2018 11:27:19 +0200
Message-Id: <20180418092722.20136-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180418092722.20136-1-christian.brauner@ubuntu.com>
References: <20180418092722.20136-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598075597524650220?=
X-GMAIL-MSGID: =?utf-8?q?1598075597524650220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This lets userspace query whether a mountpoint was made MS_UNBINDABLE.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/statfs.c            | 2 ++
 include/linux/statfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/statfs.c b/fs/statfs.c
index 5b2a24f0f263..61b3063d3921 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -29,6 +29,8 @@ static int flags_by_mnt(int mnt_flags)
 		flags |= ST_NODIRATIME;
 	if (mnt_flags & MNT_RELATIME)
 		flags |= ST_RELATIME;
+	if (mnt_flags & MNT_UNBINDABLE)
+		flags |= ST_UNBINDABLE;
 	return flags;
 }
 
diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index b336c04e793c..e1b84d0388c1 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -40,5 +40,6 @@ struct kstatfs {
 #define ST_NOATIME	(1<<10) /* do not update access times */
 #define ST_NODIRATIME	(1<<11) /* do not update directory access times */
 #define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime */
+#define ST_UNBINDABLE	(1<<17)	/* change to unbindable */
 
 #endif
-- 
2.17.0
