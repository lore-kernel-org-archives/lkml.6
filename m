Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0365AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93A72082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93A72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeLKIWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:22:41 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43318 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeLKIWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:22:41 -0500
Received: by mail-vs1-f67.google.com with SMTP id x1so8335327vsc.10;
        Tue, 11 Dec 2018 00:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9/hmsRGEdefgYhVHTSwZCfJfZAjpuXMVO80BSy706s=;
        b=KfpIS9n1637qUkwV343ikak3oz+ctZisluV2AhbbfJwf9wspnAHLs20d9tvp+u4W13
         Qo3/AwYk7O5YjOyI507KppBGJxL+EkVqamvFg4aWluNeSvcJlifSc+4L1EoHW2iL0RqH
         lsSBG9Gsj2PfLvvQS7FMyY2MUQkOczHqAlx5yuCG99R6kR8ItGEID8wBBtagB4UYxn7P
         IJ5XBt+7a4GBehrJQ8aXaP31IcV/JcV+BUkC021IJm/+qt5Q8PkAmetnBZIESLnQudqv
         QgF76Xe1YlmBqH7qEXrfahHSPfHjygfXe3Xb2f5ZMHVC5zxHGYqXvV2pd5EXGpKPZq7j
         MsUg==
X-Gm-Message-State: AA+aEWZF9/m/FLzWzZzzr614aOrJ9srV/BZRAD+3q7bOHH6EXjIndZc4
        Un0LABj7bqOMJQdVeoovY77Kso4SsZIyBnwIDXk=
X-Google-Smtp-Source: AFSGD/XKI8ZTA7djbzd9I0Nto10D9+bCYn3Xv+HaEyUwTCST/E/cI5g0/+MiW9+AyFXaZ3zhD8Af3naPd9WJ+NSiDik=
X-Received: by 2002:a67:c202:: with SMTP id i2mr6170025vsj.11.1544516559148;
 Tue, 11 Dec 2018 00:22:39 -0800 (PST)
MIME-Version: 1.0
References: <20181210210033.3276054-1-arnd@arndb.de>
In-Reply-To: <20181210210033.3276054-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Dec 2018 09:22:26 +0100
Message-ID: <CAMuHMdU0fp5p1QoD=h6v=RW9V5NgMvhz-NpoK5_8NNsnMKtjhA@mail.gmail.com>
Subject: Re: [PATCH] ARM: shmobile: fix build regressions
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Dec 10, 2018 at 10:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
> A number of Kconfig options have become available now to random ARM
> platforms outside of ARCH_MULTIPLATFORM, which now causes Kconfig
> warnings, and other build errors when those select options that
> lack additonal dependencies, e.g.:
>
> WARNING: unmet direct dependencies detected for HAVE_ARM_ARCH_TIMER
>   Depends on [n]: CPU_V7 [=n]
>   Selected by [y]:
>   - ARCH_RCAR_GEN2 [=y] && SOC_RENESAS [=y]
>   - ARCH_R8A73A4 [=y] && SOC_RENESAS [=y] && ARM [=y]
>
> WARNING: unmet direct dependencies detected for SYS_SUPPORTS_EM_STI
>   Depends on [n]: GENERIC_CLOCKEVENTS [=n]
>   Selected by [y]:
>   - ARCH_EMEV2 [=y] && SOC_RENESAS [=y] && ARM [=y]
>
> Put the old dependency on ARCH_RENESAS back for the moment to restore
> the previous behavior.

Thanks, the build bots must be lazy or overloaded these days...
The ARM selects are indeed more troublesome than the ARM64 ones.

BTW, did you see issues with the ARM64 Kconfig symbol move too,
or is that mitigated by ARM64 always selecting GENERIC_CLOCKEVENTS?

> Fixes: 062887bf5ef7 ("ARM: shmobile: Move SoC Kconfig symbols to drivers/soc/renesas/")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
