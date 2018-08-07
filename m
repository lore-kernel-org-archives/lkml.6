Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F418C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2641215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2641215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733147AbeHGMFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:05:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:65056 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726419AbeHGMFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:05:30 -0400
X-UUID: fc53ebaf3b1f4b568312d7a5fcd8bd00-20180807
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 485261318; Tue, 07 Aug 2018 17:51:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 7 Aug 2018 17:51:53 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 7 Aug 2018 17:51:52 +0800
Message-ID: <1533635512.11190.76.camel@mtksdccf07>
Subject: Re: [PATCH v3 11/13] drm/mediatek: use layer_nr function to get
 layer number to init plane
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Tue, 7 Aug 2018 17:51:52 +0800
In-Reply-To: <1533616331.22668.15.camel@mtksdaap41>
References: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
         <1533556700-26525-12-git-send-email-stu.hsieh@mediatek.com>
         <1533616331.22668.15.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,CK:

On Tue, 2018-08-07 at 12:32 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Mon, 2018-08-06 at 19:58 +0800, Stu Hsieh wrote:
> > This patch use layer_nr function to get layer number to init plane
> > 
> > When plane init in crtc create,
> > it use the number of OVL layer to init plane.
> > That's OVL can read 4 memory address.
> > 
> > For mt2712 third ddp, it use RDMA to read memory.
> > RDMA can read 1 memory address, so it just init one plane.
> > 
> > For compatibility, this patch use mtk_ddp_comp_layer_nr function
> > to get layer number from their HW component in ddp for plane init.
> > 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 37 +++++++++++++++++++++------------
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.h |  1 -
> >  2 files changed, 24 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > index 2d6aa150a9ff..1a8685fbbf57 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -45,7 +45,8 @@ struct mtk_drm_crtc {
> >  	bool				pending_needs_vblank;
> >  	struct drm_pending_vblank_event	*event;
> >  
> > -	struct drm_plane		planes[OVL_LAYER_NR];
> > +	struct drm_plane		**planes;
> 
> Why double pointer? This make things more complicated.
> Single pointer is equal to array, so you need not to modify so many
> place.
> 
> Regards,
> CK
> 
ok

Regards,
Stu

> > +	unsigned int			layer_nr;
> >  	bool				pending_planes;
> >  
> >  	void __iomem			*config_regs;
> > @@ -286,8 +287,8 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
> >  	}
> >  
> >  	/* Initially configure all planes */
> > -	for (i = 0; i < OVL_LAYER_NR; i++) {
> > -		struct drm_plane *plane = &mtk_crtc->planes[i];
> > +	for (i = 0; i < mtk_crtc->layer_nr; i++) {
> > +		struct drm_plane *plane = mtk_crtc->planes[i];
> >  		struct mtk_plane_state *plane_state;
> >  
> >  		plane_state = to_mtk_plane_state(plane->state);
> > @@ -351,8 +352,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
> >  	}
> >  
> >  	if (mtk_crtc->pending_planes) {
> > -		for (i = 0; i < OVL_LAYER_NR; i++) {
> > -			struct drm_plane *plane = &mtk_crtc->planes[i];
> > +		for (i = 0; i < mtk_crtc->layer_nr; i++) {
> > +			struct drm_plane *plane = mtk_crtc->planes[i];
> >  			struct mtk_plane_state *plane_state;
> >  
> >  			plane_state = to_mtk_plane_state(plane->state);
> > @@ -403,8 +404,8 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
> >  		return;
> >  
> >  	/* Set all pending plane state to disabled */
> > -	for (i = 0; i < OVL_LAYER_NR; i++) {
> > -		struct drm_plane *plane = &mtk_crtc->planes[i];
> > +	for (i = 0; i < mtk_crtc->layer_nr; i++) {
> > +		struct drm_plane *plane = mtk_crtc->planes[i];
> >  		struct mtk_plane_state *plane_state;
> >  
> >  		plane_state = to_mtk_plane_state(plane->state);
> > @@ -450,8 +451,8 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
> >  
> >  	if (mtk_crtc->event)
> >  		mtk_crtc->pending_needs_vblank = true;
> > -	for (i = 0; i < OVL_LAYER_NR; i++) {
> > -		struct drm_plane *plane = &mtk_crtc->planes[i];
> > +	for (i = 0; i < mtk_crtc->layer_nr; i++) {
> > +		struct drm_plane *plane = mtk_crtc->planes[i];
> >  		struct mtk_plane_state *plane_state;
> >  
> >  		plane_state = to_mtk_plane_state(plane->state);
> > @@ -598,18 +599,28 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
> >  		mtk_crtc->ddp_comp[i] = comp;
> >  	}
> >  
> > -	for (zpos = 0; zpos < OVL_LAYER_NR; zpos++) {
> > +	mtk_crtc->layer_nr = mtk_ddp_comp_layer_nr(mtk_crtc->ddp_comp[0]);
> > +	mtk_crtc->planes = devm_kmalloc_array(dev, mtk_crtc->layer_nr,
> > +					      sizeof(*mtk_crtc->planes),
> > +					      GFP_KERNEL);
> > +
> > +	for (zpos = 0; zpos < mtk_crtc->layer_nr; zpos++) {
> > +		mtk_crtc->planes[zpos] = devm_kzalloc(dev,
> > +						sizeof(*mtk_crtc->planes[zpos]),
> > +						GFP_KERNEL);
> > +
> >  		type = (zpos == 0) ? DRM_PLANE_TYPE_PRIMARY :
> >  				(zpos == 1) ? DRM_PLANE_TYPE_CURSOR :
> >  						DRM_PLANE_TYPE_OVERLAY;
> > -		ret = mtk_plane_init(drm_dev, &mtk_crtc->planes[zpos],
> > +		ret = mtk_plane_init(drm_dev, mtk_crtc->planes[zpos],
> >  				     BIT(pipe), type);
> >  		if (ret)
> >  			goto unprepare;
> >  	}
> >  
> > -	ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0],
> > -				&mtk_crtc->planes[1], pipe);
> > +	ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, mtk_crtc->planes[0],
> > +				mtk_crtc->layer_nr > 1 ? mtk_crtc->planes[1] :
> > +				NULL, pipe);
> >  	if (ret < 0)
> >  		goto unprepare;
> >  	drm_mode_crtc_set_gamma_size(&mtk_crtc->base, MTK_LUT_SIZE);
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> > index 9d9410c67ae9..60bcc8aba8e3 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> > @@ -18,7 +18,6 @@
> >  #include "mtk_drm_ddp_comp.h"
> >  #include "mtk_drm_plane.h"
> >  
> > -#define OVL_LAYER_NR	4
> >  #define MTK_LUT_SIZE	512
> >  #define MTK_MAX_BPC	10
> >  #define MTK_MIN_BPC	3
> 
> 


