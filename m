Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525646890; cv=none;
        d=google.com; s=arc-20160816;
        b=mQ1/2uDv8VRY046EiB/RRhHWXjpufjyGJVAdMki7xVTXymQ/Kyupj4XOEdUIBEVlxD
         fUikHxL61yHgYbxi2+91LxEArcPmNLrsFySSebr/BBmw3nOs/AOPgdnjUEaHcKNWCmJ1
         iv3uAhlpwv1LEkCCnr8+LkeuGa9KYVlV0K6S46ZZ/Va8p3B+VGEdHzYu1IdnUoDNM3si
         7C0ls+Y10jfbykItlk8Ssm2i9wOiTtpBrgGYAhjvChetISqOM4dvI3XaGAbTvtEJ18yo
         1ylMYDBrJOSwD4Mkk0OQctg3EpdHZO6ufB2egXuQpBZTgXf2KT+hdSXPKMIslCpdJSS1
         REow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=4n/57ZIJ/E0SxzgxGGnSSwmHjZ4cK03wEX+OE1wrZVQ=;
        b=yzs2n4AsaSQ64cDW475ayhX/++UgHYL12MHPe/te4QttL8hFV+hIx5jqjXyrifsJ3h
         2j1K+axNWaf4LzqnR2TSOvIBleHTZPiHotVnrmfiInbU68LwiKJrKbG6BRrX6h0kTdEJ
         ldG0/lZ9xmj2/XiHzuhjleX7dtbfthZhZtZAl86gclUmqEO8tUSx42lFL8tzmtcQPAZh
         GrVbMdZVJ1O9uifXZn9XHtPRWkQCt1I5UyCUUiX3r/UxqZ2Sk14Y7d8nN+Yn4d9gthz+
         gtXAyWEOugz06zCu+sXzI6X9L3flVcwbzkUcK7TF8eIYP1EMWYg0W5W17CiSLwmCdSCB
         043g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZq80OR/AElLQw8dL9/viSxlGETNqXgnxp+8/C4jk+tjitzI+PVwQgjGyfuq00DQmzLjB2X0DQ==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	tglx@linutronix.de,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pombredanne@nexb.com,
	linux-api@vger.kernel.org,
	Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/6 v1] statfs: use << to align with fs header
Date: Mon,  7 May 2018 00:47:00 +0200
Message-Id: <20180506224704.14669-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180506224704.14669-1-christian.brauner@ubuntu.com>
References: <20180506224704.14669-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599756713384254198?=
X-GMAIL-MSGID: =?utf-8?q?1599756713384254198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

After switching to using bit-shifts to define MS_* flags switch over ST_*
flags too. ST_* and MS_* flags generally have the exact same value.
Initializing them identically let's userspace easily detect when flags
indicate the same property but use a different value in doing so.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
v0->v1:
* non-functional changes: extend commit message
---
 include/linux/statfs.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index 3142e98546ac..b336c04e793c 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -27,18 +27,18 @@ struct kstatfs {
  * ABI.  The exception is ST_VALID which has the same value as MS_REMOUNT
  * which doesn't make any sense for statfs.
  */
-#define ST_RDONLY	0x0001	/* mount read-only */
-#define ST_NOSUID	0x0002	/* ignore suid and sgid bits */
-#define ST_NODEV	0x0004	/* disallow access to device special files */
-#define ST_NOEXEC	0x0008	/* disallow program execution */
-#define ST_SYNCHRONOUS	0x0010	/* writes are synced at once */
-#define ST_VALID	0x0020	/* f_flags support is implemented */
-#define ST_MANDLOCK	0x0040	/* allow mandatory locks on an FS */
-/* 0x0080 used for ST_WRITE in glibc */
-/* 0x0100 used for ST_APPEND in glibc */
-/* 0x0200 used for ST_IMMUTABLE in glibc */
-#define ST_NOATIME	0x0400	/* do not update access times */
-#define ST_NODIRATIME	0x0800	/* do not update directory access times */
-#define ST_RELATIME	0x1000	/* update atime relative to mtime/ctime */
+#define ST_RDONLY	(1<<0) /* mount read-only */
+#define ST_NOSUID	(1<<1) /* ignore suid and sgid bits */
+#define ST_NODEV	(1<<2) /* disallow access to device special files */
+#define ST_NOEXEC	(1<<3) /* disallow program execution */
+#define ST_SYNCHRONOUS	(1<<4) /* writes are synced at once */
+#define ST_VALID	(1<<5) /* f_flags support is implemented */
+#define ST_MANDLOCK	(1<<6) /* allow mandatory locks on an FS */
+/* (1<<7) used for ST_WRITE in glibc */
+/* (1<<8) used for ST_APPEND in glibc */
+/* (1<<9) used for ST_IMMUTABLE in glibc */
+#define ST_NOATIME	(1<<10) /* do not update access times */
+#define ST_NODIRATIME	(1<<11) /* do not update directory access times */
+#define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime */
 
 #endif
-- 
2.17.0
