Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x227lmvY/GX8hVq+xGwesbvIzfjF16e78JfFCYTuOXOuRNYg4E60dMwglw1UGYaQc/ZJa9BFr
ARC-Seal: i=1; a=rsa-sha256; t=1518651713; cv=none;
        d=google.com; s=arc-20160816;
        b=gORPCsoCZh6izjqqWQ0IIJENdh+RuYQdW4gL4kQe+AHhTauZasIML2uEAts5g57D5T
         As4A3Y4sdRQCyd3swe304aKOwA/IQ1sgrqIbUNvE+LE9z8fIYQkGQoQWrMdtzPwm4gy2
         /XBk9UfVWVdsbyph4FSgSoyl1csDC6ohvo6GwhyYijjuDAeFQz1FfZ8Y4ZMTQLlEUf1E
         5iUGc0tSvUzjp64DwPh4eZ9s3/uTR/oakSH/vWKD2jWXoWHJZ5g76DOqIUeBiGZq0NAU
         NRcae20rk7IqxDMb5J9GYXN6Mw4y54jP08Gp3/B+a3oAxYvDXTen65Qf0o2T88MydgN0
         Enbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=WiLnvULRfrPYezidbxzaRzBXbPwx9Ho945qjGW9ZZG4=;
        b=Kmlw2Lv9NTX+0vuWuYvj8IA9eEOFPD1kEyKX/eCXBj5tbT2orgboG9IbTrkAzXzzR6
         L/tuNvDEDc+hYocnbupT1uSBptYO2zJ54qKWo26tEDfksAHRbWCCOG0ze4qqZoAPGFgh
         GMCl39n+Mv8wp435qbIxB1ZEQQLCx5d+D1QdzKSQhcXHKhRkx0grIC5ulcLxvW4BsmpL
         rp8SAR2wDxRHLCnQJkISrLlA0/H66V32xcIjEjrFEUnC6mCRaIijOJvJxS91SI+9pKcr
         JthEJWBj0mDpcTpbSf8N75dgtbATcUKGm+0V6q4rjD8ieZA8gYtEWdyiWV8kixV7jccS
         PhQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Wed, 14 Feb 2018 15:31:18 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-48753793350974b7afe9598fd1dc46b2f1f47c2d@git.kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        dave.hansen@linux.intel.com, arjan@linux.intel.com,
        jpoimboe@redhat.com, bp@alien8.de, hpa@zytor.com,
        gregkh@linuxfoundation.org, luto@kernel.org, dwmw2@infradead.org,
        dan.j.williams@intel.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, bp@alien8.de, arjan@linux.intel.com,
        jpoimboe@redhat.com, dave.hansen@linux.intel.com, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, dan.j.williams@intel.com,
        dwmw2@infradead.org, luto@kernel.org, gregkh@linuxfoundation.org
In-Reply-To: <20180214073910.boevmg65upbk3vqb@gmail.com>
References: <20180214073910.boevmg65upbk3vqb@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Fix CR3 restore in paranoid_exit()
Git-Commit-ID: 48753793350974b7afe9598fd1dc46b2f1f47c2d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592421738874138967?=
X-GMAIL-MSGID: =?utf-8?q?1592421738874138967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  48753793350974b7afe9598fd1dc46b2f1f47c2d
Gitweb:     https://git.kernel.org/tip/48753793350974b7afe9598fd1dc46b2f1f47c2d
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 14 Feb 2018 08:39:11 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Feb 2018 00:28:03 +0100

x86/entry/64: Fix CR3 restore in paranoid_exit()

Josh Poimboeuf noticed the following bug:

 "The paranoid exit code only restores the saved CR3 when it switches back
  to the user GS.  However, even in the kernel GS case, it's possible that
  it needs to restore a user CR3, if for example, the paranoid exception
  occurred in the syscall exit path between SWITCH_TO_USER_CR3_STACK and
  SWAPGS."

Josh also confirmed via targeted testing that it's possible to hit this bug.

Fix the bug by also restoring CR3 in the paranoid_exit_no_swapgs branch.

The reason we haven't seen this bug reported by users yet is probably because
"paranoid" entry points are limited to the following cases:

 idtentry double_fault       do_double_fault  has_error_code=1  paranoid=2
 idtentry debug              do_debug         has_error_code=0  paranoid=1 shift_ist=DEBUG_STACK
 idtentry int3               do_int3          has_error_code=0  paranoid=1 shift_ist=DEBUG_STACK
 idtentry machine_check      do_mce           has_error_code=0  paranoid=1

Amongst those entry points only machine_check is one that will interrupt an
IRQS-off critical section asynchronously - and machine check events are rare.

The other main asynchronous entries are NMI entries, which can be very high-freq
with perf profiling, but they are special: they don't use the 'idtentry' macro but
are open coded and restore user CR3 unconditionally so don't have this bug.

Reported-and-tested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180214073910.boevmg65upbk3vqb@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1c5420420..4fd9044 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1168,6 +1168,7 @@ ENTRY(paranoid_exit)
 	jmp	.Lparanoid_exit_restore
 .Lparanoid_exit_no_swapgs:
 	TRACE_IRQS_IRETQ_DEBUG
+	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 .Lparanoid_exit_restore:
 	jmp restore_regs_and_return_to_kernel
 END(paranoid_exit)
