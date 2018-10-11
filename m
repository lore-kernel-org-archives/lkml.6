Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AFCC4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D622C2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bIXGqRqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D622C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeJKWaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:30:35 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38970 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeJKWae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:30:34 -0400
Received: by mail-it1-f196.google.com with SMTP id w200-v6so13607109itc.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/naWTO9CxdQZFOUKhonf+vvaQc+Kk2l6u9PJleafIc=;
        b=bIXGqRqWCR390AsBDOCm/n203ueETsQv8ljH42z4AdpWiVv9E1I2j5yHWZTSiOi+yn
         37aiTc7P4zIMpcAfQp0xi3IBQvu/4upkwywY5dydqbnC8xD3A0SbvQhxKceMirE4UD6D
         y7PVkjv3/oyZlwjRb1kJlafzC/mIDBqinxRpTfzVtK63NpTtSPixrP8kqpk/yRtku4TK
         4ldYz1wSsl3JbAbivCBI8U1SWWW/YeszX6vpJpVuOTBCbkDiBcxUJv9tBptg9fMg8IYi
         eJMU5mQ9PVq6I+E2YA1JDZEf4ejo4fITbFysM0xI80bP6IMNAK7u9N6AHEfL0F+tu7l0
         CaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/naWTO9CxdQZFOUKhonf+vvaQc+Kk2l6u9PJleafIc=;
        b=C26fqxRwUdUJyXfgSgJw/00R7pgXnXLURfciHlfY0i6ArMOKATnRIT9yKqCwWxoTGC
         KiwPvWkuVt920HdjYP4V03GktClLWKH1nsFp9aWoGL/x+Fr803WK3TZ/i+OwvXVETGM2
         2U++71d6FdKWqiHygUk4GExu6G6Bvn+NkanrTq6IyaoPjIDLnWQ0Qz7pS2P364vkqQS3
         TAXFeZzkO1JoNbJnxwqwYNtB/USrSBacztoOgHU3YR7A6uRQnH4V3nRMdAj9I03z+/XU
         d6U7IG/WYRb/BOOnu4Y8TXrVT25uXI7XwJPvEw0lnAuwiC+X9vlkuAqAB2q2h5ZftFu2
         GvUg==
X-Gm-Message-State: ABuFfojtrNpyLIMzCzzcy7lCUPuADZUUbCyl6zebs+yyj/jWYMrQNu9b
        AZogbs9qVciEFve0BE+NCGfqCRDdmJfXzbmKKutxTg==
X-Google-Smtp-Source: ACcGV60Q0Sni2OQaONE4FxcT6rBUuISZnFyUv69/YifnU1DsU7jYB2ntUPPioRbyLgN8l4NMuFNk0cS3zxK6kv/MkyM=
X-Received: by 2002:a24:f803:: with SMTP id a3-v6mr1596175ith.178.1539270180852;
 Thu, 11 Oct 2018 08:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181011103825.023036082@infradead.org> <20181011104019.748208519@infradead.org>
In-Reply-To: <20181011104019.748208519@infradead.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 11 Oct 2018 08:02:48 -0700
Message-ID: <CANn89iKxTMRr_XSC4xHD-etoU9kF6nN7yzQP4AEfYeNKjQLTPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/percpu: Fix this_cpu_read()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 3:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Eric reported that a sequence count loop using this_cpu_read() got
> optimized out. This is wrong, this_cpu_read() must imply READ_ONCE()
> because the interface is IRQ-safe, therefore an interrupt can have
> changed the per-cpu value.
>
> Fixes: 59eaef78bfea ("x86/tsc: Remodel cyc2ns to use seqcount_latch()")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>


Acked-by: Eric Dumazet <edumazet@google.com>

> ---
>  arch/x86/include/asm/percpu.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -185,22 +185,22 @@ do {                                                                      \
>         typeof(var) pfo_ret__;                          \
>         switch (sizeof(var)) {                          \
>         case 1:                                         \
> -               asm(op "b "__percpu_arg(1)",%0"         \
> +               asm volatile(op "b "__percpu_arg(1)",%0"\
>                     : "=q" (pfo_ret__)                  \
>                     : "m" (var));                       \
>                 break;                                  \
>         case 2:                                         \
> -               asm(op "w "__percpu_arg(1)",%0"         \
> +               asm volatile(op "w "__percpu_arg(1)",%0"\
>                     : "=r" (pfo_ret__)                  \
>                     : "m" (var));                       \
>                 break;                                  \
>         case 4:                                         \
> -               asm(op "l "__percpu_arg(1)",%0"         \
> +               asm volatile(op "l "__percpu_arg(1)",%0"\
>                     : "=r" (pfo_ret__)                  \
>                     : "m" (var));                       \
>                 break;                                  \
>         case 8:                                         \
> -               asm(op "q "__percpu_arg(1)",%0"         \
> +               asm volatile(op "q "__percpu_arg(1)",%0"\
>                     : "=r" (pfo_ret__)                  \
>                     : "m" (var));                       \
>                 break;                                  \
>
>
