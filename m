Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35771C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B1520863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B1520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeLAAK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:10:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbeLAAK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:10:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 677BB3078A23;
        Fri, 30 Nov 2018 13:01:12 +0000 (UTC)
Received: from [10.36.112.44] (ovpn-112-44.ams2.redhat.com [10.36.112.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45DCB1054FD4;
        Fri, 30 Nov 2018 13:01:08 +0000 (UTC)
Subject: Re: [PATCH net-next v3 01/13] virtio: add packed ring types and
 macros
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20181121100330.24846-1-tiwei.bie@intel.com>
 <20181121100330.24846-2-tiwei.bie@intel.com>
 <1928ac96-3684-45c4-1e8c-09dff03bf308@redhat.com>
 <20181130095339.GA11984@debian>
 <20181130074720-mutt-send-email-mst@kernel.org>
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <13593b5c-c1dc-3ab3-a843-d62908e0c7e0@redhat.com>
Date:   Fri, 30 Nov 2018 14:01:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130074720-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 30 Nov 2018 13:01:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/18 1:47 PM, Michael S. Tsirkin wrote:
> On Fri, Nov 30, 2018 at 05:53:40PM +0800, Tiwei Bie wrote:
>> On Fri, Nov 30, 2018 at 04:10:55PM +0800, Jason Wang wrote:
>>>
>>> On 2018/11/21 下午6:03, Tiwei Bie wrote:
>>>> Add types and macros for packed ring.
>>>>
>>>> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>>>> ---
>>>>    include/uapi/linux/virtio_config.h |  3 +++
>>>>    include/uapi/linux/virtio_ring.h   | 52 ++++++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 55 insertions(+)
>>>>
>>>> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
>>>> index 449132c76b1c..1196e1c1d4f6 100644
>>>> --- a/include/uapi/linux/virtio_config.h
>>>> +++ b/include/uapi/linux/virtio_config.h
>>>> @@ -75,6 +75,9 @@
>>>>     */
>>>>    #define VIRTIO_F_IOMMU_PLATFORM		33
>>>> +/* This feature indicates support for the packed virtqueue layout. */
>>>> +#define VIRTIO_F_RING_PACKED		34
>>>> +
>>>>    /*
>>>>     * Does the device support Single Root I/O Virtualization?
>>>>     */
>>>> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
>>>> index 6d5d5faa989b..2414f8af26b3 100644
>>>> --- a/include/uapi/linux/virtio_ring.h
>>>> +++ b/include/uapi/linux/virtio_ring.h
>>>> @@ -44,6 +44,13 @@
>>>>    /* This means the buffer contains a list of buffer descriptors. */
>>>>    #define VRING_DESC_F_INDIRECT	4
>>>> +/*
>>>> + * Mark a descriptor as available or used in packed ring.
>>>> + * Notice: they are defined as shifts instead of shifted values.
>>>
>>>
>>> This looks inconsistent to previous flags, any reason for using shifts?
>>
>> Yeah, it was suggested to use shifts, as _F_ should be a bit
>> number, not a shifted value:
>>
>> https://patchwork.ozlabs.org/patch/942296/#1989390
> 
> But let's add a _SPLIT_ variant that uses shifts consistently.

Maybe we could avoid adding SPLIT and PACKED, but define as follow:

#define VRING_DESC_F_INDIRECT_SHIFT 2
#define VRING_DESC_F_INDIRECT (1ull <<  VRING_DESC_F_INDIRECT_SHIFT)

#define VRING_DESC_F_AVAIL_SHIFT 7
#define VRING_DESC_F_AVAIL (1ull << VRING_DESC_F_AVAIL_SHIFT)

I think it would be better for consistency.
> 
> 
>>>
>>>
>>>> + */
>>>> +#define VRING_PACKED_DESC_F_AVAIL	7
>>>> +#define VRING_PACKED_DESC_F_USED	15
>>>> +
>>>>    /* The Host uses this in used->flags to advise the Guest: don't kick me when
>>>>     * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
>>>>     * will still kick if it's out of buffers. */
>>>> @@ -53,6 +60,23 @@
>>>>     * optimization.  */
>>>>    #define VRING_AVAIL_F_NO_INTERRUPT	1
>>>> +/* Enable events in packed ring. */
>>>> +#define VRING_PACKED_EVENT_FLAG_ENABLE	0x0
>>>> +/* Disable events in packed ring. */
>>>> +#define VRING_PACKED_EVENT_FLAG_DISABLE	0x1
>>>> +/*
>>>> + * Enable events for a specific descriptor in packed ring.
>>>> + * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
>>>> + * Only valid if VIRTIO_RING_F_EVENT_IDX has been negotiated.
>>>> + */
>>>> +#define VRING_PACKED_EVENT_FLAG_DESC	0x2
>>>
>>>
>>> Any reason for using _FLAG_ instead of _F_?
>>
>> Yeah, it was suggested to not use _F_, as these are values,
>> should not have _F_:
>>
>> https://patchwork.ozlabs.org/patch/942296/#1989390
>>
>> Regards,
>> Tiwei
>>
>>>
>>> Thanks
>>>
>>>
>>>> +
>>>> +/*
>>>> + * Wrap counter bit shift in event suppression structure
>>>> + * of packed ring.
>>>> + */
>>>> +#define VRING_PACKED_EVENT_F_WRAP_CTR	15
>>>> +
>>>>    /* We support indirect buffer descriptors */
>>>>    #define VIRTIO_RING_F_INDIRECT_DESC	28
>>>> @@ -171,4 +195,32 @@ static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
>>>>    	return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old);
>>>>    }
>>>> +struct vring_packed_desc_event {
>>>> +	/* Descriptor Ring Change Event Offset/Wrap Counter. */
>>>> +	__le16 off_wrap;
>>>> +	/* Descriptor Ring Change Event Flags. */
>>>> +	__le16 flags;
>>>> +};
>>>> +
>>>> +struct vring_packed_desc {
>>>> +	/* Buffer Address. */
>>>> +	__le64 addr;
>>>> +	/* Buffer Length. */
>>>> +	__le32 len;
>>>> +	/* Buffer ID. */
>>>> +	__le16 id;
>>>> +	/* The flags depending on descriptor type. */
>>>> +	__le16 flags;
>>>> +};
>>>> +
>>>> +struct vring_packed {
>>>> +	unsigned int num;
>>>> +
>>>> +	struct vring_packed_desc *desc;
>>>> +
>>>> +	struct vring_packed_desc_event *driver;
>>>> +
>>>> +	struct vring_packed_desc_event *device;
>>>> +};
>>>> +
>>>>    #endif /* _UAPI_LINUX_VIRTIO_RING_H */
