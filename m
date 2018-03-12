Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsAcjRGx6EBrrEerX2ph18arTE5DO3U9xCRJc1z0TXhFCm5FDg1mRnGu/ymWnvaMzUyrHU1
ARC-Seal: i=1; a=rsa-sha256; t=1520824071; cv=none;
        d=google.com; s=arc-20160816;
        b=0ql5XsNXyxpOLAJnXzRmlar5C4Jn9M1Urn4J1XNZBPPUWDpb+ici8BsoayMJbuEjco
         ril9r40jurT4qu2wu3JW7+dcBPk1dcdeajQuzl3w0HyCkDbKWLiVikZlvjZ2jSdX9qgo
         fFEKazaZzC2O27kxONavZ1QuL6yn2Im2/+Owenn0ELpfC8xgy+r7JpkyjPdmF5J10ttF
         xiBr+K07s3a2eiGRKZw619ayXhGFTqD9VpfcZUKUzpeanScjaEd2GpIw6hVmdW+UaJ02
         TJK94YFPIB9Uu8p3rbMKyj+jZUKj3hpKqcTFULI/ddtuY4wwhXyiw2YZJL2x/wDKhFBC
         JoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=g/aj8qO5aFf00yIgCukCNBgX6uzLTUHhZnDfgXfrwlg=;
        b=doOAfKgTFL2jC+5PzAdpKOoal/q1Y9J7kaHYsfgPF5ARPedivdE2COQMYOD8PFJ6jM
         NnJC8qmqaH91ezONuXfDj9m65qGArqYl7m0KQbOHuhZAVDIIyDA85smOmh5TufIieXFD
         PQOnNFx2AhwexT0wgIB875SGgHIXC22V2Cd0DI7Wtcu7SUy6ug71A6kYobWWNkTCO7vz
         xW9E9DOY1htlNrcljcjMW3dNdejJhHLWgBh5CfEFnxragL0BMbpBgT29iZnG5pPa8fK/
         akGvmOd+xZjpxOBmLTtb+vSoQEC4haKLllWg//O6kJKmD7fFvU50tniA9FGv81sn5LiK
         g4Iw==
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
CC: akpm@linux-foundation.org, linux-arch@vger.kernel.org,
 "Al Viro" <viro@zeniv.linux.org.uk>,
 gregkh@linuxfoundation.org,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Dan Williams" <dan.j.williams@intel.com>,
 torvalds@linux-foundation.org, kernel-hardening@lists.openwall.com,
 alan@linux.intel.com
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.357571797@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 088/104] vfs, fdtable: Prevent bounds-check bypass via
 speculative execution
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699621976171926?=
X-GMAIL-MSGID: =?utf-8?q?1594699621976171926?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: adjust context]
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
@@ -85,8 +86,10 @@ static inline struct file * fcheck_files
 	struct file * file = NULL;
 	struct fdtable *fdt = files_fdtable(files);
 
-	if (fd < fdt->max_fds)
+	if (fd < fdt->max_fds) {
+		fd = array_index_nospec(fd, fdt->max_fds);
 		file = rcu_dereference_check_fdtable(files, fdt->fd[fd]);
+	}
 	return file;
 }
 
