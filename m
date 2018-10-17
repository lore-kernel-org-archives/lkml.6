Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9637DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EE721527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9YOG5pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EE721527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeJQWZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbeJQWZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:25:27 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B127E2152A;
        Wed, 17 Oct 2018 14:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539786569;
        bh=kd6s3D4GrWS1cjFOPZPGzCTb4DfICUVnR1+wtlkoIPY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t9YOG5pa8YWlEqK1FkloORZxEMfVQwwDUBKadVHpOW+ZvCZM/nWJWk+X+f2x7CgYb
         WB81cpqu1cK0yj+6vQazO+EaFvgiYpNcX+vHu1pXudhMePP18aTsrN9b+flRRrQEpR
         3Qb3hBnYPi799Y8C4zK+LanhHnllFIH0XFnGCLZA=
Received: by mail-lj1-f181.google.com with SMTP id o14-v6so24559040ljj.2;
        Wed, 17 Oct 2018 07:29:28 -0700 (PDT)
X-Gm-Message-State: ABuFfoi/jqrHtH0sf+lgyFGDGwbO6POY7LSFWBVAi9eeCd63Q1nnrlZ3
        IMF+pWG4TM7CaLXglKDcWLEzpIHokvZtAtwSId8=
X-Google-Smtp-Source: ACcGV63bWAaWy/H3VpBx84S07a/7la7QaqGlSMK+YjC+kneYKVKnCjlJOUY+S/gCMGsXNguayP+mNAcZU6aXK06D1UE=
X-Received: by 2002:a2e:50e:: with SMTP id 14-v6mr2670546ljf.152.1539786566748;
 Wed, 17 Oct 2018 07:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181017134206eucas1p1ebc76569f706675d41f2d2183349f1f3@eucas1p1.samsung.com>
 <20181017134159.9656-1-m.szyprowski@samsung.com> <20181017134159.9656-4-m.szyprowski@samsung.com>
In-Reply-To: <20181017134159.9656-4-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 17 Oct 2018 16:29:15 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcMPz0wsEU9Lt1e0dp7tEk9+t8kteW=hih7sNsp99Dkkw@mail.gmail.com>
Message-ID: <CAJKOXPcMPz0wsEU9Lt1e0dp7tEk9+t8kteW=hih7sNsp99Dkkw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] clocksource: exynos_mct: Refactor resources allocation
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

On Wed, 17 Oct 2018 at 15:42, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Move interrupts allocation from exynos4_timer_resources() into separate
> function together with the interrupt number parsing code from
> mct_init_dt(), so the code for managing interrupts is kept together.
> While touching exynos4_timer_resources() function, move of_iomap() to it.
> No functional changes.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 49 +++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 49413900b24c..02ad55db390b 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -502,11 +502,14 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
>         return 0;
>  }
>
> -static int __init exynos4_timer_resources(struct device_node *np, void __iomem *base)
> +static int __init exynos4_timer_resources(struct device_node *np)
>  {
> -       int err, cpu;
>         struct clk *mct_clk, *tick_clk;
>
> +       reg_base = of_iomap(np, 0);
> +       if (!reg_base)
> +               panic("%s: unable to ioremap mct address space\n", __func__);
> +
>         tick_clk = of_clk_get_by_name(np, "fin_pll");
>         if (IS_ERR(tick_clk))
>                 panic("%s: unable to determine tick clock rate\n", __func__);
> @@ -517,9 +520,27 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>                 panic("%s: unable to retrieve mct clock instance\n", __func__);
>         clk_prepare_enable(mct_clk);
>
> -       reg_base = base;
> -       if (!reg_base)
> -               panic("%s: unable to ioremap mct address space\n", __func__);
> +       return 0;
> +}
> +
> +static int __init exynos4_timer_interrupts(struct device_node *np,
> +                                          unsigned int int_type)
> +{
> +       int i, err, cpu;
> +
> +       mct_int_type = int_type;

This does not look good. Before, assignment was done before call to
exynos4_timer_resources(). Now, if I follow the path correctly, it
will be after. Therefore the exynos4_timer_resources() will use wrong
value. This should pop up during tests.

Best regards,
Krzysztof

> +
> +       /* This driver uses only one global timer interrupt */
> +       mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
> +
> +       /*
> +        * Find out the number of local irqs specified. The local
> +        * timer irqs are specified after the four global timer
> +        * irqs are specified.
> +        */
> +       nr_irqs = of_irq_count(np);
> +       for (i = MCT_L0_IRQ; i < nr_irqs; i++)
> +               mct_irqs[i] = irq_of_parse_and_map(np, i);
>
>         if (mct_int_type == MCT_INT_PPI) {
>
> @@ -579,24 +600,14 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>
>  static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
>  {
> -       u32 nr_irqs, i;
>         int ret;
>
> -       mct_int_type = int_type;
> -
> -       /* This driver uses only one global timer interrupt */
> -       mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
> +       ret = exynos4_timer_resources(np);
> +       if (ret)
> +               return ret;
>
> -       /*
> -        * Find out the number of local irqs specified. The local
> -        * timer irqs are specified after the four global timer
> -        * irqs are specified.
> -        */
> -       nr_irqs = of_irq_count(np);
> -       for (i = MCT_L0_IRQ; i < nr_irqs; i++)
> -               mct_irqs[i] = irq_of_parse_and_map(np, i);
>
> -       ret = exynos4_timer_resources(np, of_iomap(np, 0));
> +       ret = exynos4_timer_interrupts(np, int_type);
>         if (ret)
>                 return ret;
>
> --
> 2.17.1
>
