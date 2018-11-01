Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D33C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4991F2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4991F2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeKBBaF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:30:05 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:50226 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728239AbeKBBaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:30:05 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 14317332-1500050 
        for multiple; Thu, 01 Nov 2018 16:26:18 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Robert Foss <robert.foss@collabora.com>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20181101161228.19432-1-robert.foss@collabora.com>
Cc:     Robert Foss <robert.foss@collabora.com>
References: <20181101161228.19432-1-robert.foss@collabora.com>
Message-ID: <154108957570.30246.16686926988338640470@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v1] drm/msm: Move fence put to where failure occurs
Date:   Thu, 01 Nov 2018 16:26:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robert Foss (2018-11-01 16:12:28)
> If dma_fence_wait fails to wait for a supplied in-fence in
> msm_ioctl_gem_submit, make sure we release that in-fence.
> 
> Also remove this dma_fence_put() from the 'out' label.
> 
> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> ---
>  drivers/gpu/drm/msm/msm_gem_submit.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index a90aedd6883a..3e7704af5b24 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -411,7 +411,6 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>         struct msm_file_private *ctx = file->driver_priv;
>         struct msm_gem_submit *submit;
>         struct msm_gpu *gpu = priv->gpu;
> -       struct dma_fence *in_fence = NULL;
>         struct sync_file *sync_file = NULL;
>         struct msm_gpu_submitqueue *queue;
>         struct msm_ringbuffer *ring;
> @@ -444,7 +443,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>         ring = gpu->rb[queue->prio];
>  
>         if (args->flags & MSM_SUBMIT_FENCE_FD_IN) {
> -               in_fence = sync_file_get_fence(args->fence_fd);
> +               struct dma_fence *in_fence = sync_file_get_fence(
> +                       args->fence_fd);
>  
>                 if (!in_fence)
>                         return -EINVAL;
> @@ -455,8 +455,10 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>                  */
>                 if (!dma_fence_match_context(in_fence, ring->fctx->context)) {
>                         ret = dma_fence_wait(in_fence, true);
> -                       if (ret)
> +                       if (ret) {
> +                               dma_fence_put(in_fence);
>                                 return ret;
> +                       }
>                 }

Careful, we need to keep the put for the normal path. Maybe,

if (args->flags & MSM_SUBMIT_FENCE_FD_IN) {
	struct dma_fence *in_fence;

	in_fence = sync_file_get_fence(args->fence_fd); // keep line breaks natural
	if (!in_fence)
		return -EINVAL;
	
	ret = 0;
	if (!dma_fence_match_match_context(in_fence, ring->fctx->context)
		ret = dma_fence_wait(in_fence, true);
	dma_fence_put(in_fence);
	if (ret)
		return ret;
}
