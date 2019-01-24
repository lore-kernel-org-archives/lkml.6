Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48047C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143272184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfAXELh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:11:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfAXELh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 23:11:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 513187D0F1;
        Thu, 24 Jan 2019 04:11:36 +0000 (UTC)
Received: from [10.72.12.164] (ovpn-12-164.pek2.redhat.com [10.72.12.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 041B710021B1;
        Thu, 24 Jan 2019 04:11:30 +0000 (UTC)
Subject: Re: [PATCH net-next V4 5/5] vhost: access vq metadata through kernel
 virtual address
From:   Jason Wang <jasowang@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20190123095557.30168-1-jasowang@redhat.com>
 <20190123095557.30168-6-jasowang@redhat.com>
 <20190123085821-mutt-send-email-mst@kernel.org>
 <335ba55b-087f-4b35-6311-540070b9647f@redhat.com>
Message-ID: <4521d3d8-561e-53f5-98e1-bf7ace003701@redhat.com>
Date:   Thu, 24 Jan 2019 12:11:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <335ba55b-087f-4b35-6311-540070b9647f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 24 Jan 2019 04:11:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/24 下午12:07, Jason Wang wrote:
>
> On 2019/1/23 下午10:08, Michael S. Tsirkin wrote:
>> On Wed, Jan 23, 2019 at 05:55:57PM +0800, Jason Wang wrote:
>>> It was noticed that the copy_user() friends that was used to access
>>> virtqueue metdata tends to be very expensive for dataplane
>>> implementation like vhost since it involves lots of software checks,
>>> speculation barrier, hardware feature toggling (e.g SMAP). The
>>> extra cost will be more obvious when transferring small packets since
>>> the time spent on metadata accessing become more significant.
>>>
>>> This patch tries to eliminate those overheads by accessing them
>>> through kernel virtual address by vmap(). To make the pages can be
>>> migrated, instead of pinning them through GUP, we use MMU notifiers to
>>> invalidate vmaps and re-establish vmaps during each round of metadata
>>> prefetching if necessary. For devices that doesn't use metadata
>>> prefetching, the memory accessors fallback to normal copy_user()
>>> implementation gracefully. The invalidation was synchronized with
>>> datapath through vq mutex, and in order to avoid hold vq mutex during
>>> range checking, MMU notifier was teared down when trying to modify vq
>>> metadata.
>>>
>>> Another thing is kernel lacks efficient solution for tracking dirty
>>> pages by vmap(), this will lead issues if vhost is using file backed
>>> memory which needs care of writeback. This patch solves this issue by
>>> just skipping the vma that is file backed and fallback to normal
>>> copy_user() friends. This might introduce some overheads for file
>>> backed users but consider this use case is rare we could do
>>> optimizations on top.
>>>
>>> Note that this was only done when device IOTLB is not enabled. We
>>> could use similar method to optimize it in the future.
>>>
>>> Tests shows at most about 22% improvement on TX PPS when using
>>> virtio-user + vhost_net + xdp1 + TAP on 2.6GHz Broadwell:
>>>
>>>          SMAP on | SMAP off
>>> Before: 5.0Mpps | 6.6Mpps
>>> After:  6.1Mpps | 7.4Mpps
>>>
>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>
>> So this is the bulk of the change.
>> Threee things that I need to look into
>> - Are there any security issues with bypassing the speculation barrier
>>    that is normally present after access_ok?
>
>
> If we can make sure the bypassing was only used in a kthread (vhost), 
> it should be fine I think.
>
>
>> - How hard does the special handling for
>>    file backed storage make testing?
>
>
> It's as simple as un-commenting vhost_can_vmap()? Or I can try to hack 
> qemu or dpdk to test this.
>
>
>>    On the one hand we could add a module parameter to
>>    force copy to/from user. on the other that's
>>    another configuration we need to support.
>
>
> That sounds sub-optimal since it leave the choice to users.
>
>
>>    But iotlb is not using vmap, so maybe that's enough
>>    for testing.
>> - How hard is it to figure out which mode uses which code.


It's as simple as tracing __get_user() usage in vhost process?

Thanks


>>
>>
>>
>> Meanwhile, could you pls post data comparing this last patch with the
>> below?  This removes the speculation barrier replacing it with a
>> (useless but at least more lightweight) data dependency.
>
>
> SMAP off
>
> Your patch: 7.2MPPs
>
> vmap: 7.4Mpps
>
> I don't test SMAP on, since it will be much slow for sure.
>
> Thanks
>
>
>>
>> Thanks!
>>
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index bac939af8dbb..352ee7e14476 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -739,7 +739,7 @@ static int vhost_copy_to_user(struct 
>> vhost_virtqueue *vq, void __user *to,
>>       int ret;
>>         if (!vq->iotlb)
>> -        return __copy_to_user(to, from, size);
>> +        return copy_to_user(to, from, size);
>>       else {
>>           /* This function should be called after iotlb
>>            * prefetch, which means we're sure that all vq
>> @@ -752,7 +752,7 @@ static int vhost_copy_to_user(struct 
>> vhost_virtqueue *vq, void __user *to,
>>                        VHOST_ADDR_USED);
>>             if (uaddr)
>> -            return __copy_to_user(uaddr, from, size);
>> +            return copy_to_user(uaddr, from, size);
>>             ret = translate_desc(vq, (u64)(uintptr_t)to, size, 
>> vq->iotlb_iov,
>>                        ARRAY_SIZE(vq->iotlb_iov),
>> @@ -774,7 +774,7 @@ static int vhost_copy_from_user(struct 
>> vhost_virtqueue *vq, void *to,
>>       int ret;
>>         if (!vq->iotlb)
>> -        return __copy_from_user(to, from, size);
>> +        return copy_from_user(to, from, size);
>>       else {
>>           /* This function should be called after iotlb
>>            * prefetch, which means we're sure that vq
>> @@ -787,7 +787,7 @@ static int vhost_copy_from_user(struct 
>> vhost_virtqueue *vq, void *to,
>>           struct iov_iter f;
>>             if (uaddr)
>> -            return __copy_from_user(to, uaddr, size);
>> +            return copy_from_user(to, uaddr, size);
>>             ret = translate_desc(vq, (u64)(uintptr_t)from, size, 
>> vq->iotlb_iov,
>>                        ARRAY_SIZE(vq->iotlb_iov),
>> @@ -855,13 +855,13 @@ static inline void __user 
>> *__vhost_get_user(struct vhost_virtqueue *vq,
>>   ({ \
>>       int ret = -EFAULT; \
>>       if (!vq->iotlb) { \
>> -        ret = __put_user(x, ptr); \
>> +        ret = put_user(x, ptr); \
>>       } else { \
>>           __typeof__(ptr) to = \
>>               (__typeof__(ptr)) __vhost_get_user(vq, ptr,    \
>>                         sizeof(*ptr), VHOST_ADDR_USED); \
>>           if (to != NULL) \
>> -            ret = __put_user(x, to); \
>> +            ret = put_user(x, to); \
>>           else \
>>               ret = -EFAULT;    \
>>       } \
>> @@ -872,14 +872,14 @@ static inline void __user 
>> *__vhost_get_user(struct vhost_virtqueue *vq,
>>   ({ \
>>       int ret; \
>>       if (!vq->iotlb) { \
>> -        ret = __get_user(x, ptr); \
>> +        ret = get_user(x, ptr); \
>>       } else { \
>>           __typeof__(ptr) from = \
>>               (__typeof__(ptr)) __vhost_get_user(vq, ptr, \
>>                                  sizeof(*ptr), \
>>                                  type); \
>>           if (from != NULL) \
>> -            ret = __get_user(x, from); \
>> +            ret = get_user(x, from); \
>>           else \
>>               ret = -EFAULT; \
>>       } \
