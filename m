Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2256XgZDQ2Jy2GDqXAV7iNSk2GdR8/e+KdYynaJ1EqIVHwQ5E00YF260tNDqsTvsyyi1dBDw
ARC-Seal: i=1; a=rsa-sha256; t=1519218512; cv=none;
        d=google.com; s=arc-20160816;
        b=mwuEz9wSVzY36jWPr5I+UqQtSBHEIuFZwdSfqZMGoZuDmKvdVsuzP72trmwK+4YYnS
         57KLU46ug1dPLxy+VbqaA/3ewcq9KtDAOen6/XUf/2jpryhZSS6j48FuJHek3V8iuoTO
         S+E0ZSPZkIsHjIisiuPQO9LWIRDyp+wBOzdoN5PU5oEkg5NRljgqT7771wExxyQOPqn7
         XEgpFVo7igAgcdVJUJDjQwlvxDD+IX834BEMZKCfXFSH9fF/BZOvXmoBW2LJRKUKQQa+
         SPvDMIVpZfOkOFQJwyNkg7BSFVRiFebshzHpNzE7we2IakVksX9dwhAEwcIWEVkSYVPW
         cjUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cMrPwaMQoiirOo8EXSJB3UC4yBjcZ5oF2sqPJ9VkKAY=;
        b=JkF/mlFsbLSrInjBPL4D3yOvUESQXKVsIrhcyKtkndpDpyTHoS9ECxAqYQz5/TzHwt
         pRiNQhjvE8NWx/4qmG4Dlb5WP1RtTcnhRvYjBaokSPorMQb1b1vKzYgs857Yg7iEYZgt
         CO95+TzNbRhNlji9yOzmdRuLy2ALl9j210/Spi7ijW38vtBOs781RBX/U6/y6Dvpgv1p
         WuUcuITGSFE5FRBi0bJS5I8dwLzuQPmXcZRJ7BMHU0BCtHMhU3CMAxdxF3w48OnWLOVw
         8u6TyAjEtATyNGREahFUwuEvKM3kIyC1in6ettpfV9l5Kswwp4Mr9rmuf14BVntwe4BA
         11tA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	kbuild test robot <fengguang.wu@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kbuild-all@01.org,
	tipbuild@zytor.com,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 066/163] x86/entry/64: Fix paranoid_entry() frame pointer warning
Date: Wed, 21 Feb 2018 13:48:15 +0100
Message-Id: <20180221124534.102951733@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015601626745893?=
X-GMAIL-MSGID: =?utf-8?q?1593016070425901395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit b3ccefaed922529e6a67de7b30af5aa38c76ace9 upstream.

With the following commit:

  f09d160992d1 ("x86/entry/64: Get rid of the ALLOC_PT_GPREGS_ON_STACK and SAVE_AND_CLEAR_REGS macros")

... one of my suggested improvements triggered a frame pointer warning:

  arch/x86/entry/entry_64.o: warning: objtool: paranoid_entry()+0x11: call without frame pointer save/setup

The warning is correct for the build-time code, but it's actually not
relevant at runtime because of paravirt patching.  The paravirt swapgs
call gets replaced with either a SWAPGS instruction or NOPs at runtime.

Go back to the previous behavior by removing the ELF function annotation
for paranoid_entry() and adding an unwind hint, which effectively
silences the warning.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kbuild-all@01.org
Cc: tipbuild@zytor.com
Fixes: f09d160992d1 ("x86/entry/64: Get rid of the ALLOC_PT_GPREGS_ON_STACK and SAVE_AND_CLEAR_REGS macros")
Link: http://lkml.kernel.org/r/20180212174503.5acbymg5z6p32snu@treble
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/entry_64.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1128,6 +1128,7 @@ idtentry machine_check		do_mce			has_err
  * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
  */
 ENTRY(paranoid_entry)
+	UNWIND_HINT_FUNC
 	cld
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
@@ -1141,7 +1142,7 @@ ENTRY(paranoid_entry)
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
 	ret
-ENDPROC(paranoid_entry)
+END(paranoid_entry)
 
 /*
  * "Paranoid" exit path from exception stack.  This is invoked
