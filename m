Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226rFgJkT3gvAbDvgSu+O6+SJM4n8x21oDHSYMo7GkjFl/tmxEyR2kavSs++abYtxZy93jdD
ARC-Seal: i=1; a=rsa-sha256; t=1517855142; cv=none;
        d=google.com; s=arc-20160816;
        b=VUHJYFAiJKkXAejXy5sJTfslc/1alBdkHEHTHq+fAGYoOcXdHx/Rny4byQmiY8MJXG
         NdhElJK3MNayFN+Ql6Y1h4+8I/+SLY3+oVC3W6rrozGFYgsKX/pckVMn5gIlz8Dlh8yK
         VspZQZ464xwA8h4zpPsv9vIMtPcrgsyw7EJHtXMhCkF4creNA/FAZnmZj9bdAnrT1Ueu
         ByJ6sEWISClpcctUyBETJOCLWXN82V4nVnesbvOEQ+uNj7N6RbmQHKVHvrkhxC+qTKw7
         u4Ae5GlOK69gPSL/HjiGtR/bgYTKiZJ3t4Wf4aIy55UQgK585eN0tLY1z1PiWSLkqywo
         81hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qWx/vzJcXAUxlHjZU5ZZLNsXW6iF36EGnfcTZyW3CQw=;
        b=Hw3LJVeee5nb82gM89flmxckXknY/JiXdtObzcSrefeNdJJLVrYnz0dJfJX/FwOION
         ieX88GnjkfLEgJwIvRO6hAuBZhZcuNJMbmOYv0lMH1YRh1ViZ/98il1uWzd0BgWOCxNm
         kUwngdry10BDkla6BsoByhONOPC7uSsTVEixQnKxHpuDO9e58dLy9lkBvmPknFQObEJ2
         bpM4+WQShoNSzhiD7Ahdusaamnj0Xjpy7qDURMLxd9FAABIMUB8jf+icSMX0Wd6yt1Vm
         ofvOSvISoGSbs4PpkvXbJNmc1apHv7+uANUjnPuJYchQijSJt2OCgvYWPGrFF2xAGyQ0
         IHfA==
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
Subject: [PATCH 4.15 41/60] vfs, fdtable: Prevent bounds-check bypass via speculative execution
Date: Mon,  5 Feb 2018 10:23:14 -0800
Message-Id: <20180205182215.657842196@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586385988984097?=
X-GMAIL-MSGID: =?utf-8?q?1591586473893931965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
