Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D2DC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 16:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7000D208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 16:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kuJgV64j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7000D208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeHZUap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 16:30:45 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43177 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbeHZUap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 16:30:45 -0400
Received: by mail-yw1-f68.google.com with SMTP id l189-v6so4760556ywb.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 09:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cN2QbvzkncMY46b2rS+9Am1lLU2adDQwU4VduoWptY8=;
        b=kuJgV64jJlEKnLx9sVPNDAdvgfGtpE3gwVIQ7AXNDHp0yxV6STub8RRrXWWl1b3wIz
         JLyGXyZTAR0Y23L2tVsbqDKtpvhr6MYJHGtkEwh4KrkX9sYEK+saakbG6ShxqSPG+w7L
         UHkKjRuy+dll1e9L3KGt9GLj9q+e2Xh5VkoFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cN2QbvzkncMY46b2rS+9Am1lLU2adDQwU4VduoWptY8=;
        b=B1ADH9MIqtXKdvVbMojXJ0FMoJhBwsg1CXGB078zSLSfsBkzE/6PznZujMprNZK4LW
         H7o5t6sJVR+5H+Ax8LILsy+f2Uvz3r8pANv+WbiBiXtnhQdmpFa7IF8EFvympBpCUrPO
         Vx9JbuS9CEhER+5kS9aQafj6fngvVqvPM27kgwvm0CzUv30rjqd3WD+6zDBhJsblf9U5
         Y9kxvJWFXa7d/Xnm6Py7f8/FjGfyWvDzLV2I0tActZx+Pvg2cUgRk76Ip0RuHGYLpBx3
         0rr2gcOS0AXY9Rk3KtIDc6OdqkkbPSoW1F306VS2jQPdN2EemBAVfZOZAnqwaHCESsI4
         /3kg==
X-Gm-Message-State: APzg51BqdxRtOzBDUYQ8D2lPiNrrgW65IUryPXnVdXBYiFtbUw322HCT
        RetqKSLLwwPAgKwlxJICtNjtv4CfuS0=
X-Google-Smtp-Source: ANB0VdYUCImdfx2tR2FtagstzCwWM5uTbcVIVlnFEPFXD6IIrUZWXatEypQx2plsbnOHpkaKhMDNJA==
X-Received: by 2002:a81:5155:: with SMTP id f82-v6mr5157929ywb.30.1535302061094;
        Sun, 26 Aug 2018 09:47:41 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id a129-v6sm14945703ywh.79.2018.08.26.09.47.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 09:47:38 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id m62-v6so3275747ywd.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 09:47:37 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr5464486ywr.168.1535302057003;
 Sun, 26 Aug 2018 09:47:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Sun, 26 Aug 2018 09:47:36
 -0700 (PDT)
In-Reply-To: <952A64F0-90B3-4E2F-B410-7E20BE90D617@amacapital.net>
References: <20180822153012.173508681@infradead.org> <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net> <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police> <20180824084717.GK24124@hirez.programming.kicks-ass.net>
 <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com> <20180824180438.GS24124@hirez.programming.kicks-ass.net>
 <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com> <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
 <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com> <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
 <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com> <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
 <20180826112341.f77a528763e297cbc36058fa@kernel.org> <CALCETrXPaX-+R6Z9LqZp0uOVmq-TUX_ksPbUL7mnfbdqo6z2AA@mail.gmail.com>
 <CAGXu5j+xUbq_mu=2jvH2Vu+mviteZJqdPNTrxpaijwsuDdN-sw@mail.gmail.com> <952A64F0-90B3-4E2F-B410-7E20BE90D617@amacapital.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 26 Aug 2018 09:47:36 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKk+ELGsSXC8e3v67oo74BF9rP2HDqMHx1Sb17-0F-xZQ@mail.gmail.com>
Message-ID: <CAGXu5jKk+ELGsSXC8e3v67oo74BF9rP2HDqMHx1Sb17-0F-xZQ@mail.gmail.com>
Subject: Re: TLB flushes on fixmap changes
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 7:20 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>> On Aug 25, 2018, at 9:43 PM, Kees Cook <keescook@chromium.org> wrote:
>>
>>> On Sat, Aug 25, 2018 at 9:21 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>>> On Sat, Aug 25, 2018 at 7:23 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>>> On Fri, 24 Aug 2018 21:23:26 -0700
>>>> Andy Lutomirski <luto@kernel.org> wrote:
>>>>> Couldn't text_poke() use kmap_atomic()?  Or, even better, just change CR3?
>>>>
>>>> No, since kmap_atomic() is only for x86_32 and highmem support kernel.
>>>> In x86-64, it seems that returns just a page address. That is not
>>>> good for text_poke, since it needs to make a writable alias for RO
>>>> code page. Hmm, maybe, can we mimic copy_oldmem_page(), it uses ioremap_cache?
>>>>
>>>
>>> I just re-read text_poke().  It's, um, horrible.  Not only is the
>>> implementation overcomplicated and probably buggy, but it's SLOOOOOW.
>>> It's totally the wrong API -- poking one instruction at a time
>>> basically can't be efficient on x86.  The API should either poke lots
>>> of instructions at once or should be text_poke_begin(); ...;
>>> text_poke_end();.
>>>
>>> Anyway, the attached patch seems to boot.  Linus, Kees, etc: is this
>>> too scary of an approach?  With the patch applied, text_poke() is a
>>> fantastic exploit target.  On the other hand, even without the patch
>>> applied, text_poke() is every bit as juicy.
>>
>> I tried to convince Ingo to use this method for doing "write rarely"
>> and he soundly rejected it. :) I've always liked this because AFAICT,
>> it's local to the CPU. I had proposed it in
>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/write-rarely&id=9ab0cb2618ebbc51f830ceaa06b7d2182fe1a52d
>
> Ingo, can you clarify why you hate it?  I personally would rather use CR3, but CR0 seems like a fine first step, at least for text_poke.

Sorry, it looks like it was tglx, not Ingo:

https://lkml.kernel.org/r/alpine.DEB.2.20.1704071048360.1716@nanos

This thread is long, and one thing that I think went unanswered was
"why do we want this to be fast?" the answer is: for doing page table
updates. Page tables are becoming a bigger target for attacks now, and
it's be nice if they could stay read-only unless they're getting
updated (with something like this).

-Kees

-- 
Kees Cook
Pixel Security
