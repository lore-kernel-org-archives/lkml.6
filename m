Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932635AbeCOTBf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:01:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932617AbeCOTBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:01:33 -0400
Date: Thu, 15 Mar 2018 14:01:32 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86/dumpstack: Save first regs set for the executive
 summary
Message-ID: <20180315190132.2d653yu7ezf2zplh@treble>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-9-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315154448.16222-9-bp@alien8.de>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 04:44:47PM +0100, Borislav Petkov wrote:
> @@ -321,6 +323,9 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
>  	raw_local_irq_restore(flags);
>  	oops_exit();
>  
> +	/* Executive summary in case the oops scrolled away */
> +	__show_regs(&exec_summary_regs, false);
> +

no_context() has the following line, right before it calls oops_end():

	/* Executive summary in case the body of the oops scrolled away */
	printk(KERN_DEFAULT "CR2: %016lx\n", address);

I think that line can now be removed, since the executive summary
__show_regs() will include CR2.


> @@ -352,26 +357,14 @@ int __die(const char *str, struct pt_regs *regs, long err)
>  	       IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION) ?
>  	       (boot_cpu_has(X86_FEATURE_PTI) ? " PTI" : " NOPTI") : "");
>  
> +	show_regs(regs);
> +
>  	if (notify_die(DIE_OOPS, str, regs, err,
>  			current->thread.trap_nr, SIGSEGV) == NOTIFY_STOP)
>  		return 1;
>  
>  	print_modules();
> -	show_regs(regs);

Was moving the show_regs() call intentional?  I didn't see it mentioned
in the changelog.

> @@ -410,7 +403,5 @@ void show_regs(struct pt_regs *regs)
>  
>  		if (regs->ip < PAGE_OFFSET)
>  			pr_cont(" Bad RIP value.\n");
> -		else
> -			show_opcodes((u8 *)regs->ip, KERN_DEFAULT);
>  	}
>  }

Doesn't this hunk belong in the previous patch, which added the
__show_regs -> show_ip() -> show_opcodes() call path?

-- 
Josh
