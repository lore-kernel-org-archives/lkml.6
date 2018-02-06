Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeBFNzR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:55:17 -0500
Received: from foss.arm.com ([217.140.101.70]:37536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeBFNzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 08:55:09 -0500
Date: Tue, 6 Feb 2018 13:55:12 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20180206135512.GB22740@arm.com>
References: <20180206114048.6c8ced1c@canb.auug.org.au>
 <750091485.16756.1517921554396.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <750091485.16756.1517921554396.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 12:52:34PM +0000, Mathieu Desnoyers wrote:
> ----- On Feb 5, 2018, at 7:40 PM, Stephen Rothwell sfr@canb.auug.org.au wrote:
> 
> > Hi all,
> > 
> > Today's linux-next merge of the tip tree got a conflict in:
> > 
> >  arch/arm64/kernel/entry.S
> > 
> > between commit:
> > 
> >  4bf3286d29f3 ("arm64: entry: Hook up entry trampoline to exception vectors")
> > 
> > from Linus' tree and commit:
> > 
> >  f1e3a12b6543 ("membarrier/arm64: Provide core serializing command")
> > 
> > from the tip tree.
> > 
> > I fixed it up (probably not completely - see below) and can carry the
> > fix as necessary. This is now fixed as far as linux-next is concerned,
> > but any non trivial conflicts should be mentioned to your upstream
> > maintainer when your tree is submitted for merging.  You may also want
> > to consider cooperating with the maintainer of the conflicting tree to
> > minimise any particularly complex conflicts.
> 
> The change introduced by 4bf3286d29 "arm64: entry: Hook up entry trampoline
> to exception vectors" adds a trampoline as mechanism for return:
> 
> -       eret                                    // return to kernel
> +
> +#ifndef CONFIG_UNMAP_KERNEL_AT_EL0
> +       eret
> +#else
> +       .if     \el == 0
> +       bne     4f
> +       msr     far_el1, x30
> +       tramp_alias     x30, tramp_exit_native
> +       br      x30
> +4:
> +       tramp_alias     x30, tramp_exit_compat
> +       br      x30
> +       .else
> +       eret
> +       .endif
> +#endif
> 
> Which means that with CONFIG_UNMAP_KERNEL_AT_EL0, for return to EL0,
> the eret is in the trampoline:
> 
>         .macro tramp_exit, regsize = 64
>         adr     x30, tramp_vectors
>         msr     vbar_el1, x30
>         tramp_unmap_kernel      x30
>         .if     \regsize == 64
>         mrs     x30, far_el1
>         .endif
>         eret
>         .endm
> 
> ENTRY(tramp_exit_native)
>         tramp_exit
> END(tramp_exit_native)
> 
> ENTRY(tramp_exit_compat)
>         tramp_exit      32
> END(tramp_exit_compat)
> 
> 
> One approach I would consider for this is to duplicate this
> comment and add it just above the "eret" instruction within the
> macro:
> 
> 	/*
> 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on eret context synchronization
> 	 * when returning from IPI handler, and when returning to user-space.
> 	 */
> 
> Or perhaps Will has something else in mind ?

To be honest with you, I'd just drop the comment entirely. entry.S is
terrifying these days and nobody should have to go in there to understand
why we select ARCH_HAS_MEMBARRIER_SYNC_CORE. If you really feel a justification
is needed, I'd be happy with a line in the Kconfig file.

Will
