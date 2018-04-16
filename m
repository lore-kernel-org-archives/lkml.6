Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx4/6nnrxKhsKW5qOiJasq7KN06TC1mG3zwK+txYhRlESfhbUA4jpll/tCeN1c5pUU7gCVYGZ
ARC-Seal: i=1; a=rsa-sha256; t=1523839387; cv=none;
        d=google.com; s=arc-20160816;
        b=yN9KtKotiFc3zpQDwJ+3m57z5gX144EMOFJGE/5sL3En3VzwyAFIZNry/ZIMGEhLEj
         iiCL/RteXwbwKDLnVlCJyExGjMSLNyPtyobmK5T0ElaEor0HpiLqRvqF4uXxcjADBHdj
         I3bWhV0wVNKy9kIcG/SWH8sH5Ojzsl/jaf5DXmi9ayjkQ1jH/0Ixuw5fsL+0eGZdbkGH
         dsaZpAAYz5BPrvm92/79wTklggQJt/9K0kMFITSb43a4Yovu4T22kqEFa/VFssACQ5Jq
         VbNqV0QLVK+ZMahDcGHwldPuGwZ5eqZQrvooiP1ZGwCWLr/C4rqgJaNbDgBGDaFiydyd
         ophg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=3CCNZXwIH8xCEUaaS5Sxz4QDnggLsEhteXcsw9Qaz7s=;
        b=YQFYRQeHCPmRwFE8uD0TXmGV14nFpsILD99fKAfhHAKeCk2E2QXplHOihJMaIDPOLy
         ry/W1oe09O2SSyumAoxV8k23ibG4C8SbQJNb7FppKYYom46OifkyLa0EHZ1cHqZTh2nz
         54QZ3ZXrzHNyP2WIao2Xmfj9T07yxp4hVnUa+YbYMFcxBDl0ZV9R0bjlrpotMYn+2jBV
         a3LtBxuvPvORCEGxXABi0TnUbqI6nkAOdZMNLN8gFkneoN90W6nUC8YU174SkYH5RnzN
         7EuEPO+3blU1I9bU09d0TAoB9ONziWl1z+od0Ng4qKfCpXgKxLSBxFFPMgLHRzk5G5O/
         ta1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 16 Apr 2018 10:42:37 +1000
Subject: [PATCH 1/6] staging: lustre: move stack-check macros to
 libcfs_debug.h
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152383935730.23409.6748888065027051683.stgit@noble>
In-Reply-To: <152383910760.23409.2327082725637657049.stgit@noble>
References: <152383910760.23409.2327082725637657049.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597861409409058351?=
X-GMAIL-MSGID: =?utf-8?q?1597861409409058351?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

CDEBUG_STACK() and CHECK_STACK() are macros to help with
debugging, so move them from
   drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
to
   drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h

This seems a more fitting location, and is a step towards
removing linux/libcfs.h and simplifying the include file structure.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 .../lustre/include/linux/libcfs/libcfs_debug.h     |   32 ++++++++++++++++++++
 .../lustre/include/linux/libcfs/linux/libcfs.h     |   31 -------------------
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
index 9290a19429e7..0dc7b91efe7c 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
@@ -62,6 +62,38 @@ int libcfs_debug_str2mask(int *mask, const char *str, int is_subsys);
 extern unsigned int libcfs_catastrophe;
 extern unsigned int libcfs_panic_on_lbug;
 
+/* Enable debug-checks on stack size - except on x86_64 */
+#if !defined(__x86_64__)
+# ifdef __ia64__
+#  define CDEBUG_STACK() (THREAD_SIZE -				 \
+			  ((unsigned long)__builtin_dwarf_cfa() &       \
+			   (THREAD_SIZE - 1)))
+# else
+#  define CDEBUG_STACK() (THREAD_SIZE -				 \
+			  ((unsigned long)__builtin_frame_address(0) &  \
+			   (THREAD_SIZE - 1)))
+# endif /* __ia64__ */
+
+#define __CHECK_STACK(msgdata, mask, cdls)			      \
+do {								    \
+	if (unlikely(CDEBUG_STACK() > libcfs_stack)) {		  \
+		LIBCFS_DEBUG_MSG_DATA_INIT(msgdata, D_WARNING, NULL);   \
+		libcfs_stack = CDEBUG_STACK();			  \
+		libcfs_debug_msg(msgdata,			       \
+				 "maximum lustre stack %lu\n",	  \
+				 CDEBUG_STACK());		       \
+		(msgdata)->msg_mask = mask;			     \
+		(msgdata)->msg_cdls = cdls;			     \
+		dump_stack();					   \
+	      /*panic("LBUG");*/					\
+	}							       \
+} while (0)
+#define CFS_CHECK_STACK(msgdata, mask, cdls)  __CHECK_STACK(msgdata, mask, cdls)
+#else /* __x86_64__ */
+#define CFS_CHECK_STACK(msgdata, mask, cdls) do {} while (0)
+#define CDEBUG_STACK() (0L)
+#endif /* __x86_64__ */
+
 #ifndef DEBUG_SUBSYSTEM
 # define DEBUG_SUBSYSTEM S_UNDEFINED
 #endif
diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
index 07d3cb2217d1..83aec9c7698f 100644
--- a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
@@ -80,35 +80,4 @@
 #include <stdarg.h>
 #include "linux-cpu.h"
 
-#if !defined(__x86_64__)
-# ifdef __ia64__
-#  define CDEBUG_STACK() (THREAD_SIZE -				 \
-			  ((unsigned long)__builtin_dwarf_cfa() &       \
-			   (THREAD_SIZE - 1)))
-# else
-#  define CDEBUG_STACK() (THREAD_SIZE -				 \
-			  ((unsigned long)__builtin_frame_address(0) &  \
-			   (THREAD_SIZE - 1)))
-# endif /* __ia64__ */
-
-#define __CHECK_STACK(msgdata, mask, cdls)			      \
-do {								    \
-	if (unlikely(CDEBUG_STACK() > libcfs_stack)) {		  \
-		LIBCFS_DEBUG_MSG_DATA_INIT(msgdata, D_WARNING, NULL);   \
-		libcfs_stack = CDEBUG_STACK();			  \
-		libcfs_debug_msg(msgdata,			       \
-				 "maximum lustre stack %lu\n",	  \
-				 CDEBUG_STACK());		       \
-		(msgdata)->msg_mask = mask;			     \
-		(msgdata)->msg_cdls = cdls;			     \
-		dump_stack();					   \
-	      /*panic("LBUG");*/					\
-	}							       \
-} while (0)
-#define CFS_CHECK_STACK(msgdata, mask, cdls)  __CHECK_STACK(msgdata, mask, cdls)
-#else /* __x86_64__ */
-#define CFS_CHECK_STACK(msgdata, mask, cdls) do {} while (0)
-#define CDEBUG_STACK() (0L)
-#endif /* __x86_64__ */
-
 #endif /* _LINUX_LIBCFS_H */
