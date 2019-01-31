Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765E6C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8F120B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O7oVvdeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfAaRq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:46:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42346 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfAaRq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:46:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so3404091lja.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 09:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0XNEU5MGizPm3b2AbjTBvU02y37bzN/zv/cszap9R4E=;
        b=O7oVvdegYX6NSnBJqxcLGjNHcYkjNkxImCUkgdTT0n/7AfZQjdh+1uTzs8agVympNA
         hNKN+jQxLaRPNDsUntqfFIG5P7F6uhN1MirK/7Nybe/WApF9jifYXMIIdbBo1I42Ds6D
         /k7wzk/xpyGsFsfmAI/xci8Ee59QREc5KYVps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0XNEU5MGizPm3b2AbjTBvU02y37bzN/zv/cszap9R4E=;
        b=K5AISBfcgE6tm1br033dP5z5hJ2H8XO1TqcpOLewXoxrXZkzrBfOU5nXiiI/S6ukEb
         LA4MD0Q5Jgwo/eE86cSw0zMqq4v4SX1YsNiKE/b3FrGm8EVW6dJaKoobc2T82AnHKylO
         c80+CsWgJ/ob4RYXCGsHLcZGNf34yL38cIycJu/AY4gLarsLKyMaPvbGx5JjQ0JNYv8s
         sKBbdjBCHxni2+0SxIAP5OHFVObKpHHaMs8EAnCk4m1eA301cTJUmlTWr24B7E7Gcfum
         5r3uzenLBxLTUQNNBM4iSJATZhzQaVzjHHiKT1wahY+S2IwHNFWWnFMhMEw+4r+63Z8e
         nrAw==
X-Gm-Message-State: AJcUukfUZNJuxlSC9KCmbUp+84lwLjmIcIFXR8wbObcvHlhYx7HHMvcY
        j5+0luOyGgY56fMTgWbFxJZBzplYZf8=
X-Google-Smtp-Source: ALg8bN7u0qViJm6a1nCb6/v3VT8f83L3OIpHPiBbOWycMWGuEdE0Z/J4e02Rd30B7pCWQXALFJH9ow==
X-Received: by 2002:a2e:7011:: with SMTP id l17-v6mr28278051ljc.147.1548956785871;
        Thu, 31 Jan 2019 09:46:25 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id s20sm929923lfb.51.2019.01.31.09.46.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 09:46:25 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id n18so2982325lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 09:46:25 -0800 (PST)
X-Received: by 2002:a19:8c1b:: with SMTP id o27mr27062208lfd.90.1548956785044;
 Thu, 31 Jan 2019 09:46:25 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-18-git-send-email-yong.wu@mediatek.com> <CAE=gft4vOxt7G0CqZxvNUxCmuGq_L4wc2Wv6LF4Y62BoJQEUXw@mail.gmail.com>
 <1548904937.19710.39.camel@mhfsdcap03>
In-Reply-To: <1548904937.19710.39.camel@mhfsdcap03>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 31 Jan 2019 09:45:48 -0800
X-Gmail-Original-Message-ID: <CAE=gft6do4Ku7ErqxY2tbPwqDN_3w6i_ygxvyUSyXLYzxvNwTg@mail.gmail.com>
Message-ID: <CAE=gft6do4Ku7ErqxY2tbPwqDN_3w6i_ygxvyUSyXLYzxvNwTg@mail.gmail.com>
Subject: Re: [PATCH v5 17/20] memory: mtk-smi: Get rid of need_larbid
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     youlin.pei@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 7:22 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Wed, 2019-01-30 at 11:11 -0800, Evan Green wrote:
> > On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
> > > It's no need to parse it again in SMI driver. Only clean some codes.
> > > This patch is fit for all the current mt2701, mt2712, mt7623, mt8173
> > > and mt8183.
> > >
> > > After this patch, the "mediatek,larb-id" only be needed for mt2712
> > > which have 2 M4Us. In the other SoCs, we can get the larb-id from M4U
> > > in which the larbs in the "mediatek,larbs" always are ordered.
> > >
> > > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/memory/mtk-smi.c | 26 ++------------------------
> > >  1 file changed, 2 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > > index 08cf40d..10e6493 100644
> > > --- a/drivers/memory/mtk-smi.c
> > > +++ b/drivers/memory/mtk-smi.c
> > > @@ -67,7 +67,6 @@ struct mtk_smi_common_plat {
> > >  };
> > >
> > >  struct mtk_smi_larb_gen {
> > > -       bool need_larbid;
> > >         int port_in_larb[MTK_LARB_NR_MAX + 1];
> > >         void (*config_port)(struct device *);
> > >         unsigned int larb_direct_to_common_mask;
> > > @@ -153,18 +152,9 @@ void mtk_smi_larb_put(struct device *larbdev)
> > >         struct mtk_smi_iommu *smi_iommu = data;
> > >         unsigned int         i;
> > >
> > > -       if (larb->larb_gen->need_larbid) {
> > > -               larb->mmu = &smi_iommu->larb_imu[larb->larbid].mmu;
> > > -               return 0;
> > > -       }
> > > -
> > > -       /*
> > > -        * If there is no larbid property, Loop to find the corresponding
> > > -        * iommu information.
> > > -        */
> > > -       for (i = 0; i < smi_iommu->larb_nr; i++) {
> > > +       for (i = 0; i < MTK_LARB_NR_MAX; i++) {
> >
> > Looks like this was the only use of mtk_smi_iommu.larb_nr. Should we
> > remove that now?
>
> This is necessary since the mt2712 which has two M4U HW.
>
> From its dtsi[1], take iommu1 as a example, its larb_nr only is 3, but
> we need scan all the larb.
>
> [1]
> http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016119.html

I'm not sure I follow. My point was that this structure member is only
ever set but never read:
$ git grep '[.>]larb_nr'
drivers/iommu/mtk_iommu.c:      data->smi_imu.larb_nr = larb_nr;
drivers/iommu/mtk_iommu_v1.c:   data->smi_imu.larb_nr = larb_nr;

Maybe I've applied the patches to the wrong tree, and there is a use
of this member I'm not seeing?
-Evan
