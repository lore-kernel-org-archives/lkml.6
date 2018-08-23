Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8449EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C07208EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fpi9kz6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C07208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbeHWIWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:22:49 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43852 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeHWIWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:22:48 -0400
Received: by mail-io0-f195.google.com with SMTP id y10-v6so3298047ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 21:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Nj8f9X2Fht1tlOh3Qo9BOnIgCzCnSucMs/H0FZ/9yA=;
        b=Fpi9kz6M8S0YjxGGtLB8U6iplXnAo8e20ryjxpm6HdKDLHJcbgVeSWniVVndklNgZx
         ZeEcN/Qsg3lArShNG049OqPRR4xwKcwIiTbySsh7MSVLbw/SQfcrJunU6/+R7h9Kz8Qd
         MFjdb+hSw5T6Wm/kNoo9bu1O1Fgh4d/smHijY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Nj8f9X2Fht1tlOh3Qo9BOnIgCzCnSucMs/H0FZ/9yA=;
        b=nWpHeEG9Ccjfb8NxQqSHBfieXC6vK53H3L55DZjD0/EvyCUhBwfFv43lAUUE+FaOYv
         QIl0gkmqr9Vb67yArvs9qY++cUj1KlWekbvuIptYbOuQjM94zuIpaTVlGmIGSK9aV8nR
         qSvyJroRbrTsH0YotdUt6EvHSIWda0w5TzCDndycHx58TG7tv9qA0tT8i3aqNEZZwRrB
         3JjEeYt6gPSYPX+Hrie7LLvNPRmwmAR/lQ5aZI9/YyJ1J80PUm+5rkmbaDuL9tvzaAr+
         ZCIHGUJ+l+XDZcgIkr9svaNcjxVq23sfkeVcOK131fvvKX9et9d5y/61w+Yo7hDjWNpn
         B/1Q==
X-Gm-Message-State: APzg51A88j9/gAge/hJhozGJsty0kMYdbZ0vJ0Q+pUGFbJ4DB2go/Y/p
        xsWiKLOr1Sn07z64MbBk4AZWWfeF/tiRhPM1pNo=
X-Google-Smtp-Source: ANB0Vda/GVbIgHQ7b5UbbqfOKXo0enG08ETkDH/d5mviSPf6jXxgFGpUhByezS5z/iJCahbi/nKV1cBvc+bt7LH9R7Q=
X-Received: by 2002:a6b:7a49:: with SMTP id k9-v6mr7029948iop.238.1535000099179;
 Wed, 22 Aug 2018 21:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180822153012.173508681@infradead.org> <20180822154046.772017055@infradead.org>
 <20180823133103.30d6a16b@roar.ozlabs.ibm.com> <CA+55aFyY4fG8Hhds4ykSm5vUMdxbLdB7mYmC2pOPk8UKBXtpjA@mail.gmail.com>
 <20180823141642.38b53175@roar.ozlabs.ibm.com>
In-Reply-To: <20180823141642.38b53175@roar.ozlabs.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 21:54:48 -0700
Message-ID: <CA+55aFzfnWv3JoB0mR7iCX322KsiE+uRq3HcmOpciEAiTw-oLw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/tlb: Remove tlb_remove_table() non-concurrent condition
To:     Nick Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 9:16 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Wed, 22 Aug 2018 20:35:16 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > And yes, those lazy tlbs are all kernel threads, but they can still
> > speculatively load user addresses.
>
> So?
>
> If the arch does not shoot those all down after the user page tables
> are removed then it's buggy regardless of this short cut.

Read the code.

That shortcut frees the pages *WITHOUT* doing that TLB flush. It just
does __tlb_remove_table(), which does *not* do that whole page
queueing so that we can batch flush and then free later.

So the fast-case it's buggy, exactly because of the reason you state.

The logic used to be that if you were the only cpu that had that tlb,
and it was a mid-level table, it didn't need that synchronization at
all.

And that logic is simply wrong. Exactly because even if mm_users is 1,
there can be things looking up TLB entries on other CPU's. Either
because of a lazy mm and a hw walker with speculation, or because of
use_mm() and a software walker.

So the whole "free immediately" shortcut was bogus. You *always* need
to queue, then flush the tlb, and then free.

That said, that wasn't actually the bug that Jann found. He found the
bug a few lines lower down, where the "I can't allocate memory for
queueing" ended up *also* not flushing the TLB.

> The only real problem I could see would be if a page walk cache still
> points to the freed table, then the table gets re-allocated and used
> elsewhere, and meanwhile a speculative access tries to load an entry
> from the page that is an invalid form of page table that might cause
> a machine check or something. That would be (u)arch specific, but if
> that's what we're concerned with here it's a different issue and needs
> to be documented as such.

We've *seen* that case, we had exactly that when we were being
aggressive about trying to avoid flushes for the lazy mmu case
entirely, because "we can just flush when we activate the lazy mm
state instead".

The logic was actually solid from a TLB case - who cares what garbage
TLB entries we might speculatively fill, when we're going to flush
them before they can possibly be used.

It turns out that that logic is solid, but hits another problem: at
least some AMD CPU's will cause machine checks when the TLB entries
are inconsistent with the machine setup. That can't happen with a
*good* page table, but when you speculatively walk already freed
tables, you can get any garbage.

I forget what the exact trigger was, but this was actually reported.
So you can't free page directory pages without flushing the tlb first
(to make that internal tlb node caches are flushed).

So the logic for freeing leaf pages and freeing middle nodes has to be
exactly the same: you make the modification to the page table to
remove the node/leaf, you queue up the memory for freeing, you flush
the tlb, and you then free the page.

That's the ordering that tlb_remove_page() has always honored, but
that tlb_remove_tabl() didn't.

It honored it for the *normal* case, which is why it took so long to
notice that the TLB shootdown had been broken on x86 when it moved to
the "generic" code. The *normal* case does this all right, and batches
things up, and then when the batch fills up it does a
tlb_table_flush() which does the TLB flush and schedules the actual
freeing.

But there were two cases that *didn't* do that. The special "I'm the
only thread" fast case, and the "oops I ran out of memory, so now I'll
fake it, and just synchronize with page twalkers manually, and then do
that special direct remove without flushing the tlb".

NOTE! Jann triggered that one by
 (a) forcing the machine low on memory
 (b) force-poisoning the page tables immediately after free

I suspect it's really hard to trigger under normal loads, exactly
because the *normal* case gets it right. It's literally the "oops, I
can't batch up because I ran out of memory" case that gets it wrong.

(And the special single-thread + lazy or use_mm() case, but that's
going to be entirely impossible to trigger, because in practice it's
just a single thread, and you won't ever hit the magic timing needed
that frees the page in the single thread at exactly the same time that
some optimistic lazy mm on another cpu happens to speculatively load
that address).

So the "atomic_read(&mm_users)" case is likely entirely impossible to
trigger any sane way. But because Jann found the problem with the 'ran
out of memory" case, we started looking at the more theoretical cases
that matched the same kind of "no tlb flush before free" pattern.

              Linus
