Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06871ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B252F2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B252F2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeJRKnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:43:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbeJRKnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:43:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69C40C03D466;
        Thu, 18 Oct 2018 02:44:50 +0000 (UTC)
Received: from [10.72.12.103] (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A2651062243;
        Thu, 18 Oct 2018 02:44:38 +0000 (UTC)
Subject: Re: [PATCH net-next V2 6/8] vhost: packed ring support
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com
References: <1531711691-6769-1-git-send-email-jasowang@redhat.com>
 <1531711691-6769-7-git-send-email-jasowang@redhat.com>
 <20181012143244.GA28400@debian>
 <20181012131812-mutt-send-email-mst@kernel.org>
 <447f47fa-32dd-a408-dd81-13a9839e0748@redhat.com>
 <20181014224208-mutt-send-email-mst@kernel.org>
 <ee3785be-b309-c4ae-e959-737018c21464@redhat.com>
 <20181015062241-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f37dbff8-321e-7b6c-6f40-49c71d167ab6@redhat.com>
Date:   Thu, 18 Oct 2018 10:44:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181015062241-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 18 Oct 2018 02:44:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/10/15 下午6:25, Michael S. Tsirkin wrote:
> On Mon, Oct 15, 2018 at 10:51:06AM +0800, Jason Wang wrote:
>> On 2018年10月15日 10:43, Michael S. Tsirkin wrote:
>>> On Mon, Oct 15, 2018 at 10:22:33AM +0800, Jason Wang wrote:
>>>> On 2018年10月13日 01:23, Michael S. Tsirkin wrote:
>>>>> On Fri, Oct 12, 2018 at 10:32:44PM +0800, Tiwei Bie wrote:
>>>>>> On Mon, Jul 16, 2018 at 11:28:09AM +0800, Jason Wang wrote:
>>>>>> [...]
>>>>>>> @@ -1367,10 +1397,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>>>>>>>     		vq->last_avail_idx = s.num;
>>>>>>>     		/* Forget the cached index value. */
>>>>>>>     		vq->avail_idx = vq->last_avail_idx;
>>>>>>> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
>>>>>>> +			vq->last_avail_wrap_counter = wrap_counter;
>>>>>>> +			vq->avail_wrap_counter = vq->last_avail_wrap_counter;
>>>>>>> +		}
>>>>>>>     		break;
>>>>>>>     	case VHOST_GET_VRING_BASE:
>>>>>>>     		s.index = idx;
>>>>>>>     		s.num = vq->last_avail_idx;
>>>>>>> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
>>>>>>> +			s.num |= vq->last_avail_wrap_counter << 31;
>>>>>>> +		if (copy_to_user(argp, &s, sizeof(s)))
>>>>>>> +			r = -EFAULT;
>>>>>>> +		break;
>>>>>>> +	case VHOST_SET_VRING_USED_BASE:
>>>>>>> +		/* Moving base with an active backend?
>>>>>>> +		 * You don't want to do that.
>>>>>>> +		 */
>>>>>>> +		if (vq->private_data) {
>>>>>>> +			r = -EBUSY;
>>>>>>> +			break;
>>>>>>> +		}
>>>>>>> +		if (copy_from_user(&s, argp, sizeof(s))) {
>>>>>>> +			r = -EFAULT;
>>>>>>> +			break;
>>>>>>> +		}
>>>>>>> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
>>>>>>> +			wrap_counter = s.num >> 31;
>>>>>>> +			s.num &= ~(1 << 31);
>>>>>>> +		}
>>>>>>> +		if (s.num > 0xffff) {
>>>>>>> +			r = -EINVAL;
>>>>>>> +			break;
>>>>>>> +		}
>>>>>> Do we want to put wrap_counter at bit 15?
>>>>> I think I second that - seems to be consistent with
>>>>> e.g. event suppression structure and the proposed
>>>>> extension to driver notifications.
>>>> Ok, I assumes packed virtqueue support 64K but looks not. I can change it to
>>>> bit 15 and GET_VRING_BASE need to be changed as well.
>>>>
>>>>>> If put wrap_counter at bit 31, the check (s.num > 0xffff)
>>>>>> won't be able to catch the illegal index 0x8000~0xffff for
>>>>>> packed ring.
>>>>>>
>>>> Do we need to clarify this in the spec?
>>> Isn't this all internal vhost stuff?
>> I meant the illegal index 0x8000-0xffff.
> It does say packed virtqueues support up to 2 15 entries each.
>
> But yes we can add a requirement that devices do not expose
> larger rings. Split does not support 2**16 either, right?
> With 2**16 enties avail index becomes 0 and ring looks empty.
>

Yes, so it's better to clarify this in the spec.

Thanks


