Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C282C71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC15B2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zilbwuQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC15B2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeJOXMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbeJOXMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:12:16 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C45A2208D9;
        Mon, 15 Oct 2018 15:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539617192;
        bh=05K3sJPcL0ZwswQiWMzWQ0wGVgGQs7xOUJczzenxl3o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zilbwuQqMGWbT1laDSRlYHD9XwBM04HPahxmWAL3urLM/5UWPqmQFmcGiRrYGHBzC
         7aMzUMgkS/+3yjeZGFl01EcLYjBLVhcnT8Q5x4L+g/kGHtjfZhj9Yng74wNNMufCVy
         5XMmiVexasG+3Qd4rRif+k/biiKzZz2WzOefm/aE=
Received: by mail-wr1-f41.google.com with SMTP id x12-v6so21821305wru.8;
        Mon, 15 Oct 2018 08:26:31 -0700 (PDT)
X-Gm-Message-State: ABuFfoj1BeWE/zzsjUIN6DlNdCL8HpRMq33CHVoz6Zx2laPVohk0F7iW
        hm9Yq1q4tOY/r0b3rMWR0QXnI8UAHu4jBpGzxWA=
X-Google-Smtp-Source: ACcGV60dN5ZoSykRdfXrkhqTSQCKiz/4LSgngL9thDbCx+lWFlDaKs1c30dpxo+aFuQP9Lz1NonaxOq1kqVK7Icxnfk=
X-Received: by 2002:adf:f84e:: with SMTP id d14-v6mr15200975wrq.174.1539617190123;
 Mon, 15 Oct 2018 08:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181015123135eucas1p18df135504c9476cead8da6463226cdec@eucas1p1.samsung.com>
 <20181015123112.9379-1-m.szyprowski@samsung.com> <20181015123112.9379-3-m.szyprowski@samsung.com>
In-Reply-To: <20181015123112.9379-3-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 15 Oct 2018 17:26:18 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfUHOmMmwty0v-vSvr_110tGU5roo2DduJWPWu5q_to0A@mail.gmail.com>
Message-ID: <CAJKOXPfUHOmMmwty0v-vSvr_110tGU5roo2DduJWPWu5q_to0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] clocksource: exynos_mct: Fix error path in timer
 resources initialization
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com, marc.zyngier@arm.com,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, Inki Dae <inki.dae@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 at 14:31, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> While freeing interrupt handlers in error path, don't assume that all
> requested interrupts are per-processor interrupts and properly release
> standard interrupts too.

Thanks for fixing!

> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>

It is a bug so how about:
Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
?

> Fixes: 56a94f13919c ("clocksource: exynos_mct: Avoid blocking calls in the cpu hotplug notifier")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Anyway I am fine so:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> ---
>  drivers/clocksource/exynos_mct.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 43b335ff4a96..a379f11fad2d 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -562,7 +562,19 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>         return 0;
>
>  out_irq:
> -       free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
> +       if (mct_int_type == MCT_INT_PPI) {
> +               free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
> +       } else {
> +               for_each_possible_cpu(cpu) {
> +                       struct mct_clock_event_device *pcpu_mevt =
> +                               per_cpu_ptr(&percpu_mct_tick, cpu);
> +
> +                       if (pcpu_mevt->evt.irq != -1) {
> +                               free_irq(pcpu_mevt->evt.irq, pcpu_mevt);
> +                               pcpu_mevt->evt.irq = -1;
> +                       }
> +               }
> +       }
>         return err;
>  }
>
> --
> 2.17.1
>
