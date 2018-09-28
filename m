Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191D4C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BBF21746
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BBF21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeI1NvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:51:07 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37876 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeI1NvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:51:06 -0400
Received: by mail-vk1-f194.google.com with SMTP id 79-v6so1202080vkm.4;
        Fri, 28 Sep 2018 00:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vXJ46Jq1KwO8GCgHRdai1f322NTD5EjOFGO+sDJtRE=;
        b=pDDIWEgDd3ruxMVKhdTlAl0SAHzKPKrJCvLgEOyLOUjq0sBBT9p+AE/suzZbmSA+e6
         E3Mr5tmth/LIzlMyKrgVTHrVtbr9qdWMlhfohV/Y+HpWzMXFkCbuM3mEzODtmKS3GIdx
         kaNCl3tkJJZbqlDZI9rPNQ/vPCFKd+wL9k52dAUeHdeQHWHjLX1pSYvfQLDAcEfcFNAY
         EJsm18Tt3134XKsyH5huV11KI/AALL6YxnfoB/408tDsqH8rw6bJ6O806WYJATFzayri
         ciBaWxk+Alwe+zoxvhOcrQRLkfa83Mkw0TCMJpw3Jzsv/l68PAttPzahBSeFykAjFiQA
         snDw==
X-Gm-Message-State: ABuFfojUVEeXxzMsAH7PusymRDlfcYUOQtbxiBLd8Ej3vgSI9lF9IPMW
        Y6oNH3yxRCumsbBThz8TgSn62pPt25ngSYEp9vM=
X-Google-Smtp-Source: ACcGV61nYXsqeSD3zDg2vzfkgDTzhVZtwqD5GzylMuzmKML93g+bvbwQj3F+QRT7WqsXerLj9d+289UuVjyyO3foZYU=
X-Received: by 2002:a1f:8b84:: with SMTP id n126-v6mr5082696vkd.74.1538119722379;
 Fri, 28 Sep 2018 00:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180928071414.30703-1-brgl@bgdev.pl> <20180928071414.30703-2-brgl@bgdev.pl>
In-Reply-To: <20180928071414.30703-2-brgl@bgdev.pl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Sep 2018 09:28:29 +0200
Message-ID: <CAMuHMdW7wAhQJ6tgB58sENrSV_GmxLZQvASg8B8UxP9UH7NmpA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] devres: constify p in devm_kfree()
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
> Make devm_kfree() signature uniform with that of kfree(). To avoid
> compiler warnings: cast p to (void *) when calling devres_destroy().

Hmm, devres_destroy(), devres_remove(), and find_dr() really should
take const void pointers.  But that requires changing dr_match_t, and
fixing up all users...

> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
