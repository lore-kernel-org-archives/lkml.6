Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBDDC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA962080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="X7NOXu82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA962080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeJ3RzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:55:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39914 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3RzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:55:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id e5-v6so9747501eds.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ShWHzED1d3dJTvmU9bZYAzxMevsmE/WhuyAJCfQ1tAs=;
        b=X7NOXu82tTvZp6m52daAGC4OD2pELfctpqTcQrCg3WWO+cnHxT7IcH/r5vV9bDHoHY
         McFe7vuSjaR4bmjXSA0EC5XhR6c4/Tvvsdwfdk12uxGQ5Yr+dA+3vuxur6DPVME8lJR7
         p/k0XipRvwZGc2UIVKlFqJ3ENroKcgEpOHK4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ShWHzED1d3dJTvmU9bZYAzxMevsmE/WhuyAJCfQ1tAs=;
        b=M80SjN3C5GwDt5LdXGGmna9iXo4OhMr2rPNq7kX90anx093f3ho+RbJhkp1ravCw9Q
         JlE2w4DmV47Zzx3btrgG6OPkEDP2DPA4Mi+wrBkLvk+bxhJ919LGhQPMO61Xd2wWb2/1
         aqyNiQ78CRb3tBeUwCwpLjZIXghSw3AA55ZivNuPLA3UIIcP7jHXfIvU0LHwkwqJT8Rb
         5UyYFX8a+dydKUEx2TCrbqfNIW3kVuvGkoVTYQBoFBCWGLfk6Fo4eZhJjnGgdi1CrdF+
         dJL7iC7bCeGTY/gN/x4XtkKsiA+9z3eSmJziDIDOzXu4uSOS0i/6nmTL7q8qnUG7R8Sl
         Ti9A==
X-Gm-Message-State: AGRZ1gKWRWaJYx6l6pL7um8iQa1NIBYydNJRXJbkAa+pcLBWuHpCdThB
        mt4h8UwNM3ielLN2cVHcXHFiiQ==
X-Google-Smtp-Source: AJdET5f1Lv7w11eNfvA9KHp3zOte8GIK9t5ae5bxnl1r+JlySOOGX2bXJco3ugfl9mhxledA3XavLA==
X-Received: by 2002:a50:d710:: with SMTP id t16-v6mr16345353edi.75.1540890156558;
        Tue, 30 Oct 2018 02:02:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m90-v6sm1989153ede.58.2018.10.30.02.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 02:02:35 -0700 (PDT)
Date:   Tue, 30 Oct 2018 10:02:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
Subject: Re: [PATCH 3/3] drm/mediatek: Use drm_gem_cma_object instead of
 mtk_drm_gem_obj
Message-ID: <20181030090233.GH21967@phenom.ffwll.local>
Mail-Followup-To: CK Hu <ck.hu@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
References: <1540538523-1973-1-git-send-email-ck.hu@mediatek.com>
 <1540538523-1973-4-git-send-email-ck.hu@mediatek.com>
 <20181026102156.GH21967@phenom.ffwll.local>
 <1540782676.13715.4.camel@mtksdaap41>
 <20181029091619.GT21967@phenom.ffwll.local>
 <1540882471.31817.9.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540882471.31817.9.camel@mtksdaap41>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 02:54:31PM +0800, CK Hu wrote:
