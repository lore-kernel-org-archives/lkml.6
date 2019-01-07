Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64697C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3CA2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfAGCOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:14:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfAGCOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:14:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B40699D2C;
        Mon,  7 Jan 2019 02:14:52 +0000 (UTC)
Received: from [10.72.12.172] (ovpn-12-172.pek2.redhat.com [10.72.12.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74577608C3;
        Mon,  7 Jan 2019 02:14:39 +0000 (UTC)
Subject: Re: [PATCH RFC 1/2] virtio-net: bql support
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        tiwei.bie@intel.com, wexu@redhat.com, jfreimann@redhat.com,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20181205225323.12555-1-mst@redhat.com>
 <20181205225323.12555-2-mst@redhat.com>
 <21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com>
 <20181226101528-mutt-send-email-mst@kernel.org>
 <0fa99d9b-e510-d7eb-db1b-831bd7610ce9@redhat.com>
 <20181230134106-mutt-send-email-mst@kernel.org>
 <b4f06d11-4761-dabb-f641-5fc05c1c34fc@redhat.com>
 <20190102085457-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <17d2ab21-1c9a-2bb9-166f-2863d019cb0b@redhat.com>
Date:   Mon, 7 Jan 2019 10:14:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190102085457-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 07 Jan 2019 02:14:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/2 下午9:59, Michael S. Tsirkin wrote:
> On Wed, Jan 02, 2019 at 11:28:43AM +0800, Jason Wang wrote:
>> On 2018/12/31 上午2:45, Michael S. Tsirkin wrote:
>>> On Thu, Dec 27, 2018 at 06:00:36PM +0800, Jason Wang wrote:
>>>> On 2018/12/26 下午11:19, Michael S. Tsirkin wrote:
>>>>> On Thu, Dec 06, 2018 at 04:17:36PM +0800, Jason Wang wrote:
>>>>>> On 2018/12/6 上午6:54, Michael S. Tsirkin wrote:
>>>>>>> When use_napi is set, let's enable BQLs.  Note: some of the issues are
>>>>>>> similar to wifi.  It's worth considering whether something similar to
>>>>>>> commit 36148c2bbfbe ("mac80211: Adjust TSQ pacing shift") might be
>>>>>>> benefitial.
>>>>>> I've played a similar patch several days before. The tricky part is the mode
>>>>>> switching between napi and no napi. We should make sure when the packet is
>>>>>> sent and trakced by BQL,  it should be consumed by BQL as well. I did it by
>>>>>> tracking it through skb->cb.  And deal with the freeze by reset the BQL
>>>>>> status. Patch attached.
>>>>>>
>>>>>> But when testing with vhost-net, I don't very a stable performance,
>>>>> So how about increasing TSQ pacing shift then?
>>>> I can test this. But changing default TCP value is much more than a
>>>> virtio-net specific thing.
>>> Well same logic as wifi applies. Unpredictable latencies related
>>> to radio in one case, to host scheduler in the other.
>>>
>>>>>> it was
>>>>>> probably because we batch the used ring updating so tx interrupt may come
>>>>>> randomly. We probably need to implement time bounded coalescing mechanism
>>>>>> which could be configured from userspace.
>>>>> I don't think it's reasonable to expect userspace to be that smart ...
>>>>> Why do we need time bounded? used ring is always updated when ring
>>>>> becomes empty.
>>>> We don't add used when means BQL may not see the consumed packet in time.
>>>> And the delay varies based on the workload since we count packets not bytes
>>>> or time before doing the batched updating.
>>>>
>>>> Thanks
>>> Sorry I still don't get it.
>>> When nothing is outstanding then we do update the used.
>>> So if BQL stops userspace from sending packets then
>>> we get an interrupt and packets start flowing again.
>> Yes, but how about the cases of multiple flows. That's where I see unstable
>> results.
>>
>>
>>> It might be suboptimal, we might need to tune it but I doubt running
>>> timers is a solution, timer interrupts cause VM exits.
>> Probably not a timer but a time counter (or event byte counter) in vhost to
>> add used and signal guest if it exceeds a value instead of waiting the
>> number of packets.
>>
>>
>> Thanks
> Well we already have VHOST_NET_WEIGHT - is it too big then?


I'm not sure, it might be too big.


>
> And maybe we should expose the "MORE" flag in the descriptor -
> do you think that will help?
>

I don't know. But how a "more" flag can help here?

Thanks


>
