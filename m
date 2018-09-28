Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6FAC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4CF2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4CF2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeI1Nwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:52:32 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39698 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbeI1Nwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:52:31 -0400
Received: by mail-ua1-f68.google.com with SMTP id g18-v6so1944413uam.6;
        Fri, 28 Sep 2018 00:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SvDJWhADNTW4PbwYWDSAhs+DaKaGiN8JD3vzzJTkwMA=;
        b=eZEwWSgGtaS/2XTaG3HETNWxQ5b9yrDhLGgU/oRiKug9SdlVihct/5UwhJQPr1e+kz
         x8KZQItbHtctUW5Nxn74fpMUdJIcgcSDUhUMV0jlgrhRogX9ptfafYOf086cM15B0BBk
         RQIQ60Mj91z5fm4pm88cyyFRlLARmI1jkxg7T5LcAUeXIBe7xn20A+WrSKhuAmWznHD1
         Uv6QFPhko4yrTaqz5CWc1OTTssw5aTTBzlyPwnpC9PXcoorBOC/XUuC2Wu3klDFscJ70
         KhNuHM3kV8/R+jDMZ7bmJ3JorGdjqSwWC7HZ9ja2EuVGiWrFd6KAkDfbPMSectSzu3ff
         2acw==
X-Gm-Message-State: ABuFfoh59VfTjHl2IKCm+cmCLWqlksYsYt8kWnQRYLZC0+vv5A2lp6nX
        hJG88SFAYZ+2ovY5CHGFaOT503NQntrg5tcCH6w=
X-Google-Smtp-Source: ACcGV615uB7qMSOyBE83cYsEl4jlgwl0h9svGsqz4T1eNBSZ4shm0o3qhrn7/GswIlDbwuYotebJtCsEoDfWNqRRHms=
X-Received: by 2002:a9f:35f1:: with SMTP id u46-v6mr5447827uad.20.1538119806802;
 Fri, 28 Sep 2018 00:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180928071414.30703-1-brgl@bgdev.pl> <20180928071414.30703-3-brgl@bgdev.pl>
In-Reply-To: <20180928071414.30703-3-brgl@bgdev.pl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Sep 2018 09:29:55 +0200
Message-ID: <CAMuHMdXC+07PH+dhq-knno1rx+1vXm4BiFX9WPmfcTt4WNGNNA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] mm: move is_kernel_rodata() to asm-generic/sections.h
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
> Export this routine so that we can use it later in devm_kstrdup_const()
> and devm_kfree_const().
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
