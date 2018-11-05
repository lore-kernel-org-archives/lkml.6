Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513FDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685352146D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685352146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbeKFD3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:29:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50274 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387640AbeKFD3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:29:12 -0500
Received: from [IPv6:2a02:8109:92c0:207d:797b:9adc:b59e:ee7c] (unknown [IPv6:2a02:8109:92c0:207d:797b:9adc:b59e:ee7c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5445D260E1F;
        Mon,  5 Nov 2018 18:08:20 +0000 (GMT)
Subject: Re: [PATCH v4 3/4] drm/virtio: add in/out fence support for explicit
 synchronization
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Emil Velikov <emil.velikov@collabora.com>
References: <20181105114152.2088-1-robert.foss@collabora.com>
 <20181105114152.2088-4-robert.foss@collabora.com>
 <CACvgo53vCBbgmu4OV4e0WeOYQSXNk=3qwyRBtPx+XAcCSZO8aQ@mail.gmail.com>
From:   Robert Foss <robert.foss@collabora.com>
Message-ID: <995bbb2f-ecaa-e4f5-045b-b9cc7b287a66@collabora.com>
Date:   Mon, 5 Nov 2018 19:08:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACvgo53vCBbgmu4OV4e0WeOYQSXNk=3qwyRBtPx+XAcCSZO8aQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heya,

On 2018-11-05 18:25, Emil Velikov wrote:
> On Mon, 5 Nov 2018 at 11:42, Robert Foss <robert.foss@collabora.com> wrote:
>>
>> When the execbuf call receives an in-fence it will get the dma_fence
>> related to that fence fd and wait on it before submitting the draw call.
>>
>> On the out-fence side we get fence returned by the submitted draw call
>> and attach it to a sync_file and send the sync_file fd to userspace. On
>> error -1 is returned to userspace.
>>
>> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
>> Signed-off-by: Robert Foss <robert.foss@collabora.com>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
>> ---
>>
>> Changes since v3:
>>   - Move all in_fence handling to the same VIRTGPU_EXECBUF_FENCE_FD_IN block
> Fwiw my suggestion was to explicitly document whether the IOCTL can
> support, simultaneously, IN and OUT fence.
I can't say I understood that part, but I'll happily spin another revision
with more documentation added.

But the change above does not entirely come from your feedback.
While looking into how other drivers do this, an issue in msm was found.
Since this code is being added to virtgpu now, we might as well do the
right thing here, and also end up with all of the in fence handling in a
single chunk.

> Merging the two patches makes things a bit meh. But as before - it's
> for Gerd to make the final call.
> 
> -Emil
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
