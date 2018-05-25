Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966559AbeEYMOc convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:14:32 -0400
Received: from gloria.sntech.de ([95.129.55.99]:60766 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966243AbeEYMOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:14:30 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ezequiel Garcia <ezequiel@collabora.com>, xxm@rock-chips.com,
        Joerg Roedel <joro@8bytes.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.co.uk>, jcliang@chromium.org,
        linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
        Enric =?ISO-8859-1?Q?Balletb=F2?=
        <enric.balletbo@collabora.co.uk>,
        tfiga@chromium.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: vop: fix irq disabled after vop driver probed
Date: Fri, 25 May 2018 14:14:20 +0200
Message-ID: <4318500.8KycslRrNH@phil>
In-Reply-To: <8495bffd-2a52-ca85-1bc9-afc3ea0af8e4@arm.com>
References: <b8eb41e576c4007d40223699eb951db32916b86a.camel@collabora.com> <25470133.K8n9sLBzRS@diego> <8495bffd-2a52-ca85-1bc9-afc3ea0af8e4@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Am Freitag, 25. Mai 2018, 13:07:02 CEST schrieb Marc Zyngier:
> [Thanks Robin for pointing me to that patch.]
> 
> Hi Heiko,
> 
> On 24/05/18 23:06, Heiko Stübner wrote:
> > From: Sandy Huang <hjc@rock-chips.com>
> > 
> > The vop irq is shared between vop and iommu and irq probing in the
> > iommu driver moved to the probe function recently. This can in some
> > cases lead to a stall if the irq is triggered while the vop driver
> > still has it disabled.
> > 
> > But there is no real need to disable the irq, as the vop can simply
> > also track its enabled state and ignore irqs in that case.
> > 
> > So remove the enable/disable handling and add appropriate condition
> > to the irq handler.
> > 
> > Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> > [added an actual commit message]
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > Hi Ezequiel,
> > 
> > this patch came from a discussion I had with Rockchip people over the
> > iommu changes and resulting issues back in april, but somehow was
> > forgotten and not posted to the lists. Correcting that now.
> > 
> > So removing the enable/disable voodoo on the shared interrupt is
> > the preferred way.
> > 
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 13 ++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > index 510cdf0..61493d4 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > @@ -549,8 +549,6 @@ static int vop_enable(struct drm_crtc *crtc)
> >  
> >  	spin_unlock(&vop->reg_lock);
> >  
> > -	enable_irq(vop->irq);
> > -
> >  	drm_crtc_vblank_on(crtc);
> >  
> >  	return 0;
> > @@ -596,8 +594,6 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
> >  
> >  	vop_dsp_hold_valid_irq_disable(vop);
> >  
> > -	disable_irq(vop->irq);
> > -
> >  	vop->is_enabled = false;
> >  
> >  	/*
> > @@ -1168,6 +1164,13 @@ static irqreturn_t vop_isr(int irq, void *data)
> >  	int ret = IRQ_NONE;
> >  
> >  	/*
> > +	 * since the irq is shared with iommu, iommu irq is enabled before vop
> > +	 * enable, so before vop enable we do nothing.
> > +	 */
> > +	if (!vop->is_enabled)
> > +		return IRQ_NONE;
> > +
> 
> What guarantee do we have that the IOMMU will actually service that
> interrupt? Can't we get into a situation where the interrupt gets
> ignored by both drivers and subsequently disabled by the core irq code
> as being spurious?
> 
> From what I understood of the way things are plugged together on the
> rockchip platforms, each individual VOP is behind a single IOMMU, hence
> there there is hardly any point in handling IOMMU interrupts if the VOP
> is off.

Yeah, which is probably the reason that patch fell through the cracks
initially. I resurrected it from the internal discussion because of the issue
described below.

> But I'm missing the actual reason behind this patch. Could you enlighten me?

Recently the iommu driver moved the irq request from the iommu enablement
to its probe function. With that change Ezequiel got various stalls, see
	https://lkml.org/lkml/2018/5/24/1347


Heiko
