Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48UZwnpzkll4RwdSDbi3WnWlEUGz5iJMM9fsZOa00qTdAo5ZqgghvCH/S4Rvi+YU6e5w/y8
ARC-Seal: i=1; a=rsa-sha256; t=1523981341; cv=none;
        d=google.com; s=arc-20160816;
        b=KX46Grv+ZxOWXEwEUhninqR+FcDKqtXeHWpQx2mED4sOxZCI+LtfDKwIW952IjcKaE
         euKtYEh+nG74g0hYqSG4gHei+4mk97tkH0ZaUxLCH4pQ1w7VqN4sZI/S/1OAvj6UJGxb
         X07ipp+EFzsyN6sb+rCUIluXWJRZtaYFNrOgIDB3JoDkyS764RLFrxaLoFOpj/Br4hp0
         nUs4Y2SYGDeWQ6HoFuhwHpeLlxgKcnYKr9jCGHkZr/dXo5b7MUQOxUSrShiyq1T7f1t+
         1YqIzB75egaoNWgeqhSaEdxSRHkgst/iMpXRxiObnsSglerxQtIkVhW6q8dL0eKTE4pp
         Plvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Q3my5xXK0mfvB60vTbwXNqheySbNaNlt32879HSCQzc=;
        b=BkI3c2xQbXRghWU6uWmBC/YqlgJKTBlmc1K9+CBKcFmKdQMWkm69ord/UtEYerMBOw
         Fme2MzeMwTbkmuD7fDpD2+oIG9eYsyo9g6X5zrehuipchVKlVK/7HgooRn7v/6cEyplb
         1WJL4GYXJYw2y/36hdjA7i/zIRL7fSxOoOfRBLrTcVpqVSVdj6dh7EhJ2zcPD30UWKiY
         Y12C582kRbrEjdLlL1IyhagKcY0gYbwzSKfqplYJH+uEIqARhXULMLyLy9QtP0b1Vzwj
         +wYD7/nA8lZDf6HEguOSp9JRr+naixRBDPadsVUISsexEGe4QIgV0Mm1JTaQXHnhW/M0
         jI2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Hettena <dhettena@nvidia.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 29/66] arm64: entry: Apply BP hardening for high-priority synchronous exceptions
Date: Tue, 17 Apr 2018 17:59:02 +0200
Message-Id: <20180417155647.135110935@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010258459867487?=
X-GMAIL-MSGID: =?utf-8?q?1598010258459867487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Will Deacon <will.deacon@arm.com>

commit 5dfc6ed27710c42cbc15db5c0d4475699991da0a upstream.

Software-step and PC alignment fault exceptions have higher priority than
instruction abort exceptions, so apply the BP hardening hooks there too
if the user PC appears to reside in kernel space.

Reported-by: Dan Hettena <dhettena@nvidia.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |    6 ++++--
 arch/arm64/mm/fault.c     |    9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -624,8 +624,10 @@ el0_sp_pc:
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
@@ -617,6 +617,12 @@ asmlinkage void __exception do_sp_pc_abo
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
@@ -676,6 +682,9 @@ asmlinkage int __exception do_debug_exce
 	if (interrupts_enabled(regs))
 		trace_hardirqs_off();
 
+	if (user_mode(regs) && instruction_pointer(regs) > TASK_SIZE)
+		arm64_apply_bp_hardening();
+
 	if (!inf->fn(addr, esr, regs)) {
 		rv = 1;
 	} else {
