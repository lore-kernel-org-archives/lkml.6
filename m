Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933643AbeEICgu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 22:36:50 -0400
Received: from exmail.andestech.com ([59.124.169.137]:29487 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbeEICgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 22:36:49 -0400
Date: Wed, 9 May 2018 10:36:05 +0800
From: Alan Kao <alankao@andestech.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Greentime Hu <greentime@andestech.com>, Zong Li <zong@andestech.com>
Subject: Re: [PATCH] riscv/ftrace: Fix the problem modules cannot find _mcount
Message-ID: <20180509023605.GB7303@andestech.com>
References: <1525749717-384-1-git-send-email-alankao@andestech.com>
 <20180508091142.12b5231a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180508091142.12b5231a@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w492S5kQ096948
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 09:11:42AM -0400, Steven Rostedt wrote:
> On Tue, 8 May 2018 11:21:57 +0800
> Alan Kao <alankao@andestech.com> wrote:
> 
> > Enabling ftrace and module support at the same time fails the kernel
> > build process, because modules cannot find the _mcount symbol.  This
> > patch fixes this issue.
> 
> I think you have a much bigger issue.
>

Yes, we do, but not this one.  Let me state more detail later.
 
> > 
> > Signed-off-by: Alan Kao <alankao@andestech.com>
> > Cc: Greentime Hu <greentime@andestech.com>
> > Cc: Zong Li <zong@andestech.com>
> > ---
> >  arch/riscv/kernel/mcount.S | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
> > index ce9bdc57a2a1..5721624886a1 100644
> > --- a/arch/riscv/kernel/mcount.S
> > +++ b/arch/riscv/kernel/mcount.S
> > @@ -126,5 +126,5 @@ do_trace:
> >  	RESTORE_ABI_STATE
> >  	ret
> >  ENDPROC(_mcount)
> > -EXPORT_SYMBOL(_mcount)
> >  #endif
> > +EXPORT_SYMBOL(_mcount)
> 
> How does this work? How do you export _mcount if _mcount isn't even
> defined?

_mcount is defined.

This EXPORT_SYMBOL and the _mcount body was inside a
"#ifndef CONFIG_DYNAMIC_FTRACE" section, so if the config has dynamic ftrace
disabled, _mcount is visible.

For the dynamic ftrace case, there is a code snippet in this file:

> ENTRY(ftrace_stub)
> #ifdef CONFIG_DYNAMIC_FTRACE         
>       .global _mcount
>       .set    _mcount, ftrace_stub
> #endif
>        ret 
> ENDPROC(ftrace_stub)

so the _mcount symbol is visible in the kernel, but not for modules.
As a result, a module build always fails, because _mcount is neither exported,
nor aliased to a defined symbol.

That's the simple purpose of this patch:  we just want to eliminate the errors
during the kernel build process.

> 
> -- Steve

Talking about some bigger issues here, there will be twofold.

1. This patch lacks call-site collecting mechanism.

This feature requires a pattern check in recordmcount.pl.  With this,
section __mcount_loc is properly constructed, and the call-sites will be
registered during the loading stage.

However, the loading will then fail at the first try of make_nop, due to
the instruction check.  This is thus the second issue.


2. The instruction check for kernel texts is not applicable to module texts.

The check expects a call instruction to _mcount, but here it is a call to
the .plt section of the module.  After referencing the implementation of arm64,
I think it would need much more work to have make_nop's and make_call's behavior
right.


Quick summary: This patch ensures that a kernel build will not fail because of
the _mcount-missing problem.  But ftrace cannot trace loading modules for now
due to the stated reasons.

Thanks,
Alan Kao
