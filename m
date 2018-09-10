Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E6EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4AA2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4AA2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeIJRIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:08:18 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36962 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJRIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:08:17 -0400
Received: by mail-qt0-f195.google.com with SMTP id n6-v6so23760059qtl.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 05:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRq5CXuwpnBHmlTJwn+Sej/jlkv8nY0l2gsJq4ykQjk=;
        b=Ezm/qDZFrIqQ5xFwaZsDEnlg50bu9KPqY421IjdlcmkqN2CZV39x/IR0OykVkVYgyv
         x/gR9zXmDf50PfY8WnWans+xzvN9yqBXqoupADFX2styodKbWWOMgKo5tD7UlJr9y+/c
         v6GErro35nVhJvVkktktZTtldDbqCT/L8o1CjB9kJHueYtk9F5KyGBTrcQ/GG2WaqV2Q
         BbZEr7LSiV4GJzCHqo6fihcD9tiqyP6i5HwcWZ5qoicnqoLZtG8jL2+4JlezAcGmx1Me
         RZIUz71XGmByWNfnj7kdMwctCu+o0XtCGspAJ7MoNHLww5OT6kM80njRUVhdUIX3Bv/o
         gpQA==
X-Gm-Message-State: APzg51DSrKqRLC+R/ZPc9CNgRsFsoywz4h0G/oZucZKFqTIXmg4vLu/M
        QcYotD3pH2/ybLO/Ktb62MV6Lp/Muu33nuDqfA8=
X-Google-Smtp-Source: ANB0VdbZFcbYSkvbftFf+zzfKC5xCjjlU4cvPC03Pvzh7ptYpF/mVy7ooTSWT1Uyk6u4jOKE779yyKOPAzaQ2LyG0rU=
X-Received: by 2002:aed:3608:: with SMTP id e8-v6mr15999263qtb.75.1536581669877;
 Mon, 10 Sep 2018 05:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180910060455.20409-1-stefan@agner.ch>
In-Reply-To: <20180910060455.20409-1-stefan@agner.ch>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 10 Sep 2018 14:14:13 +0200
Message-ID: <CAK8P3a2cc741UqFSk+hXpC2s4S+A+0FuiM1yP=Z4rC18sJHq9g@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler-clang.h: define __naked
To:     Stefan Agner <stefan@agner.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>, paullawrence@google.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 8:05 AM Stefan Agner <stefan@agner.ch> wrote:
>
> ARM32 arch code uses the __naked attribute. This has previously been
> defined in include/linux/compiler-gcc.h, which is no longer included
> for Clang. Define __naked for Clang. Conservatively add all attributes
> previously used (and supported by Clang).
>
> This fixes compile errors when building ARM32 using Clang:
>   arch/arm/mach-exynos/mcpm-exynos.c:193:13: error: variable has incomplete type 'void'
>   static void __naked exynos_pm_power_up_setup(unsigned int affinity_level)
>               ^
>
> Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

> +/*
> + * ARM32 is currently the only user of __naked supported by Clang. Follow
> + * gcc: Do not trace naked functions and make sure they don't get inlined.
> + */
> +#define __naked __attribute__((naked)) noinline notrace
> +

Please see patches 5 and 6 of the series that Miguel posted:

https://lore.kernel.org/lkml/20180908212459.19736-6-miguel.ojeda.sandonis@gmail.com/

I suppose we want the patch to fix clang build as soon as possible though,
and follow up with the cleanup for the next merge window, right?

       Arnd
