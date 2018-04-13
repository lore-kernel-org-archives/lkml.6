Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523635909; cv=none;
        d=google.com; s=arc-20160816;
        b=sCexvbVQGVK64GOxMIEZewSS842A91MPW5R/rzrqj92sxWTiaJaK09998P5X0YrmiM
         TOL6cpThB3Rr5SUGUMLJJoOLbtAyhaU69FxfSi0p0fyy6+Ut338GCuU8ext6YGKf3zXH
         ar9UKqM8048vrSDfvXGbPWgBBm1SaSmnhTM7yaZG/js9/G3bJHA1ENgEFT73eW3IFY5L
         yq9Q8Y3nV28QW/aO12Fi5cS1IVTSzKB7JAJzjSJve96/GNSfZSHW6FfQS9z2ZKEPVbVr
         B45JER0n7qe7DM+w5SAaF2ULC+SEVr/0PhZBDZ00tKRDXc0e4YL6xy5jVg5hGCknkJ3z
         0dgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=bQMLvV0Ko6+62/3QhUYTnjSM6q/HltMW5KN/AdFhXts=;
        b=UagHgmvmrqRbRgtlna/WPiCIxRk40UZbpR1yNdG3M5Ph9vsUPKTMQIGMHQiefPKF5q
         Ji9OaZgrNieydyHeZ2mwQGdFEUC02aWn9B+WQvhkx1jpEm513VPFji2TSPYpTGTbDWhj
         BnZE26/iOP9Rc9MYFCgq8irqbG3R9xQXcV9t0DKyxUFl4szcYCLxrT1BKgGvbQmzwMLl
         cB9LLPTDkahKnfWIAD9T2ZZWP4Lf6to9BuZ6YzYJrY8prjQaUFDd5aYZPQTswbbP6c4n
         1vfE+86qYYjnhANjshRFzPrQoHIX2tOn6WbJliVHXnn3gaaAKaDGZluxx8Yh2Or456HV
         9qNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx4/XJ6kJIfELH2P0ZHf95DSkvVXLVRh+YyxgKwrEdx/NoaRera0z8SSd0qEb46uEW+YA3tT64w==
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
Subject: [PATCH 3/6] statfs: add ST_UNBINDABLE
Date: Fri, 13 Apr 2018 18:11:23 +0200
Message-Id: <20180413161126.31313-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180413161126.31313-1-christian.brauner@ubuntu.com>
References: <20180413161126.31313-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597648047105357764?=
X-GMAIL-MSGID: =?utf-8?q?1597648047105357764?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This lets userspace query whether a mountpoint was made MS_UNBINDABLE.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
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
