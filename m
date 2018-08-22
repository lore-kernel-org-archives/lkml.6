Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E3BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6DF208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hhPnnD8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6DF208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeHWBBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 21:01:13 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40715 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeHWBBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 21:01:13 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so4916573ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZSIBmCqcgJFrr9/RKL0TCJ+ZayHpNkL6FQD0XF9SR4=;
        b=hhPnnD8x3CTcPyonM9ZPBGFjkr9/B17JxObBnnwfBfc87nhoj1TJvkGoYpNqoiTt71
         zakh7WV3vCS8KBhnNEh8+KaomtdyIrm9XPW68ycBYn2vLpPvcjYoL7HrsCNue3rYWpc0
         OcTSnvQwzdISQhLGWscdM6KWpl0JEpPOiqbrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZSIBmCqcgJFrr9/RKL0TCJ+ZayHpNkL6FQD0XF9SR4=;
        b=ikYxbIIBxtJYVYMO5m3PoGZLOLf/ldKR0UZFMxZXwtD3R3cpRBEk+fZhglh3xaUIet
         2eBKt0r3QoIeZcDJfJEOqD/de4YIPMJwld/5QebCmqZ3dqTB3linWBOd0v3tBFr05vr3
         JcMqvPPvW3vSGOjvob2x3ihUWAkV8djN7s6nFD6j3SuvdaWHh3SkX1BlvYRcD1xyNDVQ
         3pWW1xDtnN+CnEdz2xnMZCD2dRnJVt3dSVeaHVQTFihCE0OW69FQKfLDXJDBUsGqX/Ui
         Pm/0GH1p0zW8nwTlrKQguET13AHXNOfYXo/VO9T5yVVUB1aw5Dgl/nVYbF8jViC8UQEb
         zp+Q==
X-Gm-Message-State: APzg51Ae1vzCvi7/6eNGLaIpfQPNIezJMvAP3j0Uz86gmaTt5cooT7GT
        TwZHJ0gCvmEWF+m/N3Yf4AzRFpTf04pe2SSuL/I=
X-Google-Smtp-Source: ANB0VdaxfdH1jL32ydLPu9sx+hhUxH+ujyER9XnsCbZqKS8dlxyGHj91MkBObv3/17ZfsSYL77k8N+SnfsJLHnkGWV4=
X-Received: by 2002:a24:61d2:: with SMTP id s201-v6mr5137658itc.22.1534973678771;
 Wed, 22 Aug 2018 14:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180822153012.173508681@infradead.org> <20180822154046.823850812@infradead.org>
In-Reply-To: <20180822154046.823850812@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 14:34:27 -0700
Message-ID: <CA+55aFykjambbbvwap2C=B7yKzpy5-W6OiYG16E1RE7QLzODtg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Nick Piggin <npiggin@gmail.com>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 8:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -180,6 +180,7 @@ config X86
>         select HAVE_PERF_REGS
>         select HAVE_PERF_USER_STACK_DUMP
>         select HAVE_RCU_TABLE_FREE
> +       select HAVE_RCU_TABLE_INVALIDATE        if HAVE_RCU_TABLE_FREE

This is confusing. First you select HAVE_RCU_TABLE_FREE
unconditionally, and then you select HAVE_RCU_TABLE_INVALIDATE based
on that unconditional variable.

I can see why you do it, but that's because I see the next patch. On
its own it just looks like you have a drinking problem.

That said, I was waiting to see if this patch-set would get any
comments before applying it, but it's been mostly crickets... So I
think I'll just apply it and get this issue over and done with.

              Linus
