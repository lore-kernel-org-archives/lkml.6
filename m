Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC28FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8D82086D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfBTPoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:44:10 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33243 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfBTPoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:44:10 -0500
Received: by mail-ua1-f66.google.com with SMTP id q17so8409680uam.0;
        Wed, 20 Feb 2019 07:44:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKmoKFPA+ZYy/hUAI9OFMS9xv1Mzt2jaoQIoF31S6y0=;
        b=V7XXofknQ8VS1LByZliI2FpHtTTAK4jwEzA2Q/XslXGmBrMYajpAAJLwOo9QFH1km0
         vtmLE0HfFmLnZjoyJwiFhZbsYhJUsKjrYOzXjD4LMZSgM32fYK+m2hIIRa6SvNugmscy
         cQKNeHUNPNdJOpj1zX/QJIx0PWS1xjJXtf6EVIi8kB5KRhXamwMFC1/wbKXYgVt5Kr+Y
         aXfdg4pILy5aFWPFIpwIz3d5zwDSr4bDQtbKVEXhochtURbRq1Lwb3+C/n7IXasYsBAv
         BAXGHZUe2xq+5vDif0PDZj4R3PJWYQPezQVrTLgjmnSb/jVeZjjNgOlx0GKhdEjg6MHv
         gPVg==
X-Gm-Message-State: AHQUAube89n0eFwihsOTuojgsjGCi0PXSvhIcAdcBFzoVu5sjvf6kfjw
        MvUirs6u/aXmhLE4XjiezTs9eJG55rLX8ZGuiOk=
X-Google-Smtp-Source: AHgI3IZemqvmtUQmDtv+AEwAzyJFUptDh9qgqIdF58cHBYQyxtA4tkkGAYOjiEG2C6d7YUIi4NaQ5mmAENhgM/2OFi4=
X-Received: by 2002:a9f:2f0b:: with SMTP id x11mr10966485uaj.78.1550677449039;
 Wed, 20 Feb 2019 07:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-7-geert+renesas@glider.be> <20190220153533.GH3516@pendragon.ideasonboard.com>
In-Reply-To: <20190220153533.GH3516@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Feb 2019 16:43:57 +0100
Message-ID: <CAMuHMdUo+XtRiNY_nOW8ZgCGFVo3au1=0Q7L2nU29QcPYVkgNg@mail.gmail.com>
Subject: Re: [PATCH 6/7] iommu/ipmmu-vmsa: Extract hardware context initialization
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, Feb 20, 2019 at 4:35 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, Feb 20, 2019 at 04:05:30PM +0100, Geert Uytterhoeven wrote:
> > ipmmu_domain_init_context() takes care of (1) initializing the software
> > domain, and (2) initializing the hardware context for the domain.
> >
> > Extract the code to initialize the hardware context into a new subroutine
> > ipmmu_context_init(), to prepare for later reuse.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/iommu/ipmmu-vmsa.c | 91 ++++++++++++++++++++------------------
> >  1 file changed, 48 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index 0a21e734466eb1bd..92a766dd8b459f0c 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -404,52 +404,10 @@ static void ipmmu_domain_free_context(struct ipmmu_vmsa_device *mmu,
> >       spin_unlock_irqrestore(&mmu->lock, flags);
> >  }
> >
> > -static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
> > +static void ipmmu_context_init(struct ipmmu_vmsa_domain *domain)
>
> ipmmu_context_init() vs. ipmmmu_domain_init_context() is confusing. You
> could call this one ipmmu_domain_setup_context() maybe ?

Thanks, that name was actually on my shortlist, and may make most sense.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
