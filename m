Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELspVXGe1t3+kEixKC15vTa9Wi28+URdQKZ1+AoLnYBf0PxlPXdQ8LYuVdehU9mej0XsnWHd
ARC-Seal: i=1; a=rsa-sha256; t=1521483401; cv=none;
        d=google.com; s=arc-20160816;
        b=NmUdkRZTrvG7Xy3bvEtXsUIQgEk2xsZG7KizvQLxN/4wKLMUDV6tE7Rg8RsG5BqO5I
         P53IT4GSPxvcdS5CIoyebHwGrQYTelnl/Zd5uCyzl5bRzV8iB4rfsb0gaSPTs9EJ+65z
         yUhI9KF8a+zmQe+4UeSDGQaYRpvC1ckGw1OsNSyf9lCwNw47YTyofxXdh4Rl/ISq9kv4
         +lJe15FR5iO0xhunk2qiuyd+TvsQLs1uykLk2dH2XeWD+aej3E2uU22VXrYp+Y4FFJsD
         B2AeyIaVTwHY8v7gMaOkb1jbe6sRUPI4FxBd4h7jAGPFwh/sfuFydbRp6UhtCsK0hK0H
         VMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NB1RTFjIlQ8wmbh3lBvu0FufAsUiwKcYTVkEIU8Oj4w=;
        b=aDTDGB2D6MFokP14qUspNAj6cT0PMp/QUmKlJmRpzYlvLCxTCjpRV8BX43sK/8JCAF
         6VSiOrxBFUbMNEQ6akVIbQ+NpXU+1S73sMtZDRLKF7AZfRbS6GdzuLS59SuPV/o3xWFc
         pUeTJtJdlyijGS0s/9cvIvtwNl4TpKnsfpib0hwrRLv9qDLSkbukUakYUCJpMbdXdb4R
         YGAroml1gkWEdbaSWGNl55V0w0Lk0os8skeKuU74WN9InAcmDmd7FUe7jaKoqHg440JE
         VtECpr9+mfb0Fs3vUVNckUdefrgMzEAOlvdEuluGNGT5W9rpY9uG6jruGIVHtQuNaOBX
         u79w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ye Xiaolong <xiaolong.ye@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 076/134] kprobes/x86: Set kprobes pages read-only
Date: Mon, 19 Mar 2018 19:05:59 +0100
Message-Id: <20180319171900.247219741@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390679028073105?=
X-GMAIL-MSGID: =?utf-8?q?1595390978928845552?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>


[ Upstream commit d0381c81c2f782fa2131178d11e0cfb23d50d631 ]

Set the pages which is used for kprobes' singlestep buffer
and optprobe's trampoline instruction buffer to readonly.
This can prevent unexpected (or unintended) instruction
modification.

This also passes rodata_test as below.

Without this patch, rodata_test shows a warning:

  WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:235 note_page+0x7a9/0xa20
  x86/mm: Found insecure W+X mapping at address ffffffffa0000000/0xffffffffa0000000

With this fix, no W+X pages are found:

  x86/mm: Checked W+X mappings: passed, no W+X pages found.
  rodata_test: all tests were successful

Reported-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ye Xiaolong <xiaolong.ye@intel.com>
Link: http://lkml.kernel.org/r/149076375592.22469.14174394514338612247.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/kprobes/core.c |    4 ++++
 arch/x86/kernel/kprobes/opt.c  |    3 +++
 2 files changed, 7 insertions(+)

--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -406,6 +406,8 @@ static int arch_copy_kprobe(struct kprob
 {
 	int ret;
 
+	set_memory_rw((unsigned long)p->ainsn.insn & PAGE_MASK, 1);
+
 	/* Copy an instruction with recovering if other optprobe modifies it.*/
 	ret = __copy_instruction(p->ainsn.insn, p->addr);
 	if (!ret)
@@ -420,6 +422,8 @@ static int arch_copy_kprobe(struct kprob
 	else
 		p->ainsn.boostable = -1;
 
+	set_memory_ro((unsigned long)p->ainsn.insn & PAGE_MASK, 1);
+
 	/* Check whether the instruction modifies Interrupt Flag or not */
 	p->ainsn.if_modifier = is_IF_modifier(p->ainsn.insn);
 
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -370,6 +370,7 @@ int arch_prepare_optimized_kprobe(struct
 	}
 
 	buf = (u8 *)op->optinsn.insn;
+	set_memory_rw((unsigned long)buf & PAGE_MASK, 1);
 
 	/* Copy instructions into the out-of-line buffer */
 	ret = copy_optimized_instructions(buf + TMPL_END_IDX, op->kp.addr);
@@ -392,6 +393,8 @@ int arch_prepare_optimized_kprobe(struct
 	synthesize_reljump(buf + TMPL_END_IDX + op->optinsn.size,
 			   (u8 *)op->kp.addr + op->optinsn.size);
 
+	set_memory_ro((unsigned long)buf & PAGE_MASK, 1);
+
 	flush_icache_range((unsigned long) buf,
 			   (unsigned long) buf + TMPL_END_IDX +
 			   op->optinsn.size + RELATIVEJUMP_SIZE);
