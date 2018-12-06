Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EADC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B0B2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="etcSboKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B0B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeLFBIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:08:49 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41877 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbeLFBIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:08:48 -0500
Received: by mail-yb1-f195.google.com with SMTP id n134so958699ybf.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 17:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/jINOn+sc+LBZeMo1BY7lNtqrudJ8L4pImVfyYsvKio=;
        b=etcSboKnrSf3gjBausw5JNUVn6fOhTzKy8NbTJP0l8Sx8LBzfCRlcFEvFoBahKoCRU
         77CDRPgCmWT79f81oyAaivKXiWM0RwLYNKLieoI9uM7Wn1XVPF2VLJP+Wji4xSZf7lWt
         P/oUFq1ndWet0jsCIMciqfiPHDjHUj73ntpWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/jINOn+sc+LBZeMo1BY7lNtqrudJ8L4pImVfyYsvKio=;
        b=pugQM/bsCXFexNszzUFvf9YbKHxPPpHrma4edm1HzBL7on8lxhVcQIdhmi09zCjvyM
         O9sP7fgFZQOFNwG2zzMJAJ3qEifGn6JC55KoEVuPMjF5irujY8PcOW+yJNWhkG5jxFQH
         ZL2o2+yW+SJTmu45rE+CuPkihc1txh6KF18cqEYeHaQs/qqSz87rpsQEIC8mvaHmpTr0
         SGythsGSklOYhlYfYy/6vorFP94KRKywDrlcIhOzG1tpTQPTR0KkdyZiqRZNX/y9qfnX
         x7G5i6mESMgI17Ob9v/z2HU3C64H2HZ/mjg9H79xAn0NKFhipRhuI59BKePHyRDXekZ0
         RZvA==
X-Gm-Message-State: AA+aEWZZl+l4VI5TANOahJSU5OvKS9oJuvW2Q/TaaPWU4qZVAw4HYTSb
        48QPo7kD0OrWrWku9OC2jyhMORfKAx8=
X-Google-Smtp-Source: AFSGD/W12Bv4413r716KdCa7cin3H8BQor2IPgKFFPLM2IYl0l2NFVRj3ZgmzWxxe/keWuNEYX9FAQ==
X-Received: by 2002:a25:4457:: with SMTP id r84-v6mr24987497yba.192.1544058526801;
        Wed, 05 Dec 2018 17:08:46 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id u2sm8125459ywe.84.2018.12.05.17.08.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 17:08:46 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id f125so5080343ybc.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 17:08:45 -0800 (PST)
X-Received: by 2002:a25:a22a:: with SMTP id b39-v6mr26098595ybi.209.1544058525402;
 Wed, 05 Dec 2018 17:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20181130150859.27366-1-anders.roxell@linaro.org>
In-Reply-To: <20181130150859.27366-1-anders.roxell@linaro.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Dec 2018 17:08:34 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+-w1qh3Jg6u8jM0XxFS-X4qJpzOtf_HO3eEjohL1dj=w@mail.gmail.com>
Message-ID: <CAGXu5j+-w1qh3Jg6u8jM0XxFS-X4qJpzOtf_HO3eEjohL1dj=w@mail.gmail.com>
Subject: Re: [PATCH 1/3] stackleak: mark stackleak_track_stack() as notrace
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 7:09 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Function graph tracing recurses into itself when stackleak is enabled,
> causing the ftrace graph selftest to run for up to 90 seconds and
> trigger the softlockup watchdog.
>
> Breakpoint 2, ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:200
> 200             mcount_get_lr_addr        x0    //     pointer to function's saved lr
> (gdb) bt
> \#0  ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:200
> \#1  0xffffff80081d5280 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:153
> \#2  0xffffff8008555484 in stackleak_track_stack () at ../kernel/stackleak.c:106
> \#3  0xffffff8008421ff8 in ftrace_ops_test (ops=0xffffff8009eaa840 <graph_ops>, ip=18446743524091297036, regs=<optimized out>) at ../kernel/trace/ftrace.c:1507
> \#4  0xffffff8008428770 in __ftrace_ops_list_func (regs=<optimized out>, ignored=<optimized out>, parent_ip=<optimized out>, ip=<optimized out>) at ../kernel/trace/ftrace.c:6286
> \#5  ftrace_ops_no_ops (ip=18446743524091297036, parent_ip=18446743524091242824) at ../kernel/trace/ftrace.c:6321
> \#6  0xffffff80081d5280 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:153
> \#7  0xffffff800832fd10 in irq_find_mapping (domain=0xffffffc03fc4bc80, hwirq=27) at ../kernel/irq/irqdomain.c:876
> \#8  0xffffff800832294c in __handle_domain_irq (domain=0xffffffc03fc4bc80, hwirq=27, lookup=true, regs=0xffffff800814b840) at ../kernel/irq/irqdesc.c:650
> \#9  0xffffff80081d52b4 in ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:205
>
> Rework so we mark stackleak_track_stack as notrace
>
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  kernel/stackleak.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index e42892926244..5de3bf596dd7 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -102,7 +102,7 @@ asmlinkage void stackleak_erase(void)
>         current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
>  }
>
> -void __used stackleak_track_stack(void)
> +void __used notrace stackleak_track_stack(void)
>  {
>         /*
>          * N.B. stackleak_erase() fills the kernel stack with the poison value,
> --
> 2.19.2
>

Acked-by: Kees Cook <keescook@chromium.org>

Steven, I assume this series going via your tree?

-- 
Kees Cook
