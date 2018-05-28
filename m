Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753051AbeE1C1I (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 22:27:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51706 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752978AbeE1C1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 22:27:04 -0400
X-UUID: 6332e2ab24854901a3649e5b8582a131-20180528
Message-ID: <1527474417.11190.21.camel@mtksdccf07>
Subject: Re: [PATCH v3 8/8] drm/mediatek: add third ddp path
From: Stu Hsieh <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date: Mon, 28 May 2018 10:26:57 +0800
In-Reply-To: <1527224425.27165.27.camel@mtksdaap41>
References: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
         <1527215665-11937-9-git-send-email-stu.hsieh@mediatek.com>
         <1527224425.27165.27.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, CK:
I've some idea as below.

On Fri, 2018-05-25 at 13:00 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Fri, 2018-05-25 at 10:34 +0800, stu.hsieh@mediatek.com wrote:
> > From: Stu Hsieh <stu.hsieh@mediatek.com>
> > 
> > This patch create third crtc by third ddp path
> > 
> 
> Apply this patch before the patch 'Add support for mediatek SOC MT2712'
> because this patch is necessary for mt2712.
> 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > index b32c4cc8d051..3a866e1d6af4 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -267,6 +267,11 @@ static int mtk_drm_kms_init(struct drm_device *drm)
> >  	if (ret < 0)
> >  		goto err_component_unbind;
> >  
> > +	ret = mtk_drm_crtc_create(drm, private->data->third_path,
> > +				  private->data->third_len);
> 
> I think you should prevent doing this for mt8173 and mt2701 because that
> two SoC has only two ddp path.

Now, 8173 and 2701 have only two ddp path, there is a problem on run
time. 
There are three crtc for drm resource, and there is nothing in third
crtc. 
Because 8173 and 2701 have no third ddp, and the third ddp_len is zero.
So, I want to add the condition like following in mtk_crtc_create()
if (path_len == 0)
	return 0;

Then, the valur ret is zero and it would not create the null third crtc.


Regards,
Stu

> 
> Regards,
> CK
> 
> > +	if (ret < 0)
> > +		goto err_component_unbind;
> > +
> >  	/* Use OVL device for all DMA memory allocations */
> >  	np = private->comp_node[private->data->main_path[0]] ?:
> >  	     private->comp_node[private->data->ext_path[0]];
> 
> 
