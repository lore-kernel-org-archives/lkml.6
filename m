Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EC4C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA022175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfBFPF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:05:26 -0500
Received: from verein.lst.de ([213.95.11.211]:60151 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfBFPF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:05:26 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id B3CA168D93; Wed,  6 Feb 2019 16:05:24 +0100 (CET)
Date:   Wed, 6 Feb 2019 16:05:24 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
Message-ID: <20190206150524.GA28892@lst.de>
References: <20190118163736.6A99268CEB@newverein.lst.de> <20190118163908.E338E68D93@newverein.lst.de> <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 08:59:44AM +0000, Julien Thierry wrote:
> Hi Torsten,
> 
> On 18/01/2019 16:39, Torsten Duwe wrote:
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

Now that you mention it - yes indeed that's the correct facility to fix
the deviating address, as Steve has also confirmed. I had totally forgotten
about this hook.

> Also, I'm unsure whether it would be safe, but we could patch the "mov
> x9, lr" there as well. In theory, this would be called at init time
> (before secondary CPUs are brought up) and when loading a module (so I'd
> expect no-one is executing that code *yet*.
> 
> If this is possible, I think it would make things a bit cleaner.

This is in fact very tempting, but it will introduce a nasty side effect
to ftrace_call_adjust. Is there any obvious documentation that specifies
guarantees about ftrace_call_adjust being called exactly once for each site?

	Torsten

