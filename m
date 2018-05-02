Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525275942; cv=none;
        d=google.com; s=arc-20160816;
        b=QnOuP6eOBbkFQ3lRWBBnf2dH+eBS5gFt1kkAgce39UPzpWOPUaad8hAac8RgFBpAt4
         U6tXEsltyfpeIk9V9+rfFT2nDFdRO6VgogwMlP1hwg7Cm+tc/ghWL/UtrIJi9yK89Mvv
         +Uzc2wkp2YKLN0s2uid1aJFFcgKQRVFB4C9CeIk+Km88+YvyvLW46SJeWqVoCaLzHZtu
         BUyTqMVzQ4PoN55YDLRqC9tAakRhTtQq+uTPtzuXPkghUpLl/G6GXjp9yhjaHKBcfhyx
         I0KM/asRw6KZOKs8jDDjUa77qgGdpMisTKZ7LRO+9P5q1H8/Vy3meCbKCsHM/kqr5wCZ
         5fog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=p2Nb4Lo0IIYQ+0IGua1x4F/xF676x3ZdywfejIYtyTc=;
        b=tTGRAyWUa7MdCyJSInf+nB8UM5XBzrGQpAC1Im2e+EER37Uq/TdLYMF8GkvnNUH1LV
         /2JO67yg09dHZjswjyRJUGF0Hx+qh6rDx1Qn/WobeiDGp4z4A72t+2kjivE7xjPeGTsY
         g7a0jNnAc7JogVNrhKkZy4ChJjzMyypH3ONzPDdfQ2QN5hFzQ9E/u1LKgv+Bo84UQFM5
         cEzzjmMuqnG0E2QEBORb2Z2uh7suYGpbBJriXg/DTUZia1Rn1a9Rn+4fmcDVC5+yywq3
         xvMGuQ07xrwVafXuf7bdo5dp/F09uBT+G3U68Db0bHwMJc9ytFvT7jfqfD1v7LqUn9SI
         9vjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZpYf0jXunz/BIKx7v7ERFcHgCmvfkwzeESY2iIlldBTD274tgDHZAEHNVQ7uj/shyA5cBKpCw==
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
Subject: [PATCH 6/6 resend] statfs: add ST_PRIVATE
Date: Wed,  2 May 2018 17:42:39 +0200
Message-Id: <20180502154239.14013-7-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502154239.14013-1-christian.brauner@ubuntu.com>
References: <20180502154239.14013-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599367746803672088?=
X-GMAIL-MSGID: =?utf-8?q?1599367746803672088?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
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
