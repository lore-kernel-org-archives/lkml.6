Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeDBFXX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 01:23:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55426 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbeDBFXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 01:23:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A0806022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v2 4/6] drm/msm: Issue queued events when disabling crtc
To: Sean Paul <seanpaul@chromium.org>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: robdclark@gmail.com, hoegsberg@chromium.org, jsanka@codeaurora.org,
        abhinavk@codeaurora.org, linux-kernel@vger.kernel.org
References: <20180328190657.218661-1-seanpaul@chromium.org>
 <20180328190657.218661-5-seanpaul@chromium.org>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <0d69abf7-c425-2bd1-ef66-de465c46896d@codeaurora.org>
Date: Mon, 2 Apr 2018 10:53:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328190657.218661-5-seanpaul@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 29 March 2018 12:36 AM, Sean Paul wrote:
> Ensure that any queued events are issued when disabling the crtc. This
> avoids timeouts when we come back and wait for dependencies (like the
> previous frame's flip_done).

Reviewed-by: Archit Taneja <architt@codeaurora.org>

> 
> Changes in v2:
> - None
> 
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> index 76b96081916f..10271359789e 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> @@ -430,6 +430,7 @@ static void mdp5_crtc_atomic_disable(struct drm_crtc *crtc,
>   	struct mdp5_crtc_state *mdp5_cstate = to_mdp5_crtc_state(crtc->state);
>   	struct mdp5_kms *mdp5_kms = get_kms(crtc);
>   	struct device *dev = &mdp5_kms->pdev->dev;
> +	unsigned long flags;
>   
>   	DBG("%s", crtc->name);
>   
> @@ -445,6 +446,14 @@ static void mdp5_crtc_atomic_disable(struct drm_crtc *crtc,
>   	mdp_irq_unregister(&mdp5_kms->base, &mdp5_crtc->err);
>   	pm_runtime_put_sync(dev);
>   
> +	if (crtc->state->event && !crtc->state->active) {
> +		WARN_ON(mdp5_crtc->event);
> +		spin_lock_irqsave(&mdp5_kms->dev->event_lock, flags);
> +		drm_crtc_send_vblank_event(crtc, crtc->state->event);
> +		crtc->state->event = NULL;
> +		spin_unlock_irqrestore(&mdp5_kms->dev->event_lock, flags);
> +	}
> +
>   	mdp5_crtc->enabled = false;
>   }
>   
> 
