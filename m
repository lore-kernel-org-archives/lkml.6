Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtiye29EEjmXZ+kLcJnR+wgOvP36ENkx/lwZzZLm+B0OR6+W9X2rNJKuSYjRVxpDHWAjw5a
ARC-Seal: i=1; a=rsa-sha256; t=1520824076; cv=none;
        d=google.com; s=arc-20160816;
        b=YOg5EEtQzSgVDwKBI9MkUh6q+5shpjevJUCb7mWjZBbe8trSRoVTw639s6ALWxlgAk
         y52YXVQCzv+6DEtdMFMY5yXcEsiU9BMGzeimNp6z5sAu0/gWVVcTyicADAOTGc9IQNMc
         K5rNOcGHWKXLi+BeRYvIFDqsFiuRtsUdr6Yk5quQ58KCaS56GSwCyXrIjJ4URBEHiCnB
         1WeYYSuD3FtZZo315C9lpXLgm8R9sBqeRoKLrn7s8JCafdhkPuw/ocB4iMAPwBg+Zf8M
         NyMsNLSyNudRV1WISPkedwsNlFoafbx4UwywyRPBVqQ9k6+OMxsw2sCpBLdclpH/k2mF
         1eUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=34NVLQOtYvIvmxbxEgTLuAse/WMak+4BTmQFXoDNWIw=;
        b=kL/P7oPddsE6dYu58UZ9ghw6rPPgReXfybGIgwY1mu2GS8g8zWfWIe7gAvZXAovXHA
         hqveDFTJmOYpZUSaA4tuVzl+TGqSSkJ2BReeubtWnDmD73akidkKyPdLLLevTWrc5+Ug
         gLXpy3tXA5hCIbnCaz5KMIrxen/lDh2ya7e5zE1pycgebpLZis2fUEyujyF9Ii7wpgBi
         ACzE53Sg/H11DtVojxgMObzW3bgEA8DYypUxc24l7rfzwBwgrGl7sIxLFEoMwG3zt2d+
         ihuO+mgZmqa7TT/9fTKRK2ci4N6kDBB3bFaKxN6LTQGcal2jgKxjiGLChlD8L9t1ezNe
         q3dQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, torvalds@linux-foundation.org,
 "Al Viro" <viro@zeniv.linux.org.uk>,
 kernel-hardening@lists.openwall.com, gregkh@linuxfoundation.org,
 linux-arch@vger.kernel.org, alan@linux.intel.com,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Dan Williams" <dan.j.williams@intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.494230946@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 57/76] vfs, fdtable: Prevent bounds-check bypass via
 speculative execution
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699621976171926?=
X-GMAIL-MSGID: =?utf-8?q?1594699626255780781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 56c30ba7b348b90484969054d561f711ba196507 upstream.

'fd' is a user controlled value that is used as a data dependency to
read from the 'fdt->fd' array.  In order to avoid potential leaks of
kernel memory values, block speculative execution of the instruction
stream that could issue reads based on an invalid 'file *' returned from
__fcheck_files.

Co-developed-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727418500.33451.17392199002892248656.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/fdtable.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
+#include <linux/nospec.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/fs.h>
@@ -76,8 +77,10 @@ static inline struct file *__fcheck_file
 {
 	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
 
-	if (fd < fdt->max_fds)
+	if (fd < fdt->max_fds) {
+		fd = array_index_nospec(fd, fdt->max_fds);
 		return rcu_dereference_raw(fdt->fd[fd]);
+	}
 	return NULL;
 }
 
