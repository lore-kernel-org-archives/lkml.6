Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80767C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1E920844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GauPpDcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfAVKqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:46:51 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43106 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfAVKqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:46:51 -0500
Received: by mail-io1-f66.google.com with SMTP id b23so18723878ios.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 02:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eSPrnxQ6dQuliSqyrd4f/WYTHkwSHxqv0f/vECaUqJQ=;
        b=GauPpDcrl64e4tZmT2X0TaxinL1WLSO/e90XrEAhy6A9K5RdTNcfu2y6p4OQhz7ydv
         EpDwxsiW0Hd2WiJHPlrJV4XqbqfsDfqHqzHPoCDVh7HuVX6kSu5AUQr2fceY41BWpDqq
         UlcGOn99RWMG2x1khvkRVV2iTjwiwzt9Pnyyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSPrnxQ6dQuliSqyrd4f/WYTHkwSHxqv0f/vECaUqJQ=;
        b=loCUzpa28UanAbE2MYLR14xxOtQiTqqqqZM1GInMvLitMERqkoifjfdXgQM5l58nH/
         +lNYgOnGCBV0hqAK7Dq4EFLF33hPsKXyNumXZqx8wPkTlhER6bMi6wuJ8F+PQn/rqiA1
         L4fcAFHrRMyxccWXS5LAJOW6wdMu55kGD+wukWSZEwPojXyxLVVRKDypCmNDztmG9jZZ
         nvqh85HW7yyHyjTwAb7tycqR5hJ2BQEOujMCceNGv1uYwz504f+ePuMh4j36pYF37rfD
         GIOSA981wLcAkkbwXwRWWmCeBq4fnIFtcVFdCbgAC6wPbRDq68EQg+KFjWs9uoKZIXhr
         04pg==
X-Gm-Message-State: AJcUukecc9FQ652jnLVm6h3979TkFiz5rHSAgYwZVqAFXYWwwIU1yo7P
        hx1Bjk1iBJvZ/7ga/Cq9mzAvjZUYUAT216BQdNXHdQ==
X-Google-Smtp-Source: ALg8bN6q3OCD6Ec2smKZ3mgIzjcvR93Aj72RrpVZfQvqXacsPi3eYSCpkRDjjoqJASCqvQ5skowsMSJ/n/OQy9f3XmQ=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr20279439ioa.34.1548154010404;
 Tue, 22 Jan 2019 02:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20181227114948.ev4b3jte3ubsc5us@dcvr> <154642214920.6261.102817444136744919@jlahtine-desk.ger.corp.intel.com>
 <20190104010626.e6yqdqkmdcqjepke@dcvr> <154659116310.4596.13613897418163029789@jlahtine-desk.ger.corp.intel.com>
 <20190118121705.a4usvhnskyblooja@dcvr> <20190122103914.msboylvkor5sb5lq@8bytes.org>
In-Reply-To: <20190122103914.msboylvkor5sb5lq@8bytes.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 22 Jan 2019 11:46:39 +0100
Message-ID: <CAKMK7uEX1T6_yXoq_d4Fs2LiWC_tDaEEXv-hTL=S-_4HEeya7A@mail.gmail.com>
Subject: Re: [PATCH] iommu/intel: quirk to disable DMAR for QM57 igfx
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Eric Wong <e@80x24.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:39 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Fri, Jan 18, 2019 at 12:17:05PM +0000, Eric Wong wrote:
> > @@ -5411,6 +5411,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e20, quirk_iommu_g4x_gfx);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e30, quirk_iommu_g4x_gfx);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e40, quirk_iommu_g4x_gfx);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e90, quirk_iommu_g4x_gfx);
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_iommu_g4x_gfx);
> >
> >  static void quirk_iommu_rwbf(struct pci_dev *dev)
> >  {
> > @@ -5457,7 +5458,6 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
> >         }
> >  }
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
> > -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_calpella_no_shadow_gtt);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0062, quirk_calpella_no_shadow_gtt);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x006a, quirk_calpella_no_shadow_gtt);
>
> This seems to make sense to me. Joonas, any comments or objections?

This is ironlake, which has a huge iommu hack in the gpu driver to
work around hard hangs, which:
- causes massive stalls and kills performance
- isn't well tested (it's the only one that needs this), so tends to break

So if we do this then imo we should:
- probably nuke that w/a too (check for needs_idle_maps and all the
related stuff in i915_gem_gtt.c)
- roll it out for all affected chips (i.e. need to include 0x0040).

Note that the string of platforms which have various issues with iommu
and igfx is very long, thus far we only disabled it where there's no
workaround to stop it from hanging the box, but otherwise left it
enabled. So if we make a policy change to also disable it anywhere
where it doesn't work well (instead of not at all), there's a pile
more platforms to switch.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
