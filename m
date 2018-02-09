Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x227o7VuvSHLjC70YkjvJUSKKI5WTIH5T5L1EU7OZNE80mwTmWOPhtJU2bu61QSW9oNtR8175
ARC-Seal: i=1; a=rsa-sha256; t=1518168356; cv=none;
        d=google.com; s=arc-20160816;
        b=SKdDa1R0FrK2lKEfRGIyfKvQlUZ8B/sCmiNNiYvi+/LSVmPNqSj7MZfHrJLxdPDmkG
         DUGxHFxrkyXd9R4gvYRhjIQQMQyQB3bHepxv4oJx9ULcwsa9BkoaTLKGGnwkaWLpoZE6
         gDXW2FBqJGz/g1XexAo2eZmEQ2QMHh1MoxDqHfC4qOe9ClS41MQtkJt57kvtJ6mOtdhU
         wbTAIsmrFE4nnJp3mVjW7HpImmz/W0ioi67d/WeG/7Xr439G7l7r+skpFw4Mc8OlYUe9
         VAgiEVEE5K/LjgN7+o8Jx42dRXi5BQby9EvYLyVKwhsXDOimohACeeMDd1s4QF8VdXH0
         C/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=c+a2sINmdTrcI8vkYK/XU7EvC9UjG9GZQWNCAcJ90XU=;
        b=KtkOAsjyTyoKqzZkfi5gFA7NSyniyvnBjfnVFAE+6eMw/JTbPM5Z7VZHQYssDT9AQo
         F0gzn17eYcU3DSPKfg8vGCdsabdXXgVz+UcOPkJUqVpenLM74XL5ELcFTVk09lOKqGvd
         WRF7CKH9F7UkyAt0HEfmONjKZd4tpDC+9va5ZGux/viT6MjgmL1AEg79laJnYmj4R5wO
         ikjoykdtq2S2ZLlPP7bevqKCGCPA50XuPqsv8g9zPmTXeUG7qiDPI+NImNET7q2cByAx
         Jx+TGuMfVaS2DaEFXP28BV5MFto8bXU1pDRtNQtuUJdXud5nsAOOqBXg7vfreIW/JGB+
         cGzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=l0dR+8Nn;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=l0dR+8Nn;
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
Subject: [PATCH 06/31] x86/entry/32: Split off return-to-kernel path
Date: Fri,  9 Feb 2018 10:25:15 +0100
Message-Id: <1518168340-9392-7-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914902552804674?=
X-GMAIL-MSGID: =?utf-8?q?1591914902552804674?=
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
