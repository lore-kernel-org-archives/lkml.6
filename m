Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbeDBFWL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 01:22:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54970 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeDBFWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 01:22:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4C426022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v2 2/6] drm/msm: Refactor complete_commit() to look more
 the helpers
To: Sean Paul <seanpaul@chromium.org>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: robdclark@gmail.com, hoegsberg@chromium.org, jsanka@codeaurora.org,
        abhinavk@codeaurora.org, linux-kernel@vger.kernel.org
References: <20180328190657.218661-1-seanpaul@chromium.org>
 <20180328190657.218661-3-seanpaul@chromium.org>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <df0760a7-c3c2-fb9a-d5c4-2a74d9792fc8@codeaurora.org>
Date: Mon, 2 Apr 2018 10:52:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328190657.218661-3-seanpaul@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 29 March 2018 12:36 AM, Sean Paul wrote:
> Factor out the commit_tail() portions of complete_commit() into a
> separate function to facilitate moving to the atomic helpers in future
> patches.
> 

Reviewed-by: Archit Taneja <architt@codeaurora.org>

> Changes in v2:
> - None
> 
> Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>   drivers/gpu/drm/msm/msm_atomic.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
> index e792158676aa..671a18ee977d 100644
> --- a/drivers/gpu/drm/msm/msm_atomic.c
> +++ b/drivers/gpu/drm/msm/msm_atomic.c
> @@ -97,18 +97,12 @@ static void msm_atomic_wait_for_commit_done(struct drm_device *dev,
>   	}
>   }
>   
> -/* The (potentially) asynchronous part of the commit.  At this point
> - * nothing can fail short of armageddon.
> - */
> -static void complete_commit(struct msm_commit *c, bool async)
> +static void msm_atomic_commit_tail(struct drm_atomic_state *state)
>   {
> -	struct drm_atomic_state *state = c->state;
>   	struct drm_device *dev = state->dev;
>   	struct msm_drm_private *priv = dev->dev_private;
>   	struct msm_kms *kms = priv->kms;
>   
> -	drm_atomic_helper_wait_for_fences(dev, state, false);
> -
>   	kms->funcs->prepare_commit(kms, state);
>   
>   	drm_atomic_helper_commit_modeset_disables(dev, state);
> @@ -135,6 +129,19 @@ static void complete_commit(struct msm_commit *c, bool async)
>   	drm_atomic_helper_cleanup_planes(dev, state);
>   
>   	kms->funcs->complete_commit(kms, state);
> +}
> +
> +/* The (potentially) asynchronous part of the commit.  At this point
> + * nothing can fail short of armageddon.
> + */
> +static void complete_commit(struct msm_commit *c)
> +{
> +	struct drm_atomic_state *state = c->state;
> +	struct drm_device *dev = state->dev;
> +
> +	drm_atomic_helper_wait_for_fences(dev, state, false);
> +
> +	msm_atomic_commit_tail(state);
>   
>   	drm_atomic_state_put(state);
>   
> @@ -143,7 +150,7 @@ static void complete_commit(struct msm_commit *c, bool async)
>   
>   static void commit_worker(struct work_struct *work)
>   {
> -	complete_commit(container_of(work, struct msm_commit, work), true);
> +	complete_commit(container_of(work, struct msm_commit, work));
>   }
>   
>   /**
> @@ -242,7 +249,7 @@ int msm_atomic_commit(struct drm_device *dev,
>   		return 0;
>   	}
>   
> -	complete_commit(c, false);
> +	complete_commit(c);
>   
>   	return 0;
>   
> 
