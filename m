Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227WiC0Sqs1hu1Ks8bmiZytEwWR7uNraye4GuG84ojFxgnICBq8SZnehS3U6TaZ2w5WrhJKL
ARC-Seal: i=1; a=rsa-sha256; t=1517855087; cv=none;
        d=google.com; s=arc-20160816;
        b=OyNJOB4xPlMwuN+vzSymohBZe60TFng7f3L+9W5d+oXmauYnWUIgjs02Hp6mRPVZBZ
         2OqgwloI/i2RxNua89q/3wSdJlMtLFgcq6QVkczrO1BcSMg3vk8M1P8fq7JeSRKySWc8
         HE+YTsUMWSai3hFXFO78NlS9dsZDi0eaUYVaCZQG1/9XmWi35i8G1TXHF0cJ3YJ0Nvmu
         sjR07ijNapD4tGuKaUVtHAEOX8Ze5W/3pUqaEN0WLfrpQVMlSQLRjTB0QxCYc38kyVDA
         qZJUDKkzHUuSRh0hOXXxsVx+MpBooi1AwhBVlKSfX357OeUTZTSaFIi5r0BlUJPotRG3
         YRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F2F1k/TGqhSoSptaBJeh49Kp94mrUWCZsk6nOKoTSWU=;
        b=HqpvWQFyiIn+/DizJmG51euh7kBxAyUCLh7uqCMm+aU0Mg7/Icd+QA8bpMftB5y4zy
         ChzmqwrGz6WxO4EVlfGEYDPzg/6Ua8qa0Yw8r01eoU+d9q9TMR7n3P1/aJfaW7qCMFsG
         VDtvZ5GzoEwfcLocgZ5OU8wmKhV6j23FZUVjxGIPK+Xjh1k73DnoUgf0c8jp3ZyyG3kL
         LDTBA/D3ULVXb1CP8ozouo7Cp/D58LDwPooBb7qqaCEubf7IyGeLmQ6vllylMN0n0AbS
         VnausqfmCOZ7wTgL8KXV/j90HOXjkZ+oYv8H+rDkxNoYi8AL0ZDSOleRVPcEjDaDRe1t
         8kqA==
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
Subject: [PATCH 4.14 44/64] x86/syscall: Sanitize syscall table de-references under speculation
Date: Mon,  5 Feb 2018 10:23:03 -0800
Message-Id: <20180205182140.385565178@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586416249692382?=
X-GMAIL-MSGID: =?utf-8?q?1591586416249692382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -284,7 +285,8 @@ __visible void do_syscall_64(struct pt_r
 	 * regs->orig_ax, which changes the behavior of some syscalls.
 	 */
 	if (likely((nr & __SYSCALL_MASK) < NR_syscalls)) {
-		regs->ax = sys_call_table[nr & __SYSCALL_MASK](
+		nr = array_index_nospec(nr & __SYSCALL_MASK, NR_syscalls);
+		regs->ax = sys_call_table[nr](
 			regs->di, regs->si, regs->dx,
 			regs->r10, regs->r8, regs->r9);
 	}
@@ -320,6 +322,7 @@ static __always_inline void do_syscall_3
 	}
 
 	if (likely(nr < IA32_NR_syscalls)) {
+		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		/*
 		 * It's possible that a 32-bit syscall implementation
 		 * takes a 64-bit parameter but nonetheless assumes that
