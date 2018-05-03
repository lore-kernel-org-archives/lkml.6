Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeECJJ6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:09:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750969AbeECJJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:09:56 -0400
Subject: Re: [RFC] virtio: support VIRTIO_F_IO_BARRIER
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, zhihong.wang@intel.com
References: <20180503025955.28816-1-tiwei.bie@intel.com>
 <ab66939d-47fb-5f43-3938-0c156ffc6918@redhat.com>
 <20180503083015.kb7po26ga46g66tc@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1292c46c-34ad-ea21-1f05-164044a5f35a@redhat.com>
Date: Thu, 3 May 2018 17:09:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503083015.kb7po26ga46g66tc@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月03日 16:30, Tiwei Bie wrote:
> On Thu, May 03, 2018 at 03:30:03PM +0800, Jason Wang wrote:
>> On 2018年05月03日 10:59, Tiwei Bie wrote:
>>> This patch introduces the support for VIRTIO_F_IO_BARRIER.
>>> When this feature is negotiated, driver will use the barriers
>>> suitable for hardware devices.
>>>
>>> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>>> ---
>>>    drivers/virtio/virtio_ring.c       | 5 +++++
>>>    include/uapi/linux/virtio_config.h | 8 +++++++-
>>>    2 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>> index 21d464a29cf8..edb565643bf4 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -996,6 +996,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>>>    		!context;
>>>    	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
>>> +	if (virtio_has_feature(vdev, VIRTIO_F_IO_BARRIER))
>>> +		vq->weak_barriers = false;
>>> +
>>>    	/* No callback?  Tell other side not to bother us. */
>>>    	if (!callback) {
>>>    		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
>>> @@ -1164,6 +1167,8 @@ void vring_transport_features(struct virtio_device *vdev)
>>>    			break;
>>>    		case VIRTIO_F_IOMMU_PLATFORM:
>>>    			break;
>>> +		case VIRTIO_F_IO_BARRIER:
>>> +			break;
>>>    		default:
>>>    			/* We don't understand this bit. */
>>>    			__virtio_clear_bit(vdev, i);
>>> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
>>> index 308e2096291f..6ca8d24bf468 100644
>>> --- a/include/uapi/linux/virtio_config.h
>>> +++ b/include/uapi/linux/virtio_config.h
>>> @@ -49,7 +49,7 @@
>>>     * transport being used (eg. virtio_ring), the rest are per-device feature
>>>     * bits. */
>>>    #define VIRTIO_TRANSPORT_F_START	28
>>> -#define VIRTIO_TRANSPORT_F_END		34
>>> +#define VIRTIO_TRANSPORT_F_END		38
>>>    #ifndef VIRTIO_CONFIG_NO_LEGACY
>>>    /* Do we get callbacks when the ring is completely used, even if we've
>>> @@ -71,4 +71,10 @@
>>>     * this is for compatibility with legacy systems.
>>>     */
>>>    #define VIRTIO_F_IOMMU_PLATFORM		33
>>> +
>>> +/*
>>> + * If clear - driver may use barriers suitable for CPU cores.
>>> + * If set - driver must use barriers suitable for hardware devices.
>>> + */
>>> +#define VIRTIO_F_IO_BARRIER		37
>>>    #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
>> Hi:
>>
>> I believe this depends on Michael's patch of
>>
>> "[PATCH] virtio_ring: switch to dma_XX barriers for rpmsg"
>>
>> ?
>>
>> Thanks
> We already have below commit and some other related commits
> in the tree:
>
> 7b21e34fd1c2 ("virtio: harsher barriers for rpmsg.")
>
> They should have already guaranteed that virtio_Xmb() will
> be OK for hardware devices when vq->weak_barriers is false.
> If my understanding is correct, the barriers used in this
> case are overkill. So Michael's patch is to make the barriers
> weaker (or better).
>
> Best regards,
> Tiwei Bie

Well, I think we need dma barriers for some platforms according to 
previous discussion? Without Michael's patch, we won't use any dma 
barriers in fact for virtio.

Thanks
