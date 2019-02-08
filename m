Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D851C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645FB2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfBHSzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:55:49 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37800 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfBHSzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:55:49 -0500
Received: by mail-vs1-f68.google.com with SMTP id s16so2738778vsk.4;
        Fri, 08 Feb 2019 10:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f61cwLrdFDvWDcPfkag69gux4j1k/vsAch0XX1ifjVE=;
        b=fKD4Bz8sZPFbi2evLgYGzKU1nLf6FI7LcNbhxz2iO7J2FAf3H0y0H9p4pmHOcpnU4S
         NrbLyJuxdKu9p+LXDJz2Yvtd5f1YcdcugTg5LwE274MKdP1qMzJhTHq3zTiqk1o8Iz2L
         lZKMo1RhcJozt/Zm+EBdU+sXLwe/urExbisTOOI9W00m/37YHLcN4nYfzI9m4U1LVVp1
         7FZzKBIuRbWiYXMUJgapUOEZKBYh6MgZy8H10m+917rqJfPHOLdOmeqUjTCxJLxtH7XU
         yhcamyT4yWQWXamarOLUkj1UXtbPv7e3NlPXy5nNfu7GOeybMVGy0TRUEA/C+F+TIJ7T
         BQvg==
X-Gm-Message-State: AHQUAubLtldD/3jgVic9icBeEASszDwL0jkxazeBS7vGnHSh1AcGXsRb
        t/z3o5TNSHp6svYI0lZti4LvgZir8re9jSpkMao=
X-Google-Smtp-Source: AHgI3IaRK3MtMkGTGISomWxB18I0In+4ZKMz+zuiS6KmxlUba/ZclgIgxCKKCfF9lJbpsQnUMR6sQXX7sbWPVRJ8YT4=
X-Received: by 2002:a67:f43:: with SMTP id 64mr9783331vsp.166.1549652147985;
 Fri, 08 Feb 2019 10:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20190207193653.18221-1-geert+renesas@glider.be>
 <20190208164019.GY32526@8bytes.org> <fa781547-7fa8-cb1a-50bd-d18351c02afd@arm.com>
In-Reply-To: <fa781547-7fa8-cb1a-50bd-d18351c02afd@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Feb 2019 19:55:36 +0100
Message-ID: <CAMuHMdV6T8EsLZaiM-=M=fRPuDXt05aXg6egmMBr6Sc9V39iKA@mail.gmail.com>
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Fri, Feb 8, 2019 at 6:55 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 08/02/2019 16:40, Joerg Roedel wrote:
> > On Thu, Feb 07, 2019 at 08:36:53PM +0100, Geert Uytterhoeven wrote:
> >> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> >> index 8ac10af17c0043a3..d62487d024559620 100644
> >> --- a/drivers/base/dd.c
> >> +++ b/drivers/base/dd.c
> >> @@ -968,9 +968,9 @@ static void __device_release_driver(struct device *dev, struct device *parent)
> >>                      drv->remove(dev);
> >>
> >>              device_links_driver_cleanup(dev);
> >> -            arch_teardown_dma_ops(dev);
> >>
> >>              devres_release_all(dev);
> >> +            arch_teardown_dma_ops(dev);
> >>              dev->driver = NULL;
> >>              dev_set_drvdata(dev, NULL);
> >>              if (dev->pm_domain && dev->pm_domain->dismiss)
> >
> > Thanks for the fix! Should it also be tagged for stable and get a Fixes

FTR, Greg has added it to driver-core-testing, with a CC to stable.

> > tag? I know it only triggers with a fix in v5.0-rc, but still...
>
> I think so:
>
> Fixes: 09515ef5ddad ("of/acpi: Configure dma operations at probe time
> for platform/amba/pci bus devices")

Thanks! It won't backport cleanly due to commit dc3c05504d38849f
("dma-mapping: remove dma_deconfigure") in v4.20, though.

> There aren't many drivers using dmam_alloc_*(), let alone which would
> also find themselves behind an IOMMU on an Arm system, but it turns out
> I actually have another one which can reproduce the BUG() with 5.0-rc.

SATA core uses dmam_alloc_*().

> I've tried a 4.12 kernel with a bit of instrumentation[1] and sure
> enough the devres-managed buffer is freed with the wrong ops[2] even
> then. How it manages not to blow up more catastrophically I have no
> idea... I guess at best it just leaks the buffers and IOMMU mappings,
> and at worst quietly frees random other pages instead.

May depend on the actual ops, and whether CMA is used or not.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
