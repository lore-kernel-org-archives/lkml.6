Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F4AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3679820883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3679820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeKITop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:44:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbeKITop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:44:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76DD1C05E144;
        Fri,  9 Nov 2018 10:04:53 +0000 (UTC)
Received: from [10.72.12.67] (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B05195D6B5;
        Fri,  9 Nov 2018 10:04:44 +0000 (UTC)
Subject: Re: [PATCH net-next v2 3/5] virtio_ring: add packed ring support
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Tiwei Bie <tiwei.bie@intel.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-4-tiwei.bie@intel.com>
 <20181107123933-mutt-send-email-mst@kernel.org>
 <20181108013759.GA20591@debian>
 <2d46a41e-bc00-276a-e19a-105c9dffc75a@redhat.com>
 <20181108091337-mutt-send-email-mst@kernel.org>
 <21d6dbd9-8f78-6939-0e80-27b470aeb00a@redhat.com>
 <20181108225555-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <fb0f3926-3b08-58e6-979c-7edc9307945d@redhat.com>
Date:   Fri, 9 Nov 2018 18:04:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108225555-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 09 Nov 2018 10:04:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/11/9 上午11:58, Michael S. Tsirkin wrote:
> On Fri, Nov 09, 2018 at 10:25:28AM +0800, Jason Wang wrote:
>> On 2018/11/8 下午10:14, Michael S. Tsirkin wrote:
>>> On Thu, Nov 08, 2018 at 04:18:25PM +0800, Jason Wang wrote:
>>>> On 2018/11/8 上午9:38, Tiwei Bie wrote:
>>>>>>> +
>>>>>>> +	if (vq->vq.num_free < descs_used) {
>>>>>>> +		pr_debug("Can't add buf len %i - avail = %i\n",
>>>>>>> +			 descs_used, vq->vq.num_free);
>>>>>>> +		/* FIXME: for historical reasons, we force a notify here if
>>>>>>> +		 * there are outgoing parts to the buffer.  Presumably the
>>>>>>> +		 * host should service the ring ASAP. */
>>>>>> I don't think we have a reason to do this for packed ring.
>>>>>> No historical baggage there, right?
>>>>> Based on the original commit log, it seems that the notify here
>>>>> is just an "optimization". But I don't quite understand what does
>>>>> the "the heuristics which KVM uses" refer to. If it's safe to drop
>>>>> this in packed ring, I'd like to do it.
>>>> According to the commit log, it seems like a workaround of lguest networking
>>>> backend. I agree to drop it, we should not have such burden.
>>>>
>>>> But we should notice that, with this removed, the compare between packed vs
>>>> split is kind of unfair.
>>> I don't think this ever triggers to be frank. When would it?
>>
>> I think it can happen e.g in the path of XDP transmission in
>> __virtnet_xdp_xmit_one():
>>
>>
>>          err = virtqueue_add_outbuf(sq->vq, sq->sg, 1, xdpf, GFP_ATOMIC);
>>          if (unlikely(err))
>>                  return -ENOSPC; /* Caller handle free/refcnt */
>>
> I see. We used to do it for regular xmit but stopped
> doing it. Is it fine for xdp then?


There's no traffic control in XDP, so it was the only thing we can do.


>
>>>> Consider the removal of lguest support recently,
>>>> maybe we can drop this for split ring as well?
>>>>
>>>> Thanks
>>> If it's helpful, then for sure we can drop it for virtio 1.
>>> Can you see any perf differences at all? With which device?
>>
>> I don't test but consider the case of XDP_TX in guest plus vhost_net in
>> host. Since vhost_net is half duplex, it's pretty easier to trigger this
>> condition.
>>
>> Thanks
> Sounds reasonable. Worth testing before we change things though.


Let me test and submit a patch.

Thanks


>
>>>>> commit 44653eae1407f79dff6f52fcf594ae84cb165ec4
>>>>> Author: Rusty Russell<rusty@rustcorp.com.au>
>>>>> Date:   Fri Jul 25 12:06:04 2008 -0500
>>>>>
>>>>>        virtio: don't always force a notification when ring is full
>>>>>        We force notification when the ring is full, even if the host has
>>>>>        indicated it doesn't want to know.  This seemed like a good idea at
>>>>>        the time: if we fill the transmit ring, we should tell the host
>>>>>        immediately.
>>>>>        Unfortunately this logic also applies to the receiving ring, which is
>>>>>        refilled constantly.  We should introduce real notification thesholds
>>>>>        to replace this logic.  Meanwhile, removing the logic altogether breaks
>>>>>        the heuristics which KVM uses, so we use a hack: only notify if there are
>>>>>        outgoing parts of the new buffer.
>>>>>        Here are the number of exits with lguest's crappy network implementation:
>>>>>        Before:
>>>>>                network xmit 7859051 recv 236420
>>>>>        After:
>>>>>                network xmit 7858610 recv 118136
>>>>>        Signed-off-by: Rusty Russell<rusty@rustcorp.com.au>
>>>>>
>>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>>> index 72bf8bc09014..21d9a62767af 100644
>>>>> --- a/drivers/virtio/virtio_ring.c
>>>>> +++ b/drivers/virtio/virtio_ring.c
>>>>> @@ -87,8 +87,11 @@ static int vring_add_buf(struct virtqueue *_vq,
>>>>>     	if (vq->num_free < out + in) {
>>>>>     		pr_debug("Can't add buf len %i - avail = %i\n",
>>>>>     			 out + in, vq->num_free);
>>>>> -		/* We notify*even if*  VRING_USED_F_NO_NOTIFY is set here. */
>>>>> -		vq->notify(&vq->vq);
>>>>> +		/* FIXME: for historical reasons, we force a notify here if
>>>>> +		 * there are outgoing parts to the buffer.  Presumably the
>>>>> +		 * host should service the ring ASAP. */
>>>>> +		if (out)
>>>>> +			vq->notify(&vq->vq);
>>>>>     		END_USE(vq);
>>>>>     		return -ENOSPC;
>>>>>     	}
>>>>>
>>>>>
