Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9128C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC7920657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC7920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeKAV7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:59:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56730 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeKAV7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:59:32 -0400
Received: from [IPv6:2a02:8109:92c0:207d:3d24:60ad:a75d:194d] (unknown [IPv6:2a02:8109:92c0:207d:3d24:60ad:a75d:194d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E61A526398E;
        Thu,  1 Nov 2018 12:56:38 +0000 (GMT)
Subject: Re: [PATCH 2/5] drm/virtio: add uapi for in and out explicit fences
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
References: <20181025183739.9375-1-robert.foss@collabora.com>
 <20181025183739.9375-3-robert.foss@collabora.com>
 <CACvgo51LU3dAfO-jNcV02ZyYBOv8fKLhG_2QyRrB9XYfGJrzHQ@mail.gmail.com>
From:   Robert Foss <robert.foss@collabora.com>
Message-ID: <3a8a03d6-a544-b9f3-15a2-f6a2411bdb28@collabora.com>
Date:   Thu, 1 Nov 2018 13:56:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACvgo51LU3dAfO-jNcV02ZyYBOv8fKLhG_2QyRrB9XYfGJrzHQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-10-31 10:38, Emil Velikov wrote:
> Hi Rob,
> 
> On Thu, 25 Oct 2018 at 19:38, Robert Foss <robert.foss@collabora.com> wrote:
>>
>> Add a new field called fence_fd that will be used by userspace to send
>> in-fences to the kernel and receive out-fences created by the kernel.
>>
>> This uapi enables virtio to take advantage of explicit synchronization of
>> dma-bufs.
>>
>> There are two new flags:
>>
>> * VIRTGPU_EXECBUF_FENCE_FD_IN to be used when passing an in-fence fd.
>> * VIRTGPU_EXECBUF_FENCE_FD_OUT to be used when requesting an out-fence fd
>>
>> The execbuffer IOCTL is now read-write to allow the userspace to read the
>> out-fence.
>>
>> On error -1 should be returned in the fence_fd field.
>>
>> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
>> Signed-off-by: Robert Foss <robert.foss@collabora.com>
>> ---
>> Changes since v2:
>>   - Since exbuf-flags is a new flag, check that unsupported
>>     flags aren't set.
>>
>>   drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
>>   include/uapi/drm/virtgpu_drm.h         | 13 ++++++++++---
>>   2 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> index d01a9ed100d1..1af289b28fc4 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> @@ -116,9 +116,14 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>>          struct ww_acquire_ctx ticket;
>>          void *buf;
>>
>> +       exbuf->fence_fd = -1;
>> +
> Move this after the sanity checking.

Agreed. Fixed in v4

> 
>>          if (vgdev->has_virgl_3d == false)
>>                  return -ENOSYS;
>>
>> +       if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
>> +               return -EINVAL;
>> +
> I assume this did this trigger when using old userspace?

No, not as far as I'm aware. This check is there to prevent userspace from
polluting the bitspace of flag, so that all free bits can be used for new flags.

As far as I understand this is pointed out by a drm driver development document
written by danvet, which I unfortunately can't seem to find the link for at the
moment.

> 
> With those the patch is
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
> 
> Thanks
> Emil
> 
