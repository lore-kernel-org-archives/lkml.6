Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81A1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1F8217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbeLTPmd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:42:33 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:42891 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbeLTPmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:42:31 -0500
Received: by mail-vk1-f194.google.com with SMTP id y14so470648vky.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 07:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tHQnhEmeNAkhfMiX5dm+pc4968Yh2EmyfSDMadQr4KU=;
        b=G15LryuEzwKxSJgAq6U3IpngjFb394sRdG52H+7RQcgtV+J8FoO8Trzs0LrMyT/r8p
         NaE1b9AUz4dGAKuHopvfDuGnU2SttHJtE5/DH9vrn5PGBaa3Oa35FNN/eZh43HT4W1xH
         Y+EUP+T1ABWM3aIt988zTKKjqYeB9KUhX1cPbidJDFXp1InjqZs4KuyQy03oUnW2HzKT
         OXobMTN6DCxoi6aKZp13sRBRG2d978abpXb0fo61y7HWD75qUZH2R6nQ8o+3EquMARgP
         QLnD1JAq/GGpWMtGS9SmCk9xLINDJLqyZjbiFiqgQbNLmlcfdmcfGmR+29UlL2lFmrS+
         1smQ==
X-Gm-Message-State: AA+aEWaXAzNYOY8aAkYomDTwvAObpRTzBihiSWUzzk5s4yIEZJD8kO4+
        pgh5CCJsTNksbNQi8MDWC9ej3n5tl+SiyNFN0a0=
X-Google-Smtp-Source: AFSGD/W9y0+JF2fO7Q92lGcmeA3Ba1SrzGbyMudAJGbf750QDrt3V0qtbKEISY/Ax9DQLCPNPnhHn2+VQe+G2lyFxTo=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr11841962vkh.65.1545320549416;
 Thu, 20 Dec 2018 07:42:29 -0800 (PST)
MIME-Version: 1.0
References: <20181211150513.15161-1-joro@8bytes.org> <CGME20181211150640epcas5p4ffdd63a1900ebfe4a04eea24d2c86de6@epcas5p4.samsung.com>
 <20181211150513.15161-4-joro@8bytes.org> <30d86186-e0a2-2be1-2295-20510fbd74ba@samsung.com>
 <20181219143451.GY16835@8bytes.org>
In-Reply-To: <20181219143451.GY16835@8bytes.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Dec 2018 16:42:17 +0100
Message-ID: <CAMuHMdXr5tVuWf4dJzBLRfdqpMCMBSg-+t35nb=Rmh9PM=abJg@mail.gmail.com>
Subject: Re: [PATCH 3/4] iommu/of: Don't call iommu_ops->add_device directly
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörg,

On Wed, Dec 19, 2018 at 5:51 PM Joerg Roedel <joro@8bytes.org> wrote:
> On Wed, Dec 19, 2018 at 10:54:18AM +0100, Marek Szyprowski wrote:
> > On 2018-12-11 16:05, Joerg Roedel wrote:
> > > From: Joerg Roedel <jroedel@suse.de>
> > >
> > > Make sure to invoke this call-back through the proper
> > > function of the IOMMU-API.
> > >
> > > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> > > ---
> > >  drivers/iommu/of_iommu.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > > index c5dd63072529..4d4847de727e 100644
> > > --- a/drivers/iommu/of_iommu.c
> > > +++ b/drivers/iommu/of_iommu.c
> > > @@ -218,10 +218,10 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
> > >             ops = dev->iommu_fwspec->ops;
> > >     /*
> > >      * If we have reason to believe the IOMMU driver missed the initial
> > > -    * add_device callback for dev, replay it to get things in order.
> > > +    * probe for dev, replay it to get things in order.
> > >      */
> > > -   if (ops && ops->add_device && dev->bus && !dev->iommu_group)
> > > -           err = ops->add_device(dev);
> > > +   if (dev->bus && !dev->iommu_group)
> > > +           err = iommu_probe_device(dev);
> >
> > This change removes a check for NULL ops, what causes NULL pointer
> > exception on first device without IOMMU.
>
> Bummer, this check was supposed to be in iommu_probe_device(), but
> apparently it got lost. Does the attached patch fix it?
>
> > I'm also not sure if this is a good idea to call iommu_probe_device(),
> > which comes from dev->bus->iommu_ops, which might be different from ops
> > from local variable.
>
> The local variable comes from dev->iommu_fwspec->ops, which should be
> exactly the same as dev->bus->iommu_ops. I'll leave that for now until
> it turns out to be a problem (which I don't expect).
>
>
> Regards,
>
>         Joerg
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a2131751dcff..3ed4db334341 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -114,10 +114,14 @@ void iommu_device_unregister(struct iommu_device *iommu)
>  int iommu_probe_device(struct device *dev)
>  {
>         const struct iommu_ops *ops = dev->bus->iommu_ops;
> +       int ret = -EINVAL;
>
>         WARN_ON(dev->iommu_group);
>
> -       return ops->add_device(dev);
> +       if (ops)

Is this sufficient? The old code checked for ops->add_device != NULL,
too.

> +               ret = ops->add_device(dev);
> +
> +       return ret;
>  }
>
>  void iommu_release_device(struct device *dev)


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
