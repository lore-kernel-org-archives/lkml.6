Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49516C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61A821536
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wVRbyip3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61A821536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeHZGEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 02:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbeHZGEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 02:04:42 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE19121536;
        Sun, 26 Aug 2018 02:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535250226;
        bh=/O6CBF2OkJTiG0yrABiwNKem3rtr8nMP92KU+ULR7FM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wVRbyip3fWwc9TXGFPxT/Kp7eWUTCuTIdxKN9I3McUnBik5U95Hd4LgkHbNEVv75J
         rXufDiWB2CHDwlVGCacoWmMWSC2f8Mr4iXEZ/Do49Ju9Wwq/u2FoG+WIry9apC3cMQ
         SYcpwbIlkIWW5fccxek4s25b4Y+UEexZMUU5Ih3M=
Date:   Sun, 26 Aug 2018 11:23:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Message-Id: <20180826112341.f77a528763e297cbc36058fa@kernel.org>
In-Reply-To: <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
References: <20180822153012.173508681@infradead.org>
        <20180822154046.823850812@infradead.org>
        <20180822155527.GF24124@hirez.programming.kicks-ass.net>
        <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
        <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
        <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
        <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
        <20180823133958.GA1496@brain-police>
        <20180824084717.GK24124@hirez.programming.kicks-ass.net>
        <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com>
        <20180824180438.GS24124@hirez.programming.kicks-ass.net>
        <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com>
        <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
        <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com>
        <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
        <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com>
        <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 21:23:26 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> On Fri, Aug 24, 2018 at 7:29 PM,  <nadav.amit@gmail.com> wrote:
> >
> >
> > On August 24, 2018 5:58:43 PM PDT, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >>Adding a few people to the cc.
> >>
> >>On Fri, Aug 24, 2018 at 1:24 PM Nadav Amit <nadav.amit@gmail.com>
> >>wrote:
> >>> >
> >>> > Can you actually find something that changes the fixmaps after boot
> >>> > (again, ignoring kmap)?
> >>>
> >>> At least the alternatives mechanism appears to do so.
> >>>
> >>> IIUC the following path is possible when adding a module:
> >>>
> >>>         jump_label_add_module()
> >>>         ->__jump_label_update()
> >>>         ->arch_jump_label_transform()
> >>>         ->__jump_label_transform()
> >>>         ->text_poke_bp()
> >>>         ->text_poke()
> >>>         ->set_fixmap()
> >>
> >>Yeah, that looks a bit iffy.
> >>
> >>But making the tlb flush global wouldn't help.  This is running on a
> >>local core, and if there are other CPU's that can do this at the same
> >>time, then they'd just fight about the same mapping.
> >>
> >>Honestly, I think it's ok just because I *hope* this is all serialized
> >>anyway (jump_label_lock? But what about other users of text_poke?).
> >
> > The users should hold text_mutex.
> >
> >>
> >>But I'd be a lot happier about it if it either used an explicit lock
> >>to make sure, or used per-cpu fixmap entries.
> >
> > My concern is that despite the lock, one core would do a speculative page walk and cache a translation that soon after would become stale.
> >
> >>
> >>And the tlb flush is done *after* the address is used, which is bogus
> >>anyway.
> >
> > It seems to me that it is intended to remove the mapping that might be a security issue.
> >
> > But anyhow, set_fixmap and clear_fixmap perform a local TLB flush, (in __set_pte_vaddr()) so locally things should be fine.
> >
> >>
> >>> And a similar path can happen when static_key_enable/disable() is
> >>called.
> >>
> >>Same comments.
> >>
> >>How about replacing that
> >>
> >>        local_irq_save(flags);
> >>       ... do critical things here ...
> >>        local_irq_restore(flags);
> >>
> >>in text_poke() with
> >>
> >>        static DEFINE_SPINLOCK(poke_lock);
> >>
> >>        spin_lock_irqsave(&poke_lock, flags);
> >>       ... do critical things here ...
> >>        spin_unlock_irqrestore(&poke_lock, flags);
> >>
> >>and moving the local_flush_tlb() to after the set_fixmaps, but before
> >>the access through the virtual address.
> >>
> >>But changing things to do a global tlb flush would just be wrong.
> >
> > As I noted, I think that locking and local flushes as they are right now are fine (besides the redundant flush).
> >
> > My concern is merely that speculative page walks on other cores would cache stale entries.
> >
> >
> 
> This is almost certainly a bug, or even two bugs.  Bug 1:  why on
> Earth do we flush in __set_pte_vaddr()?  We should flush when
> *clearing* or when modifying an existing fixmap entry.  Right now, if
> we do text_poke() after boot, then the TLB entry will stick around and
> will be a nice exploit target.
> 
> Bug 2: what you're describing.  It's racy.
> 
> Couldn't text_poke() use kmap_atomic()?  Or, even better, just change CR3?

No, since kmap_atomic() is only for x86_32 and highmem support kernel.
In x86-64, it seems that returns just a page address. That is not
good for text_poke, since it needs to make a writable alias for RO
code page. Hmm, maybe, can we mimic copy_oldmem_page(), it uses ioremap_cache?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