> Hi, Daniel:
> 
> On Mon, 2018-10-29 at 10:16 +0100, Daniel Vetter wrote:
> > On Mon, Oct 29, 2018 at 11:11:16AM +0800, CK Hu wrote:
> > > Hi,Daniel:
> > > 
> > > On Fri, 2018-10-26 at 12:21 +0200, Daniel Vetter wrote:
> > > > On Fri, Oct 26, 2018 at 03:22:03PM +0800, CK Hu wrote:
> > > > > After adding dma_dev in struct drm_device and
> > > > > drm_gem_cma_dumb_create_no_kmap(), drm_gem_cma_object could replace
> > > > > mtk_drm_gem_obj, so use drm_gem_cma_object instead of mtk_drm_gem_obj to
> > > > > reduce redundant code.
> > > > > 
> > > > > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > > > 
> > > > A few questions/thoughts:
> > > > 
> > > > - Why do you need both drm_device->dev and drm_device->dma_dev? Can't you
> > > >   just register the drm_device with the right struct device?
> > > > 
> > > 
> > > In [1], mmsys is the drm driver and ovl0 and ovl1 is the sub device
> > > which has dma function.
> > > In this drm, there are two crtc and each one is comprised of many
> > > component.
> > > This is an example of mt8173:
> > > 
> > > crtc0: ovl0, color0, aal, od, rdma0, ufoe, dsi0
> > > crtc1: ovl1, color1, gamma, rdma1, dpi0
> > > 
> > > In the device node of ovl0 and ovl1, there is a 'iommus' parameter in
> > > it, so use dma_alloc_xxx() and dma_map_xxx() with that device would get
> > > iova rather than pa. I don't think it's a good idea to register ovl0 or
> > > ovl1 as drm device because each one is just a component in a pipeline.
> > > mmsys controls the clock and routing of multi-media system which include
> > > this drm system, so it's better to register mmsys as drm device. Maybe
> > > we could move 'iommus' parameter from ovl device to mmsys device, so the
> > > dma device changes from ovl device to mmsys device. I'm not sure this
> > > would be a good choice, how do you think?
> > > 
> > > [1]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/mediatek/mt8173.dtsi?h=v4.19
> > 
> > Ah ok. But if you have 2 blocks that make up the overall drm device, why
> > don't you need to switch at runtime between them? I.e. buffer allocated
> > for crtc0 needs to be dma-mapped to crtc0, buffer allocated to crtc1 needs
> > to be dma-mapped on crtc1?
> > 
> > And if they're both the exact same iommu, then imo it would make indeed
> > sense to move the iommu attribute up. Since your current code cant'
> > actually handle truly separate dma-mappings. And neither can your patch
> > series here handled separate iommu for crtc0 and crtc1.
> 
> Yes, they're the exact same iommu. So I would move iommu attribute up.
> 
> > 
> > > > - You don't use drm_gem_prime_import_dev, so prime import isn't using the
> > > >   right device either.
> > > 
> > > Yes, you are right. I'm not familiar with whore drm core, so I start to
> > > modify what Mediatek drm use. But this function still works for the drm
> > > device that itself is dma device. If one day there is a drm device which
> > > itself is not a dma device and need this function, send a patch to
> > > modify this function and test it with that drm device. If you want me to
> > > modify all in advance, I'm ok but need others to test it because
> > > Mediatek drm driver does not use them.
> > 
> > I meant to say that mediatek should use drm_gem_prime_import_dev, but
> > currently isn't using that. And your patch series here doesn't fix that
> > either. So there's more bugs left in this area.
> 
> Great, you find a bug. My test only include export but not import. This
> would take time to generate import-test environment.

igt has a bunch of import tests for display iirc, using vgem.

> > > > - exynos seems to have the same or at least similar issue, stronger case
> > > >   for your patches if you can solve both.
> > > 
> > > I'm still Mediatek's employee. If I modify other company's driver and it
> > > is not a MUST-BE for Mediatek, Mediatek may think I give contribution to
> > > other company. So I've better not to modify exynos driver.
> > 
> > This isn't how upstream works :-)
> 
> OK, because now I would not modify drm core, I would focus on Mediatek
> drm driver first. If the modification of exynos driver is easy, I could
> try. But if the modification of exynos is huge, I suggest that someone
> who is familiar with exynos driver and have exynos platform to do it.

Since we now clarified that you only have 1 iommu (and that it's kinda
misplaced in the DT) I think exonys is a different case. This was more
about your original patch series, which looked like exynos could need too.
-Daniel

> 
> Regards,
> CK
> > 
> > > > - I'd start out with using struct drm_gem_cma_object in mtk (similar to
> > > >   what vc4 does), and then reusing as much as possible of the existing
> > > >   helpers. And then looking later on what's still left (like the support
> > > >   for leaving out the virtual mapping).
> > > 
> > > I'm not clear what vc4 does. It looks like that you want me to redefine
> > > mtk_drm_gem_obj based on drm_gem_cma_object. So it would be like
> > > 
> > > struct mtk_drm_gem_obj {
> > > 	struct drm_gem_cma_object base;
> > > 	void *cookie;
> > > 	unsigned long dma_attrs;
> > > };
> > > 
> > > I could try to modify as this and see what have left.
> > 
> > Yup, that's my suggestion. Then we can look at what mtk can use unchanged
> > from the core helpers. And what would need to change and so better
> > evaluate whether it makes sense to do that.
> > 
> > I still think just moving the iommu is probably best.
> > -Daniel
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
