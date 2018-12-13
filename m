Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006C2C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD54B2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ct1Q7AGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD54B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbeLMSP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:15:58 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55962 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbeLMSP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:15:58 -0500
Received: by mail-it1-f195.google.com with SMTP id o19so5049436itg.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 10:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jetzu+LmyuhNP24jLyn9ZDS6DIpioEtZ8VCdsw+GJp0=;
        b=ct1Q7AGY6IwhPHqOYTKglRnpj651ELLful6lDbHfk+KpW9heTdPSvnmuizaVQmvXac
         iehMr4FEaxwzdLa6ELHAJC/X2wO/EEBUM/qHDe65ElhwGpsTd772XVwyJ03qG2JldT6S
         ced1xpxA4sQ7rGJJdNDlTOE25eXcw0kLz9WJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jetzu+LmyuhNP24jLyn9ZDS6DIpioEtZ8VCdsw+GJp0=;
        b=YSKNmErivc1iFysIN3nMU3Yf1nC4O7Lz4TfYvHO8m+ZKCyIrOfng9px+aptAa4C4gd
         6aFcu7BTzSdVwh5gDnXYeoe6Bf5EkGTZ0WBhi4zLj4eGwbNvAbwKgzaE4M3ND4zN41Ip
         k6pVnVAJUU24Ps1Y8K95RLyQppvyMwqVKv7qoWPrXd5RmPEEa7KSybbX7xngg5+rnEBF
         GN1C0OaRoMavtZTACSGrK8+q45ziyi6zvuSq4UtAYx6N1bTXo/SRk9hxMjWkA+AvGQi7
         fxPyP9eoaGzb9blTtUPpS602LXJwjFTnFTHpEUJj3+ak3q/RQAwZ03J8snRlkgQE/EMy
         8ltw==
X-Gm-Message-State: AA+aEWZi6vsOL3mSuv1wlBtMxk4XimsXS2bGrz8bt9cQDRsupgY3vSKM
        ws0dNwr62VlAw1LEo/f/VgGCDJGE9ebXu7+5o2gxQA==
X-Google-Smtp-Source: AFSGD/XYXxOncnYj23T+mXnL15S7NTjOEh+U2xrb+DnRjGIM9mM+RxWtNB13y6mOqadMs1rfxTmzpqWoWLYTCdADI44=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr23695567jab.2.1544724957185;
 Thu, 13 Dec 2018 10:15:57 -0800 (PST)
MIME-Version: 1.0
References: <1544612209-13660-1-git-send-email-miles.chen@mediatek.com> <20181213181317.GD18185@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181213181317.GD18185@edgewater-inn.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 13 Dec 2018 19:15:45 +0100
Message-ID: <CAKv+Gu_40M=JO+P3GOJogXfm=x0JXYjHs=rHWAtR-6QNxjSYvA@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: print PHYS_OFFSET in dump_kernel_offset()
To:     Will Deacon <will.deacon@arm.com>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 at 19:12, Will Deacon <will.deacon@arm.com> wrote:
>
> [+Ard because I'll basically go with his preference on this one]
>
> On Wed, Dec 12, 2018 at 06:56:49PM +0800, Miles Chen wrote:
> > When debug with kaslr, it is sometimes necessary to have PHYS_OFFSET to
> > perform linear virtual address to physical address translation.
> > Sometimes we're debugging with only few information such as a kernel log
> > and a symbol file, print PHYS_OFFSET in dump_kernel_offset() for that case.
> >
> > Tested by:
> > echo c > /proc/sysrq-trigger
> > [   11.996161] SMP: stopping secondary CPUs
> > [   11.996732] Kernel Offset: 0x2522200000 from 0xffffff8008000000
> > [   11.996881] PHYS_OFFSET: 0xffffffeb40000000
> >
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > Tested-by: Miles Chen <miles.chen@mediatek.com>

Fine with me, but I would like to see an ack from Miles Chen :-)

> > ---
> >  arch/arm64/kernel/setup.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index f4fc1e0544b7..4b0e1231625c 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -388,6 +388,7 @@ static int dump_kernel_offset(struct notifier_block *self, unsigned long v,
> >       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && offset > 0) {
> >               pr_emerg("Kernel Offset: 0x%lx from 0x%lx\n",
> >                        offset, KIMAGE_VADDR);
> > +             pr_emerg("PHYS_OFFSET: 0x%llx\n", PHYS_OFFSET);
> >       } else {
> >               pr_emerg("Kernel Offset: disabled\n");
> >       }
> > --
> > 2.18.0
> >
