Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2584C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9491A24740
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9491A24740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933026AbeGDF0j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 01:26:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752975AbeGDF0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 01:26:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BB79401DEA8;
        Wed,  4 Jul 2018 05:26:37 +0000 (UTC)
Received: from [10.72.12.45] (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4336510FD2A1;
        Wed,  4 Jul 2018 05:26:26 +0000 (UTC)
Subject: Re: [PATCH net-next 6/8] virtio: introduce packed ring defines
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wexu@redhat.com,
        maxime.coquelin@redhat.com, jfreimann@redhat.com
References: <1530596284-4101-1-git-send-email-jasowang@redhat.com>
 <1530596284-4101-7-git-send-email-jasowang@redhat.com>
 <20180704044823.GA22808@debian>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <81c82dfe-54f9-671c-695a-68c309fa1b73@redhat.com>
Date:   Wed, 4 Jul 2018 13:26:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704044823.GA22808@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 04 Jul 2018 05:26:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 04 Jul 2018 05:26:37 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年07月04日 12:48, Tiwei Bie wrote:
> On Tue, Jul 03, 2018 at 01:38:02PM +0800, Jason Wang wrote:
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   include/uapi/linux/virtio_config.h |  2 ++
>>   include/uapi/linux/virtio_ring.h   | 32 ++++++++++++++++++++++++++++++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
>> index 449132c..947f6a3 100644
>> --- a/include/uapi/linux/virtio_config.h
>> +++ b/include/uapi/linux/virtio_config.h
>> @@ -75,6 +75,8 @@
>>    */
>>   #define VIRTIO_F_IOMMU_PLATFORM		33
>>   
>> +#define VIRTIO_F_RING_PACKED		34
> It's better to add some comments for this macro.

Ok.

>
>> +
>>   /*
>>    * Does the device support Single Root I/O Virtualization?
>>    */
>> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
>> index 6d5d5fa..71c7a46 100644
>> --- a/include/uapi/linux/virtio_ring.h
>> +++ b/include/uapi/linux/virtio_ring.h
>> @@ -43,6 +43,8 @@
>>   #define VRING_DESC_F_WRITE	2
>>   /* This means the buffer contains a list of buffer descriptors. */
>>   #define VRING_DESC_F_INDIRECT	4
>> +#define VRING_DESC_F_AVAIL      7
> It's better to use tab between VRING_DESC_F_AVAIL and 7.

Let me fix.

>
>> +#define VRING_DESC_F_USED	15
> Maybe it's better to define VRING_DESC_F_AVAIL and
> VRING_DESC_F_USED as (1 << 7) and (1 << 15) or something
> similar to make them consistent with VRING_DESC_F_NEXT
> (1 << 0), VRING_DESC_F_WRITE (1 << 1) and
> VRING_DESC_F_INDIRECT (1 << 2).

Ok.

>
> I plan to define below macros in virtio_ring.c:
>
> #define _VRING_DESC_F_AVAIL(b)  ((__u16)(b) << 7)
> #define _VRING_DESC_F_USED(b)   ((__u16)(b) << 15)
>
>>   
>>   /* The Host uses this in used->flags to advise the Guest: don't kick me when
>>    * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
>> @@ -62,6 +64,36 @@
>>    * at the end of the used ring. Guest should ignore the used->flags field. */
>>   #define VIRTIO_RING_F_EVENT_IDX		29
>>   
>> +struct vring_desc_packed {
> We may have other related types named as:
>
> struct vring_packed;
> struct vring_packed_desc_event;
>
> So maybe it's better to name this type as:
>
> struct vring_packed_desc;

Yes.

>
>> +	/* Buffer Address. */
>> +	__virtio64 addr;
>> +	/* Buffer Length. */
>> +	__virtio32 len;
>> +	/* Buffer ID. */
>> +	__virtio16 id;
>> +	/* The flags depending on descriptor type. */
>> +	__virtio16 flags;
>> +};
>> +
>> +/* Enable events */
>> +#define RING_EVENT_FLAGS_ENABLE 0x0
>> +/* Disable events */
>> +#define RING_EVENT_FLAGS_DISABLE 0x1
>> +/*
>> + * Enable events for a specific descriptor
>> + * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
>> + * Only valid if VIRTIO_F_RING_EVENT_IDX has been negotiated.
>> + */
>> +#define RING_EVENT_FLAGS_DESC 0x2
> For above three macros, maybe it's better to name
> them as:
>
> VRING_EVENT_FLAGS_ENABLE
> VRING_EVENT_FLAGS_DISABLE
> VRING_EVENT_FLAGS_DESC
>
> or
>
> VRING_EVENT_F_ENABLE
> VRING_EVENT_F_DISABLE
> VRING_EVENT_F_DESC
>
> VRING_EVENT_F_* will be more consistent with
> VIRTIO_F_*, VRING_DESC_F_*, etc

True. Let me fix above in next version.

Thanks

>> +/* The value 0x3 is reserved */
>> +
>> +struct vring_packed_desc_event {
>> +	/* Descriptor Ring Change Event Offset and Wrap Counter */
>> +	__virtio16 off_wrap;
>> +	/* Descriptor Ring Change Event Flags */
>> +	__virtio16 flags;
>> +};
>> +
>>   /* Virtio ring descriptors: 16 bytes.  These can chain together via "next". */
>>   struct vring_desc {
>>   	/* Address (guest-physical). */
>> -- 
>> 2.7.4
>>

