Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AB8JxZoS/3ThOaajV0dW/wgPiulvmZRec5nWai7Jnum+i+wifvHBNwfcGynNQkK5xFParsZFubs4
ARC-Seal: i=1; a=rsa-sha256; t=1524498469; cv=none;
        d=google.com; s=arc-20160816;
        b=JcIeIWuDvh/wN+VafTE01WyicdnjF0x8i7BGPSjhJoAAxCIrBzQIx+LF9trppgDpzE
         ctcK+9znCoWGbndgsn6hwc3JMN2MX0XKSo2eK1K0hQl+6tK9ZtgtJO3Ky4H17LBTnoGl
         +xlkO1KVZb83lCyQzijqKWZIHixJ/3pfCVZKDf/StFIJceQVsUOV1o8GNLeFaZ7hHfYo
         Gy3L3SBUbtJzHx33lqhtPhBfaFOlPp1RgpBRKzNFMSFQndz3LGSDFtS/RhiNpAPco7jk
         gB6cMfzLQZcVpGKw+XHBarGLf2fRHFiObrf3Lzxcaq08XcVcPw1OgEgO6X6EFq1Oav1/
         Embw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=As1QK1SfZFoKkepHCdFdNR8IF6nzgbilli2hGnAj1fI=;
        b=VbhMHqZveVdt+sqmrtCEltS7CyL2ah1R+pkHxZ8VlKkW0OQJcstPH4oJOUlwZ5gegB
         z6HlhuJAEoc1jkQOO76THf37w/5wft62/liARMJcjfw3U+cyIpWhh4r2GfAwut6Pgtsh
         e0faPbldDewoeMzoAPOP+Fo257wLTG/D6Gd2ZIZs2/mFDz/AKNa3j9yV4jX2vi/12Qrx
         Tdcq5ZWNDfwYcQFjf/SVl9GM3pCBf7uND/CUFYuFYsB3IawURmyElT65aPInfy3sZdNB
         7WO2mgXQ5rdbAai6bpYhQRKnIGsJedxLSyu+0LbmyiBS1S2q1IM0hYnEYqOeAzpMsyJL
         8f2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=PfERHSeV;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=PfERHSeV;
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
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 06/37] x86/entry/32: Split off return-to-kernel path
Date: Mon, 23 Apr 2018 17:47:09 +0200
Message-Id: <1524498460-25530-7-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552507076916088?=
X-GMAIL-MSGID: =?utf-8?q?1598552507076916088?=
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
