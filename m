Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523635910; cv=none;
        d=google.com; s=arc-20160816;
        b=JoJzLSOSNnEo0xja/7wM8By2dqvXZvDQM761rOtkzTvqmb5v3R5C549gswoiQGo5UZ
         ZG+1qFJNS8Cv4STpo0iDUAZNL0xSL5A+b6cHjA36pjRWr9p9cghoPS+zh05UYYXYjQzy
         694gDHfbUS0XTNrCPUy2T7tSWj/XIJGeXoueiUZUMxwqGWS5iB6Cc0iSWxwO+8U055q7
         SvsBNggfbw+kSIFpOa2kSMfWEah+CTapkuYwLYdrCp3W2CPj8AatYRH1WEMEO8sxKboi
         7uwALC4Y06FSHCCZTbfPpcqbPquqUQ1Celib8ZkWRIUybNg/gV+eNRksP67SP0bsuAjj
         JV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=skkXM04WjM7UeWsHfWHN3Lcgjql4mHKU2ojImbeCSiE=;
        b=rKcVeWcdMH+p4ORYhSblard34Ks+p/rLNOVEluACD61TxgZTHYjA6WEnXb5XAwc/LL
         eDS9Io+sezIhhE5XSovqXiKiXWlnmRRzfRpMK7A7meMUtEXw3gI3lDDPSs7fU25dlJJ0
         yzzni4YGA1ROrpswKwWN5PVAg+Pq8iMFp3X5f6j9livgQKh1lcbmFio4httdKxLOpClx
         DPO2rQImM0sufdcBdC8G9cTUOU9kvFC9nm4zo4sAMCRno4DPvaamaABLhHiy5qdREc9k
         5+SYh01T7+HFxSH1s+b5JKH7T2JNznhEtahrbivUB2GQnAGkKhWbMc3J97BBu8i4H4cm
         npwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx49eVhsBWkkKiD7It7nYVwu/RRfTktE/nSpW5B3p9mUiZAhTDjy1+W4KgAzTUBwEBW8l5JTl7g==
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
Subject: [PATCH 4/6] statfs: add ST_SHARED
Date: Fri, 13 Apr 2018 18:11:24 +0200
Message-Id: <20180413161126.31313-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180413161126.31313-1-christian.brauner@ubuntu.com>
References: <20180413161126.31313-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597648048961369415?=
X-GMAIL-MSGID: =?utf-8?q?1597648048961369415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This lets userspace query whether a mountpoint was made MS_SHARED.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
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
