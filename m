Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41FBC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5FB2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfBTPm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:42:29 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44158 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfBTPm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:42:29 -0500
Received: by mail-vs1-f65.google.com with SMTP id r201so14178893vsc.11;
        Wed, 20 Feb 2019 07:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQfSrSQYfYUqGoyytm7wx+3kzkjNa93b77XBbf1Zuyw=;
        b=lXYVhjhfpQqKtYp7k0zMpH0NnIFXz5A/RcZCPtQi7+z1Iz8jynG56qjfMvwZ6zy9KQ
         xkI2SU6qfVRqXI4rLSt1IoASIsWSI2dfYRWzwAUsGcEUcKwQA7tC/s8QOv/c4lHl1UQ5
         LuFXi4/wkXQbIYR18qGE/TB40ZEvgbgPqapi4oUwF+zdBosKpCM4vtzk6nwK2Nyp7Bkm
         7WpKxmgjfQX4gull9W/Fg8bxYlEgCophXILuiUxN08OzJ1Xnq2Mg7pxl3OucKTYNo8J3
         6UsoQmC+PB/1+q/NMU05qUGS8tpnwtjb3m5Z9OMNh7pO5sWnd0vLOJp7QOU05HQoN0hI
         Ln0w==
X-Gm-Message-State: AHQUAuaKMnn5GJ8ZIhq0wXb3Ab9mVcPGUXiPbsMRo1O9jtCa5m2d3li+
        ZqAYWLDW8cmdAMR9mNc7qzjJyrIvyUJBYFdOrpTe4pRS
X-Google-Smtp-Source: AHgI3IZwqlpHCv3pdsNrKF21K3hFnc7CVrgreKS1aZbeJRgG6r3iXDNEgzeZFfU/16pOFMCrRNLS2zz81dVB0Vn8UGU=
X-Received: by 2002:a67:8588:: with SMTP id h130mr3894664vsd.11.1550677348007;
 Wed, 20 Feb 2019 07:42:28 -0800 (PST)
MIME-Version: 1.0
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-4-geert+renesas@glider.be> <20190220153057.GF3516@pendragon.ideasonboard.com>
In-Reply-To: <20190220153057.GF3516@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Feb 2019 16:42:15 +0100
Message-ID: <CAMuHMdWkQ918Y61tMJbHEu29AGLEyNwbvZbSBB-RRH7YYUNRcA@mail.gmail.com>
Subject: Re: [PATCH 3/7] iommu/ipmmu-vmsa: Prepare to handle 40-bit error addresses
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

On Wed, Feb 20, 2019 at 4:31 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, Feb 20, 2019 at 04:05:27PM +0100, Geert Uytterhoeven wrote:
> > On R-Car Gen3, the faulting virtual address is a 40-bit address, and
> > comprised of two registers.  Read the upper address part, and combine
> > both parts, when running on a 64-bit system.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Apart from this, the driver doesn't support 40-bit IOVA addresses yet.
> > ---
> >  drivers/iommu/ipmmu-vmsa.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index ac70cb967ff821c6..4d07c26c97848b65 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -186,7 +186,9 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
> >  #define IMMAIR_ATTR_IDX_WBRWA                1
> >  #define IMMAIR_ATTR_IDX_DEV          2
> >
> > -#define IMEAR                                0x0030
> > +#define IMEAR                                0x0030  /* R-Car Gen2 */
> > +#define IMELAR                               IMEAR   /* R-Car Gen3 */
>
> I would have defined that as a single macro.

Fair enough.

> > +#define IMEUAR                               0x0034  /* R-Car Gen3 */
> >
> >  #define IMPCTR                               0x0200
> >  #define IMPSTR                               0x0208
> > @@ -521,14 +523,16 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
> >  {
> >       const u32 err_mask = IMSTR_MHIT | IMSTR_ABORT | IMSTR_PF | IMSTR_TF;
> >       struct ipmmu_vmsa_device *mmu = domain->mmu;
> > +     unsigned long iova;
>
> Isn't there a more appropriate type, such as dma_addr_t possibly ?

Good question! Thanks for opening the can of worms ;-)

I used "unsigned long", as that's what the "iova" parameter of
report_iommu_fault() (called in this function) takes.

However, dma_addr_t would probably be a better choice.

Note that most iommu_ops methods take unsigned long, except for
.iova_to_phys(), which takes dma_addr_t.
Also, all io_pgtable_ops methods take unsigned long, including
.iova_to_phys().

The latter is interesting, as several IOMMU drivers forward the iova
received in their iommu_ops.iova_to_phys() methods to
io_pgtable_ops.iova_to_phys(), thus truncating the value on e.g. arm32
with LPAE.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
