Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932273AbeCIPR1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbeCIPRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:17:25 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF8320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 10 Mar 2018 00:17:22 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/kprobes: Prohibit probing of .entry_trampoline
 code
Message-Id: <20180310001722.e33a64196771d17d9f0d9b4c@kernel.org>
In-Reply-To: <1520565492-4637-2-git-send-email-francis.deslauriers@efficios.com>
References: <1520565492-4637-1-git-send-email-francis.deslauriers@efficios.com>
        <1520565492-4637-2-git-send-email-francis.deslauriers@efficios.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Mar 2018 22:18:12 -0500
Francis Deslauriers <francis.deslauriers@efficios.com> wrote:

> .entry_trampoline is a code area that is used to ensure page table
> isolation between userspace and kernelspace.
> 
> At the beginning of the execution of the trampoline, we load the
> kernel's CR3 register. This has the effect of enabling the translation
> of the kernel virtual addresses to physical addresses. Before this
> happens most kernel addresses can not be translated because the running
> process' CR3 is still used.
> 
> If a kprobe is placed on the trampoline code before that change of the
> CR3 register happens the kernel crashes because int3 handling pages are
> not accessible.
> 
> To fix this, add the .entry_trampoline section to the kprobe blacklist
> to prohibit the probing of code before all the kernel pages are
> accessible.

OK, looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Ingo, could you pick it as an urgent fix?

Thanks!

> 
> Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
> ---
>  arch/x86/include/asm/sections.h |  1 +
>  arch/x86/kernel/kprobes/core.c  | 10 +++++++++-
>  arch/x86/kernel/vmlinux.lds.S   |  2 ++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
> index d6baf23..5c019d2 100644
> --- a/arch/x86/include/asm/sections.h
> +++ b/arch/x86/include/asm/sections.h
> @@ -10,6 +10,7 @@ extern struct exception_table_entry __stop___ex_table[];
>  
>  #if defined(CONFIG_X86_64)
>  extern char __end_rodata_hpage_align[];
> +extern char __entry_trampoline_start[], __entry_trampoline_end[];
>  #endif
>  
>  #endif	/* _ASM_X86_SECTIONS_H */
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index bd36f3c..0715f82 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -1168,10 +1168,18 @@ NOKPROBE_SYMBOL(longjmp_break_handler);
>  
>  bool arch_within_kprobe_blacklist(unsigned long addr)
>  {
> +	bool is_in_entry_trampoline_section = false;
> +
> +#ifdef CONFIG_X86_64
> +	is_in_entry_trampoline_section =
> +		(addr >= (unsigned long)__entry_trampoline_start &&
> +		 addr < (unsigned long)__entry_trampoline_end);
> +#endif
>  	return  (addr >= (unsigned long)__kprobes_text_start &&
>  		 addr < (unsigned long)__kprobes_text_end) ||
>  		(addr >= (unsigned long)__entry_text_start &&
> -		 addr < (unsigned long)__entry_text_end);
> +		 addr < (unsigned long)__entry_text_end) ||
> +		is_in_entry_trampoline_section;
>  }
>  
>  int __init arch_init_kprobes(void)
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 9b138a0..b854ebf 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -118,9 +118,11 @@ SECTIONS
>  
>  #ifdef CONFIG_X86_64
>  		. = ALIGN(PAGE_SIZE);
> +		VMLINUX_SYMBOL(__entry_trampoline_start) = .;
>  		_entry_trampoline = .;
>  		*(.entry_trampoline)
>  		. = ALIGN(PAGE_SIZE);
> +		VMLINUX_SYMBOL(__entry_trampoline_end) = .;
>  		ASSERT(. - _entry_trampoline == PAGE_SIZE, "entry trampoline is too big");
>  #endif
>  
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
