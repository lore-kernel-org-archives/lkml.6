Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx49sWGNLXc7mBtAxoDWw2UPy0Ic6flxCqHQLsVPYp66Sa06g1Bl+OL7XVIACQzpcsSxAvLO7
ARC-Seal: i=1; a=rsa-sha256; t=1523892343; cv=none;
        d=google.com; s=arc-20160816;
        b=cwBgKlEV3qVFPzL+cFvgybjvHgofoK4DvXF0skAH8Pa+Y8UlAW4dLDMTcJzDuJCVza
         U8UNHdbVC3nCXeqDnS38723HBDNo1wVrnQ6DNgJIvs3W4A0UBKhXw5UqWlICPlm2H7tU
         NJU27FTIFY8ecQ2OS3/iubNpCim0AdrR3vBxn04cMVezvBzYVhyqcmbNJCohwnLODiUX
         +C/BiSQFKD4cC6pEUpZ4UOG+JneC95JSIKsHE8YWdd2Pgv3tNjOvUndp+LHo3aelkPTb
         QPe6JylQfckcdy7Hy6EqSc8uwBMfgDvcRHyrkejgzLlAYwam2zW13V90LS+K03URYYz2
         iShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=As1QK1SfZFoKkepHCdFdNR8IF6nzgbilli2hGnAj1fI=;
        b=XG7xcerTYW38NOdKqz17JIbi0GK1qpEd7I1RCLlJhOl9PXmCW9uy1cLjefnrZ2WvaO
         QWrQcF9gOnHeelM5LQBFI3yjovRz1tVo4kYinrioXMSbi0brd9dVDT2RaqFeNNSZbxSc
         rQvKbax2+cjBqEMPSfqi4+4CBYBfuCaoOKE//+OUyP/KOK2f18csFQLy+vEWHSvCJWWW
         srlmD9o1eNwQer0pfrNyrKYMXBLeYlcMhHaUFeGhkR7MtC67CM9oLLh31dOQ7VsTlolO
         qeeIRMsdK3jYkKvd80yAjVbwZnzfX4tObtSDrw10FmrnVzfRKYwlxVNnhk2/XzXeMEso
         N2iQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=QsEneInO;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=QsEneInO;
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
Subject: [PATCH 06/35] x86/entry/32: Split off return-to-kernel path
Date: Mon, 16 Apr 2018 17:24:54 +0200
Message-Id: <1523892323-14741-7-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916937714331009?=
X-GMAIL-MSGID: =?utf-8?q?1597916937714331009?=
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
index 3a319fd..2f04d6e 100644
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
@@ -399,9 +399,9 @@ ENTRY(resume_kernel)
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
@@ -606,6 +606,11 @@ restore_all:
 	 */
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
