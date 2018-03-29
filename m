Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx48eOTiS2JGwj6zRBEXdMXQ+KyuyR5XJN7vzSsj4vgMnmYS9fJSB7rvkBdJVjUCiAhtbquZ7
ARC-Seal: i=1; a=rsa-sha256; t=1522297744; cv=none;
        d=google.com; s=arc-20160816;
        b=abcWH7OdNamGPByM/ehIfoFzkj2S8ft8WiluUI9UZZET++HLTOkJWs+2eUuehPqU6s
         TfFqJNMHUxMkJySSPch7sDw7QpFzAY/jKgyTb+F/K7Z/olC59dPZNiUjhZPQNtlVAgXS
         08bAvHd/qYAL7oU5Od8eByhEqfoDbjLn+Q2WJua2QieldSU5uLcoSVnIATUCyKv20iyi
         1sIJHz+mOqbc7l93bru/AtKaJZyv+sVkAxwQFa+93Ad72qOA6gTi/UfGtLBS6WRE+38P
         9TVONAlJ+O9SNsRM81DWj+dTqVlRmmx/UDiFv86Vt/XLO8lg9L4QMnw2mTplJnGSJxqd
         KEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=IyKX+mJRFGmfMXg9P0WHlotmpQeSIr21b16jhPPuu4A=;
        b=X0n/55r5V6dKncbypUeQ+6YpG9J9XbUjm6ARNQfu625Euv3YRi8Ovh61TvxjcO7UAq
         vKw74gnxOQqfhLrtqtQOv42Wqix7N5JRzuLMUAv7qjuQhvox9GkGxW9Y+GfQ5K8n5J8Y
         8/Lbdve1tOrbjSBcik2peGTWQBfsYTgs0NuhPUoK38H3bFtPELTL//AboId8KmBAqJkg
         zwb/RFEB6bM+c+5GJODC5QwuaOeYz/8cMgNbxXJb+63EzZ9TIpsr5pn5E5qypeXejEI1
         iCdzTFJzHOlLmcfEc09/wqvnbxQJRjn82sUd56T20HczbFhuP2m1IMtKlpBoyZNDCnsq
         2RSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Thu, 29 Mar 2018 15:26:48 +1100
Subject: [PATCH 16/17] staging: lustre: discard linux-time.h
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152229760884.27689.2832237566424423407.stgit@noble>
In-Reply-To: <152229732768.27689.4800156943561963977.stgit@noble>
References: <152229732768.27689.4800156943561963977.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244879815147026?=
X-GMAIL-MSGID: =?utf-8?q?1596244879815147026?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Very little is left in linux-time.h.
Move CFS_TICK to libcfs.h discard the test.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
---
 .../staging/lustre/include/linux/libcfs/libcfs.h   |    5 ++
 .../lustre/include/linux/libcfs/linux/libcfs.h     |    1 
 .../lustre/include/linux/libcfs/linux/linux-time.h |   66 --------------------
 drivers/staging/lustre/lustre/ptlrpc/pinger.c      |    2 -
 4 files changed, 6 insertions(+), 68 deletions(-)
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
index 3d3fa52858e5..f183f31da387 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
@@ -52,6 +52,11 @@
 
 #define LOWEST_BIT_SET(x)       ((x) & ~((x) - 1))
 
+/*
+ * One jiffy
+ */
+#define CFS_TICK		(1UL)
+
 /*
  * Lustre Error Checksum: calculates checksum
  * of Hex number by XORing each bit.
diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
index 30e333af8d0d..c39c34d74382 100644
--- a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
@@ -80,7 +80,6 @@
 #include <linux/uaccess.h>
 #include <stdarg.h>
 #include "linux-cpu.h"
-#include "linux-time.h"
 
 #define LUSTRE_TRACE_SIZE (THREAD_SIZE >> 5)
 
diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
deleted file mode 100644
index ecdebccf2b44..000000000000
--- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
+++ /dev/null
@@ -1,66 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * GPL HEADER START
- *
- * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 only,
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License version 2 for more details (a copy is included
- * in the LICENSE file that accompanied this code).
- *
- * You should have received a copy of the GNU General Public License
- * version 2 along with this program; If not, see
- * http://www.gnu.org/licenses/gpl-2.0.html
- *
- * GPL HEADER END
- */
-/*
- * Copyright (c) 2008, 2010, Oracle and/or its affiliates. All rights reserved.
- * Use is subject to license terms.
- */
-/*
- * This file is part of Lustre, http://www.lustre.org/
- * Lustre is a trademark of Sun Microsystems, Inc.
- *
- * libcfs/include/libcfs/linux/linux-time.h
- *
- * Implementation of portable time API for Linux (kernel and user-level).
- *
- * Author: Nikita Danilov <nikita@clusterfs.com>
- */
-
-#ifndef __LIBCFS_LINUX_LINUX_TIME_H__
-#define __LIBCFS_LINUX_LINUX_TIME_H__
-
-#ifndef __LIBCFS_LIBCFS_H__
-#error Do not #include this file directly. #include <linux/libcfs/libcfs.h> instead
-#endif
-
-#define ONE_BILLION ((u_int64_t)1000000000)
-#define ONE_MILLION 1000000
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/time.h>
-#include <asm/div64.h>
-
-/*
- * post 2.5 kernels.
- */
-
-#include <linux/jiffies.h>
-
-/*
- * One jiffy
- */
-#define CFS_TICK		(1UL)
-
-#define CFS_DURATION_T	  "%ld"
-
-#endif /* __LIBCFS_LINUX_LINUX_TIME_H__ */
diff --git a/drivers/staging/lustre/lustre/ptlrpc/pinger.c b/drivers/staging/lustre/lustre/ptlrpc/pinger.c
index 3f17c673d1b8..89eef8ec7df4 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/pinger.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/pinger.c
@@ -251,7 +251,7 @@ static void ptlrpc_pinger_main(struct work_struct *ws)
 		 * we will SKIP the next ping at next_ping, and the
 		 * ping will get sent 2 timeouts from now!  Beware.
 		 */
-		CDEBUG(D_INFO, "next wakeup in " CFS_DURATION_T " (%ld)\n",
+		CDEBUG(D_INFO, "next wakeup in %ld (%ld)\n",
 		       time_to_next_wake,
 		       this_ping + PING_INTERVAL * HZ);
 	} while (time_to_next_wake <= 0);
