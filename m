Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878F1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAB620861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAB620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbeIFRtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:49:10 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46977 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeIFRtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:49:09 -0400
Received: by mail-ua1-f66.google.com with SMTP id u11-v6so8624621uan.13;
        Thu, 06 Sep 2018 06:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMi1fiXiQnlIIm20vOCO9Ai8Uq3ouuXvA0TXGEkRtWI=;
        b=Xes3LWUQnZ6CgDlA66he0sqJs0m1Vszw+990zDeqWWaXIkry/rqWbwOjNI3NaQrBcp
         nX5Go7RoBdcBbKUbiaaTdT7K8wVLom9WjOu0xZRnLT2M5FdqOyg5hFYxVHs2RS1ZcgQu
         Kvwn1qAdn7iv8kCGrXj8WhIqnjs9J2g/eZ3x+vt8ASFOEOch/ck4Skdn7mOw9vxvXg5T
         BOWhEgQ7Vcm5bJWUDZHTuvfdYh+6ssvDCPHpbfxA5GW9cu0Ewhv1NwadcaJwPrZMn0sr
         HzmwY1ofm6apdgeE8tNTdeH+DjoNxVJN8uN2aS0L0PY5CMvzfL9HHkYzHf+ou74S43e3
         XbHA==
X-Gm-Message-State: APzg51AQetM5dDygc3RxfdK8YHtWVXVvrpUyoInrCjKtk+MhZod+57WR
        773lqjudZr3eUyshxjXZ7udmw01A2cF8mcnRyxc=
X-Google-Smtp-Source: ANB0VdYuqCPS7oaEhD1Dhm+ONl2xMkVrLOAfak+ENZyqTtq8kbfKHRpXGNztfm83TJckkur/vwiRQaXO49LIfMpP+2Y=
X-Received: by 2002:ab0:60ae:: with SMTP id f14-v6mr936720uam.153.1536239621198;
 Thu, 06 Sep 2018 06:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180905090555.9888-1-geert+renesas@glider.be> <CACRpkdZMD-GJUtcSiP30Rb-XAR6OHXZvdmEgOY-CxgauDGvViQ@mail.gmail.com>
In-Reply-To: <CACRpkdZMD-GJUtcSiP30Rb-XAR6OHXZvdmEgOY-CxgauDGvViQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Sep 2018 15:13:28 +0200
Message-ID: <CAMuHMdUgEqLxWPaE_G7YUGUmTteAW29Lqtnvgp=JRXOrJA-gxA@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpio: Fix VLA removal fallout
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Sep 6, 2018 at 3:01 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Sep 5, 2018 at 11:23 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > This patch series fixes various (mostly harmless) issues introduced by
> > commit 3027743f83f867d8 ("gpio: Remove VLA from gpiolib").
> >
> > As per the "one patch should fix one issue"-policy, this series contains 3
> > patches, although they all have the same Fixes: tag.
> >
> > W.r.t. propagating errors: while gpiod_set_array_value_complex() and its
> > callers can now return an error code, this is currently limited to -ENOMEM.
> > Actual failures setting a GPIO output value cannot be propagated, as
> > gpio_chip.set() still returns void.  Do you want to change that?
> > E.g. gen_74x164_set_value() can fail.
> >
> > Feel free to fold patches if deemed appropriate.
>
> What I want to know is if these patches drive a truck through Janusz patch
> set augmenting the array functions that I definately also plan to merge for
> this kernel cycle.
>
> Issues should be fixed of course, but if some of them already disappear
> if I apply Janusz patches, I'd rather postpone ... is it going to be hard
> to redo the cleanups on top of his patches?

I can respin afterwards. Just a few changed lines of context.

One question is if the stable team plans to backport the VLA removal (and
my fixes) or not...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
