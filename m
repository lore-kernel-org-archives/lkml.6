Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B67C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBB0204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBB0204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeIZPFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:05:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43831 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZPFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:05:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id x24-v6so22485700lfe.10;
        Wed, 26 Sep 2018 01:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A6s0+ZNL7nKauaszPZVs6oJ75UHD81RARze2+MoySwc=;
        b=K/bXWjZZZKoOSFUpn4w9geIJ6r62B5OXwlbhOBPckjsl4atZL4iIbsAwHEk5Eyzkaw
         SiOi6RXqjCXItATpAi3hvBS9ooVAZhwbWJ5pTC4be36xPoTgIySfPoSyxHPLM8V8hjUt
         WpBKZEgNECVG2HxDKDLQIqmroDlVCA4j+EvcYGsM7nkU6O9L4EegdogZweylg9FNYFCk
         sAfIyXHOSqcUhH2333N0w26dMn+aguusuUj7mb5+Lj+ctbaSBmDBwF5qC4pa8X9qKkB8
         ndYzxG05rln1qOlmqPK2PrHQ3cWoN9bTsE8mBsoS5MPA4pvM7HLZzseFLMPqNU+D9fq0
         nmcA==
X-Gm-Message-State: ABuFfoh6PrzmsZ6OvzCqjk0YKS26w2Rr5WETsgeoUqUlQKbNT1dJHZ/k
        d/UBjeYs7IadAjrS2q5VUsZhsXykOCIzs78IzTI=
X-Google-Smtp-Source: ACcGV60MHY9QOABRzTadUP7X+wOMtbpxWasRc5Y9aoKMLL6gHsD7XYGpfv/1QalbdZ5Je6Dw+TbrmBBzWJksxO/oWs0=
X-Received: by 2002:a19:1346:: with SMTP id j67-v6mr3459424lfi.93.1537952039712;
 Wed, 26 Sep 2018 01:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180807211843.47586-1-keescook@chromium.org> <20180807211843.47586-8-keescook@chromium.org>
 <CAK8P3a3kiH-a+JG8FqUw7nc_hk+9z-FdsGFT57SxR83W32zKzQ@mail.gmail.com> <CAKv+Gu-dGbWsQu0NgOWVFy7Sca3yBD0pLzEMwmkG3mg9LFPpkA@mail.gmail.com>
In-Reply-To: <CAKv+Gu-dGbWsQu0NgOWVFy7Sca3yBD0pLzEMwmkG3mg9LFPpkA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 26 Sep 2018 10:53:42 +0200
Message-ID: <CAK8P3a3=_uQihMw0GwEbvDnbvrxzq-em6rccW-so+qmkXk8btQ@mail.gmail.com>
Subject: Re: [PATCH v8 7/9] crypto: qat: Remove VLA usage
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        David Miller <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, dm-devel@redhat.com,
        qat-linux@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:44 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 25 Sep 2018 at 18:12, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Aug 7, 2018 at 11:18 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > In the quest to remove all stack VLA usage from the kernel[1], this uses
> > > the new upper bound for the stack buffer. Also adds a sanity check.
> > >
> > > [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> > >
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > After rebasing to linux-next, I now get a warning about this file:
> >
> > drivers/crypto/qat/qat_common/qat_algs.c: In function 'qat_alg_do_precomputes':
> > drivers/crypto/qat/qat_common/qat_algs.c:257:1: error: the frame size
> > of 1112 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> >
> > I assume it was already possible to get into that state with the VLA,
> > but it seems bad enough that I think we need to do something
> > about it.
> >
> > The large stack variables add up to 1084 bytes, which fully explains
> > how we got here:
> >
> >         SHASH_DESC_ON_STACK(shash, ctx->hash_tfm); /* 360 */
> >         struct sha1_state sha1;  /* 92 */
> >         struct sha256_state sha256; /* 104 */
> >         struct sha512_state sha512; /* 208 */
> >         char ipad[MAX_ALGAPI_BLOCKSIZE]; /* 160 */
> >         char opad[MAX_ALGAPI_BLOCKSIZE]; /* 160 */
> >
> > The question is what we can do about it. One simple step I've tried
> > is to move the sha1/sha256/sha512 into a union, which saves around
> > 200 bytes and should bring us (slightly) below the warning
> > limit, but I suspect we can do better than that. Any ideas?
> >
>
> All the processing takes place in the context of a setkey() operation,
> which means only one such operation should be in flight per tfm at any
> given time. So we could move all these pieces into the tfm context
> struct instead. Something like the below [untested] (whitespace
> mangling courtesy of Gmail)

Ah, right, this is what I was hoping for. I assume we already guarantee
that this context is never put on the stack somewhere else, right?

      Arnd
