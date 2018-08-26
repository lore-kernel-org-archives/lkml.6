Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A92C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5E421722
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O3C3h+1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5E421722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeH0Brz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 21:47:55 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38155 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0Brz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 21:47:55 -0400
Received: by mail-yw1-f66.google.com with SMTP id n21-v6so4824849ywh.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Vw/vpMtNloNfEZxPwTTY9XIGpMEqoQcmV42JHdQlmdY=;
        b=O3C3h+1VmW4rfHW8p5+eiDiCaYBhkRFAmquqQVvJZW5u7q0s2n56y5kGu93nkglFZd
         AFmK35IKgfSdwCWQ4ZPA/8VwUC6ccD7M3RtORls6Gr4gNSwXb+w/X6cIDn5NfWqylpjc
         C3HlCljCkYvRKKPDFP31q8HABP9LpqJdy+5/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Vw/vpMtNloNfEZxPwTTY9XIGpMEqoQcmV42JHdQlmdY=;
        b=noUwg04wFM7pXS13DeWec7sUQgrku2pVeaE3diGgjTPswbJGCvwyT6nFxwW66j//YZ
         IYGFgAZGVZi1ZUMCznFnfaKDPv0aLYPVmpem2p5gGm0xmt5dJ/kwFP9mzk89JPwi0ouA
         rYJrosNdzqiXwCpbfIKzEWA4QIoHBlLPZ8gwas49V+C/wjTciGtzjlJ82hfaHBMLqQ5h
         x8XY4cPuruKbU0wdIQnPl3/hEJmVR3r9A4Gdgqv37DZSEG2OQ3fDS7ryyOxW9Zi9Jc4K
         5zRerhsAIpvkWqx0nNMX1eB5VTQSJh+4mQn4nY2VSAiKv4kZl9B4YHF+C2fsYnraU+tf
         Ny8Q==
X-Gm-Message-State: APzg51D4vQm9NKDqjioIR2fxch0EKcnjccpupPc59uuzFZ2rBhxO1ILA
        CVl0iuEULJFnACIEBe+/QGmW/HTfJes=
X-Google-Smtp-Source: ANB0Vdalt56F1ot9u2tL3zQtiz3FGM0QMmiTbVuQ9V2GKawQ3uqU+IOBbCGEJ0sVGfpFe8BD1C01fw==
X-Received: by 2002:a0d:db89:: with SMTP id d131-v6mr5768165ywe.318.1535321042913;
        Sun, 26 Aug 2018 15:04:02 -0700 (PDT)
Received: from mail-yb0-f178.google.com (mail-yb0-f178.google.com. [209.85.213.178])
        by smtp.gmail.com with ESMTPSA id s63-v6sm5800894ywd.63.2018.08.26.15.04.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 15:04:01 -0700 (PDT)
Received: by mail-yb0-f178.google.com with SMTP id o17-v6so5383364yba.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 15:04:01 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr5773553ybz.410.1535321040528;
 Sun, 26 Aug 2018 15:04:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Sun, 26 Aug 2018 15:03:59
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1808262212030.1195@nanos.tec.linutronix.de>
References: <20180822153012.173508681@infradead.org> <20180823133958.GA1496@brain-police>
 <20180824084717.GK24124@hirez.programming.kicks-ass.net> <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com>
 <20180824180438.GS24124@hirez.programming.kicks-ass.net> <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com>
 <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
 <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com> <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
 <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com> <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
 <20180826112341.f77a528763e297cbc36058fa@kernel.org> <CALCETrXPaX-+R6Z9LqZp0uOVmq-TUX_ksPbUL7mnfbdqo6z2AA@mail.gmail.com>
 <CAGXu5j+xUbq_mu=2jvH2Vu+mviteZJqdPNTrxpaijwsuDdN-sw@mail.gmail.com>
 <952A64F0-90B3-4E2F-B410-7E20BE90D617@amacapital.net> <CAGXu5jKk+ELGsSXC8e3v67oo74BF9rP2HDqMHx1Sb17-0F-xZQ@mail.gmail.com>
 <DF353FDA-4A57-4F5E-A403-531DDA0DBC25@amacapital.net> <alpine.DEB.2.21.1808262212030.1195@nanos.tec.linutronix.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 26 Aug 2018 15:03:59 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJQGiGwQRBGuVrmhQqyUEfRUUSD6WYokc2xezExY9ZNUg@mail.gmail.com>
Message-ID: <CAGXu5jJQGiGwQRBGuVrmhQqyUEfRUUSD6WYokc2xezExY9ZNUg@mail.gmail.com>
Subject: Re: TLB flushes on fixmap changes
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
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

On Sun, Aug 26, 2018 at 1:15 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sun, 26 Aug 2018, Andy Lutomirski wrote:
>> > On Aug 26, 2018, at 9:47 AM, Kees Cook <keescook@chromium.org> wrote:
>> >> On Sun, Aug 26, 2018 at 7:20 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>> >>> I tried to convince Ingo to use this method for doing "write rarely"
>> >>> and he soundly rejected it. :) I've always liked this because AFAICT,
>> >>> it's local to the CPU. I had proposed it in
>> >>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/write-rarely&id=9ab0cb2618ebbc51f830ceaa06b7d2182fe1a52d
>> >>
>> >> Ingo, can you clarify why you hate it?  I personally would rather use CR3, but CR0 seems like a fine first step, at least for text_poke.
>> >
>> > Sorry, it looks like it was tglx, not Ingo:
>> >
>> > https://lkml.kernel.org/r/alpine.DEB.2.20.1704071048360.1716@nanos
>> >
>> > This thread is long, and one thing that I think went unanswered was
>> > "why do we want this to be fast?" the answer is: for doing page table
>> > updates. Page tables are becoming a bigger target for attacks now, and
>> > it's be nice if they could stay read-only unless they're getting
>> > updated (with something like this).
>> >
>> >
>> It kind of sounds like tglx would prefer the CR3 approach. And indeed my
>> patch has a serious problem wrt the NMI code.
>
> That's exactly the problem I have with CR0. It leaves everything and some
> more writeable for any code which can interrupt that section.

I thought the point was that the implementation I suggested was
NMI-proof? (And in reading Documentation/preempt-locking.txt it sounds
like disabling interrupts is redundant to preempt_disable()? But I
don't understand how; it looks like the preempt stuff is advisory?)

-Kees

-- 
Kees Cook
Pixel Security
