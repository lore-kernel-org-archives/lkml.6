Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0D4C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C567218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfAYJVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:21:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfAYJVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:21:40 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6982C7C854;
        Fri, 25 Jan 2019 09:21:39 +0000 (UTC)
Received: from [10.72.12.101] (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F4A66019F;
        Fri, 25 Jan 2019 09:21:34 +0000 (UTC)
Subject: Re: [PATCH net-next V4 5/5] vhost: access vq metadata through kernel
 virtual address
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        aarcange@redhat.com
References: <20190123095557.30168-1-jasowang@redhat.com>
 <20190123095557.30168-6-jasowang@redhat.com>
 <20190124214402-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <42a63594-a4b9-1b7b-2566-544853880317@redhat.com>
Date:   Fri, 25 Jan 2019 17:21:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124214402-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 25 Jan 2019 09:21:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/25 上午11:03, Michael S. Tsirkin wrote:
> On Wed, Jan 23, 2019 at 05:55:57PM +0800, Jason Wang wrote:
>> It was noticed that the copy_user() friends that was used to access
>> virtqueue metdata tends to be very expensive for dataplane
>> implementation like vhost since it involves lots of software checks,
>> speculation barrier, hardware feature toggling (e.g SMAP). The
>> extra cost will be more obvious when transferring small packets since
>> the time spent on metadata accessing become more significant.
>>
>> This patch tries to eliminate those overheads by accessing them
>> through kernel virtual address by vmap(). To make the pages can be
>> migrated, instead of pinning them through GUP, we use MMU notifiers to
>> invalidate vmaps and re-establish vmaps during each round of metadata
>> prefetching if necessary. For devices that doesn't use metadata
>> prefetching, the memory accessors fallback to normal copy_user()
>> implementation gracefully. The invalidation was synchronized with
>> datapath through vq mutex, and in order to avoid hold vq mutex during
>> range checking, MMU notifier was teared down when trying to modify vq
>> metadata.
>>
>> Another thing is kernel lacks efficient solution for tracking dirty
>> pages by vmap(), this will lead issues if vhost is using file backed
>> memory which needs care of writeback. This patch solves this issue by
>> just skipping the vma that is file backed and fallback to normal
>> copy_user() friends. This might introduce some overheads for file
>> backed users but consider this use case is rare we could do
>> optimizations on top.
>>
>> Note that this was only done when device IOTLB is not enabled. We
>> could use similar method to optimize it in the future.
>>
>> Tests shows at most about 22% improvement on TX PPS when using
>> virtio-user + vhost_net + xdp1 + TAP on 2.6GHz Broadwell:
>>
>>          SMAP on | SMAP off
>> Before: 5.0Mpps | 6.6Mpps
>> After:  6.1Mpps | 7.4Mpps
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/vhost/vhost.c | 288 +++++++++++++++++++++++++++++++++++++++++-
>>   drivers/vhost/vhost.h |  13 ++
>>   mm/shmem.c            |   1 +
>>   3 files changed, 300 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 37e2cac8e8b0..096ae3298d62 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -440,6 +440,9 @@ void vhost_dev_init(struct vhost_dev *dev,
>>   		vq->indirect = NULL;
>>   		vq->heads = NULL;
>>   		vq->dev = dev;
>> +		memset(&vq->avail_ring, 0, sizeof(vq->avail_ring));
>> +		memset(&vq->used_ring, 0, sizeof(vq->used_ring));
>> +		memset(&vq->desc_ring, 0, sizeof(vq->desc_ring));
>>   		mutex_init(&vq->mutex);
>>   		vhost_vq_reset(dev, vq);
>>   		if (vq->handle_kick)
>> @@ -510,6 +513,73 @@ static size_t vhost_get_desc_size(struct vhost_virtqueue *vq, int num)
>>   	return sizeof(*vq->desc) * num;
>>   }
>>   
>> +static void vhost_uninit_vmap(struct vhost_vmap *map)
>> +{
>> +	if (map->addr)
>> +		vunmap(map->unmap_addr);
>> +
>> +	map->addr = NULL;
>> +	map->unmap_addr = NULL;
>> +}
>> +
>> +static int vhost_invalidate_vmap(struct vhost_virtqueue *vq,
>> +				 struct vhost_vmap *map,
>> +				 unsigned long ustart,
>> +				 size_t size,
>> +				 unsigned long start,
>> +				 unsigned long end,
>> +				 bool blockable)
>> +{
>> +	if (end < ustart || start > ustart - 1 + size)
>> +		return 0;
>> +
>> +	if (!blockable)
>> +		return -EAGAIN;
>> +
>> +	mutex_lock(&vq->mutex);
>> +	vhost_uninit_vmap(map);
>> +	mutex_unlock(&vq->mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +static int vhost_invalidate_range_start(struct mmu_notifier *mn,
>> +					const struct mmu_notifier_range *range)
>> +{
>> +	struct vhost_dev *dev = container_of(mn, struct vhost_dev,
>> +					     mmu_notifier);
>> +	int i;
>> +
>> +	for (i = 0; i < dev->nvqs; i++) {
>> +		struct vhost_virtqueue *vq = dev->vqs[i];
>> +
>> +		if (vhost_invalidate_vmap(vq, &vq->avail_ring,
>> +					  (unsigned long)vq->avail,
>> +					  vhost_get_avail_size(vq, vq->num),
>> +					  range->start, range->end,
>> +					  range->blockable))
>> +			return -EAGAIN;
>> +		if (vhost_invalidate_vmap(vq, &vq->desc_ring,
>> +					  (unsigned long)vq->desc,
>> +					  vhost_get_desc_size(vq, vq->num),
>> +					  range->start, range->end,
>> +					  range->blockable))
>> +			return -EAGAIN;
>> +		if (vhost_invalidate_vmap(vq, &vq->used_ring,
>> +					  (unsigned long)vq->used,
>> +					  vhost_get_used_size(vq, vq->num),
>> +					  range->start, range->end,
>> +					  range->blockable))
>> +			return -EAGAIN;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct mmu_notifier_ops vhost_mmu_notifier_ops = {
>> +	.invalidate_range_start = vhost_invalidate_range_start,
>> +};
>> +
>>   /* Caller should have device mutex */
>>   long vhost_dev_set_owner(struct vhost_dev *dev)
>>   {
> It seems questionable to merely track .invalidate_range_start.
> Don't we care about keeping pages young/accessed?


My understanding is the young stuffs were only needed for secondary MMU 
where the hva is not used. This is not the case of vhost since anyway 
guest will access those pages through userspace address.


> MMU will think they aren't and will penalize vhost by pushing
> them out.
>
> I note that MMU documentation says
>          * invalidate_range_start() and invalidate_range_end() must be
>           * paired
> and it seems questionable that they are not paired here.


I can see some users with the unpaired invalidate_range_start(). Maybe I 
miss something but I can not find anything that we need to do after the 
page is unmaped.


>
>
> I also wonder about things like write-protecting the pages.
> It does not look like a range is invalidated when page
> is write-protected, even though I might have missed that.
> If not we can be corrupting memory in a variety of ways
> e.g. when using KSM, or with COW.


Yes, we probably need to implement change_pte() method which will do 
vunmap().

Thanks

