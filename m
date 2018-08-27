Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE15C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC71208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ll3JnYyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC71208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeH0L7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:59:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59258 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0L7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R4XLgZxIEeetxse3cGbQmpC5HMsrrsc0HLlgHIwbagw=; b=Ll3JnYyJBVNBLJNr/LfsTj+/t
        Vzcr/ATNuLuNDSIxL6gq248LwoaBTQq90JG0uy/dy4rJfo81fSpxFNk4L8C7gx7kGQlS3CM78HYIE
        PxzM2kod6F38lSbQQpR45t+ihNkXXyTl/B4n4+YoqJpHRoUFuiCfxIuEr8KYkx/w8Hl9fCr9Zkjvc
        rARysP8GjXXnuj3+NabtiVihFLk3uM6x3E9GtBwvCvSWjMO4dwH1P5TkbUmyhh4EDrSnXUUo//n6W
        AGQfHh7ezq2y3c7XdchVdFrfkDGBcv6+LLM3m+soExK3VnHSJi6SDXR2epEAL6jkHqqVfTCwle5fN
        uGJbzq6+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuCeR-0000qB-Ev; Mon, 27 Aug 2018 08:13:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB3112024EFCD; Mon, 27 Aug 2018 10:13:29 +0200 (CEST)
Date:   Mon, 27 Aug 2018 10:13:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: TLB flushes on fixmap changes
Message-ID: <20180827081329.GZ24124@hirez.programming.kicks-ass.net>
References: <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com>
 <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
 <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com>
 <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
 <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com>
 <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
 <20180826112341.f77a528763e297cbc36058fa@kernel.org>
 <CALCETrXPaX-+R6Z9LqZp0uOVmq-TUX_ksPbUL7mnfbdqo6z2AA@mail.gmail.com>
 <20180826090958.GT24124@hirez.programming.kicks-ass.net>
 <20180827120305.01a6f26267c64610cadec5d8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827120305.01a6f26267c64610cadec5d8@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 12:03:05PM +0900, Masami Hiramatsu wrote:
> On Sun, 26 Aug 2018 11:09:58 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > FWIW, before text_poke_bp(), text_poke() would only be used from
> > stop_machine, so all the other CPUs would be stuck busy-waiting with
> > IRQs disabled. These days, yeah, that's lots more dodgy, but yes
> > text_mutex should be serializing all that.
> 
> I'm still not sure that speculative page-table walk can be done
> over the mutex. Also, if the fixmap area is for aliasing
> pages (which always mapped to memory), what kind of
> security issue can happen?

So suppose CPU-A is doing the text_poke (let's say through text_poke_bp,
such that other CPUs get to continue with whatever they're doing).

While at that point, CPU-B gets an interrupt, and the CPU's
branch-trace-buffer for the IRET points to / near our fixmap. Then the
CPU could do a speculative TLB fill based on the BTB value, either
directly or indirectly (through speculative driven fault-ahead) of
whatever is in te fixmap at the time.

Then CPU-A completes the text_poke and only does a local TLB invalidate
on CPU-A, leaving CPU-B with an active translation.

*FAIL*


