Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4/DUHnOAT8w2o6j2Qr0QIpZXxcJ32iXSSvmqa3pKrsY3TJREGoC/NjTWhLlUyBiyhv5KcX9
ARC-Seal: i=1; a=rsa-sha256; t=1524498471; cv=none;
        d=google.com; s=arc-20160816;
        b=Ksg0MojDcwkp2QcTxMUmdws1b/0Fp+CHBhDoWPUkBJuSo5XezyMakTrnfZkkmyqg9o
         ChWUyRKQPGwgPQyocnoJRX0MiUy2sJwvgWD1bNLnmS1O7ARP9vwWfMqBxjSbZuq4cyiC
         dYFDaUp6Hanm1X9d5WNHsFQBMWN2dojzJXzU7QoLOyF466mHhiH6MMpoeA60TR6+K1e0
         b9DTxkjis2mUh8sd+NVY0Vw6tNDAOWJhKyQeFgEn08pZr6YyGZRCPdwwyMckWAfZru7M
         lz8Efk6h8IgfJo7ddDnjgLhSM2IOjtZ8W86jF3kglYfqz8bkbjb6T4SSZOK3vnDeMbFq
         /G7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=oOuKC7JhFHBF2ZWVaEZG92J8LI0SKRJqDxYwgOGnUdg=;
        b=JM7MlFBTLmtQSroNfKwqY6ml6d5OQXhJ3mgNbYA7Gb/Npj4kcJp6ianvrueV0mnMwx
         ig8bO3NumRFlgC3ZHDQ3FH6MaKBRhocfFOv7OIX/pD+A/iHvB4SwWaSVBBfelJ167S/h
         TDARb9sXImQ7lENx92GskmoL90xToxhbUVWA/sw5+bmMslrGjniXoP/cHRo0iDg2Iiu7
         kKJNWbStMgJDZPyNhd6m9xbAupWCX3EOTHuAKkpIjS69TE16ZyLDIXiBnaQfjuwMOYlh
         /JeYMF18BE/NYKpgmgm/Pmkp1+TjPf22OJpoZG6NYLL3mjF2/x2fUW5HTa9G9ttt9I75
         zWuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=B2tiJFJA;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=B2tiJFJA;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 12/37] x86/32: Use tss.sp1 as cpu_current_top_of_stack
Date: Mon, 23 Apr 2018 17:47:15 +0200
Message-Id: <1524498460-25530-13-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552508826007825?=
X-GMAIL-MSGID: =?utf-8?q?1598552508826007825?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Now that we store the task-stack in tss.sp1 we can also use
it as cpu_current_top_of_stack. This unifies the handling
with x86-64.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/processor.h   | 4 ----
 arch/x86/include/asm/thread_info.h | 2 --
 arch/x86/kernel/cpu/common.c       | 4 ----
 arch/x86/kernel/process_32.c       | 6 ------
 4 files changed, 16 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 21a1149..d65e852 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -374,12 +374,8 @@ DECLARE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw);
 #define __KERNEL_TSS_LIMIT	\
 	(IO_BITMAP_OFFSET + IO_BITMAP_BYTES + sizeof(unsigned long) - 1)
 
-#ifdef CONFIG_X86_32
-DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
-#else
 /* The RO copy can't be accessed with this_cpu_xyz(), so use the RW copy. */
 #define cpu_current_top_of_stack cpu_tss_rw.x86_tss.sp1
-#endif
 
 /*
  * Save the original ist values for checking stack pointers during debugging
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index a5d9521..943c673 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -205,9 +205,7 @@ static inline int arch_within_stack_frames(const void * const stack,
 
 #else /* !__ASSEMBLY__ */
 
-#ifdef CONFIG_X86_64
 # define cpu_current_top_of_stack (cpu_tss_rw + TSS_sp1)
-#endif
 
 #endif
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 311e988..2d67ad0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1512,10 +1512,6 @@ EXPORT_PER_CPU_SYMBOL(__preempt_count);
  * the top of the kernel stack.  Use an extra percpu variable to track the
  * top of the kernel stack directly.
  */
-DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) =
-	(unsigned long)&init_thread_union + THREAD_SIZE;
-EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
-
 #ifdef CONFIG_CC_STACKPROTECTOR
 DEFINE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
 #endif
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 3f3a8c6..8c29fd5 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -290,12 +290,6 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	update_sp0(next_p);
 	refresh_sysenter_cs(next);
 	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
-	/*
-	 * TODO: Find a way to let cpu_current_top_of_stack point to
-	 * cpu_tss_rw.x86_tss.sp1. Doing so now results in stack corruption with
-	 * iret exceptions.
-	 */
-	this_cpu_write(cpu_tss_rw.x86_tss.sp1, next_p->thread.sp0);
 
 	/*
 	 * Restore %gs if needed (which is common)
-- 
2.7.4
