Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeCOSXD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:23:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750987AbeCOSXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:23:03 -0400
Date: Thu, 15 Mar 2018 13:23:01 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] x86/dumpstack: Improve opcodes dumping in the Code:
 section
Message-ID: <20180315182301.uhuame6qdfs5jdlb@treble>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-5-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315154448.16222-5-bp@alien8.de>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 04:44:43PM +0100, Borislav Petkov wrote:
> @@ -402,6 +396,10 @@ void show_regs(struct pt_regs *regs)
>  	 */
>  	if (!user_mode(regs)) {
>  		show_trace_log_lvl(current, regs, NULL, KERN_DEFAULT);
> -		show_opcodes((u8 *)regs->ip);
> +
> +		if (regs->ip < PAGE_OFFSET)
> +			pr_cont(" Bad RIP value.\n");
> +		else
> +			show_opcodes((u8 *)regs->ip);

[ Oops, sorry about three reviews for the same patch... ]

I don't see the printk preceding the pr_cont() here.  Shouldn't it be
something like:

			printk(KERN_DEFAULT "Code: Bad RIP value.\n")

?

-- 
Josh
