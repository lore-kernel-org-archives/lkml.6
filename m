Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EFDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FD120659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FD120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeLEKgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:36:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48866 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbeLEKgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:36:24 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: robertfoss)
        with ESMTPSA id D4CD9277A03
Subject: Re: [RESEND PATCH v3] drm/msm: Move fence put to where failure occurs
To:     Rob Clark <robdclark@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>
References: <20181204165604.19462-1-robert.foss@collabora.com>
 <CAF6AEGt+SJPoTChr=zn+g8Vth_F_D39EmWGXpo3qbsUgL=638A@mail.gmail.com>
From:   Robert Foss <robert.foss@collabora.com>
Message-ID: <6a911a81-cac0-87bb-26c9-558c20efd360@collabora.com>
Date:   Wed, 5 Dec 2018 11:36:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAF6AEGt+SJPoTChr=zn+g8Vth_F_D39EmWGXpo3qbsUgL=638A@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-12-04 21:21, Rob Clark wrote:
> On Tue, Dec 4, 2018 at 11:56 AM Robert Foss <robert.foss@collabora.com> wrote:
>>
>> If dma_fence_wait fails to wait for a supplied in-fence in
>> msm_ioctl_gem_submit, make sure we release that in-fence.
>>
>> Also remove this dma_fence_put() from the 'out' label.
>>
>> Signed-off-by: Robert Foss <robert.foss@collabora.com>
>> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
>> Cc: stable@vger.kernel.org
> 
> Fyi, this is queued up in msm-next/fixes

Ah!

I had a look for it in drm=misc-next, but didn't find it.
Thanks for the heads up!

> 
> BR,
> -R
> 
> 
>> ---
>>   drivers/gpu/drm/msm/msm_gem_submit.c | 15 ++++++++-------
>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
>> index a90aedd6883a..d5e6665a4c8f 100644
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
>> @@ -444,6 +443,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>>          ring = gpu->rb[queue->prio];
>>
>>          if (args->flags & MSM_SUBMIT_FENCE_FD_IN) {
>> +               struct dma_fence *in_fence;
>> +
>>                  in_fence = sync_file_get_fence(args->fence_fd);
>>
>>                  if (!in_fence)
>> @@ -453,11 +454,13 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>>                   * Wait if the fence is from a foreign context, or if the fence
>>                   * array contains any fence from a foreign context.
>>                   */
>> -               if (!dma_fence_match_context(in_fence, ring->fctx->context)) {
>> +               ret = 0;
>> +               if (!dma_fence_match_context(in_fence, ring->fctx->context))
>>                          ret = dma_fence_wait(in_fence, true);
>> -                       if (ret)
>> -                               return ret;
>> -               }
>> +
>> +               dma_fence_put(in_fence);
>> +               if (ret)
>> +                       return ret;
>>          }
>>
>>          ret = mutex_lock_interruptible(&dev->struct_mutex);
>> @@ -583,8 +586,6 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>>          }
>>
>>   out:
>> -       if (in_fence)
>> -               dma_fence_put(in_fence);
>>          submit_cleanup(submit);
>>          if (ret)
>>                  msm_gem_submit_free(submit);
>> --
>> 2.17.1
>>
