Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A64C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBBE21850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfB0T1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:27:54 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42640 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfB0T1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:27:54 -0500
Received: by mail-ua1-f68.google.com with SMTP id s26so5831326uao.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 11:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3cLq+kIlMMXRZaenVxSwc6pfzBM/ls2MR1D4QP0Hu2k=;
        b=UMTHXWsm9oqX8+Chkt8XEsssOsgtdK5P/P0R/lmfHur0hZardLYQeDYiGKmByVv/Xw
         jogGmN9vmxWtbl8QpMbhlK10GNbJO5ZR/BSg9lpWVzU84uB0OmUv5UYySrIjDEQwYzao
         5LXIWbTe4hfP9AUC4rVQGh+Ysp07VY9LQ5byiMeLzMljkTDHSE0/96V0k8vsH4h00F5n
         neuvXlkTLGxyxR5Eu6DA/DiSesL0R/9hVypR5j2LsHlE6LWVac/vO9/BlEn2B6NzBp51
         jtsTDbb3/R0Oi8lxOio/t2ZxapFCm0vXhL72Jt4koBAQf6VqKU5X/wVYi0t3EoUFrXR3
         KxJQ==
X-Gm-Message-State: AHQUAuZz2xH3cCYIRN8Onbq4jJqjhcfRBllBkG8aKa1OaCFXfnprZeJU
        +sbc6rLCURhWCTfoFx14D2PP52g/B4UohEoO/7k=
X-Google-Smtp-Source: AHgI3IYIIgJnnj+3JVj92wdAfbL35gf/TxgoFevJ67043vd71Gt2nCkIM687D/Ouf5eryemB/ak7axdzhzJsiRNvfRk=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr2797801vsp.166.1551295673138;
 Wed, 27 Feb 2019 11:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20190227170608.27963-1-steven.price@arm.com> <20190227170608.27963-10-steven.price@arm.com>
In-Reply-To: <20190227170608.27963-10-steven.price@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Feb 2019 20:27:40 +0100
Message-ID: <CAMuHMdXCjuurBiFzQBeLPUFu=mmSowvb=37XyWmF_=xVhkQm4g@mail.gmail.com>
Subject: Re: [PATCH v3 09/34] m68k: mm: Add p?d_large() definitions
To:     Steven Price <steven.price@arm.com>
Cc:     Linux MM <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Wed, Feb 27, 2019 at 6:07 PM Steven Price <steven.price@arm.com> wrote:
> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
>
> For m68k, we don't support large pages, so add stubs returning 0
>
> CC: Geert Uytterhoeven <geert@linux-m68k.org>
> CC: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Steven Price <steven.price@arm.com>

Thanks for your patch!

>  arch/m68k/include/asm/mcf_pgtable.h      | 2 ++
>  arch/m68k/include/asm/motorola_pgtable.h | 2 ++
>  arch/m68k/include/asm/pgtable_no.h       | 1 +
>  arch/m68k/include/asm/sun3_pgtable.h     | 2 ++
>  4 files changed, 7 insertions(+)

If the definitions are the same, why not add them to
arch/m68k/include/asm/pgtable.h instead?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
