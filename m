Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6B7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED6020855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED6020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeKZOyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 09:54:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbeKZOyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 09:54:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C48F44E92B;
        Mon, 26 Nov 2018 04:02:07 +0000 (UTC)
Received: from [10.72.12.50] (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 22FC51974D;
        Mon, 26 Nov 2018 04:02:02 +0000 (UTC)
Subject: Re: [PATCH net-next 3/3] vhost: don't touch avail ring if in_order is
 negotiated
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181123030016.4924-1-jasowang@redhat.com>
 <20181123030016.4924-4-jasowang@redhat.com>
 <20181123103750-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <99e6b6b0-3cc6-b100-1e60-aa837d293bc8@redhat.com>
Date:   Mon, 26 Nov 2018 12:01:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181123103750-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 26 Nov 2018 04:02:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/11/23 下午11:41, Michael S. Tsirkin wrote:
> On Fri, Nov 23, 2018 at 11:00:16AM +0800, Jason Wang wrote:
>> Device use descriptors table in order, so there's no need to read
>> index from available ring. This eliminate the cache contention on
>> avail ring completely.
> Well this isn't what the in order feature says in the spec.
>
> It forces the used ring to be in the same order as
> the available ring. So I don't think you can skip
> checking the available ring.


Maybe I miss something. The spec 
(https://github.com/oasis-tcs/virtio-spec master) said: "If 
VIRTIO_F_IN_ORDER has been negotiated, driver uses descriptors in ring 
order: starting from offset 0 in the table, and wrapping around at the 
end of the table."

Even if I was wrong, maybe it's time to force this consider the obvious 
improvement it brings? And maybe what you said is the reason that we 
only allow the following optimization only for packed ring?

"notify the use of a batch of buffers to the driver by only writing out 
a single used descriptor with the Buffer ID corresponding to the last 
descriptor in the batch. "

This seems another good optimization for packed ring as well.


> And in fact depending on
> ring size and workload, using all of descriptor buffer might
> cause a slowdown.


This is not the sin of in order but the size of the queue I believe?


> Rather you should be able to get
> about the same speedup, but from skipping checking
> the used ring in virtio.


Yes, I've made such changes in virtio-net pmd. But since we're testing 
it with vhost-kernel, the main contention was on available. So the 
improvement was not obvious.

Thanks


>
>
>> Virito-user + vhost_kernel + XDP_DROP gives about ~10% improvement on
>> TX from 4.8Mpps to 5.3Mpps on Intel(R) Core(TM) i7-5600U CPU @
>> 2.60GHz.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/vhost/vhost.c | 19 ++++++++++++-------
>>   1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 3a5f81a66d34..c8be151bc897 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2002,6 +2002,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>>   	__virtio16 avail_idx;
>>   	__virtio16 ring_head;
>>   	int ret, access;
>> +	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
>>   
>>   	/* Check it isn't doing very strange things with descriptor numbers. */
>>   	last_avail_idx = vq->last_avail_idx;
>> @@ -2034,15 +2035,19 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>>   
>>   	/* Grab the next descriptor number they're advertising, and increment
>>   	 * the index we've seen. */
>> -	if (unlikely(vhost_get_avail(vq, ring_head,
>> -		     &vq->avail->ring[last_avail_idx & (vq->num - 1)]))) {
>> -		vq_err(vq, "Failed to read head: idx %d address %p\n",
>> -		       last_avail_idx,
>> -		       &vq->avail->ring[last_avail_idx % vq->num]);
>> -		return -EFAULT;
>> +	if (!in_order) {
>> +		if (unlikely(vhost_get_avail(vq, ring_head,
>> +		    &vq->avail->ring[last_avail_idx & (vq->num - 1)]))) {
>> +			vq_err(vq, "Failed to read head: idx %d address %p\n",
>> +				last_avail_idx,
>> +				&vq->avail->ring[last_avail_idx % vq->num]);
>> +			return -EFAULT;
>> +		}
>> +		head = vhost16_to_cpu(vq, ring_head);
>> +	} else {
>> +		head = last_avail_idx & (vq->num - 1);
>>   	}
>>   
>> -	head = vhost16_to_cpu(vq, ring_head);
>>   
>>   	/* If their number is silly, that's an error. */
>>   	if (unlikely(head >= vq->num)) {
>> -- 
>> 2.17.1
