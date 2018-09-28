Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8769C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F2B2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F2B2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbeI1NxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:53:22 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39725 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbeI1NxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:53:22 -0400
Received: by mail-ua1-f65.google.com with SMTP id g18-v6so1945140uam.6;
        Fri, 28 Sep 2018 00:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vb9KxwKwUpFp0CNrTOJ8oE1hB/VayTuRzsKtIl+2dw=;
        b=SQhF9N2CMQkC/gZ74iMP5kcFPK3jwyxmIGO70voeGtWAEvAKWIhtZo0mMkQr+4zH9v
         2hWhe98xiQXFUrFb/7VskHiGAOshauyCEpur91CGFBSDHNLlW31fpNlDq2a4LrsiC956
         vQygNxJDdmaokfZ8C/rtQVbnO3dX1s/NWlZ+P2nkyjCrDL1VX3EO0k+tpw7aKvnumoVc
         pD2akeK8FqK9hoZ0m9XY3FMLFeqNRUQrOpEHwnSs2xgRPj1p8KhpYIbODDqhnjkeiSoL
         4C9xAebOdsM6Kqf4kP5eu7NwMpPTwy0QstBNqKPEaV1INVYkMvnWMP+JFCExImU5tRtP
         KyLA==
X-Gm-Message-State: ABuFfojVgSgDiGQXudgweZkRcb5NikrJp7ViisOlvZ/B41vTzuahZ8Wk
        8OnxyeJDJ47WEAH/roQLkS2NVf9I7qimCJ99ors=
X-Google-Smtp-Source: ACcGV60Vnax4Q9ba0ceQ7Vc3k1hnUJZ2+UU6nNrVotBgD1euvB+633bKApD3tm2uylfvBCk+iJc2L18W8zV5naUljxo=
X-Received: by 2002:ab0:5a25:: with SMTP id l34-v6mr5212527uad.75.1538119857038;
 Fri, 28 Sep 2018 00:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180928071414.30703-1-brgl@bgdev.pl> <20180928071414.30703-4-brgl@bgdev.pl>
In-Reply-To: <20180928071414.30703-4-brgl@bgdev.pl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Sep 2018 09:30:45 +0200
Message-ID: <CAMuHMdVF9zD+KZ8E1-BCrn4W2QngABHqnCajOhk3Y=xpq4R=Cg@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] devres: provide devm_kstrdup_const()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 9:14 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> Provide a resource managed version of kstrdup_const(). This variant
> internally calls devm_kstrdup() on pointers that are outside of
> .rodata section and returns the string as is otherwise.
>
> Make devm_kfree() check if the passed pointer doesn't point to .rodata
> and if so - don't actually destroy the resource.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
