Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226qhVIGL+nPSfW5+qwTmRLqnphvWfKcOMm0M0TupWIjit7XhwOPSFZpK8DzH+0GXMKLvjzT
ARC-Seal: i=1; a=rsa-sha256; t=1517855140; cv=none;
        d=google.com; s=arc-20160816;
        b=z7GYKjM57pEeuo+61P8YCHAMPJFbXaMXLnuxUYFe5wpzqZ8pucXpcpPFCCZARuxbuz
         gAPi4dsJjYtTDxQ/C/GhypoLC6fr34qGR7DEzgNdwom5v6i6106liKraLT6zY10iWTRg
         tF4gEMo/obRrMrPJuaila/0v8aWwAbW0/mk+SCljYIh5o7vu6f7IS/JCK9aHMvf2nb+N
         3FeKvTtXtiUPorG0UwLRCcHNQC9jNHuXiC/U5hLQJqJ9JIOZSQdGsNG++P451OctNrw3
         J8vLlXE8KSXB/469+lL020adllyElONH0fbyicsVz2oN0HdStsM+TfJKMOyWLQMsewRN
         hgrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RQeE7capP/jrjJMaLqf/QwkBdWS9xA5WfMUeJPjv+qU=;
        b=WeUicLDMHGrNn6IIZNG8lRgbcY28j29LdUwMxumN7zNN7FjlytXIeOBevJWWI8Uh/m
         k6ufY0bvTlgV4Kzx12QvnSCHiIBMJ5bhFYIhJHo4svLc/z6GXN8RqKqrK5rm4VspxJEf
         WmCUofUwf2D5P5mxvfxfpLD73eBLNqWZiJbJ7EyNHJ7fQfLn7eB/Ck7CFLLhQdIQDc3J
         teLdzYmQh/iS8qnw2u+95bBO7lmdPMNR/FHdn5teRkZCKwj1fGGBIeXqwYypOCGj7y91
         aDd05tHqkhflTJBuSh7L4aCllsdNcSGsZgMq/ngAT0fMF4dtoNIOPPNy41rtJVOnnGSg
         56Hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arch@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Andy Lutomirski <luto@kernel.org>,
	alan@linux.intel.com
Subject: [PATCH 4.15 40/60] x86/syscall: Sanitize syscall table de-references under speculation
Date: Mon,  5 Feb 2018 10:23:13 -0800
Message-Id: <20180205182215.617155182@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586416249692382?=
X-GMAIL-MSGID: =?utf-8?q?1591586472160165292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams dan.j.williams@intel.com

commit 2fbd7af5af8665d18bcefae3e9700be07e22b681

The syscall table base is a user controlled function pointer in kernel
space. Use array_index_nospec() to prevent any out of bounds speculation.

While retpoline prevents speculating into a userspace directed target it
does not stop the pointer de-reference, the concern is leaking memory
relative to the syscall table base, by observing instruction cache
behavior.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727417984.33451.1216731042505722161.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/entry/common.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -21,6 +21,7 @@
 #include <linux/export.h>
 #include <linux/context_tracking.h>
 #include <linux/user-return-notifier.h>
+#include <linux/nospec.h>
 #include <linux/uprobes.h>
 #include <linux/livepatch.h>
 #include <linux/syscalls.h>
@@ -282,7 +283,8 @@ __visible void do_syscall_64(struct pt_r
 	 * regs->orig_ax, which changes the behavior of some syscalls.
 	 */
 	if (likely((nr & __SYSCALL_MASK) < NR_syscalls)) {
-		regs->ax = sys_call_table[nr & __SYSCALL_MASK](
+		nr = array_index_nospec(nr & __SYSCALL_MASK, NR_syscalls);
+		regs->ax = sys_call_table[nr](
 			regs->di, regs->si, regs->dx,
 			regs->r10, regs->r8, regs->r9);
 	}
@@ -318,6 +320,7 @@ static __always_inline void do_syscall_3
 	}
 
 	if (likely(nr < IA32_NR_syscalls)) {
+		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		/*
 		 * It's possible that a 32-bit syscall implementation
 		 * takes a 64-bit parameter but nonetheless assumes that
