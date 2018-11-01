Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8339C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590672081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590672081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeKAVqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:46:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56620 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbeKAVqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:46:49 -0400
Received: from [IPv6:2a02:8109:92c0:207d:3d24:60ad:a75d:194d] (unknown [IPv6:2a02:8109:92c0:207d:3d24:60ad:a75d:194d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E322C260560;
        Thu,  1 Nov 2018 12:43:53 +0000 (GMT)
Subject: Re: [PATCH 1/5] drm/virtio: add virtio_gpu_alloc_fence()
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Emil Velikov <emil.velikov@collabora.com>
References: <20181025183739.9375-1-robert.foss@collabora.com>
 <20181025183739.9375-2-robert.foss@collabora.com>
 <CACvgo516JGdfBZ8zM73bQ-TCeNEbOp9ioBy9jh0AAtpUsu5tOg@mail.gmail.com>
From:   Robert Foss <robert.foss@collabora.com>
Message-ID: <1c92b6dc-4152-c81b-5180-2f48799b959f@collabora.com>
Date:   Thu, 1 Nov 2018 13:43:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACvgo516JGdfBZ8zM73bQ-TCeNEbOp9ioBy9jh0AAtpUsu5tOg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Emil,

On 2018-10-31 10:38, Emil Velikov wrote:
> Hi Rob,
> 
> On Thu, 25 Oct 2018 at 19:38, Robert Foss <robert.foss@collabora.com> wrote:
>>
>> From: Gustavo Padovan <gustavo.padovan@collabora.com>
>>
>> Refactor fence creation to remove the potential allocation failure from
>> the cmd_submit and atomic_commit paths. Now the fence should be allocated
>> first and just after we should proceed with the rest of the execution.
>>
> 
> Commit does a bit more that what the above says:
>   - dummy, factor out fence creation/destruction
>   - use per virtio_gpu_framebuffer fence
> 
> Personally I'd keep the two separate patches and elaborate on the latter.
> Obviously in that case, one will need to add 3 lines worth of
> virtio_gpu_fence_alloc() in virtio_gpu_cursor_plane_update which will be nuked
> with the next patch.
> 
> Not a big deal, but it's up-to the maintainer to make the final call if it's
> worth splitting or not.

Agreed, I'll hold off with this change until then.

> 
> Couple of minor nitpicks below.
> 
>>          struct virtio_gpu_device *vgdev = dev->dev_private;
>>          struct virtio_gpu_output *output = NULL;
>>          struct virtio_gpu_framebuffer *vgfb;
>> -       struct virtio_gpu_fence *fence = NULL;
>>          struct virtio_gpu_object *bo = NULL;
>>          uint32_t handle;
>>          int ret = 0;
> 
> Add the virtio_gpu_fence_alloc()? And yes it will be nuked with patch 2/...
> 
> 
> 
>> +struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev)
>> +{
>> +       struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
>> +       struct virtio_gpu_fence *fence = kzalloc(sizeof(struct virtio_gpu_fence), GFP_ATOMIC);
>> +       if (!fence)
>> +               return fence;
>> +
>> +       fence->drv = drv;
>> +       dma_fence_init(&fence->f, &virtio_fence_ops, &drv->lock, drv->context, 0);
> Oh no, lines over 80 col... while the original code is pretty and neat.

Ack

> 
>> +
>> +       return fence;
>> +}
>> +
>> +void virtio_gpu_fence_cleanup(struct virtio_gpu_fence *fence)
>> +{
>> +       if (!fence)
>> +               return;
>> +
>> +       if (fence->drv)
>> +               dma_fence_put(&fence->f);
>> +       else
>> +               kfree(fence);
> I'm not sure if/how we reach the else case here?

That case should never be hit, and if it is that's a bug.
Fixed in v4.

> 
>> +}
>> +
>>   int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
>>                            struct virtio_gpu_ctrl_hdr *cmd_hdr,
>> -                         struct virtio_gpu_fence **fence)
>> +                         struct virtio_gpu_fence *fence)
>>   {
> 
> With a follow-up commit, we can drop the no longer needed return type.
> Which it turns out was never checked ...
> 

Fixed during drm-misc-next rebase for v4.

> 
> 
>> @@ -319,6 +332,8 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>>                  dma_fence_put(&fence->f);
>>          }
>>          return 0;
>> +fail_fence:
> 
> The error labels seems to be called after what they do, not what
> fails. fail_backoff seems better IMHO.

Agreed. Fixed in v4.

> 
>> +ttm_eu_backoff_reservation(&ticket, &validate_list);
> Indentation seems off (or my client ate it)?

No, the indentation is bad here. Fixed in v4.

Thanks for the feedback Emil.
