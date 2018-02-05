Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225dOJtGCIqOVWenpXJB45HPZCayggoalA/WjT2OQsNrkCHhM60qSVg+csOqat+z/dhPmy9Y
ARC-Seal: i=1; a=rsa-sha256; t=1517855058; cv=none;
        d=google.com; s=arc-20160816;
        b=QV1Fe0lU3JQde+J1Q1ncCiAyENbNDdercgnDW8lJiwHzIJvLzpdGLhly4+mKJRl9oy
         eQMrr1z4zARc8ebYziMswlC91YCnDMcZoDMBH5Q/NHaLNL2sMgxoBAs8eyo0V5506aoi
         qAL0Pocbr29wAKYX9jLOAkQ/QZyNlMOUqyTVzrEc30xAA9GTXxEHqfyBU2ukVSb87vsY
         8UvuuxLatb7GZxFbsKDCLVq6eya1s+WrUkAOtR/ZSqEteKRksoMiLujvZvsK4Ip9xXas
         3OboZiA4c54xWYwcqpXxutog/uKwJErul7K08lWRhnPJKud+A4jmkKGkKHbxLO+btNrX
         rPtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kKhKOSRAGTEduYDqevxQ6blkPRq46uEfRph7UuT/UHs=;
        b=MRY/d4u4tpAId3G4PmKFn8XsEVmFMsXBwUfyebjZI+DVhb1pjmbBcJ9i0/4IKWfdr3
         ekay0FGZudXswcxiL9YnV0t8E8c6v51dyFoKP6SfKyXCOp5R8JkHyONgwLNF4Y/YqxvI
         yd+9HppktGx8RdA81NIR7FeuUEelrXJSMojd0PVfof6fZkLoPf4mhO5CyrfAWVJabRim
         akGonahA4HWdxsYV6PO8Vu6yR1heFxRfdjBK7Afpfv3YeubHwVBjZdcKYoNLPiJPvD0t
         sKBaIuw1GwAxnxsMQ0jDwacoLkmfKMp8jkvmiWvOlU150P/l3UiS1hyMFI+YBRTzbDVf
         lgEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arch@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Al Viro <viro@zeniv.linux.org.uk>,
	torvalds@linux-foundation.org,
	alan@linux.intel.com
Subject: [PATCH 4.14 45/64] vfs, fdtable: Prevent bounds-check bypass via speculative execution
Date: Mon,  5 Feb 2018 10:23:04 -0800
Message-Id: <20180205182140.422732097@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586385988984097?=
X-GMAIL-MSGID: =?utf-8?q?1591586385988984097?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams dan.j.williams@intel.com

commit 56c30ba7b348b90484969054d561f711ba196507

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 include/linux/fdtable.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -10,6 +10,7 @@
 #include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
+#include <linux/nospec.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/fs.h>
@@ -82,8 +83,10 @@ static inline struct file *__fcheck_file
 {
 	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
 
-	if (fd < fdt->max_fds)
+	if (fd < fdt->max_fds) {
+		fd = array_index_nospec(fd, fdt->max_fds);
 		return rcu_dereference_raw(fdt->fd[fd]);
+	}
 	return NULL;
 }
 
