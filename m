Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBD9ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF114214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF114214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJQOst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:48:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbeJQOss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:48:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B7B9C05D3EC;
        Wed, 17 Oct 2018 06:54:36 +0000 (UTC)
Received: from [10.72.12.94] (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4ED6326DE5;
        Wed, 17 Oct 2018 06:54:25 +0000 (UTC)
Subject: Re: [PATCH net-next V2 6/8] vhost: packed ring support
To:     Maxime Coquelin <maxime.coquelin@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wexu@redhat.com, jfreimann@redhat.com
References: <1531711691-6769-1-git-send-email-jasowang@redhat.com>
 <1531711691-6769-7-git-send-email-jasowang@redhat.com>
 <20181012143244.GA28400@debian>
 <20181012131812-mutt-send-email-mst@kernel.org>
 <447f47fa-32dd-a408-dd81-13a9839e0748@redhat.com>
 <1df62bd3-3cc9-d04a-2939-4570d37faa68@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0f3827e5-a7fa-e54a-725d-7726e90333b8@redhat.com>
Date:   Wed, 17 Oct 2018 14:54:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1df62bd3-3cc9-d04a-2939-4570d37faa68@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 17 Oct 2018 06:54:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/10/16 下午9:58, Maxime Coquelin wrote:
>
> On 10/15/2018 04:22 AM, Jason Wang wrote:
>>
>>
>> On 2018年10月13日 01:23, Michael S. Tsirkin wrote:
>>> On Fri, Oct 12, 2018 at 10:32:44PM +0800, Tiwei Bie wrote:
>>>> On Mon, Jul 16, 2018 at 11:28:09AM +0800, Jason Wang wrote:
>>>> [...]
>>>>> @@ -1367,10 +1397,48 @@ long vhost_vring_ioctl(struct vhost_dev 
>>>>> *d, unsigned int ioctl, void __user *arg
>>>>>           vq->last_avail_idx = s.num;
>>>>>           /* Forget the cached index value. */
>>>>>           vq->avail_idx = vq->last_avail_idx;
>>>>> +        if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
>>>>> +            vq->last_avail_wrap_counter = wrap_counter;
>>>>> +            vq->avail_wrap_counter = vq->last_avail_wrap_counter;
>>>>> +        }
>>>>>           break;
>>>>>       case VHOST_GET_VRING_BASE:
>>>>>           s.index = idx;
>>>>>           s.num = vq->last_avail_idx;
>>>>> +        if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
>>>>> +            s.num |= vq->last_avail_wrap_counter << 31;
>>>>> +        if (copy_to_user(argp, &s, sizeof(s)))
>>>>> +            r = -EFAULT;
>>>>> +        break;
>>>>> +    case VHOST_SET_VRING_USED_BASE:
>>>>> +        /* Moving base with an active backend?
>>>>> +         * You don't want to do that.
>>>>> +         */
>>>>> +        if (vq->private_data) {
>>>>> +            r = -EBUSY;
>>>>> +            break;
>>>>> +        }
>>>>> +        if (copy_from_user(&s, argp, sizeof(s))) {
>>>>> +            r = -EFAULT;
>>>>> +            break;
>>>>> +        }
>>>>> +        if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
>>>>> +            wrap_counter = s.num >> 31;
>>>>> +            s.num &= ~(1 << 31);
>>>>> +        }
>>>>> +        if (s.num > 0xffff) {
>>>>> +            r = -EINVAL;
>>>>> +            break;
>>>>> +        }
>>>> Do we want to put wrap_counter at bit 15?
>>> I think I second that - seems to be consistent with
>>> e.g. event suppression structure and the proposed
>>> extension to driver notifications.
>>
>> Ok, I assumes packed virtqueue support 64K but looks not. I can 
>> change it to bit 15 and GET_VRING_BASE need to be changed as well.
>>
>>>
>>>
>>>> If put wrap_counter at bit 31, the check (s.num > 0xffff)
>>>> won't be able to catch the illegal index 0x8000~0xffff for
>>>> packed ring.
>>>>
>>
>> Do we need to clarify this in the spec?
>>
>>>>> +        vq->last_used_idx = s.num;
>>>>> +        if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
>>>>> +            vq->last_used_wrap_counter = wrap_counter;
>>>>> +        break;
>>>>> +    case VHOST_GET_VRING_USED_BASE:
>>>> Do we need the new VHOST_GET_VRING_USED_BASE and
>>>> VHOST_SET_VRING_USED_BASE ops?
>>>>
>>>> We are going to merge below series in DPDK:
>>>>
>>>> http://patches.dpdk.org/patch/45874/
>>>>
>>>> We may need to reach an agreement first.
>>
>> If we agree that 64K virtqueue won't be supported, I'm ok with either.
>
> I'm fine to put wrap_counter at bit 15.
> I will post a new version of the DPDK series soon.
>
>> Btw the code assumes used_wrap_counter is equal to avail_wrap_counter 
>> which looks wrong?
>
> For split ring, we used to set the last_used_idx to the same value as
> last_avail_idx as VHOST_USER_GET_VRING_BASE cannot be called while the
> ring is being processed, so their value is always the same at the time
> the request is handled.


I may miss something, but it looks to me we should sync last_used_idx 
from used_idx.

Thanks


>
>
> I kept the same behavior for packed ring, and so the wrap counter have
> to be the same.
>
> Regards,
> Maxime
>
>> Thanks
>>
>>>>
>>>>> +        s.index = idx;
>>>>> +        s.num = vq->last_used_idx;
>>>>> +        if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
>>>>> +            s.num |= vq->last_used_wrap_counter << 31;
>>>>>           if (copy_to_user(argp, &s, sizeof s))
>>>>>               r = -EFAULT;
>>>>>           break;
>>>> [...]
>>
