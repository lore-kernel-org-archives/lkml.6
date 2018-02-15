Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224u21UROqJR1mz00I3VvzNZbgcmBCQOwym3VjPv38sZ+7iswP4sMcuottkc/un5EehnZtJ4
ARC-Seal: i=1; a=rsa-sha256; t=1518708768; cv=none;
        d=google.com; s=arc-20160816;
        b=lubyd7E2SYIOhbtLyG1ldxilu/bDPSjtW4tqRXJWhZmblluDlHYVYFh05X9ezDIpEy
         UAZaxGMxZEkboiFZ/wsKsUlrkI6Ae33nK/rR25x9y5D0DJYXwNo9M/y9wM4gCJpM57CX
         e7Vfi6yKjuHMOpojspFZP3pk+QSq7yGDgLO5Vv1EkvLVm669UhDC8vfb7kEAnDrh1ZMD
         whAe8ssAGNC+zmhd+kR5UyX0nw2ZFkZ5pPhknHcycHBn7qRoH9sNoiZmKucI1RJeYRvB
         NogISa/fjhE2ZdgFlf6QOHcr40BUbBxopLGciSmSLQkB0swupwJyXOV1psFCRxYMSNc6
         p2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=h+fWMlVpPKysrD4+3ED8+N0hJYD1AsecrAB2CKjh0/w=;
        b=ie4KyfnJrDvGUALP5sr+mdY7HNSBWDeWy3tcYOtZu+zXH5Ct5GX+5sbffHg3sEniTS
         zxXRDINEAIE2vXmiYyL52cnCUp9WAdNfb5qLFvn9zhkE7KFn7UnRIdD6uPXhg247HYmy
         Gas0Bl6Gi+cW9zV9vND3AecjONu3Xb5bKKnAQBqvHGzSYMyXuOdKryYK/hZY4vAqnXJM
         JPQkpGw/uEDRIXuB7FvSVeXUqfN0ftgflPMBgsEXTsl+CibaRLHmyGQNqWmi3GVgRVXt
         RMEcZZsolDygBvXufc63eZTe6SdGFq90VdCLNdJHQIEKMKeX+btIDpiMQYvAEIAmwDN0
         wEjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Hettena <dhettena@nvidia.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 073/195] [Variant 2/Spectre-v2] arm64: entry: Apply BP hardening for high-priority synchronous exceptions
Date: Thu, 15 Feb 2018 16:16:04 +0100
Message-Id: <20180215151709.358499659@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481565852328465?=
X-GMAIL-MSGID: =?utf-8?q?1592481565852328465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 5dfc6ed27710 upstream.

Software-step and PC alignment fault exceptions have higher priority than
instruction abort exceptions, so apply the BP hardening hooks there too
if the user PC appears to reside in kernel space.

Reported-by: Dan Hettena <dhettena@nvidia.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |    6 ++++--
 arch/arm64/mm/fault.c     |    9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -759,8 +759,10 @@ el0_sp_pc:
 	 * Stack or PC alignment exception handling
 	 */
 	mrs	x26, far_el1
-	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
+	enable_dbg
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+#endif
 	ct_user_exit
 	mov	x0, x26
 	mov	x1, x25
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -778,6 +778,12 @@ asmlinkage void __exception do_sp_pc_abo
 	struct siginfo info;
 	struct task_struct *tsk = current;
 
+	if (user_mode(regs)) {
+		if (instruction_pointer(regs) > TASK_SIZE)
+			arm64_apply_bp_hardening();
+		local_irq_enable();
+	}
+
 	if (show_unhandled_signals && unhandled_signal(tsk, SIGBUS))
 		pr_info_ratelimited("%s[%d]: %s exception: pc=%p sp=%p\n",
 				    tsk->comm, task_pid_nr(tsk),
@@ -837,6 +843,9 @@ asmlinkage int __exception do_debug_exce
 	if (interrupts_enabled(regs))
 		trace_hardirqs_off();
 
+	if (user_mode(regs) && instruction_pointer(regs) > TASK_SIZE)
+		arm64_apply_bp_hardening();
+
 	if (!inf->fn(addr, esr, regs)) {
 		rv = 1;
 	} else {
