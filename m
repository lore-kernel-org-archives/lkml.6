Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx4/fZWBuzefx3OteqSVsvaEoi8cjOVQgfSd2sIBG9JnYa+J7BoyxutVuXHkTftJhdF/r/nlZ
ARC-Seal: i=1; a=rsa-sha256; t=1522297723; cv=none;
        d=google.com; s=arc-20160816;
        b=DOn+t/ids68l80vAc23SZ/LaGkjFps/5TFTnthvYbc9NQm55CB+1yoSeeI1vvIAbpB
         4l+H6ywyNOkWP3MBQgak6axgycYtGt2GtEz7s+gLULQvfdVPRJLKiVKwOeSobzJOtJgK
         d+RMyJNqzBAihZ4PqEBuA7UxqhYcM0WGh58TsHGNxwMaLZr42OhjNGlXULOIVHCOi+19
         48VT4CPWjlcL4erIFzGD4WoBW9MkmwcGeAIcNoNQEvbgV2SmGfJDwdxbpn0sAChfT79l
         BRboXs5lVmh3fQpmXRuCGyDon6u6AkMjRe+uiYGXN+OFXB3xe8OunW82Wgwz4CYstyt5
         x9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=B18q4yj/P8PE7DPhw6uZlRavk0GiMWc+76XaWht/kec=;
        b=JpBUaIH9iERv+2V9R5HohYjapUEtEzor/qqNzWdlS7pgJ9tmENG8pEjuYYx86ToQt1
         tWKx+fDNbfc8LsWitJKEZDVOv9FdJAKvu5DmJITXUL61TARr1U48Oy0uhxvTlawr5ZdV
         sliZY8Wsfjmh0YAdiL+g4xCfAKYrtLjc6aJwz/XgK40F1yrOrNb6XGeKorJF/+b3FvxO
         TJ/SyuNx/MEgArtxesgOxwTwa9OCHTfQ/Zubz9J2UjjRLQdk8UOpqHwl2bSthNU+SX7r
         mDF+rr7odvuwbxzFgSMFgiG8bLLk8mQ2UoRlaPd8iaiGYgsu7wWHZr+lb+Hi1ii5YlE/
         GQfA==
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
Subject: [PATCH 13/17] staging: lustre: libcfs: remove cfs_timeout_cap()
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152229760874.27689.12453214678546053828.stgit@noble>
In-Reply-To: <152229732768.27689.4800156943561963977.stgit@noble>
References: <152229732768.27689.4800156943561963977.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244858213208850?=
X-GMAIL-MSGID: =?utf-8?q?1596244858213208850?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This wrapper is only used once, so open-code it as max().

This allows us to remove the libcfs_time.h include file.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
---
 .../staging/lustre/include/linux/libcfs/libcfs.h   |    1 
 .../lustre/include/linux/libcfs/libcfs_time.h      |   50 --------------------
 .../lustre/include/linux/libcfs/linux/linux-time.h |    2 -
 drivers/staging/lustre/lustre/ptlrpc/import.c      |    4 +-
 4 files changed, 3 insertions(+), 54 deletions(-)
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/libcfs_time.h

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
index 3b751c436b3d..3d3fa52858e5 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
@@ -43,7 +43,6 @@
 #include <linux/libcfs/libcfs_private.h>
 #include <linux/libcfs/libcfs_cpu.h>
 #include <linux/libcfs/libcfs_prim.h>
-#include <linux/libcfs/libcfs_time.h>
 #include <linux/libcfs/libcfs_string.h>
 #include <linux/libcfs/libcfs_hash.h>
 #include <linux/libcfs/libcfs_fail.h>
diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_time.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_time.h
deleted file mode 100644
index 172a8872e3f3..000000000000
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs_time.h
+++ /dev/null
@@ -1,50 +0,0 @@
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
- * libcfs/include/libcfs/libcfs_time.h
- *
- * Time functions.
- *
- */
-
-#ifndef __LIBCFS_TIME_H__
-#define __LIBCFS_TIME_H__
-/*
- * return valid time-out based on user supplied one. Currently we only check
- * that time-out is not shorted than allowed.
- */
-static inline long cfs_timeout_cap(long timeout)
-{
-	if (timeout < CFS_TICK)
-		timeout = CFS_TICK;
-	return timeout;
-}
-
-#endif
diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
index ff3aae2f1231..ecb2126a9e6f 100644
--- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
+++ b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
@@ -78,7 +78,7 @@ static inline int cfs_time_beforeq_64(u64 t1, u64 t2)
 /*
  * One jiffy
  */
-#define CFS_TICK		(1)
+#define CFS_TICK		(1UL)
 
 #define CFS_DURATION_T	  "%ld"
 
diff --git a/drivers/staging/lustre/lustre/ptlrpc/import.c b/drivers/staging/lustre/lustre/ptlrpc/import.c
index 4a9d1f189d01..dd4fd54128dd 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/import.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/import.c
@@ -1486,7 +1486,7 @@ int ptlrpc_disconnect_import(struct obd_import *imp, int noclose)
 	}
 
 	if (ptlrpc_import_in_recovery(imp)) {
-		long timeout;
+		unsigned long timeout;
 
 		if (AT_OFF) {
 			if (imp->imp_server_timeout)
@@ -1501,7 +1501,7 @@ int ptlrpc_disconnect_import(struct obd_import *imp, int noclose)
 
 		if (wait_event_idle_timeout(imp->imp_recovery_waitq,
 					    !ptlrpc_import_in_recovery(imp),
-					    cfs_timeout_cap(timeout)) == 0)
+					    max(timeout, CFS_TICK)) == 0)
 			l_wait_event_abortable(
 				imp->imp_recovery_waitq,
 				!ptlrpc_import_in_recovery(imp));
