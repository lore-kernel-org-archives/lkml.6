Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC60C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD3E2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD3E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeK2IiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:38:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36572 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeK2IiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:38:15 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so27644577qtn.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 13:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAwgbzfjrplFZPtEfwcTtm1K91xj/h0NzY76QEOUON8=;
        b=VV4faYiWzWPyfs659C1r5byQWdb4n5U48VafRWF4eFMsb2g0D933sfYtuQpIDXddCx
         9QLBm4Bl9nIFgEngSk4lIX2eNSBPp2n7B/+1X7u59wDni5w6pvvs+ghqxnp3lUjOn9YW
         Vkc4h7Lj5rDRlmZChZlJUPJxmcB1eXWAeIh3QzCtU3X8KfTlVa2HnUB4jGb3QthheBTy
         IxDJhm0Kqgflg4tKGRlGmI5xhXw93IrhzH6stdouxFsmq9ImpwTmWD6zmsLRvQ0czODn
         XbZC3VH+foyLnJK2aXTJSkdgL+lx/dPIW3nMT/7TzG4KHpFX4Ejgxs2ED4XJ7bOCQo/N
         4ZWA==
X-Gm-Message-State: AGRZ1gLJHJEXA1Sf4enw9KMcP/z7KmxlCMZYssSvMafYcEPwaM+oBcg/
        hupuAIJr3SkbR/xTTPVnclJF3Ohca9TNWbAwljCnOA==
X-Google-Smtp-Source: AFSGD/Vga/5LRGPmxj8WUdiGslZzLE+x8fkCUoOUNrY/KJbf9nOZuofnbNQ5Vxqgply+kPogx8SeGXjWfcXZEb0mrjM=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr36228458qtl.343.1543440913564;
 Wed, 28 Nov 2018 13:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20181128175324.163202-1-lkundrak@v3.sk> <20181128175324.163202-15-lkundrak@v3.sk>
In-Reply-To: <20181128175324.163202-15-lkundrak@v3.sk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Nov 2018 22:34:57 +0100
Message-ID: <CAK8P3a2=itOMfHax1rpJEUKfBKeU=-hPnn1yA3V4r3Q9Hfhz8g@mail.gmail.com>
Subject: Re: [PATCH v4 14/20] ARM: mmp/mmp2: use cpu_is_pj4() instead of cpu_is_mmp2()
To:     lkundrak@v3.sk
Cc:     arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pavel Machek <pavel@ucw.cz>, quozl@laptop.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 6:54 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> The MMP2 platform uses the PJ4 CPU. The cpu_is_mmp2() macro is thus
> actually not useful at all and moreover gives the wrong result on
> MACH_MMP2_DT.
>
> The actual problem I aim to fix is that on a device-tree enabled system,
> the timer ends up being initialized incorrectly. In fact, it ticks like
> at rate that's 1/100 slower or so.
>
> Perhaps the other cpu_is_mmp2() uses are more benign, but still useless.

I think we still need the helper. If it's broken on some platforms,
it has to be fixed instead.

> @@ -104,7 +104,7 @@ void __init mmp2_init_irq(void)
>
>  static int __init mmp2_init(void)
>  {
> -       if (cpu_is_mmp2()) {
> +       if (cpu_is_pj4()) {
>  #ifdef CONFIG_CACHE_TAUROS2
>                 tauros2_init(0);
>  #endif
> diff --git a/arch/arm/mach-mmp/pm-mmp2.c b/arch/arm/mach-mmp/pm-mmp2.c
> index 17699be3bc3d..bcd5111ffb37 100644
> --- a/arch/arm/mach-mmp/pm-mmp2.c
> +++ b/arch/arm/mach-mmp/pm-mmp2.c
> @@ -220,7 +220,7 @@ static int __init mmp2_pm_init(void)
>  {
>         uint32_t apcr;
>
> -       if (!cpu_is_mmp2())
> +       if (!cpu_is_pj4())
>                 return -EIO;
>
>         suspend_set_ops(&mmp2_pm_ops);

These are both regular initcalls. On a multiplatform kernel, they
will be called unconditionally, and the cpu_is_mmp2() has to
guard code that would be wrong on other SoCs, including those
with a pj4 CPU (Armada XP, Dove, Berlin).

> diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
> index 96ad1db0b04b..0f49ac579a17 100644
> --- a/arch/arm/mach-mmp/time.c
> +++ b/arch/arm/mach-mmp/time.c
> @@ -163,7 +163,7 @@ static void __init timer_config(void)
>
>         __raw_writel(0x0, mmp_timer_base + TMR_CER); /* disable */
>
> -       ccr &= (cpu_is_mmp2()) ? (TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
> +       ccr &= (cpu_is_pj4()) ? (TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
>                 (TMR_CCR_CS_0(3) | TMR_CCR_CS_1(3));
>         __raw_writel(ccr, mmp_timer_base + TMR_CCR);
>

This looks correct, here we just need to ensure we are not on pj1.
Note: we should probably rename 'timer_init' to something that
that has 'mmp' in the name, the current name conflicts with
a function of the same name in mach-davinci, which is not yet
multiplatform, but hopefully will be one day.

        Arnd
