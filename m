Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FEDC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC1C2174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkCmoVtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC1C2174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeH0Luu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbeH0Luu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:50:50 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68F4D208B8;
        Mon, 27 Aug 2018 08:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535357116;
        bh=w5OcNqhyRkIfdMQt8JR5hd055TQNQqkHBWMtDzRwxdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DkCmoVttWtTCNvbDfjMPLbFQtzOPM8DhWj3ppNiAVznP8imP9zyRSAjr4OxhJXSif
         6uKuVbSksEzysskYWgL30/5yoK5kjgJPl3+fe9SzM2J6uqqX0r+CmqjazFewSYft73
         QdrBsSj1fRcxtSlQt9nWoldKR0/dZIKjl+HNf/eE=
Date:   Mon, 27 Aug 2018 17:05:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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
Message-Id: <20180827170511.6bafa15cbc102ae135366e86@kernel.org>
In-Reply-To: <4BF82052-4738-441C-8763-26C85003F2C9@gmail.com>
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
        <20180826090958.GT24124@hirez.programming.kicks-ass.net>
        <20180827120305.01a6f26267c64610cadec5d8@kernel.org>
        <4BF82052-4738-441C-8763-26C85003F2C9@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2018 20:26:09 -0700
Nadav Amit <nadav.amit@gmail.com> wrote:

> at 8:03 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Sun, 26 Aug 2018 11:09:58 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> >> On Sat, Aug 25, 2018 at 09:21:22PM -0700, Andy Lutomirski wrote:
> >>> I just re-read text_poke().  It's, um, horrible.  Not only is the
> >>> implementation overcomplicated and probably buggy, but it's SLOOOOOW.
> >>> It's totally the wrong API -- poking one instruction at a time
> >>> basically can't be efficient on x86.  The API should either poke lots
> >>> of instructions at once or should be text_poke_begin(); ...;
> >>> text_poke_end();.
> >> 
> >> I don't think anybody ever cared about performance here. Only
> >> correctness. That whole text_poke_bp() thing is entirely tricky.
> > 
> > Agreed. Self modification is a special event.
> > 
> >> FWIW, before text_poke_bp(), text_poke() would only be used from
> >> stop_machine, so all the other CPUs would be stuck busy-waiting with
> >> IRQs disabled. These days, yeah, that's lots more dodgy, but yes
> >> text_mutex should be serializing all that.
> > 
> > I'm still not sure that speculative page-table walk can be done
> > over the mutex. Also, if the fixmap area is for aliasing
> > pages (which always mapped to memory), what kind of
> > security issue can happen?
> 
> The PTE is accessible from other cores, so just as we assume for L1TF that
> the every addressable memory might be cached in L1, we should assume and
> PTE might be cached in the TLB when it is present.

Ok, so other cores can accidentally cache the PTE in TLB, (and no way
to shoot down explicitly?)

> Although the mapping is for an alias, there are a couple of issues here.
> First, this alias mapping is writable, so it might an attacker to change the
> kernel code (following another initial attack).

Combined with some buffer overflow, correct? If the attacker already can
write a kernel data directly, he is in the kernel mode.

> Second, the alias mapping is
> never explicitly flushed. We may assume that once the original mapping is
> removed/changed, a full TLB flush would take place, but there is no
> guarantee it actually takes place.

Hmm, would this means a full TLB flush will not flush alias mapping?
(or, the full TLB flush just doesn't work?)

> > Anyway, from the viewpoint of kprobes, either per-cpu fixmap or
> > changing CR3 sounds good to me. I think we don't even need per-cpu,
> > it can call a thread/function on a dedicated core (like the first
> > boot processor) and wait :) This may prevent leakage of pte change
> > to other cores.
> 
> I implemented per-cpu fixmap, but I think that it makes more sense to take
> peterz approach and set an entry in the PGD level. Per-CPU fixmap either
> requires to pre-populate various levels in the page-table hierarchy, or
> conditionally synchronize whenever module memory is allocated, since they
> can share the same PGD, PUD & PMD. While usually the synchronization is not
> needed, the possibility that synchronization is needed complicates locking.
> 

Could you point which PeterZ approach you said? I guess it will be
make a clone of PGD and use it for local page mapping (as new mm).
If so, yes it sounds perfectly fine to me.

> Anyhow, having fixed addresses for the fixmap can be used to circumvent
> KASLR.

I think text_poke doesn't mind using random address :)

> I don’t think a dedicated core is needed. Anyhow there is a lock
> (text_mutex), so use_mm() can be used after acquiring the mutex.

Hmm, use_mm() said;

/*
 * use_mm
 *      Makes the calling kernel thread take on the specified
 *      mm context.
 *      (Note: this routine is intended to be called only
 *      from a kernel thread context)
 */

So maybe we need a dedicated kernel thread for safeness?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
