Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C5EECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BBF2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BBF2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeJQXnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:43:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39137 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeJQXna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:43:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id q5-v6so16770419qki.6;
        Wed, 17 Oct 2018 08:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbjCxbmSa3ybDatEzCyRbifNXOZuCL6No/RZA0ROCoo=;
        b=WOq63fnMeQlCI3xaCMq+6WYK5xYStRnaUlLbqNIKZ53Cv+bUTSU7SqH3X7t4ubfXGd
         +baD0kVCFIranZbddGG/M2il2s3Du8IVa8LAJLhhStypSSP7pqzyYZOZjn3WjOPkiC95
         l5svK5s8oLwTV4IyDEeqVGBeE3WAAWxAa862PzwE0vNpNj5dPvqTJI8hj18+dtxgvGXh
         FWBcmYVzBDyXBwpXVlHPiE+vtTanLISgkkgpdRus7xpSchBxuSre9w+9Hco9Zm1PQirh
         NJLcps7IwA9EXtb3kDxR2dwhTFFBDEqB+KQoXifoD4AQhZ4U5aKUk+SQtJF/YknI/LPP
         oRvg==
X-Gm-Message-State: ABuFfohWybXDlPV5y6dA+XNH+Lp9FSnFxuaukbF3OpFag2gYWCIZ3Iaz
        wj8VeOwnlhpfEehZX8coLjm26LHOJuAept2VIQQ=
X-Google-Smtp-Source: ACcGV60Fjbu6EJlUwh0yruq3JsfoIfHwRXPLtViZy9iUQJKEc2JGBtTzwPJyI3HTNEtXO5rKWlVNuqrf2/F6fQx3r+0=
X-Received: by 2002:a37:2b66:: with SMTP id r99-v6mr2955403qkh.343.1539791232565;
 Wed, 17 Oct 2018 08:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <1963c845cf9b7aa31547cdfe1f82b1add1ad2504.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <1963c845cf9b7aa31547cdfe1f82b1add1ad2504.1539655732.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:46:56 +0200
Message-ID: <CAK8P3a1hByh-k8mng8a22C1-tNU0yn1LNvoaCmHp4RpP_GUs4Q@mail.gmail.com>
Subject: Re: [PATCH V9 15/21] csky: Debug and Ptrace GDB
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:06 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds arch ptrace implementation, stack dump and bug.h.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> diff --git a/arch/csky/include/asm/bug.h b/arch/csky/include/asm/bug.h
> new file mode 100644
> index 0000000..bd7b323
> --- /dev/null
> +++ b/arch/csky/include/asm/bug.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#ifndef __ASM_CSKY_BUG_H
> +#define __ASM_CSKY_BUG_H
> +
> +#include <linux/compiler.h>
> +#include <linux/const.h>
> +#include <linux/types.h>
> +
> +#define BUG()                          \
> +do {                                   \
> +       asm volatile ("bkpt\n");        \
> +       unreachable();                  \
> +} while (0)

Since you have a breakpoint instruction, a nice addition might
be to use that for implementing WARN_ON as well, whenever you
get around to doing that. It's certainly not required for the initial
merge.
