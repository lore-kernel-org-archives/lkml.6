Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0B7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4A320652
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4A320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbeJLS5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:57:52 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41559 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJLS5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:57:52 -0400
Received: by mail-vs1-f66.google.com with SMTP id w1so11542255vsj.8;
        Fri, 12 Oct 2018 04:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KwtZp2SD3UzdJnSRMVX2E/VKmFYk6aXO2HZ1884zu8=;
        b=IGoNuoHSDsO3pw7cLmzHJZIgjHRq0sCtrwxff5ZxnOokw34n0dXIGOtWedxkg+uoki
         2R4FxGCQ/EThGzBPikzeOvvp9LxNUkbub4JaHQ57LU976ZDdKMgntJLeo99cZ+ujVvgP
         WlEkbYxsHUI6HfC9z7kJ2uyLuhTCtgXz6s9Vvbzdx9P0SPGedeVQAfjClJ6rTVZuKvHF
         8qeNR7Uini3UoLXY4YhLD6DnbwNlOke4/OUmqClwGVDOja/AQ2ywBBQP5nZcybhvqFjX
         eJYPINEcFG/kh+OA35q9r49tBUFLIW52y5qLdQy9zbtCtGaQfxbCYszz/VmvmxZ4hDk2
         fjzQ==
X-Gm-Message-State: ABuFfojD1KRu1i3g5fECKxOJUC0wsSUpHIKtlusfFQfhUUoEXTvEll2Q
        po8g57DtmNXIyZFxQyTycMvgJY/Vf7bsAbw6Ihw=
X-Google-Smtp-Source: ACcGV63L6/mNF+dfr7McIZztIgM4M8I0OA2iRxeOC1+xq6a5r9ephB7B6LH0TBbzRlZJqS6FPPKo45k945zL1kVIwXM=
X-Received: by 2002:ab0:6093:: with SMTP id i19mr2370779ual.75.1539343552344;
 Fri, 12 Oct 2018 04:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181011084249.4520-1-geert+renesas@glider.be>
 <20181011084249.4520-2-geert+renesas@glider.be> <20181012103901.pvyxvxv7v57zo5il@pathway.suse.cz>
In-Reply-To: <20181012103901.pvyxvxv7v57zo5il@pathway.suse.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Oct 2018 13:25:38 +0200
Message-ID: <CAMuHMdVA9=JsqEhYDzw_sW==mXqQffmH6L_R8=+0PD5PEsBvvw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Prepare for more general use of ptr_to_id()
To:     Petr Mladek <pmladek@suse.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Fri, Oct 12, 2018 at 12:39 PM Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2018-10-11 10:42:47, Geert Uytterhoeven wrote:
> >   - Make the ptr argument const, to avoid adding casts in future
> >     callers,
> >   - Move the function and its dependencies up, so it can be called from
> >     special pointer type formatting routines.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I have pushed the changes into printk.git,
> branch for-4.20-vsprintf-hash-fixes.
>
> Note that I have split it into two separate commits. The first one
> adds the const modifier. The second commit does a pure move of
> the code without any "hidden" changes. I forgot to ask for this
> when reviewing v1.
>
> You might see the result at
> https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/log/?h=for-4.20-vsprintf-hash-fixes

Thanks, looks good!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
