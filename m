Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24F6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551AA20851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IQjnTO6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551AA20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbeHWH1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 03:27:37 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33937 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeHWH1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 03:27:36 -0400
Received: by mail-io0-f195.google.com with SMTP id c22-v6so3253151iob.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 20:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GWbtkZMgO44q21FL+QlPkVXET6vkQdrpdf+86VyR8fM=;
        b=IQjnTO6Ac751aj7VFtgC2QHYDDoCuN/+TUOD9UVjvpreSaSXZV4o3MnWn6LDMa5pnj
         xkWShlcjCxwNzusQyXIBN2oH3m0WCH/QlbypvHmKMCgc3ZaF09iqOSHSLZTgkIvmqcQd
         Pzm4alOTLdiEqAk9qLlov5p1ZH51vE9hYrNaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWbtkZMgO44q21FL+QlPkVXET6vkQdrpdf+86VyR8fM=;
        b=kJxRBaiNBd3n/GUCH+CzRHTSARJXHJ19zeeAUmCu2aH1/SMhsVOM5+VsiMHqZ7ap9o
         jg5GaH34CINe87JpWQkFSi4nud2e7g1gmYDopG2fWjpr08fnFk5XVV0BRknHKYpTqGyr
         gX4yanhykFdXark01jIwOsjBDeDOKKj2tJonVDTlEiMCFP73ie5ksz6PizICssjoKMU+
         nK4Dxnpt+JTTTtQ1hYFq4GXxm0xcWUUhOxsHfMDjGBgtR11UeIQdGGZmDLDUBLs34vSE
         cHFhZoi4g6vr1B1VMIjPaNIf666ZucTQb5bcbTE6wOkz9IB1wANmMIcGtQnP2S9hENh7
         z1xQ==
X-Gm-Message-State: AOUpUlEc7xZhu/zA0g03h+1FxcW6nvmeU1tCob/ACVT0aRfN/1IyQnAL
        b/atJLyxUAdn+NlGXB59f96Wt1f4eE8Gpi7KVH0=
X-Google-Smtp-Source: AA+uWPz5+//5vTXRBiZMy0qGkhbqC/nijVMfWQjYoSYI1t0zksUF3m2VwX1TKbOl3lg+4mW9q9T283LkHTUbWmn4QUk=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr32454704ioh.259.1534996797255;
 Wed, 22 Aug 2018 20:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180822153012.173508681@infradead.org> <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net> <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
In-Reply-To: <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 20:59:46 -0700
Message-ID: <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE
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

On Wed, Aug 22, 2018 at 8:45 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> powerpc/radix has no such issue, it already does this tracking.

Yeah, I now realize that this was why you wanted to add that hacky
thing to the generic code, so that you can add the tlb_flush_pgtable()
call.

I thought it was because powerpc had some special flush instruction
for it, and the regular tlb flush didn't do it. But no. It was because
the regular code had lost the tlb flush _entirely_, because powerpc
didn't want it.

> We were discussing this a couple of months ago, I wasn't aware of ARM's
> issue but I suggested x86 could go the same way as powerpc.

The problem is that x86 _used_ to do this all correctly long long ago.

And then we switched over to the "generic" table flushing (which
harkens back to the powerpc code).

Which actually turned out to be not generic at all, and did not flush
the internal pages like x86 used to (back when x86 just used
tlb_remove_page for everything).

So as a result, x86 had unintentionally lost the TLB flush we used to
have, because tlb_remove_table() had lost the tlb flushing because of
a powerpc quirk.

You then added it back as a hacky per-architecture hook (apparently
having realized that you never did it at all), which didn't fix the
unintentional lack of flushing on x86.

So now we're going to do it right.  No more "oh, powerpc didn't need
to flush because the hash tables weren't in the tlb at all" thing in
the generic code that then others need to work around.

              Linus
