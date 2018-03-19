Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsTUbggAdytWjHdW83l5itnA+axOJW9TQR+rJ6haDW89bRhcmmHPGZDbnwsG+UGUzRKCNQk
ARC-Seal: i=1; a=rsa-sha256; t=1521483884; cv=none;
        d=google.com; s=arc-20160816;
        b=ik7HLrQ3FhsvsyrHH31VqyHwrxdLbwHpfCL3ZKqVeJq1Mk+ApiXQshlbDhxa2XzAlR
         JU4NfJ0XSVEko1IKWZDq7WoK0lcAOBC6EjDpaUXxvazm64RJ5OXIx41UY4Y5DaQdACIT
         KF5BzyeX5vEER4Kmaxm7f6PsJqP8vw3Oq+C/qigxi0rdgczEDhPcczuOWG/ejzJ5NaWs
         izTmAzhuOQOWE79lxcTHGI2EQt5PLfM2ZsVAroF0THlWuz9J+C+oFGPNhiKFiu2CDJ0N
         bTevjyX024wsO1i06yq/HPFUpb91KAbC1vsp/sGPcj+UI6fs4YSXA1ZXz04oCWf+5NRc
         z6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0v3HRY50vYU0PwM1UVl0Gad/3ow5H1AAghNmVno68jA=;
        b=iK7rRUM0kzINQjU/+dSeZC2MxUX8JMvUeNyXW8aHkp4DEnKN4Mn2JZIfH9FODAiHQn
         D0LBvk6HzxoyWGh99yK12rdeOOsPwRyjgSke1hHdmaFs+J7AbmP/CIX07ben+U5sq1ZM
         rs5iklnbq8YDWvk3sjMqZO5HYxij3tXLDf0byGH1NUeYxJCfBeGP9WnZs5+X2rP+3kyx
         jP1sMquJD0ZQLA0vz2nq6jDsOwqEAUHp4vquI9+nLx2QJx9eyL9eeMryCh+/cSeR+eun
         H4ricZiAuDy1HeCqXzUwQh8bL4zaWd5I8dW+emNxxsHZhGHOx/jSh80tzL6zWbZ1wWfx
         Y8VA==
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
Subject: [PATCH 4.9 153/241] kprobes/x86: Set kprobes pages read-only
Date: Mon, 19 Mar 2018 19:06:58 +0100
Message-Id: <20180319180757.511132837@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390679028073105?=
X-GMAIL-MSGID: =?utf-8?q?1595391485194248899?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -409,6 +409,8 @@ static int arch_copy_kprobe(struct kprob
 {
 	int ret;
 
+	set_memory_rw((unsigned long)p->ainsn.insn & PAGE_MASK, 1);
+
 	/* Copy an instruction with recovering if other optprobe modifies it.*/
 	ret = __copy_instruction(p->ainsn.insn, p->addr);
 	if (!ret)
@@ -423,6 +425,8 @@ static int arch_copy_kprobe(struct kprob
 	else
 		p->ainsn.boostable = -1;
 
+	set_memory_ro((unsigned long)p->ainsn.insn & PAGE_MASK, 1);
+
 	/* Check whether the instruction modifies Interrupt Flag or not */
 	p->ainsn.if_modifier = is_IF_modifier(p->ainsn.insn);
 
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -371,6 +371,7 @@ int arch_prepare_optimized_kprobe(struct
 	}
 
 	buf = (u8 *)op->optinsn.insn;
+	set_memory_rw((unsigned long)buf & PAGE_MASK, 1);
 
 	/* Copy instructions into the out-of-line buffer */
 	ret = copy_optimized_instructions(buf + TMPL_END_IDX, op->kp.addr);
@@ -393,6 +394,8 @@ int arch_prepare_optimized_kprobe(struct
 	synthesize_reljump(buf + TMPL_END_IDX + op->optinsn.size,
 			   (u8 *)op->kp.addr + op->optinsn.size);
 
+	set_memory_ro((unsigned long)buf & PAGE_MASK, 1);
+
 	flush_icache_range((unsigned long) buf,
 			   (unsigned long) buf + TMPL_END_IDX +
 			   op->optinsn.size + RELATIVEJUMP_SIZE);
