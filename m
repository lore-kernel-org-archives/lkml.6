Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF9AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F4F20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S2aMyK/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F4F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbeKGEfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:35:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42260 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387612AbeKGEfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zR1LEdFJ0rRvzzXmQeciPhWoTcQ0OcM2NLSraw/Coug=; b=S2aMyK/JITq9RD5soC7cHq+uh2
        mS7VZXKuZDN5efoBKiEARL/rGoeCGIWnRXUkctS1TQkwfktCd0ZgJnGuh7ej5Upmg6iY/FKSQl2qk
        GTaWcCKmYiphhaalcAVq7Uhtw8uSmFR8DYHYc1JLJvKFNrWSRutKwFtRt6icyWiqreo4P9ddKzyxK
        ta473e5ue7gnCDvNTq9n9XGqSIu/XxCnu3ZJGruB0ceNrqvRGhht5LrIQStjtS9LnVOKMIJePpQ7e
        FILf+r1mkUNSYmy0xactUnIbFC9fvfLAmuxGgHh38+MzLbrjAuUFzzbIyb8WAuEBecBIbUkh9lkRq
        /GGK8E3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK6ik-0001cJ-29; Tue, 06 Nov 2018 19:09:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 989C12029F881; Tue,  6 Nov 2018 20:08:59 +0100 (CET)
Date:   Tue, 6 Nov 2018 20:08:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 6/7] x86/alternatives: use temporary mm for text poking
Message-ID: <20181106190859.GB9761@hirez.programming.kicks-ass.net>
References: <20181102232946.98461-1-namit@vmware.com>
 <20181102232946.98461-7-namit@vmware.com>
 <20181105133041.GC22467@hirez.programming.kicks-ass.net>
 <EFF64D16-26DE-437E-99B5-A870921B7D5F@vmware.com>
 <20181106082019.GF22431@hirez.programming.kicks-ass.net>
 <20181106131119.GA9828@hirez.programming.kicks-ass.net>
 <341D9EA6-8B5E-4EC4-9140-14B5A7FD5690@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <341D9EA6-8B5E-4EC4-9140-14B5A7FD5690@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 06:11:18PM +0000, Nadav Amit wrote:
> From: Peter Zijlstra
> > On Tue, Nov 06, 2018 at 09:20:19AM +0100, Peter Zijlstra wrote:
> > 
> >> By our current way of thinking, kmap_atomic simply is not correct.
> > 
> > Something like the below; which weirdly builds an x86_32 kernel.
> > Although I imagine a very sad one.
> > 
> > ---
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index ba7e3464ee92..e273f3879d04 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1449,6 +1449,16 @@ config PAGE_OFFSET
> > config HIGHMEM
> > 	def_bool y
> > 	depends on X86_32 && (HIGHMEM64G || HIGHMEM4G)
> > +	depends on !SMP || BROKEN
> > +	help
> > +	  By current thinking kmap_atomic() is broken, since it relies on per
> > +	  CPU PTEs in the global (kernel) address space and relies on CPU local
> > +	  TLB invalidates to completely invalidate these PTEs. However there is
> > +	  nothing that guarantees other CPUs will not speculatively touch upon
> > +	  'our' fixmap PTEs and load then into their TLBs, after which our
> > +	  local TLB invalidate will not invalidate them.
> > +
> > +	  There are AMD chips that will #MC on inconsistent TLB states.
> > 
> > config X86_PAE
> > 	bool "PAE (Physical Address Extension) Support”
> 
> Please help me understand the scenario you are worried about. I see several
> (potentially) concerning situations due to long lived mappings:
> 
> 1. Inconsistent cachability in the PAT (between two different mappings of
> the same physical memory), causing memory ordering issues.
> 
> 2. Inconsistent access-control (between two different mappings of the same
> physical memory), allowing to circumvent security hardening mechanisms.
> 
> 3. Invalid cachability in the PAT for MMIO, causing #MC
> 
> 4. Faulty memory being mapped, causing #MC
> 
> 5. Some potential data leakage due to long lived mappings
> 
> The #MC you mention, I think, regards something that resembles (3) -
> speculative page-walks using cachable memory caused #MC when this memory was
> set on MMIO region. This memory, IIUC, was mistakenly presumed to be used by
> page-tables, so I don’t see how it is relevant for kmap_atomic().
> 
> As for the other situations, excluding (2), which this series is intended to
> deal with, I don’t see a huge problem which cannot be resolved in different
> means.

mostly #3 and related I think; kmap_atomic is a stack and any entry can
be used for whatever is needed. When the remote CPU does a speculative
hit on our fixmap entry, that translation will get populated.

When we then unmap and flush (locally) and re-establish that mapping for
something else; the CPU might #MC because the translations are
incompatible.

Imagine one being some MMIO mapping for i915 and another being a regular
user address with incompatible cachebility or something.

Now the remote CPU will never actually use those translations except for
speculation. But I'm terribly uncomfortable with this.

It might all just work; but not doing global flushes for global mapping
changes makes me itch.
