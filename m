Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70CAC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9F72064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9F72064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeKBCMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:12:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57832 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKBCMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:12:05 -0400
Received: from [IPv6:2a02:8109:92c0:207d:3d24:60ad:a75d:194d] (unknown [IPv6:2a02:8109:92c0:207d:3d24:60ad:a75d:194d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 541172605F9;
        Thu,  1 Nov 2018 17:08:14 +0000 (GMT)
Subject: Re: [PATCH v1] drm/msm: Move fence put to where failure occurs
To:     Chris Wilson <chris@chris-wilson.co.uk>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com
References: <20181101161228.19432-1-robert.foss@collabora.com>
 <154108957570.30246.16686926988338640470@skylake-alporthouse-com>
From:   Robert Foss <robert.foss@collabora.com>
Message-ID: <8153c015-a082-1897-a486-6fe2c5166168@collabora.com>
Date:   Thu, 1 Nov 2018 18:08:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154108957570.30246.16686926988338640470@skylake-alporthouse-com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Chris,

On 2018-11-01 17:26, Chris Wilson wrote:
> Quoting Robert Foss (2018-11-01 16:12:28)
>> If dma_fence_wait fails to wait for a supplied in-fence in
>> msm_ioctl_gem_submit, make sure we release that in-fence.
>>
>> Also remove this dma_fence_put() from the 'out' label.
>>
>> Signed-off-by: Robert Foss <robert.foss@collabora.com>
>> ---
>>   drivers/gpu/drm/msm/msm_gem_submit.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
>> index a90aedd6883a..3e7704af5b24 100644
>> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
>> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
>> @@ -411,7 +411,6 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>>          struct msm_file_private *ctx = file->driver_priv;
>>          struct msm_gem_submit *submit;
>>          struct msm_gpu *gpu = priv->gpu;
>> -       struct dma_fence *in_fence = NULL;
>>          struct sync_file *sync_file = NULL;
>>          struct msm_gpu_submitqueue *queue;
>>          struct msm_ringbuffer *ring;
>> @@ -444,7 +443,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>>          ring = gpu->rb[queue->prio];
>>   
>>          if (args->flags & MSM_SUBMIT_FENCE_FD_IN) {
>> -               in_fence = sync_file_get_fence(args->fence_fd);
>> +               struct dma_fence *in_fence = sync_file_get_fence(
>> +                       args->fence_fd);
>>   
>>                  if (!in_fence)
>>                          return -EINVAL;
>> @@ -455,8 +455,10 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>>                   */
>>                  if (!dma_fence_match_context(in_fence, ring->fctx->context)) {
>>                          ret = dma_fence_wait(in_fence, true);
>> -                       if (ret)
>> +                       if (ret) {
>> +                               dma_fence_put(in_fence);
>>                                  return ret;
>> +                       }
>>                  }
> 
> Careful, we need to keep the put for the normal path. Maybe,

Good catch, I'll send out a fixed version tomorrow.

> 
> if (args->flags & MSM_SUBMIT_FENCE_FD_IN) {
> 	struct dma_fence *in_fence;
> 
> 	in_fence = sync_file_get_fence(args->fence_fd); // keep line breaks natural
> 	if (!in_fence)
> 		return -EINVAL;
> 	
> 	ret = 0;
> 	if (!dma_fence_match_match_context(in_fence, ring->fctx->context)
> 		ret = dma_fence_wait(in_fence, true);
> 	dma_fence_put(in_fence);
> 	if (ret)
> 		return ret;
> }
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
