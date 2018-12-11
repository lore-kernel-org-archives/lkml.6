Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBE8C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569AD2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569AD2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbeLKKJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:09:12 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45781 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeLKKJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:09:11 -0500
Received: by mail-qk1-f195.google.com with SMTP id y78so8211638qka.12;
        Tue, 11 Dec 2018 02:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDSdrMM5bBz6Iqfcx8J9M/ABMO6lf3JX9eobabQHXUw=;
        b=kFi4iZCDtnHPuucvUnivQbNxJZs3wnOlgxOzr8nurV0IQFDyAhaIwMDfHaoGSaGta+
         phLqhezf66cbkSxx369g1kPLuY0apwm4pxvTYYWBl/6qGZOyMb9y0pzJDeCX3NMoABAz
         d9QYSZ3+/9MTQFdKGzTvT0fkpDKrSQct4mrHkBzoCUeQQakbG79eBqLLV9RyEE2YK+Oo
         6GcwSePo8dcMDYduRZy6yCk46jMWuxRqwV0H+AAcX95fHT3dswQWy3yWW1EXNebnQ8Aj
         UZyWWFNIhaKRHLhdc3kY2jHOXtm8mZmQ0lcFhqmoB7Zn6IRr5AvEjKYyd34YfLtW2kkv
         Zzng==
X-Gm-Message-State: AA+aEWZpHVJXcTrZYAhPsB8km0XTlgdpyIjBtft61XU3fEI11Z+YmDU5
        l22Mq4Rq7mKQvn6sgFEaBCHw6QC7YG1XyNXR6Gc=
X-Google-Smtp-Source: AFSGD/XqaoKboLmI7ss0whDbYHdUl3wq+V09AJ5WV+WAnEJnoc1+eBQaDI9nZ1TqR4V+zO4Bkd2hkiMB7cuI0mFsYg0=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr13682397qkf.330.1544522950912;
 Tue, 11 Dec 2018 02:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20181210215856.2238253-1-arnd@arndb.de> <20181210215856.2238253-2-arnd@arndb.de>
 <20181211100550.GD14426@ulmo>
In-Reply-To: <20181211100550.GD14426@ulmo>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Dec 2018 11:08:53 +0100
Message-ID: <CAK8P3a1zbmYMFZB8R+rs=vdJY=KNqgRPBCQNO91LcSSTR0O03Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: tegra: avoid section mismatch warning
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     arm-soc <arm@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:05 AM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Mon, Dec 10, 2018 at 10:58:37PM +0100, Arnd Bergmann wrote:
> > WARNING: vmlinux.o(.text+0x39ecc): Section mismatch in reference from the function tegra114_gic_cpu_pm_registration() to the (unknown reference) .init.rodata:(unknown)
> > The function tegra114_gic_cpu_pm_registration() references
> > the (unknown reference) __initconst (unknown).
> > This is often because tegra114_gic_cpu_pm_registration lacks a __initconst
> > annotation or the annotation of (unknown) is wrong.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm/mach-tegra/irq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> I'm not seeing these. Do I need to enable any special options to trigger
> these? Or are these just so new that I haven't run into them yet?

My guess would be that this is a result of the CONFIG_NO_AUTO_INLINE
option that is now available in linux-next.

       Arnd
