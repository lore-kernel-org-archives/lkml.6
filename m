Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELu7gVNqVYDSbqZB3lZqlllPMEMjjukxXoXOkK7yMfgfzZwmHv+WH2UjAv1MTkVwvPrqb5MG
ARC-Seal: i=1; a=rsa-sha256; t=1521228602; cv=none;
        d=google.com; s=arc-20160816;
        b=K0CtqNsP2ULOKaXsRmBIXoadCULx4YdnRJp57k5tXxVHqUeV/HS+fXwbNkYwgupOxB
         CvHxZIXcheusxKtlp5431Sgpv/nRyaLZxwzQSLnZ/wiZTUZOha9BuXjVBfgqkOffV7w+
         ysz/TtmB/zM7l61MUshDNO2hjE8RHHfCTEvxkHpSWqlQNWRdXjeRojTlDoIaCORqKw8r
         B1MYMnHUh/yTKxCUdHQ3+hOGHxTUoQzCrtrild/daHRCPg+/FN8HOZ/QHY2L7W1pJI29
         WaCm4lRJbxDuft0zPqVOahi5KlUy/Rqx9POR2tpKcA+MKeESQpWMkQf1QL04MHI0DzLh
         0pIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=c+a2sINmdTrcI8vkYK/XU7EvC9UjG9GZQWNCAcJ90XU=;
        b=DXG/1vsr7si9z9VbYvsf1AVnrr8jhaOa129G0/AX9jevN8FcMcsuXnlfdFb/+T36Sn
         HbUsiz+Sjj0u6OQ1VwaWKPy0VAcC06Fyom2h6r8wF/m1fVeeuDVUl+nN2BBdxt4oTZ+x
         5CUAiQcRTg4waT5ZH0MAeFAyX43fisUOf/3FZzXKsMc+fkdd+e0qFNLBRcyyb5hBPvLb
         q79Kw5RiaS6y0Fab6LEIF2b+VYQvMstRMu8uoVKa2Vi3roItux8xw8+rsIQLpBwkFIcs
         lEMu6/APeyVoWDU1gvvqWKViu3+wiEOM77EVbiL/8Yepl+/uqKSTeSHWFPtwgiUU21Nl
         8rWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=ipOEtpYt;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=ipOEtpYt;
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
Subject: [PATCH 06/35] x86/entry/32: Split off return-to-kernel path
Date: Fri, 16 Mar 2018 20:29:24 +0100
Message-Id: <1521228593-3820-7-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123803224668545?=
X-GMAIL-MSGID: =?utf-8?q?1595123803224668545?=
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
