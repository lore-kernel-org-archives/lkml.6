Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226E1C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 09:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45CB20676
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 09:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DScAhLgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45CB20676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeHZMw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 08:52:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54912 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeHZMw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 08:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Jt0oOLxfIzuU8qEN+Ck+i6KG4P9MOFTtQQBTRs+RvhI=; b=DScAhLgKn94OCa0A6iPBIOltF
        fMbMbYKywWISKNujOlP5qyGh4dwUbHulQcvjbNorsxDxPBaY8+WNeg+6SzavYMlhmmECjGG1Utcpz
        ulrWruo0M6+dPT67igvePbk/HBnZqYtMZQQWbROCl/dk1hvvop05OGLBk5lkHZlnWXgWcDr2DfovE
        Dxk4RlyDrIDla1lfWDFbSWkZcx2OCKQNXtg2te5B2IzBNpuWXZ/4FTw0TA1IDqg93DG6WpToJOZKj
        fM58Afvw5sbeFjTc7TTgSbdTyX2vdM/ntYaCpNhZFPzB2083jwBpCs3GR+3KDr7GYoQGFES7BzLdq
        YvKjm0b+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ftr3c-0003nk-2l; Sun, 26 Aug 2018 09:10:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54B332024EB1E; Sun, 26 Aug 2018 11:09:58 +0200 (CEST)
Date:   Sun, 26 Aug 2018 11:09:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <20180826090958.GT24124@hirez.programming.kicks-ass.net>
References: <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com>
 <20180824180438.GS24124@hirez.programming.kicks-ass.net>
 <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com>
 <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
 <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com>
 <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
 <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com>
 <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
 <20180826112341.f77a528763e297cbc36058fa@kernel.org>
 <CALCETrXPaX-+R6Z9LqZp0uOVmq-TUX_ksPbUL7mnfbdqo6z2AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXPaX-+R6Z9LqZp0uOVmq-TUX_ksPbUL7mnfbdqo6z2AA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 09:21:22PM -0700, Andy Lutomirski wrote:
> I just re-read text_poke().  It's, um, horrible.  Not only is the
> implementation overcomplicated and probably buggy, but it's SLOOOOOW.
> It's totally the wrong API -- poking one instruction at a time
> basically can't be efficient on x86.  The API should either poke lots
> of instructions at once or should be text_poke_begin(); ...;
> text_poke_end();.

I don't think anybody ever cared about performance here. Only
correctness. That whole text_poke_bp() thing is entirely tricky.

FWIW, before text_poke_bp(), text_poke() would only be used from
stop_machine, so all the other CPUs would be stuck busy-waiting with
IRQs disabled. These days, yeah, that's lots more dodgy, but yes
text_mutex should be serializing all that.

And on that, I so hate comments like: "must be called under foo_mutex",
we have lockdep_assert_held() for that.
