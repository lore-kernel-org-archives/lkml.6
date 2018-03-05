Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934636AbeCEMZn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:25:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:34362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934287AbeCEMZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:25:41 -0500
Date: Mon, 5 Mar 2018 13:25:39 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        akpm@linux-foundation.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: linux-next: build failure after merge of the printk tree
Message-ID: <20180305122539.dakxwzxylyrv27od@pathway.suse.cz>
References: <20180302160732.12691fbc@canb.auug.org.au>
 <20180302155454.eme5gplxdcltvwkw@pathway.suse.cz>
 <20180303144739.GA516@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180303144739.GA516@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-03-03 23:47:39, Sergey Senozhatsky wrote:
> Cc-ing Tejun
> 
> On (03/02/18 16:54), Petr Mladek wrote:
> [..]
> > > (Though it is not immediately obvious why.)
> > 
> > It is a mistery to me. The error appears when I move any of
> > dump_stack_print_info() or show_regs_print_info() function
> > definitions from kernel/printk/printk.c to lib/dump_stack.c.
> > All the other changes seems unrelated.
> > 
> > The thing is that we basically do not touch dump_stack() definition
> > by that patch.
> 
> Apparently dump_stack_print_info() was in lib/dump_stack.c a long
> time ago, but it was deliberately moved to printk.c, when kernel gained
> a "generic" (dummy) dump_stack() fallback. Some archs, like blackfin,
> define their own dump_stack() symbol and make it global via EXPORT_SYMBOL.
> 
> In case of blackfin that arch-specific dump_stack() symbol invokes a
> global dump_stack_print_info(). If we move dump_stack_print_info() back
> to lib/dump_stack.c then we link both with arch/blackfin/dumpstack.o
> and lib/dump_stack.o, which results in multiple definitions error.
> If we move dump_stack_print_info() out on libdump_stack.o, then we
> never link with lib/dump_stack.o

Ah, I have finally understood the meaning of the libs-y kbuild
variable. It is a nice source of these strange build failures.


> ... so what are we going to do with that.
> 
> a) we can drop the patch and cherry pick only the kexec part
> 
> b) we can try to mark dummy lib/dump_stack() as __weak
>    EXPORT_SYMBOL and remove EXPORT_SYMBOL from arch-specific
>    definitions.

Using the weak symbol makes perfect sense. I am going to
look at the patch.

Thanks a lot everybody for help.

Best Regards,
Petr
