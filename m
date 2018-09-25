Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB85FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0DC206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0DC206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbeIYWUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:20:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46748 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbeIYWUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:20:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id q2-v6so10547853lfc.13;
        Tue, 25 Sep 2018 09:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3HrWUrQJziYKgmycYe8k7tgF3TyJyC6Crtp0yLLjPDc=;
        b=QHrHHDa7/waPcJCAfkr5kKYCDyNv26aFyNJ5lkAuwP800mA0FXBUuJY/rzGOHtepNG
         sSfXG9HZX8/fsYiibhbZC0AP0id7A8YMA0Hrv8H0v6+9vIKW8Mu+fN04TJXBlFKwehvS
         ZuycLlqPPHMtTMC9W6Ldg+ncRQNT6z6UGD/R0Eu9f5eRIZ/V6YgJYfR9U66hKtHDCFvg
         F4pT7N3FR4CrT+leXDnnVzS/jzd9efTMv9L14LWycJeDol/U/6yPt93P+MBqF80agbbG
         AGYLZlmDTm2EcZrIvlaTkVUzpSUCceXc0XxoK174rnf2LxJygDBxm/q88AkkPKId9oAB
         9+ag==
X-Gm-Message-State: ABuFfogGrLQl/Dz3NRrebjMnOIxGY83ABlinqWnmtMB4XRCOIcmdoZIl
        4sesoSCYsfIuKzGxexeIfk0bOkMkZ05E1XyCHS4=
X-Google-Smtp-Source: ACcGV60wGR1kUPlPjCemY3/4RIq/Paopg2NS3CbtleN5PatKTGq7e7g0fMeKMdeISfSIwn6ATQ/FOQPUlPEzcO0Azmg=
X-Received: by 2002:a19:d212:: with SMTP id j18-v6mr1342691lfg.44.1537891948028;
 Tue, 25 Sep 2018 09:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180807211843.47586-1-keescook@chromium.org> <20180807211843.47586-8-keescook@chromium.org>
In-Reply-To: <20180807211843.47586-8-keescook@chromium.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 25 Sep 2018 18:12:10 +0200
Message-ID: <CAK8P3a3kiH-a+JG8FqUw7nc_hk+9z-FdsGFT57SxR83W32zKzQ@mail.gmail.com>
Subject: Re: [PATCH v8 7/9] crypto: qat: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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

On Tue, Aug 7, 2018 at 11:18 PM Kees Cook <keescook@chromium.org> wrote:
>
> In the quest to remove all stack VLA usage from the kernel[1], this uses
> the new upper bound for the stack buffer. Also adds a sanity check.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

After rebasing to linux-next, I now get a warning about this file:

drivers/crypto/qat/qat_common/qat_algs.c: In function 'qat_alg_do_precomputes':
drivers/crypto/qat/qat_common/qat_algs.c:257:1: error: the frame size
of 1112 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

I assume it was already possible to get into that state with the VLA,
but it seems bad enough that I think we need to do something
about it.

The large stack variables add up to 1084 bytes, which fully explains
how we got here:

        SHASH_DESC_ON_STACK(shash, ctx->hash_tfm); /* 360 */
        struct sha1_state sha1;  /* 92 */
        struct sha256_state sha256; /* 104 */
        struct sha512_state sha512; /* 208 */
        char ipad[MAX_ALGAPI_BLOCKSIZE]; /* 160 */
        char opad[MAX_ALGAPI_BLOCKSIZE]; /* 160 */

The question is what we can do about it. One simple step I've tried
is to move the sha1/sha256/sha512 into a union, which saves around
200 bytes and should bring us (slightly) below the warning
limit, but I suspect we can do better than that. Any ideas?

        Arnd
