Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D388C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36457214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36457214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbeHBN27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:28:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15153 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732168AbeHBN27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:28:59 -0400
X-UUID: 54ae87890341443fa7db8fd32343c4a3-20180802
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2005248011; Thu, 02 Aug 2018 19:38:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 2 Aug 2018 19:38:06 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 2 Aug 2018 19:38:06 +0800
Message-ID: <1533209886.11190.62.camel@mtksdccf07>
Subject: Re: [PATCH v1 12/15] drm/mediatek: add layer number condition for
 RDMA to control plane
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Thu, 2 Aug 2018 19:38:06 +0800
In-Reply-To: <1532487770.9280.17.camel@mtksdaap41>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
         <1532420235-22268-13-git-send-email-stu.hsieh@mediatek.com>
         <1532487770.9280.17.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, CK:

On Wed, 2018-07-25 at 11:02 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Tue, 2018-07-24 at 16:17 +0800, Stu Hsieh wrote:
> > This patch add layer number condition for RDMA to control plane
> > 
> > When plane init in crtc create,
> > it use the number of OVL layer to init plane.
> > That's OVL can read 4 memory address.
> > 
> > For mt2712 third ddp, it use RDMA to read memory.
> > RDMA can read 1 memory address, so it just init one plane.
> > 
> > For compatibility, this patch use two define OVL_LAYER_NR and
> > RDMA_LAYER_NR to distingush two difference HW engine.
> > 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 25 +++++++++++++++++--------
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.h |  2 ++
> >  2 files changed, 19 insertions(+), 8 deletions(-)
> > 
> 
> [...]
> 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> > index 9d9410c67ae9..b44fefadf14a 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> > @@ -18,7 +18,9 @@
> >  #include "mtk_drm_ddp_comp.h"
> >  #include "mtk_drm_plane.h"
> >  
> > +#define MAX_LAYER_NR	4
> >  #define OVL_LAYER_NR	4
> > +#define RDMA_LAYER_NR	1
> >  #define MTK_LUT_SIZE	512
> >  #define MTK_MAX_BPC	10
> >  #define MTK_MIN_BPC	3
> 
> If the layer number is not fixed in '4', I would like to get this value
> from component because in some SoC, OVL may have 6 layer. So add an
> interface to get the max layer number and OVL, RDMA driver would return
> the number for this SoC.
> 
> Regards,
> CK
> 
OK

Regards,
Stu

> 


