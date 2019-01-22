Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393B3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F0020879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfAVNKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:10:01 -0500
Received: from verein.lst.de ([213.95.11.211]:36361 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbfAVNKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:10:00 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 051806FA7F; Tue, 22 Jan 2019 14:09:59 +0100 (CET)
Date:   Tue, 22 Jan 2019 14:09:58 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     "Singh, Balbir" <bsingharora@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
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
Message-ID: <20190122130958.GA16778@lst.de>
References: <20190118163736.6A99268CEB@newverein.lst.de> <20190118163908.E338E68D93@newverein.lst.de> <b4081483-e5d6-2e7b-3540-6f3c3622fa24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4081483-e5d6-2e7b-3540-6f3c3622fa24@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir!

On Tue, Jan 22, 2019 at 02:39:32PM +1300, Singh, Balbir wrote:
> 
> On 1/19/19 5:39 AM, Torsten Duwe wrote:
> > + */
> > +ftrace_common_return:
> > +	/* restore function args */
> > +	ldp	x0, x1, [sp]
> > +	ldp	x2, x3, [sp, #S_X2]
> > +	ldp	x4, x5, [sp, #S_X4]
> > +	ldp	x6, x7, [sp, #S_X6]
> > +	ldr	x8, [sp, #S_X8]
> > +
> > +	/* restore fp and x28 */
> > +	ldp	x28, x29, [sp, #S_X28]
> > +
> > +	ldr	lr, [sp, #S_LR]
> > +	ldr	x9, [sp, #S_PC]
> 
> Is it fair to assume that we never modify registers beyond LR and PC as a result of ftrace/livepatching? I presume it is, but just checking.

These are either callee-save or scratch. Whatever is called, ftrace framework
functions or replacement functions, must preserve the callee-saved regs; and
the caller, who made a function call (sic!-) saves caller-saved and marks the
rest dead on return. So it's the arguments that matter after all.

As you can see, disabling IPA-RA is cruicial here.

Or are you talking about deliberate argument manipulation?

> > +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
> > +	u32 old, new;
> > +
> > +	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
> > +	new = aarch64_insn_gen_branch_imm(pc, addr, true);
> > +
> 
> Is this a branch or a call? Does addr always fit in the immediate limits?

As Julien has now pointed out, the correct enum value AARCH64_INSN_BRANCH_LINK
should clarify this. It will surely fit for the kernel proper, and the modules
are handled with the trampolines.

> > +	return ftrace_modify_code(pc, old, new, true);
> 
> Can you talk to the semantics of whether this operation is atomic w.r.t system? Will old and new return consistent values? Given the nature of ftrace, I presume it's well isolated. 

aarch64_insn_patch_text_nosync() does a __flush_icache_range() on success.
Mark wrote that this is already sufficient IIRC. (I had memory barriers
there, when I was still trying to modify 2 insns every time).

> 
> > +	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS) &&
> > +		addr == MCOUNT_ADDR) {
> > +		old = aarch64_insn_gen_nop();
> > +		new = MOV_X9_X30;
> > +		pc -= REC_IP_BRANCH_OFFSET;
> > +		return ftrace_modify_code(pc, old, new, validate);
> 
> I presume all the icache flush and barrier handling is in ftrace_modify_code()?

Yes, see above.

> > +	}
> > +
> >  	if (offset < -SZ_128M || offset >= SZ_128M) {
> >  #ifdef CONFIG_ARM64_MODULE_PLTS
> >  		u32 replaced;
> > --- a/arch/arm64/include/asm/module.h
> > +++ b/arch/arm64/include/asm/module.h
> > @@ -32,7 +32,8 @@ struct mod_arch_specific {
> >  	struct mod_plt_sec	init;
> >  
> >  	/* for CONFIG_DYNAMIC_FTRACE */
> > -	struct plt_entry 	*ftrace_trampoline;
> > +	struct plt_entry	*ftrace_trampolines;
> > +#define MOD_ARCH_NR_FTRACE_TRAMPOLINES	2
> 
> I don't see the generation of ftrace_trampolines[1]
> 

That was further up, install_ftrace_trampoline() in kernel/ftrace.c.

+       if (*addr == FTRACE_ADDR)
+               mod_trampoline = &mod->arch.ftrace_trampolines[0];
+       else if (*addr == FTRACE_REGS_ADDR)
+               mod_trampoline = &mod->arch.ftrace_trampolines[1];
[...]
+       trampoline = get_plt_entry(*addr, mod_trampoline);
+
+       if (!plt_entries_equal(mod_trampoline, &trampoline)) {
[...]

get_plt_entry() generates a small bunch of instructions that easily
fit into the argument registers. Compare commit bdb85cd1d20669dfae8
for the new trampoline insns.

Hope I've covered all your concerns,

	Torsten

