Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F6EC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190782147D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190782147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbeLCD1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:27:11 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:24918 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725805AbeLCD1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:27:11 -0500
X-UUID: 58567d1b71d8435eae3b1b003a4e96a8-20181203
X-UUID: 58567d1b71d8435eae3b1b003a4e96a8-20181203
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1972276798; Mon, 03 Dec 2018 11:27:01 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 11:27:00 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 11:27:00 +0800
Message-ID: <1543807620.11594.2.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: Only try to attach bridge if there is one
From:   CK Hu <ck.hu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Mon, 3 Dec 2018 11:27:00 +0800
In-Reply-To: <1543210200.1796.2.camel@mtksdaap41>
References: <20181126040737.138682-1-drinkcat@chromium.org>
         <1543210200.1796.2.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nicolas:

On Mon, 2018-11-26 at 13:30 +0800, CK Hu wrote:
> Hi, Nicolas:
> 
> On Mon, 2018-11-26 at 12:07 +0800, Nicolas Boichat wrote:
> > Even if dsi->bridge is NULL, we still try to call drm_bridge_attach,
> > and print out an error message, before creating the connector.
> > 
> > When no bridge is provided, let's skip these 2 steps and directly
> > create the connector.
> 

Applied to mediatek-drm-fixes-4.20 [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-fixes-4.20

Regards,
CK

> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> 
> > 
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index 66df1b17795921..27b507eb4a997d 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -818,10 +818,13 @@ static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_dsi *dsi)
> >  	dsi->encoder.possible_crtcs = 1;
> >  
> >  	/* If there's a bridge, attach to it and let it create the connector */
> > -	ret = drm_bridge_attach(&dsi->encoder, dsi->bridge, NULL);
> > -	if (ret) {
> > -		DRM_ERROR("Failed to attach bridge to drm\n");
> > -
> > +	if (dsi->bridge) {
> > +		ret = drm_bridge_attach(&dsi->encoder, dsi->bridge, NULL);
> > +		if (ret) {
> > +			DRM_ERROR("Failed to attach bridge to drm\n");
> > +			goto err_encoder_cleanup;
> > +		}
> > +	} else {
> >  		/* Otherwise create our own connector and attach to a panel */
> >  		ret = mtk_dsi_create_connector(drm, dsi);
> >  		if (ret)
> 


