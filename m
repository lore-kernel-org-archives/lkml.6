Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CDFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FBF208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FBF208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeH0SHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:07:31 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44421 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeH0SHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:07:30 -0400
Received: by mail-vk0-f65.google.com with SMTP id 125-v6so7613302vke.11;
        Mon, 27 Aug 2018 07:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1uvPih9z65OZrIg9ihuxLYe3PjDnksk5oTUOf3CvDk=;
        b=gBqy9yoDdoab4h8Kt2f08Os0STc+I3KX5+5gcmY7FPZa3rsYGPRtqdZvzol2MoKtUB
         k+R7FOnTOenuX78axq8IaFXtddip5U0fOjA91vnYelgk/UQ7to/eiUi0+gnBpcju+z0D
         NDpX55/6bLBeSqs277kIc079OmiyUtzgc2hlgmoZfsk0AiMOzpkw27waGJcPaHdtdm4z
         g7wcGVJM0e4GkKZ1J+dBC1P23jXMuqQ4I6egynsF9+5HXuWgKwmmAfpobX/ren98D8/4
         pzEgLG0pYwABB6ZEGMY40EHjMQLNsWCBsWagEteki2PNDVzmnNyLad/xX0FOO2mbCar9
         aBqA==
X-Gm-Message-State: APzg51D2teCyg9ipnuiYehN7Rd/AH8GgYBV08Bfr5lnM+uWCq8SquuVV
        DneChB2AXUBFFyVefdLGSwcX34WWGN/ncXf7DRg=
X-Google-Smtp-Source: ANB0VdY+u31AxI7kZSjfjwA1i+9EvxOHwPMm1pEcT58mFO+mqO6YztkB09A3nWtLKLn7YkW5i0XWIN/MS2x+RaPv6To=
X-Received: by 2002:a1f:8948:: with SMTP id l69-v6mr8311028vkd.132.1535379639808;
 Mon, 27 Aug 2018 07:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180726211916.10264-1-digetx@gmail.com> <2725801.tsBI9ZhLPt@avalon>
In-Reply-To: <2725801.tsBI9ZhLPt@avalon>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Aug 2018 16:20:26 +0200
Message-ID: <CAMuHMdXdpnezLAB=ksrETYY1GxbWZBxBaea4n+E4wjSh1ntdmw@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/ipmmu-vmsa: Don't register as BUS IOMMU if
 machine doesn't have IPMMU-VMSA
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     digetx@gmail.com, Joerg Roedel <joro@8bytes.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Marc Dietrich <marvin24@gmx.de>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Fri, Jul 27, 2018 at 11:09 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> (CC'ing Geert and Magnus)
>
> Thank you for the patch.
>
> On Friday, 27 July 2018 00:19:16 EEST Dmitry Osipenko wrote:
> > This fixes kernel crashing on NVIDIA Tegra if kernel is compiled in
> > a multiplatform configuration and IPMMU-VMSA driver is enabled.
> >
> > Cc: <stable@vger.kernel.org> # v3.20+
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/iommu/ipmmu-vmsa.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index 9e8495762bc8..78c50db9cd71 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -1109,12 +1109,19 @@ static struct platform_driver ipmmu_driver = {
> >
> >  static int __init ipmmu_init(void)
> >  {
> > +     struct device_node *np;
> >       static bool setup_done;
> >       int ret;
> >
> >       if (setup_done)
> >               return 0;
> >
> > +     np = of_find_matching_node(NULL, ipmmu_of_ids);
> > +     if (!np)
> > +             return 0;
> > +
> > +     of_node_put(np);
> > +
>
> While functionally correct, this will add some unnecessary overhead when
> iommu_init() is called from IOMMU_OF_DECLARE(). I'm OK with this fix as a
> temporary measure to solve your problem, but we need to address the underlying
> issue properly.
>
> Geert, Magnus, the ipmmu-vmsa driver is a bit of a mess. We should brush it up
> and start using IOMMU_OF_DECLARE() on all platforms (and eventually get rid of
> bus_set_iommu() completely...). Do you have plans to address this ? If not,
> could you please add it to your to-do list ?

On the contrary: IOMMU_OF_DECLARE() has been removed.

>
> >       ret = platform_driver_register(&ipmmu_driver);
> >       if (ret < 0)
> >               return ret;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
