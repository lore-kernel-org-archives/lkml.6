Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966275AbeEYLHN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:07:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59842 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965872AbeEYLHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:07:10 -0400
Subject: Re: [PATCH] drm/rockchip: vop: fix irq disabled after vop driver
 probed
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>
Cc: xxm@rock-chips.com, Joerg Roedel <joro@8bytes.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.co.uk>, jcliang@chromium.org,
        linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
        =?UTF-8?Q?Enric_Balletb=c3=b2?= <enric.balletbo@collabora.co.uk>,
        tfiga@chromium.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <b8eb41e576c4007d40223699eb951db32916b86a.camel@collabora.com>
 <25470133.K8n9sLBzRS@diego>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <8495bffd-2a52-ca85-1bc9-afc3ea0af8e4@arm.com>
Date: Fri, 25 May 2018 12:07:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <25470133.K8n9sLBzRS@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Thanks Robin for pointing me to that patch.]

Hi Heiko,

On 24/05/18 23:06, Heiko Stübner wrote:
> From: Sandy Huang <hjc@rock-chips.com>
> 
> The vop irq is shared between vop and iommu and irq probing in the
> iommu driver moved to the probe function recently. This can in some
> cases lead to a stall if the irq is triggered while the vop driver
> still has it disabled.
> 
> But there is no real need to disable the irq, as the vop can simply
> also track its enabled state and ignore irqs in that case.
> 
> So remove the enable/disable handling and add appropriate condition
> to the irq handler.
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> [added an actual commit message]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Hi Ezequiel,
> 
> this patch came from a discussion I had with Rockchip people over the
> iommu changes and resulting issues back in april, but somehow was
> forgotten and not posted to the lists. Correcting that now.
> 
> So removing the enable/disable voodoo on the shared interrupt is
> the preferred way.
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 13 ++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 510cdf0..61493d4 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -549,8 +549,6 @@ static int vop_enable(struct drm_crtc *crtc)
>  
>  	spin_unlock(&vop->reg_lock);
>  
> -	enable_irq(vop->irq);
> -
>  	drm_crtc_vblank_on(crtc);
>  
>  	return 0;
> @@ -596,8 +594,6 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
>  
>  	vop_dsp_hold_valid_irq_disable(vop);
>  
> -	disable_irq(vop->irq);
> -
>  	vop->is_enabled = false;
>  
>  	/*
> @@ -1168,6 +1164,13 @@ static irqreturn_t vop_isr(int irq, void *data)
>  	int ret = IRQ_NONE;
>  
>  	/*
> +	 * since the irq is shared with iommu, iommu irq is enabled before vop
> +	 * enable, so before vop enable we do nothing.
> +	 */
> +	if (!vop->is_enabled)
> +		return IRQ_NONE;
> +

What guarantee do we have that the IOMMU will actually service that
interrupt? Can't we get into a situation where the interrupt gets
ignored by both drivers and subsequently disabled by the core irq code
as being spurious?

>From what I understood of the way things are plugged together on the
rockchip platforms, each individual VOP is behind a single IOMMU, hence
there there is hardly any point in handling IOMMU interrupts if the VOP
is off.

But I'm missing the actual reason behind this patch. Could you enlighten me?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
