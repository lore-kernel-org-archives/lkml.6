Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x224wT0D1A7zGYtG+WIfAQT5sYOOQpE7SjzcrjiWc7mquz89LXwOPkS7a2lpgza8HpFdmyPqe
ARC-Seal: i=1; a=rsa-sha256; t=1518655300; cv=none;
        d=google.com; s=arc-20160816;
        b=glrCdAnXLskRYTVbK73B/ZhXf+uG+qTbHs3HvfYuKR4PszeXg8hVqi5VdjLVsMlDrY
         rEl+vcJi/1W4eWLod+XWBZb7E0wOiWaESKflYDumQ+YTBpCds7Uxtzh50dAqIvkUWZUx
         LElydvwQWt8TxGxWYmLXttapfRoBYPcMPZ0dl34Bh8FJ0qF1KBMgeEQwcT4lJe+513Om
         TKLUN7kxzYMMVtL8XVVCcPs7VkMGRQZ84nzOK9eBfhju5fp9f83W7Dy2ZfS3PTVj2tB1
         dBkccKaNeHsXai7Cw1fFtzkTisqiZv4uyuFZifzUGbnU/E2L2PA67ZoKYWGI0D7rYaXU
         hmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=wmWLyntccOROfN+3cvljjuEe098xczDFtnYGzTRkjlo=;
        b=bYgsEmciM8spx4FsMJIg0nVJm+OYxLAsPiagTxBs+HigiY5BgC+1Bfdm3H2VA2sbI8
         mLjIT9IEAuoa0xlstNhiCnx+TEaVlt05DlyPjHTNxIXHE1fJvGMqvXdLkFLJEIhKXOHA
         rNyvPlDzOVsr8l8uy3ZrXAcJQNerj9eRBAInJ7WKvV1b2lFZFUPTdBvFVHiyxUQzaFpH
         ZINo6IBHHhzeruQlF6de88II7FziMUpPQTrl3xnOaBbf1Tplz4J3h4Fm0kJ8H2KIM9Dy
         GIiH6/aA5Xl0Yxzy47t6JKsAu2S6R/0qtKnoeBcREcny2sqGXRIHLO4nIBHlDnuoy8Cn
         WE2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Wed, 14 Feb 2018 16:31:14 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-e48657573481a5dff7cfdc3d57005c80aa816500@git.kernel.org>
Cc: dan.j.williams@intel.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        luto@kernel.org, dwmw2@infradead.org, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        hpa@zytor.com, peterz@infradead.org, arjan@linux.intel.com
Reply-To: peterz@infradead.org, arjan@linux.intel.com, hpa@zytor.com,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        mingo@kernel.org, tglx@linutronix.de, jpoimboe@redhat.com,
        dave.hansen@linux.intel.com, luto@kernel.org, dwmw2@infradead.org,
        bp@alien8.de, linux-kernel@vger.kernel.org, dan.j.williams@intel.com
In-Reply-To: <20180214073910.boevmg65upbk3vqb@gmail.com>
References: <20180214073910.boevmg65upbk3vqb@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Fix CR3 restore in paranoid_exit()
Git-Commit-ID: e48657573481a5dff7cfdc3d57005c80aa816500
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
X-GMAIL-MSGID: =?utf-8?q?1592425500104085915?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  e48657573481a5dff7cfdc3d57005c80aa816500
Gitweb:     https://git.kernel.org/tip/e48657573481a5dff7cfdc3d57005c80aa816500
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 14 Feb 2018 08:39:11 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Feb 2018 01:15:54 +0100

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
