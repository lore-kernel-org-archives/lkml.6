Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD843C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8952188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f2zVWUJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8952188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeHRDax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 23:30:53 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44431 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeHRDaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 23:30:52 -0400
Received: by mail-io0-f193.google.com with SMTP id q19-v6so8263535ioh.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 17:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=So/0woPgTYnR6w6xB0pl/j/cXwLpa8Z0tXPRnUk3uoE=;
        b=f2zVWUJQJriQW5UynhFGAUUgm2fgTxfT0GqrsYU1EfgeFfhLASa0vxCJhNI3IBr1Lm
         jn8gmsI6h5BMNR6M+qEzLCTRoDujDXl2LFjISr1PHkfjHemtiCZmL0dn7lffdnj/bTiO
         yZrsSDy5JqfXUbS/kGomGVjOtH2zRuW8gxVJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=So/0woPgTYnR6w6xB0pl/j/cXwLpa8Z0tXPRnUk3uoE=;
        b=tH070qV9Rnn1rQDExG4Ftj9ISmFrxHsXld5CCskRtd3qh4G8zVQLEa3d2Ll3/ITZBC
         xs9URrwZZme7dahBiL9lNQ8lPe+seszvmCbZd15tmymMQQmXzHPz7r5AuaXGGtxsdCdT
         1DBBrGMCU35D8ng0nwYQ6rWtUK17JIEMvGO5swuUnTZYLFGW96xfeBVGkYwdn2Ltozwg
         QjxIBo3Z9DPj348Y69VLthwZV8tJMb3N3dwa0T9/M0EwYKYhpAMKGCFUU8B9yghqbs0f
         TcbGHCCT8OOI62iwO2k7JJS2z1XY/RnZiceydDYlXWMGQxFLGNCNY4Cowp31JtChvMvV
         kk8Q==
X-Gm-Message-State: AOUpUlHyXQRo4Ta6NtBcfoFqccxaGlOk8l++6KE6b1TcqLfEFayB/jsA
        4uWEPPEnyXJFcQZSq/VqSmvnovAsUqcTN1uv0I8=
X-Google-Smtp-Source: AA+uWPw41CHpti4mBAkP3QE+XMC1j9nAulCdEifc87l+wOWB+FcJ0Bcenahq3FqC67WHf5YCpUzRY2IIj97N/nHrgVE=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr18930556ioh.203.1534551918251;
 Fri, 17 Aug 2018 17:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180817222733.GA18575@roeck-us.net>
In-Reply-To: <20180817222733.GA18575@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Aug 2018 17:25:07 -0700
Message-ID: <CA+55aFw6KDEts1bk7F-HYVn_dSuFQHZZh89Ydqh1rFn-c5V+eQ@mail.gmail.com>
Subject: Re: Crash in MM code in v4.4.y, v4.9.y with TRANSPARENT_HUGEPAGE enabled
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 3:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> [    6.649970] random: crng init done
> [    6.689002] BUG: unable to handle kernel paging request at ffffeafffa1a0020

Hmm. Lots of bits set.

> [    6.689082] RIP: 0010:[<ffffffff8116ba10>]  [<ffffffff8116ba10>] page_remove_rmap+0x10/0x230
> [    6.689082] RSP: 0018:ffffc900007abc18  EFLAGS: 00000296
> [    6.689082] RAX: ffffea0005e58000 RBX: ffffeafffa1a0000 RCX: 0000000020200000
> [    6.689082] RDX: 00003fffffe00000 RSI: 0000000000000001 RDI: ffffeafffa1a0000

Is that RDX value the same value as PHYSICAL_PMD_PAGE_MASK?

If I did my math right, it would be, if your CPU has 46 bits of
physical memory. Might that be the case?

The reason I mention that is because we had the bug with spurious
inversion of the zero pte/pmd, fixed by

  f19f5c49bbc3 ("x86/speculation/l1tf: Exempt zeroed PTEs from inversion")

and that would make a zeroed pmd entry be inverted by
PHYSICAL_PMD_PAGE_MASK, and then you get odd garbage page pointers
etc.

Maybe. I could have gotten the math wrong too, but it sounds like the
register contents _potentially_ might match up with something like
this, and then we'd zap a bogus hugepage because of some confusion.

Although then I'd have expected the bisection to hit
"x86/speculation/l1tf: Invert all not present mappings" instead of the
one you hit, so I don't know.

Plus I'd have expected the problem to have been in mainline too, and
apparently it's just the 4.4 and 4.9 backports.

Your test-case does have mprotect with PROT_NONE. Which together with
that mask that *might* be PHYSICAL_PMD_PAGE_MASK makes me think it
might be related.

             Linus
