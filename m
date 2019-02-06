Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87FBC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFEC2186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfBFOJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:09:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbfBFOJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:09:11 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28B7D20844;
        Wed,  6 Feb 2019 14:09:09 +0000 (UTC)
Date:   Wed, 6 Feb 2019 09:09:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Torsten Duwe <duwe@lst.de>, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
Message-ID: <20190206090907.311259df@gandalf.local.home>
In-Reply-To: <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
References: <20190118163736.6A99268CEB@newverein.lst.de>
        <20190118163908.E338E68D93@newverein.lst.de>
        <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 08:59:44 +0000
Julien Thierry <julien.thierry@arm.com> wrote:

> Hi Torsten,
> 
> On 18/01/2019 16:39, Torsten Duwe wrote:
> > Once gcc8 adds 2 NOPs at the beginning of each function, replace the
> > first NOP thus generated with a quick LR saver (move it to scratch reg
> > x9), so the 2nd replacement insn, the call to ftrace, does not clobber
> > the value. Ftrace will then generate the standard stack frames.
> > 
> > Note that patchable-function-entry in GCC disables IPA-RA, which means
> > ABI register calling conventions are obeyed *and* scratch registers
> > such as x9 are available.
> > 
> > Introduce and handle an ftrace_regs_trampoline for module PLTs, right
> > after ftrace_trampoline, and double the size of this special section.
> > 
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > 
> > ---
> > 
> > Mark, if you see your ftrace entry macro code being represented correctly
> > here, please add your sign-off, As I've initially copied it from your mail.
> > 
> > ---
> >  arch/arm64/include/asm/ftrace.h  |   17 ++++-
> >  arch/arm64/include/asm/module.h  |    3 
> >  arch/arm64/kernel/entry-ftrace.S |  125 +++++++++++++++++++++++++++++++++++++--
> >  arch/arm64/kernel/ftrace.c       |  114 ++++++++++++++++++++++++++---------
> >  arch/arm64/kernel/module-plts.c  |    3 
> >  arch/arm64/kernel/module.c       |    2 
> >  6 files changed, 227 insertions(+), 37 deletions(-)  
> 
> [...]
> 
> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -133,17 +163,45 @@ int ftrace_make_call(struct dyn_ftrace *
> >  	return ftrace_modify_code(pc, old, new, true);
> >  }
> >  
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
> > +			unsigned long addr)
> > +{
> > +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
> > +	u32 old, new;
> > +
> > +	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
> > +	new = aarch64_insn_gen_branch_imm(pc, addr, true);
> > +
> > +	return ftrace_modify_code(pc, old, new, true);
> > +}
> > +#endif
> > +
> >  /*
> >   * Turn off the call to ftrace_caller() in instrumented function
> >   */
> >  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> >  		    unsigned long addr)
> >  {
> > -	unsigned long pc = rec->ip;
> > +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;  
> 
> Sorry to come back on this patch again, but I was looking at the ftrace
> code a bit, and I see that when processing the ftrace call locations,
> ftrace calls ftrace_call_adjust() on every ip registered as mcount
> caller (or in our case patchable entries). This ftrace_call_adjust() is
> arch specific, so I was thinking we could place the offset in here once
> and for all so we don't have to worry about it in the future.

The ftrace_call_adjust() is there in case what is saved in the mcount
table is different than what is needed for the addresses. Which this
looks to be the case here.

-- Steve

