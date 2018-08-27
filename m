Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2157CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7E020B80
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yuQsF/a0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7E020B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeH0NZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbeH0NZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:25:36 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E45C20A8B;
        Mon, 27 Aug 2018 09:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535362781;
        bh=NswiXxKUMprlxnabLOVDpx3lhqa9GgiKTYFOXkWSPko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yuQsF/a0z1kJOhInlnaDXeTE7nz9Yzpb4NhwWCidra1il7VONNShxx2WAFkbxk33s
         IDH4bAAsdV8AObh/KI2QUjImRhnaw0bRPPrCM+9EGoWWD53H771S8ITLnG0IQph3QI
         P2LU823mIG1Td4Ci6mD+2vFRhakAHCPNC3t+u2no=
Date:   Mon, 27 Aug 2018 18:39:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-Id: <20180827183936.75f4e9bc131cdeac943f44e3@kernel.org>
In-Reply-To: <20180827081329.GZ24124@hirez.programming.kicks-ass.net>
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
        <20180827081329.GZ24124@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 10:13:29 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Aug 27, 2018 at 12:03:05PM +0900, Masami Hiramatsu wrote:
> > On Sun, 26 Aug 2018 11:09:58 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > FWIW, before text_poke_bp(), text_poke() would only be used from
> > > stop_machine, so all the other CPUs would be stuck busy-waiting with
> > > IRQs disabled. These days, yeah, that's lots more dodgy, but yes
> > > text_mutex should be serializing all that.
> > 
> > I'm still not sure that speculative page-table walk can be done
> > over the mutex. Also, if the fixmap area is for aliasing
> > pages (which always mapped to memory), what kind of
> > security issue can happen?
> 
> So suppose CPU-A is doing the text_poke (let's say through text_poke_bp,
> such that other CPUs get to continue with whatever they're doing).
> 
> While at that point, CPU-B gets an interrupt, and the CPU's
> branch-trace-buffer for the IRET points to / near our fixmap. Then the
> CPU could do a speculative TLB fill based on the BTB value, either
> directly or indirectly (through speculative driven fault-ahead) of
> whatever is in te fixmap at the time.

Hmm, but how "near" is it enough? Since text_poke just map a non
executable alias page in fixmap, it is hard to suppose that IRET points
there (except for attacker change the IRET address).

I see that Intel CPU sometimes speculatively read-ahead the page tables,
but in that case, I guess we just need to keep fixmap area away from
text area. (Of course, it is hard to estimate how far is enough :( )

Anyway, I agree to introduce new page-table (and kthread?) for fixmap.

> Then CPU-A completes the text_poke and only does a local TLB invalidate
> on CPU-A, leaving CPU-B with an active translation.
> 
> *FAIL*

Ah, I got it. So on CPU-B, it can write-access to fixmap'd pages unless
the CPU-B shoot down the full TLB...

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
