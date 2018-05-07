Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753422AbeEGVPQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:15:16 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:43281 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753354AbeEGVPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:15:14 -0400
X-Google-Smtp-Source: AB8JxZo7m+Q7Vqh6ewYUboSIOrKfck46+qifEGYRxqvTm71u2RG4CBv1QZI/ngzF3kXgDcWyKRab73Z4XhwrsLMrZ1A=
MIME-Version: 1.0
In-Reply-To: <20180507204911.GC15604@bombadil.infradead.org>
References: <CAGXu5j++1TLqGGiTLrU7OvECfBAR6irWNke9u7Rr2i8g6_30QQ@mail.gmail.com>
 <20180505034646.GA20495@bombadil.infradead.org> <CAGXu5jLbbts6Do5JtX8+fij0m=wEZ30W+k9PQAZ_ddOnpuPHZA@mail.gmail.com>
 <20180507113902.GC18116@bombadil.infradead.org> <CAGXu5jKq7uZsDN8qLzKTUC2eVQT2f3ZvVbr8s9oQFeikun9NjA@mail.gmail.com>
 <20180507201945.GB15604@bombadil.infradead.org> <CAGXu5jL_vYWs7eKY34ews2pW24fvOqNPybmuugg9ycfR1siOLA@mail.gmail.com>
 <20180507204911.GC15604@bombadil.infradead.org>
From: Kees Cook <keescook@google.com>
Date: Mon, 7 May 2018 14:15:12 -0700
Message-ID: <CAGXu5jLxzDjWZ5OWsGf8_rSr6yePHOJ91ujBgLU2iXLKEuT7wQ@mail.gmail.com>
Subject: Re: *alloc API changes
To: Matthew Wilcox <willy@infradead.org>
Cc: John Johansen <john.johansen@canonical.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 1:49 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, May 07, 2018 at 01:27:38PM -0700, Kees Cook wrote:
>> On Mon, May 7, 2018 at 1:19 PM, Matthew Wilcox <willy@infradead.org> wrote:
>> > Yes.  And today with kvmalloc.  However, I proposed to Linus that
>> > kvmalloc() shouldn't allow it -- we should have kvmalloc_large() which
>> > would, but kvmalloc wouldn't.  He liked that idea, so I'm going with it.
>>
>> How would we handle size calculations for _large?
>
> I'm not sure we should, at least initially.  The very few places which
> need a large kvmalloc really are special and can do their own careful
> checking.  Because, as Linus pointed out, we shouldn't be letting the
> user ask us to allocate a terabyte of RAM.  We should just fail that.
>
> let's see how those users pan out, and then see what we can offer in
> terms of safety.
>
>> > There are very, very few places which should need kvmalloc_large.
>> > That's one million 8-byte pointers.  If you need more than that inside
>> > the kernel, you're doing something really damn weird and should do
>> > something that looks obviously different.
>>
>> I'm CCing John since I remember long ago running into problems loading
>> the AppArmor DFA with kmalloc and switching it to kvmalloc. John, how
>> large can the DFAs for AppArmor get? Would an 8MB limit be a problem?
>
> Great!  Opinions from people who'll use this interface are exceptionally
> useful.
>
>> And do we have any large IO or network buffers >8MB?
>
> Not that get allocated with kvmalloc ... because you can't DMA map vmalloc
> (without doing some unusual contortions).

Er, yes, right. I meant for _all_ allocators, though. If 8MB is going
to be the new "saturated" value? Maybe I misunderstood? What are you
proposing for the code of array_size()?

>> > but I thought of another problem with array_size.  We already have
>> > ARRAY_SIZE and it means "the number of elements in the array".
>> >
>> > so ... struct_bytes(), array_bytes(), array3_bytes()?
>>
>> Maybe "calc"? struct_calc(), array_calc(), array3_calc()? This has the
>> benefit of actually saying more about what it is doing, rather than
>> its return value... In the end, I don't care. :)
>
> I don't have a strong feeling on this either.

I lean ever so slightly towards *_size(). It'll be hard to mix up
ARRAY_SIZE() and array_size(), given the parameters.

-Kees

-- 
Kees Cook
Pixel Security
