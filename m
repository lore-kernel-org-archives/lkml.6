Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELvWE7mb6bH57w3/s8q3TCafZL/RQmj0LBOTf41nyRztBBGCaBuFkIixWH2joxeChOejBZo2
ARC-Seal: i=1; a=rsa-sha256; t=1520245572; cv=none;
        d=google.com; s=arc-20160816;
        b=qXPVIOhv2MpGXRaBpkveeFgH/Pf8B1cYNr3WP6ZTDBC8Pcjwl0MTzcswnQxslHHSIh
         6UyTH8M1Yn73DGu/Qy70HoeN1AboThqTo26TW+DUf5N/7tED0Zc5bPdeiq8IUvukQ6gp
         YpI7IqdZMFUOatbaNMQ+ga9iEQVvXR38QZBZOiCPVpiiTGeOe09KlsuBVmBIR9frDTkx
         ME+CF7pPR4ozRGNOnX9L1lE+MQvWmKnhZxV/5rec5etfo+JjiS/qQvfTnG4k+55nmYNk
         l6NNFW6pYNZk2KAP6XatxnAKCv9T+8rk3+x9UMNDoFoOCrzLfNo7QU0HnYlT+6z6pmTd
         uxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=c+a2sINmdTrcI8vkYK/XU7EvC9UjG9GZQWNCAcJ90XU=;
        b=CzGM9GhJW7qyOGUaobrPo3sRsVFuhUAIiOqYdtKhinc+KyrGkPFTHg2d2w7+BhYWLw
         yzBGueFKfp+fn1qPmq8Ye3RhyHK8+8fvOkvKsKg4HyNuMeO2fIwvzkel+iyj+kdlB20E
         j4tvO4F3K4qm1ycWBZ6emCk6MaGOPgixUm64JLe0i3kVU20aBkd22XXlpNtbWtf8clzA
         vhei+XyMNpQ377EtwNVU+aOa4L//rrYWTZHbi/hLHmQOdpo7TXKbb1eS9n/FVD9oJaz1
         7n/d07T68Qc85l/e5ouDHY3GIiOJ+KkMFD9Z89txaY+zOnjrPXWqWyQVj2HcDQ7Mwor/
         wPZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=dEU5p3qF;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=dEU5p3qF;
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
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 06/34] x86/entry/32: Split off return-to-kernel path
Date: Mon,  5 Mar 2018 11:25:35 +0100
Message-Id: <1520245563-8444-7-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093020633025871?=
X-GMAIL-MSGID: =?utf-8?q?1594093020633025871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Use a separate return path when we know we are returning to
the kernel. This allows us to put the PTI cr3-switch and the
switch to the entry-stack into the return-to-user path
without further checking.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 00ae759..9bd7718 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -65,7 +65,7 @@
 # define preempt_stop(clobbers)	DISABLE_INTERRUPTS(clobbers); TRACE_IRQS_OFF
 #else
 # define preempt_stop(clobbers)
-# define resume_kernel		restore_all
+# define resume_kernel		restore_all_kernel
 #endif
 
 .macro TRACE_IRQS_IRET
@@ -400,9 +400,9 @@ ENTRY(resume_kernel)
 	DISABLE_INTERRUPTS(CLBR_ANY)
 .Lneed_resched:
 	cmpl	$0, PER_CPU_VAR(__preempt_count)
-	jnz	restore_all
+	jnz	restore_all_kernel
 	testl	$X86_EFLAGS_IF, PT_EFLAGS(%esp)	# interrupts off (exception path) ?
-	jz	restore_all
+	jz	restore_all_kernel
 	call	preempt_schedule_irq
 	jmp	.Lneed_resched
 END(resume_kernel)
@@ -602,6 +602,11 @@ restore_all:
 .Lirq_return:
 	INTERRUPT_RETURN
 
+restore_all_kernel:
+	TRACE_IRQS_IRET
+	RESTORE_REGS 4
+	jmp	.Lirq_return
+
 .section .fixup, "ax"
 ENTRY(iret_exc	)
 	pushl	$0				# no error code
-- 
2.7.4
