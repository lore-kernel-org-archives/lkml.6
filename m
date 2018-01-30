Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeA3Czq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 21:55:46 -0500
Received: from regular1.263xmail.com ([211.150.99.138]:59553 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeA3Czp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 21:55:45 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: sandy.huang@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <44ced71726392a0605561efcc8f40569>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v2 10/43] drm/rockchip: add mutex vop lock
To: Thierry Escande <thierry.escande@collabora.com>,
        Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Tomasz Figa <tfiga@chromium.org>
Cc: Zain Wang <wzz@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?Q?=c3=98rjan_Eide?= <orjan.eide@arm.com>,
        Haixia Shi <hshi@chromium.org>
References: <20180126131710.7622-1-thierry.escande@collabora.com>
 <20180126131710.7622-11-thierry.escande@collabora.com>
From: Sandy Huang <hjc@rock-chips.com>
Message-ID: <0545286d-cbd7-d24b-bb83-315029a20836@rock-chips.com>
Date: Tue, 30 Jan 2018 10:55:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180126131710.7622-11-thierry.escande@collabora.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2018/1/26 21:16, Thierry Escande Ð´µÀ:
> From: zain wang <wzz@rock-chips.com>
> 
> Add a lock to vop to avoid disabling the crtc while waiting for a line
> flag while enabling psr. If we disable in the middle of waiting for the
> line flag, we'll end up timing out or worse.
> 
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 30 +++++++++++++++++++++++------
>   1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 31304434847a..bf4b1a2f3fa4 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -117,6 +117,8 @@ struct vop {
>   	spinlock_t reg_lock;
>   	/* lock vop irq reg */
>   	spinlock_t irq_lock;
> +	/* protects crtc enable/disable */
> +	struct mutex vop_lock;
>   
>   	unsigned int irq;
>   
> @@ -577,6 +579,7 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
>   
>   	WARN_ON(vop->event);
>   
> +	mutex_lock(&vop->vop_lock);
>   	drm_crtc_vblank_off(crtc);
>   
>   	/*
> @@ -612,6 +615,7 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
>   	clk_disable(vop->aclk);
>   	clk_disable(vop->hclk);
>   	pm_runtime_put(vop->dev);
> +	mutex_unlock(&vop->vop_lock);
>   
>   	if (crtc->state->event && !crtc->state->active) {
>   		spin_lock_irq(&crtc->dev->event_lock);
> @@ -882,10 +886,13 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
>   	uint32_t pin_pol, val;
>   	int ret;
>   
> +	mutex_lock(&vop->vop_lock);
> +
>   	WARN_ON(vop->event);
>   
>   	ret = vop_enable(crtc);
>   	if (ret) {
> +		mutex_unlock(&vop->vop_lock);
>   		DRM_DEV_ERROR(vop->dev, "Failed to enable vop (%d)\n", ret);
>   		return;
>   	}
> @@ -949,6 +956,7 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
>   	clk_set_rate(vop->dclk, adjusted_mode->clock * 1000);
>   
>   	VOP_REG_SET(vop, common, standby, 0);
> +	mutex_unlock(&vop->vop_lock);
>   }
>   
>   static bool vop_fs_irq_is_pending(struct vop *vop)
> @@ -1487,15 +1495,21 @@ int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout)
>   {
>   	struct vop *vop = to_vop(crtc);
>   	unsigned long jiffies_left;
> +	int ret = 0;
>   
>   	if (!crtc || !vop->is_enabled)
>   		return -ENODEV;
>   
> -	if (mstimeout <= 0)
> -		return -EINVAL;
> +	mutex_lock(&vop->vop_lock);
> +	if (mstimeout <= 0) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>   
> -	if (vop_line_flag_irq_is_enabled(vop))
> -		return -EBUSY;
> +	if (vop_line_flag_irq_is_enabled(vop)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
>   
>   	reinit_completion(&vop->line_flag_completion);
>   	vop_line_flag_irq_enable(vop);
> @@ -1506,10 +1520,13 @@ int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout)
>   
>   	if (jiffies_left == 0) {
>   		DRM_DEV_ERROR(vop->dev, "Timeout waiting for IRQ\n");
> -		return -ETIMEDOUT;
> +		ret = -ETIMEDOUT;
> +		goto out;
>   	}
>   
> -	return 0;
> +out:
> +	mutex_unlock(&vop->vop_lock);
> +	return ret;
>   }
>   EXPORT_SYMBOL(rockchip_drm_wait_vact_end);
>   
> @@ -1559,6 +1576,7 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
>   
>   	spin_lock_init(&vop->reg_lock);
>   	spin_lock_init(&vop->irq_lock);
> +	mutex_init(&vop->vop_lock);
>   
>   	ret = devm_request_irq(dev, vop->irq, vop_isr,
>   			       IRQF_SHARED, dev_name(dev), vop);
> 


Reviewed-by: Sandy huang <hjc@rock-chips.com>
