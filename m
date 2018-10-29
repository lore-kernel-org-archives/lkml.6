Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B89C6786F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD89020843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD89020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbeJ2L6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:58:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28296 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729142AbeJ2L6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:58:35 -0400
X-UUID: 91b3b6bc22aa4b4ea569d6bf4406d0a8-20181029
X-UUID: 91b3b6bc22aa4b4ea569d6bf4406d0a8-20181029
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2080718267; Mon, 29 Oct 2018 11:11:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 29 Oct 2018 11:11:16 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 29 Oct 2018 11:11:16 +0800
Message-ID: <1540782676.13715.4.camel@mtksdaap41>
Subject: Re: [PATCH 3/3] drm/mediatek: Use drm_gem_cma_object instead of
 mtk_drm_gem_obj
From:   CK Hu <ck.hu@mediatek.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Mon, 29 Oct 2018 11:11:16 +0800
In-Reply-To: <20181026102156.GH21967@phenom.ffwll.local>
References: <1540538523-1973-1-git-send-email-ck.hu@mediatek.com>
         <1540538523-1973-4-git-send-email-ck.hu@mediatek.com>
         <20181026102156.GH21967@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 796F07C8841D1A99995A87FD48162DFBD488881728D65E08D8630C4E444656732000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Daniel:

On Fri, 2018-10-26 at 12:21 +0200, Daniel Vetter wrote:
> On Fri, Oct 26, 2018 at 03:22:03PM +0800, CK Hu wrote:
> > After adding dma_dev in struct drm_device and
> > drm_gem_cma_dumb_create_no_kmap(), drm_gem_cma_object could replace
> > mtk_drm_gem_obj, so use drm_gem_cma_object instead of mtk_drm_gem_obj to
> > reduce redundant code.
> > 
> > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> 
> A few questions/thoughts:
> 
> - Why do you need both drm_device->dev and drm_device->dma_dev? Can't you
>   just register the drm_device with the right struct device?
> 

In [1], mmsys is the drm driver and ovl0 and ovl1 is the sub device
which has dma function.
In this drm, there are two crtc and each one is comprised of many
component.
This is an example of mt8173:

crtc0: ovl0, color0, aal, od, rdma0, ufoe, dsi0
crtc1: ovl1, color1, gamma, rdma1, dpi0

In the device node of ovl0 and ovl1, there is a 'iommus' parameter in
it, so use dma_alloc_xxx() and dma_map_xxx() with that device would get
iova rather than pa. I don't think it's a good idea to register ovl0 or
ovl1 as drm device because each one is just a component in a pipeline.
mmsys controls the clock and routing of multi-media system which include
this drm system, so it's better to register mmsys as drm device. Maybe
we could move 'iommus' parameter from ovl device to mmsys device, so the
dma device changes from ovl device to mmsys device. I'm not sure this
would be a good choice, how do you think?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/mediatek/mt8173.dtsi?h=v4.19

> - You don't use drm_gem_prime_import_dev, so prime import isn't using the
>   right device either.

Yes, you are right. I'm not familiar with whore drm core, so I start to
modify what Mediatek drm use. But this function still works for the drm
device that itself is dma device. If one day there is a drm device which
itself is not a dma device and need this function, send a patch to
modify this function and test it with that drm device. If you want me to
modify all in advance, I'm ok but need others to test it because
Mediatek drm driver does not use them.

> 
> - exynos seems to have the same or at least similar issue, stronger case
>   for your patches if you can solve both.

I'm still Mediatek's employee. If I modify other company's driver and it
is not a MUST-BE for Mediatek, Mediatek may think I give contribution to
other company. So I've better not to modify exynos driver.

> - I'd start out with using struct drm_gem_cma_object in mtk (similar to
>   what vc4 does), and then reusing as much as possible of the existing
>   helpers. And then looking later on what's still left (like the support
>   for leaving out the virtual mapping).

I'm not clear what vc4 does. It looks like that you want me to redefine
mtk_drm_gem_obj based on drm_gem_cma_object. So it would be like

struct mtk_drm_gem_obj {
	struct drm_gem_cma_object base;
	void *cookie;
	unsigned long dma_attrs;
};

I could try to modify as this and see what have left.

Regards,
CK

> 
> -Daniel
> 

[Snip...]

> > ---
> > -- 
> > 1.9.1
> > 
> 


