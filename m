Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225KrDN+1HDULEH78sy6KGS/ALBMsUzXmo4P/BUvc1w2RB8IBAlGU4mJF3rD4ykkmDumOuxw
ARC-Seal: i=1; a=rsa-sha256; t=1518709294; cv=none;
        d=google.com; s=arc-20160816;
        b=wUMjuijov8u1O5GEvXoQqDHDmou/ydEDlczrj5wUUKNrbfQrFTIw/x5NnofKZOV4mf
         NRaxd/9aCqiG92su6khD1LvTQUzVG+GDW96SKRoYsbXn+3dKAok2/r94JBr0hfooPkbI
         FqxQqNb1uRuCBNOOYUnhkR9k1LpjhzAAfrwMf4OvqQVhKQ9OuXrtTonhM7cOHHwa1sBq
         yWXXlHMze/nM4YstUyVqsB8cGzIwUjbaJdGB1it1Mxbvyc0bjTFpLw63ouMb7XZ+QgDV
         4e95qnXvOh2sme8sVuAl3S4GedilLGsnGwhHIqp8hS+A+wn1ioAYurb5381C8dK5qaeF
         N3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TZ8bOAQ/xtX038d5Jo1nur5apODGqnyju8efPEenH70=;
        b=ELKB527+5i2cK2KaXaDCM0Q0RQcqW1t/HtK4Msp+qRH5q3CdTqVhDkme1ggowzvE1l
         qUvcCAjHGBYNbazYG8AgEOuxFr3fNcGxx1WJdysVziqb5sRcZdtfrDIxyjYIA/BOz3i4
         9apTLluk+0Zdx7SWiLE+8Gs4YAw04IODAEOeqRHUHBxcqPlapDeOj0omDIPtDQCuoy0A
         +QcKhVwxi3WqzS1sit79LWt0iv/DfqI8ReGzGOKaZBTMv4FF/N1oTwstERXMfOdD1HbO
         7BICKB81sU30/z+cQ4Qmst1tIY20zglsiF/UgbHRhnd9LVMKs5xxNPX3nwv/PK0cIEPL
         6Mxg==
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
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 066/202] [Variant 2/Spectre-v2] arm64: entry: Apply BP hardening for high-priority synchronous exceptions
Date: Thu, 15 Feb 2018 16:16:06 +0100
Message-Id: <20180215151716.907352807@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481565852328465?=
X-GMAIL-MSGID: =?utf-8?q?1592482117218991285?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |    5 ++++-
 arch/arm64/mm/fault.c     |    9 +++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -767,7 +767,10 @@ el0_sp_pc:
 	 * Stack or PC alignment exception handling
 	 */
 	mrs	x26, far_el1
-	enable_daif
+	enable_da_f
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+#endif
 	ct_user_exit
 	mov	x0, x26
 	mov	x1, x25
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -731,6 +731,12 @@ asmlinkage void __exception do_sp_pc_abo
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
@@ -790,6 +796,9 @@ asmlinkage int __exception do_debug_exce
 	if (interrupts_enabled(regs))
 		trace_hardirqs_off();
 
+	if (user_mode(regs) && instruction_pointer(regs) > TASK_SIZE)
+		arm64_apply_bp_hardening();
+
 	if (!inf->fn(addr, esr, regs)) {
 		rv = 1;
 	} else {
