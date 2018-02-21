Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225BIvZTNKlgb+dR8PQi8KkLjQw/wrEn49w7XEYiyaMInXcWD3PKxj1fK/vVF314tA4ywYtN
ARC-Seal: i=1; a=rsa-sha256; t=1519218116; cv=none;
        d=google.com; s=arc-20160816;
        b=Z5hPEWpitnq3cbsBx6AokdtvYZSIgplhaOXyz/fSum4HRrD+5nc5IHQfiBOQFRSQO2
         BldSRE4UvOzMEAQQH9XAH9yX+3ni9DMatNj1PBgb9jU1GxXtS2CWZTAlyBk3yIqM3QRd
         JfQya7J/L4RdceCgz1MB9zYGAAEweTySzE+un1KhCF7u3nTtAmE8LI00Z/PYa4zTHY6Y
         Rs46Xu/WS6wjeITMhl8x4fVxPGEZsFE2VNjL1A0x7bmJlhv7oakb18pSt5qrZ0WInVP3
         5YWQ27q2lueNrAc/MdOdjuLz07utEt3XEnMqkXGU9xEsT14mponpau3VDz5eSrTOK2Tx
         BSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+sI1mszy5Z4/U5HMD/8xuYl92e5wdmnA5znlQRHP/1I=;
        b=m5W1Dzu1Inov1+CK2YzzcdkqbWaX6ienhFTCcZqXTchClWWNKN/CBAW1/a/UM7/vvd
         zDNUto3rvp9dmnvrLWM52fTBNp5OHDkBxY5n3pSkLfL58KnhYkxbIXMVUi8gVsrlPESj
         Ha87+YLFEF9iYvIXtYncs+7FE3VWOiTrH/bNmQPQjt9I8zPVMylp+BpJynC3WZovtTEB
         R14YxzrJSWnAEikc8YNiZ9huiZFe5b2inNSsiAGu0jI7dWacn4lAu7okz8/ZwKx2sXW8
         6LFnWFvzMVAuXtIUbRNaSiYE9DGUJbQ3EiwAyImC8faOQq7WD6SAB0WGSL8/hclDbHQt
         IQhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 089/167] x86/entry/64: Fix CR3 restore in paranoid_exit()
Date: Wed, 21 Feb 2018 13:48:20 +0100
Message-Id: <20180221124529.258044214@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015655835796589?=
X-GMAIL-MSGID: =?utf-8?q?1593015655835796589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ingo Molnar <mingo@kernel.org>

commit e48657573481a5dff7cfdc3d57005c80aa816500 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/entry_64.S |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1162,6 +1162,7 @@ ENTRY(paranoid_exit)
 	jmp	.Lparanoid_exit_restore
 .Lparanoid_exit_no_swapgs:
 	TRACE_IRQS_IRETQ_DEBUG
+	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 .Lparanoid_exit_restore:
 	jmp restore_regs_and_return_to_kernel
 END(paranoid_exit)
