Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54396C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEEF2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQFpmpmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEEF2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeIYOzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:55:22 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34070 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeIYOzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:55:21 -0400
Received: by mail-it1-f195.google.com with SMTP id o72-v6so5685389ita.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jxgi2935BexNSO0XwcF0lp5n8KyZPq4LJLIGysjZJ+Y=;
        b=PQFpmpmYUk0afv6meLAGaRp8zHkJHu7gHljIJ5U2Pb1bUgpm1WuIsZjPw7oQba8ezq
         Rd/kf9IYkwW5jWqruO/mfPk39R549+hZ7IJ1tQTNOxoIkEt0VsS3878y1VpF8Hj2RZDN
         J1pGKXKP6dO6k3nX6XWX3G8fOlfScL+3poiPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jxgi2935BexNSO0XwcF0lp5n8KyZPq4LJLIGysjZJ+Y=;
        b=pdVQMJwrOh+Wa+xIwEwCXSmEyGdjjMxjoq7gzFvBWCa3fvqNLtF0t+5kmycg19Cm/B
         PDcGM3uELQJkmeWPBvgYGrrwOCRNIemJ/xEtkgkuZoI+HlkbB/yceDkO3wy7fYsfYrji
         +vcIblm49/gXsrJCYIPn3upddagMp/RU0YC54qEDQsZsjaAEfnko1EFXikTh8pPagJpl
         sqFH37YJSKTNVr7uQ/WDxFszXwjEI6iTfeF7sAcLBKjr1sar6b3lb++gdiTvBE7cZSwH
         0gW+ks+2IM3e6FJ5jlLho5E3cCtZO5cwA+U9gUv06JR1lP2cOcsgKhkDJlIZsO7hXSQd
         3jdg==
X-Gm-Message-State: ABuFfojjA9tZxnC1jUcxDtN0zHxFRicBmqFD32ejyAtznxEJsGOqmhSB
        iqiLRyGEJRpRO4p1hcrQzbN+uUYgMeqwqf7dLp5zYQ==
X-Google-Smtp-Source: ACcGV634303vyBvmH9uzwPsff/i3S3WBGi3wZqsZNUxWfhq/lbg6Rh5RRCzPdeXRgj0BZ/tptLn8vpiDd7kNyRs7dT4=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr1869621itd.130.1537865332320;
 Tue, 25 Sep 2018 01:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180921102546.12745-1-thierry.reding@gmail.com>
In-Reply-To: <20180921102546.12745-1-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Sep 2018 10:48:39 +0200
Message-ID: <CACRpkdbLoz+gSFa292OFNszeS6tNywpBRHyGwL9SK2u5s=UhZw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Implement wake event support on Tegra186 and later
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        ilina@codeaurora.org, Marc Zyngier <marc.zyngier@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

thanks for working on the wakeup business!

This patch gets me a bit confused on our different approaches
toward wakeups in the kernel, so I included Lina, Marc and Ulf
to see if we can get some common understanding.

On Fri, Sep 21, 2018 at 12:25 PM Thierry Reding
<thierry.reding@gmail.com> wrote:

> The following is a set of patches that allow certain interrupts to be
> used as wakeup sources on Tegra186 and later. To implement this, each
> of the GPIO controllers' IRQ domain needs to become hierarchical, and
> parented to the PMC domain. The PMC domain in turn implements a new
> IRQ domain that is a child to the GIC IRQ domain.
>
> The above ensures that the interrupt chip implementation of the PMC is
> called at the correct time. The ->irq_set_type() and ->irq_set_wake()
> implementations program the PMC wake registers in a way to enable the
> given interrupts as wakeup sources.
>
> This is based on a suggestion from Thomas Gleixner that resulted from
> the following thread:
>
>         https://lkml.org/lkml/2018/9/13/1042

I am not sure if you are aware about Lina's series
"Wakeup GPIO support for SDM845 SoC"
that is now in v3:
https://patchwork.kernel.org/cover/10587965/

It appears to me, though I am blissfully ignorant of the
details, that there is a relationship between this patch
series and the other one.

Your approach is to insert an hiearchical PMC irq controller
and Lina's approach is to simply put a mechanism on the
side to inject IRQs into the GIC after sleep (IIUC).

I guess your hierarchy is in response to this mail from tglx:
https://lkml.org/lkml/2018/9/14/339

So from a birds eye point of view I don't see how the Tegra
PMC irq controller and Qualcomm's PDC power domain
controller are conceptually different. Are you doing the same
thing in two different ways for the same problem space
here?

Or are these hardwares so very different that they really
warrant two different approaches to wakeups?

I guess I miss a bit of hardware insight... is the key difference
that in Qualcomm's PDC the IRQs need to be replayed/injected
by software while Tegra's PMC will do this in hardware?

Yours,
Linus Walleij
