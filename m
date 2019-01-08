Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16DBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732F1218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546915198;
	bh=VT0+XNUdZwsmaGLxFPXM9zwdwnbcsTw9cqA1fMecFRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OvN0vlRbC77r7QPFP1paTCi9cSjvp1E/x68G5TPpE1R6fI0PrYl7nRpccEy7mIhAj
	 FZPpm3W2S2LCPnqQ1iWZh9ffFgawiG9srPi4koq/jsKnyKo27Dj5qwIalgL8EZs/IQ
	 MBOjIjlf2SVgiyNGg563qvgKEFU17kQ0nY0By9OM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfAHCj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 21:39:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbfAHCj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 21:39:57 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B312206A3;
        Tue,  8 Jan 2019 02:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546915196;
        bh=VT0+XNUdZwsmaGLxFPXM9zwdwnbcsTw9cqA1fMecFRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kxdHCejoo7hs1seGOIlYhPyhqOgP6q4raLbVYdBr9TZ879haspLbpoPKnS3ot4hfv
         7TgO+x/UAwi6Vq2F3Y4TLDhYDH/m0ul+YrDM06Ep/V3NSktzs53+vCQG13POcdaGHs
         tsHAuPnTwt7OXyYtuJHzuzldmRBZpoEMJbeB1WQU=
Date:   Tue, 8 Jan 2019 11:39:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: kprobes: Move extable address check into
 arch_prepare_kprobe()
Message-Id: <20190108113953.8bc0cc7d196ddba370377217@kernel.org>
In-Reply-To: <aec51c10-d744-df0f-1216-d3372e779cb1@arm.com>
References: <154502881646.30629.9938335052821665530.stgit@devbox>
        <154502884653.30629.3172839440883293817.stgit@devbox>
        <aec51c10-d744-df0f-1216-d3372e779cb1@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2019 17:05:18 +0000
James Morse <james.morse@arm.com> wrote:

> Hi!
> 
> On 17/12/2018 06:40, Masami Hiramatsu wrote:
> > Move extable address check into arch_prepare_kprobe() from
> > arch_within_kprobe_blacklist().
> 
> I'm trying to work out the pattern for what should go in the blacklist, and what
> should be rejected by the arch code.
> 
> It seems address-ranges should be blacklisted as the contents don't matter.
> easy-example: the idmap text.

Yes, more precisely, the code smaller than a function (symbol), it must be
rejected by arch_prepare_kprobe(), since blacklist is poplated based on
kallsyms.

> The arch code should also reject instructions that can't be probed from
> arch_prepare_kprobe(). easy-example: exclusive load or store.
> 
> 
> > Please do not blacklisting instructions on exception_table,
> > since it is a kind of architectural unsupported instruction.
> 
> This doesn't fit the pattern, ... what should it be?

Some kind of instructions can not be instrumented by kprobes, such instruction
level rejection must be done in arch_prepare_kprobe(), instead of blacklist.

> The instructions in the exception_table don't matter, its the address that
> indicates there is a fixup for page-faults that occur here. We don't need to
> look at the instruction to determine this, why can't we treated these as a
> blacklisted range?

Sorry for your confusion, it was my mis-describing.

As I pointed, the exception_table contains some range of code which inside
functions, must be smaller than function.
Since those instructions are expected to cause exception (that is main reason
why it can not be probed on arm64), I thought such situation was similar to
the limitation of instruction.

So I think below will be better.
----
Please do not blacklisting instructions on exception_table,
since those are smaller than one function.
----


Thank you,

> 
> 
> Thanks,
> 
> James
> 
> 
> > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > index 2a5b338b2542..b2d4b7428ebc 100644
> > --- a/arch/arm64/kernel/probes/kprobes.c
> > +++ b/arch/arm64/kernel/probes/kprobes.c
> > @@ -102,6 +102,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> >  
> >  	if (in_exception_text(probe_addr))
> >  		return -EINVAL;
> > +
> > +	if (search_exception_tables(probe_addr))
> > +		return -EINVAL;
> > +
> >  	if (probe_addr >= (unsigned long) __start_rodata &&
> >  	    probe_addr <= (unsigned long) __end_rodata)
> >  		return -EINVAL;
> > @@ -477,8 +481,7 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
> >  	    (addr >= (unsigned long)__entry_text_start &&
> >  	    addr < (unsigned long)__entry_text_end) ||
> >  	    (addr >= (unsigned long)__idmap_text_start &&
> > -	    addr < (unsigned long)__idmap_text_end) ||
> > -	    !!search_exception_tables(addr))
> > +	    addr < (unsigned long)__idmap_text_end))
> >  		return true;
> >  
> >  	if (!is_kernel_in_hyp_mode()) {
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
