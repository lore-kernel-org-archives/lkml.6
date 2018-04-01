Return-Path: <ben.hutchings@codethink.co.uk>
X-Google-Smtp-Source: AIpwx49LSWPGeHwzkj718MMvOUEi45+Fe7l5Tby4OLocAFf1b9lZMe6Llbpk+LQFVDqYAkS5/2XJ
ARC-Seal: i=1; a=rsa-sha256; t=1522599635; cv=none;
        d=google.com; s=arc-20160816;
        b=FfqtpK7B9cuF4Fv21hLl35l31Mn7GaWBxdGwlGGWYxaPP8rjf7DAaggeJ/0U9evZzp
         FdtKKlbdm8ffcaw2rrnYm/tQfaVfjW+fKjmtG5cOCKgfR9pKKzvnlztjLbSEnmbXinZt
         if3/QabOOWaEdPJNNOJnfr9hTnwrZEMs5IGBFh2x7/5VIZ6O8XhDQxVYNr9K1t0hVMpX
         eBQ/F0TayOZuIf5Lz51bei1CJjgbw3ReKHGzJ/wUaYOgtfcyMEln9ipAnhKx+2Hoowbd
         d9wFNt2jsrxwz2KD8/jB1Jxzd2WQZsMdZ+WLpQvXg7brzM/LT0AD8H2xHBf7gU4jrkKS
         2B/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=7/oXmh5YrfJuwSbFG6E2ucmQy4qCaogdk4oMry2zHzE=;
        b=0ss4DXqqJMu28XP+OuMmHMV2QedDQ2hhFXEGN85tp+jpEPkCQ9Mw2FYzCU59k//LCb
         xyB8BLije93UgxHVdMpG2C9ZK9zSoFJ4YWMSO8C/5SqZqu0h1dPAcDP5C73ImYwe0j1M
         fqhYHUczHuhKNhaJ8sxTqUtgxJP9zuTDyyCrhm9iOJlMI/sfQFaLnAoefaf4Euqj/aJk
         Q0FIeLz0mXdk7IGyzVqVFlFVHUja/qNdXdzfoYjdiyVNejEuhqUxfKapdLnO7bqtHzie
         vbQp5CRVxLUfyuvHp7kQb48epKlPvSo4nZbwZCXlDJOABWV9MMJNK1AZtkh3oQrOFWmc
         YlGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Message-ID: <1522599630.2654.59.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 076/134] kprobes/x86: Set kprobes pages read-only
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, Borislav Petkov <bp@alien8.de>, Brian
 Gerst <brgerst@gmail.com>,  "David S . Miller" <davem@davemloft.net>, Denys
 Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Josh
 Poimboeuf <jpoimboe@redhat.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ye Xiaolong <xiaolong.ye@intel.com>,
 Ingo Molnar <mingo@kernel.org>, Sasha Levin <alexander.levin@microsoft.com>
Date: Sun, 01 Apr 2018 17:20:30 +0100
In-Reply-To: <20180319171900.247219741@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
	 <20180319171900.247219741@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595390679028073105?=
X-GMAIL-MSGID: =?utf-8?q?1596561435146596398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-19 at 19:05 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> 
> [ Upstream commit d0381c81c2f782fa2131178d11e0cfb23d50d631 ]

This caused a regression in mainline, fixed by:

commit c93f5cf571e7795f97d49ef51b766cf25e328545
Author: Masami Hiramatsu <mhiramat@kernel.org>
Date:   Thu May 25 19:38:17 2017 +0900

    kprobes/x86: Fix to set RWX bits correctly before releasing trampoline

Ben.

> Set the pages which is used for kprobes' singlestep buffer
> and optprobe's trampoline instruction buffer to readonly.
> This can prevent unexpected (or unintended) instruction
> modification.
> 
> This also passes rodata_test as below.
> 
> Without this patch, rodata_test shows a warning:
> 
>   WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:235 note_page+0x7a9/0xa20
>   x86/mm: Found insecure W+X mapping at address ffffffffa0000000/0xffffffffa0000000
> 
> With this fix, no W+X pages are found:
> 
>   x86/mm: Checked W+X mappings: passed, no W+X pages found.
>   rodata_test: all tests were successful
> 
> Reported-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: David S . Miller <davem@davemloft.net>
> Cc: Denys Vlasenko <dvlasenk@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ye Xiaolong <xiaolong.ye@intel.com>
> Link: http://lkml.kernel.org/r/149076375592.22469.14174394514338612247.stgit@devbox
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/x86/kernel/kprobes/core.c |    4 ++++
>  arch/x86/kernel/kprobes/opt.c  |    3 +++
>  2 files changed, 7 insertions(+)
> 
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -406,6 +406,8 @@ static int arch_copy_kprobe(struct kprob
>  {
>  	int ret;
>  
> +	set_memory_rw((unsigned long)p->ainsn.insn & PAGE_MASK, 1);
> +
>  	/* Copy an instruction with recovering if other optprobe modifies it.*/
>  	ret = __copy_instruction(p->ainsn.insn, p->addr);
>  	if (!ret)
> @@ -420,6 +422,8 @@ static int arch_copy_kprobe(struct kprob
>  	else
>  		p->ainsn.boostable = -1;
>  
> +	set_memory_ro((unsigned long)p->ainsn.insn & PAGE_MASK, 1);
> +
>  	/* Check whether the instruction modifies Interrupt Flag or not */
>  	p->ainsn.if_modifier = is_IF_modifier(p->ainsn.insn);
>  
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -370,6 +370,7 @@ int arch_prepare_optimized_kprobe(struct
>  	}
>  
>  	buf = (u8 *)op->optinsn.insn;
> +	set_memory_rw((unsigned long)buf & PAGE_MASK, 1);
>  
>  	/* Copy instructions into the out-of-line buffer */
>  	ret = copy_optimized_instructions(buf + TMPL_END_IDX, op->kp.addr);
> @@ -392,6 +393,8 @@ int arch_prepare_optimized_kprobe(struct
>  	synthesize_reljump(buf + TMPL_END_IDX + op->optinsn.size,
>  			   (u8 *)op->kp.addr + op->optinsn.size);
>  
> +	set_memory_ro((unsigned long)buf & PAGE_MASK, 1);
> +
>  	flush_icache_range((unsigned long) buf,
>  			   (unsigned long) buf + TMPL_END_IDX +
>  			   op->optinsn.size + RELATIVEJUMP_SIZE);

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
