Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A2EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8562150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cV+wc8rC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8562150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeHWWqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:46:55 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34762 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHWWqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:46:55 -0400
Received: by mail-it0-f66.google.com with SMTP id x79-v6so3264728ita.1;
        Thu, 23 Aug 2018 12:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/bEn5OIBqgOb53Gz/lHhoUwwxCPmH66LYI850gHrlPE=;
        b=cV+wc8rCK1Rwdns624ZvTCLQ5pKwkMTXrz34XCtdd7Yla27QuKv3Efoir256tXsGpk
         +HuegusbtJYJr1V1ex9waZxVwsemhymlHCFxz6Dr78p47zGJWjzCDTC+MZHp9Wl9AoUz
         lTfu3shSQzSpVpeA3b0jJqc2VLH/2X5vMyWBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bEn5OIBqgOb53Gz/lHhoUwwxCPmH66LYI850gHrlPE=;
        b=Ux3Ch7Mdl3xz8XS8QTbtuXQY4zw1i5TNJJd8WYl5tHtpPkg4Ww0+doT4Hp0clp5aHL
         ezDPPuGnWjxEAXFnAD0hpHGjib73Ju6c1ft8Ff8UyxuovP7W9QXY1dHMvLObRgzXp0b1
         /TBPnISGwDdthdxREaI62L1DTOwiThWH6NpBYJsKCogIWZHyEDf+PtAoLIfNqYHMdZh8
         0tQo+/6d254SW02y4lNAuONyGXQBajRKcy6X1A1tmwkMEQ/xOGMWGmFYnYEx7jYGs9vJ
         sjs2KilUTFIZj5DpzLouFL2XMezTVV5DdEhUezCsAyA8dkuuVqXSTvsWW75KjRCuNRzu
         s9TQ==
X-Gm-Message-State: APzg51DqRES+NadkbKEVNVcsCmL5K3qBZZW3UpmvX+JbLr7i94a1R+jp
        WynlNRqdZxNkl4F6EznU68F/Mi/crREyPbS9OTY=
X-Google-Smtp-Source: ANB0VdbHplx/zuKHI+2t1CnvbRBjqopyNaJkSWBLtfb1ulmXapr/ynDd32y1kqCvkVl8RoMaQdwpo+vU2kF+O/ZuAxc=
X-Received: by 2002:a24:3046:: with SMTP id q67-v6mr8180734itq.9.1535051748840;
 Thu, 23 Aug 2018 12:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180823084709.19717-1-npiggin@gmail.com>
In-Reply-To: <20180823084709.19717-1-npiggin@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Aug 2018 12:15:37 -0700
Message-ID: <CA+55aFxaiv3SMvFUSEnd_p6nuGttUnv2_O3v_G2zCnnc0pV2pA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] minor mmu_gather patches
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
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 1:47 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> These are split from some patches I posted a while back, I was going
> to take a look and revive the series again after your fixes go in,
> but having another look, it may be that your "[PATCH 3/4] mm/tlb,
> x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE" becomes
> easier after my patch 1.
>
> And I'm not convinced patch 2 is not a real bug at least for ARM64,
> so it may be possible to squeeze it in if it's reviewed very
> carefully (I need to actually reproduce and trace it).
>
> So not signed off by yet, but if you think it might be worth doing
> these with your changes, it could be a slightly cleaner end result?

Actually, you did have sign-offs, and yes, that patch 1/2 does
actually clean up and simplify the HAVE_RCU_TABLE_INVALIDATE fix, so I
decided to mix these in with PeterZ's series.

And since it turns out that patch doesn't apparently matter for
correctness and doesn't need to be backported to stable, I put it at
the end of the series together with the x86 cleanup patch to avoid the
unnecessary RCU-delayed freeing entirely for the non-PV case.

So right now my "tlb-fixes" branch looks like this:

    x86/mm/tlb: Revert the recent lazy TLB patches
 *  mm: move tlb_table_flush to tlb_flush_mmu_free
 *  mm/tlb: Remove tlb_remove_table() non-concurrent condition
 *  mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE
    mm: mmu_notifier fix for tlb_end_vma
    x86/mm: Only use tlb_remove_table() for paravirt

where the three starred patches are marked for stable.

The initial revert is for this merge window only, and the two last
patches are cleanups and fixes but shouldn't matter for correctness in
stable.

PeterZ - your "mm/tlb, x86/mm: Support invalidating TLB caches for
RCU_TABLE_FREE" patch looks exactly the same, but it now no longer has
the split of tlb_flush_mmu_tlbonly(), since with Nick's patch to move
the call to tlb_table_flush(tlb) into tlb_flush_mmu_free, there's no
need for the separate double-underscore version.

I hope nothing I did screwed things up. It all looks sane to me.
Famous last words.

I'll do a few more test builds and boots, but I think I'm going to
merge it in this cleaned-up and re-ordered form.

                     Linus
