Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELv0ktrAtK1P3ac3EHnk9e9L67guD+lPz57eF/M1ENNNg+I6UZJmo8itw+Ty6bllQknX9eI/
ARC-Seal: i=1; a=rsa-sha256; t=1521228600; cv=none;
        d=google.com; s=arc-20160816;
        b=wvTL87p9VgmNNDIoQEXG8nb3y2SijSQ6rqxIM9qrOx7LjVynE/v1j4nHw1yizu1QWO
         Ze+8QLuv5d/4UM6rO3/bXIrDKINSWlXwnRgxv7pxVkpgK9v9iJvnDaantzMjoey9RJ37
         WBrdWRzPEZjDdgWC7QVdGzqUPUMit/TgLbVIlauvAVLVZmJ1p8YZnAIB2EyYn7U9Vfnx
         TFbC4YdSbxpmh9g/VccmneDNeNxZPIoOXsn1te99kG6ENQbp0PJhPV7A2tSqktI4CjHV
         B5UhQLUj4frixquy6dCAhs+zxG5wqLN1R3Bn523S+E7PAmJFvwECyNJEIOt+RVUx9Dw/
         azFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=NTVb4LONHnLz6w99SoQtjWWuv+4gRfgau5jr8PemZlw=;
        b=hWRUCg4BWmTqzq83SEuiMcdW6P4KW2Iia3WCmNuqNa0vQuGQTj/V/fCtKgO0b+c4T7
         siYT3RuOaK/ajwuP5haHZMEfPUi7vE7E68lm7O1Zxsq6L0a4hW4VkvB8ppsKy59D9sO4
         +wUvVRhetmtg6cJcpfOseFyYAKBZqQRlchxpyS3lvETbnVPcgJXUtZoGFL5yXRInvSaq
         FMRkaPdncR82vKOmkRa4fWix9qBTz3gP5XrNGAH9Ic59FIDsz+8YAS+LFGLklEj9w+B9
         juJsxoTQ5UyMnFULfAcNNrEeRIYzoLrqzBv7n6rDrIRBadkuvFHC9pDkwm2tu7t1cdGa
         Q4Ng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=NthVvN3U;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=NthVvN3U;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
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
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 03/35] x86/entry/32: Load task stack from x86_tss.sp1 in SYSENTER handler
Date: Fri, 16 Mar 2018 20:29:21 +0100
Message-Id: <1521228593-3820-4-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123801347660556?=
X-GMAIL-MSGID: =?utf-8?q?1595123801347660556?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

We want x86_tss.sp0 point to the entry stack later to use
it as a trampoline stack for other kernel entry points
besides SYSENTER.

So store the task stack pointer in x86_tss.sp1, which is
otherwise unused by the hardware, as Linux doesn't make use
of Ring 1.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/asm-offsets_32.c | 2 +-
 arch/x86/kernel/process_32.c     | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index f452bfd..b97e48c 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -47,7 +47,7 @@ void foo(void)
 	BLANK();
 
 	/* Offset from the sysenter stack to tss.sp0 */
-	DEFINE(TSS_entry_stack, offsetof(struct cpu_entry_area, tss.x86_tss.sp0) -
+	DEFINE(TSS_entry_stack, offsetof(struct cpu_entry_area, tss.x86_tss.sp1) -
 	       offsetofend(struct cpu_entry_area, entry_stack_page.stack));
 
 #ifdef CONFIG_CC_STACKPROTECTOR
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 5224c60..097d36a 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -292,6 +292,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(cpu_current_top_of_stack,
 		       (unsigned long)task_stack_page(next_p) +
 		       THREAD_SIZE);
+	/* SYSENTER reads the task-stack from tss.sp1 */
+	this_cpu_write(cpu_tss_rw.x86_tss.sp1, next_p->thread.sp0);
 
 	/*
 	 * Restore %gs if needed (which is common)
-- 
2.7.4
