Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933659AbeEIDCE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 23:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932115AbeEIDCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 23:02:03 -0400
Date: Tue, 8 May 2018 23:02:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Kao <alankao@andestech.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Greentime Hu <greentime@andestech.com>, Zong Li <zong@andestech.com>
Subject: Re: [PATCH] riscv/ftrace: Fix the problem modules cannot find
 _mcount
Message-ID: <20180508230200.69fbf110@vmware.local.home>
In-Reply-To: <20180509023605.GB7303@andestech.com>
References: <1525749717-384-1-git-send-email-alankao@andestech.com>
        <20180508091142.12b5231a@gandalf.local.home>
        <20180509023605.GB7303@andestech.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2018 10:36:05 +0800
Alan Kao <alankao@andestech.com> wrote:

> This EXPORT_SYMBOL and the _mcount body was inside a
> "#ifndef CONFIG_DYNAMIC_FTRACE" section, so if the config has dynamic ftrace
> disabled, _mcount is visible.
> 
> For the dynamic ftrace case, there is a code snippet in this file:
> 
> > ENTRY(ftrace_stub)
> > #ifdef CONFIG_DYNAMIC_FTRACE         
> >       .global _mcount
> >       .set    _mcount, ftrace_stub
> > #endif
> >        ret 
> > ENDPROC(ftrace_stub)  

I missed that, thanks.

> 
> Talking about some bigger issues here, there will be twofold.
> 
> 1. This patch lacks call-site collecting mechanism.
> 
> This feature requires a pattern check in recordmcount.pl.  With this,
> section __mcount_loc is properly constructed, and the call-sites will be
> registered during the loading stage.
> 
> However, the loading will then fail at the first try of make_nop, due to
> the instruction check.  This is thus the second issue.
> 
> 
> 2. The instruction check for kernel texts is not applicable to module texts.
> 
> The check expects a call instruction to _mcount, but here it is a call to
> the .plt section of the module.  After referencing the implementation of arm64,
> I think it would need much more work to have make_nop's and make_call's behavior
> right.

And powerpc64 I believe does something similar (which I think arm64
based it's work from).

> 
> 
> Quick summary: This patch ensures that a kernel build will not fail because of
> the _mcount-missing problem.  But ftrace cannot trace loading modules for now
> due to the stated reasons.

Probably why they had modules break to begin with ;-)

-- Steve
