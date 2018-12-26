Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE3AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D77621741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLZFng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 00:43:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbeLZFnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 00:43:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19245C0528AC;
        Wed, 26 Dec 2018 05:43:35 +0000 (UTC)
Received: from [10.72.12.31] (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B33F620D8;
        Wed, 26 Dec 2018 05:43:29 +0000 (UTC)
Subject: Re: [PATCH net V2 4/4] vhost: log dirty page correctly
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jintack Lim <jintack@cs.columbia.edu>
References: <20181212100819.21295-1-jasowang@redhat.com>
 <20181212100819.21295-5-jasowang@redhat.com>
 <20181212092435-mutt-send-email-mst@kernel.org>
 <0239c220-e7ca-c08f-be26-eb9be63fced3@redhat.com>
 <20181213092930-mutt-send-email-mst@kernel.org>
 <519ee6f7-06fc-ad49-03da-c096aeb24ced@redhat.com>
 <20181214081821-mutt-send-email-mst@kernel.org>
 <55b3d55a-950f-eeaf-1908-bed78a1a9200@redhat.com>
 <20181224123654-mutt-send-email-mst@kernel.org>
 <9e57732f-2d42-173f-9297-42821f34ab8f@redhat.com>
 <20181225111716-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <2a78e991-1917-256b-4f09-60c228c17979@redhat.com>
Date:   Wed, 26 Dec 2018 13:43:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181225111716-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 26 Dec 2018 05:43:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/26 上午12:25, Michael S. Tsirkin wrote:
> On Tue, Dec 25, 2018 at 05:43:25PM +0800, Jason Wang wrote:
>> On 2018/12/25 上午1:41, Michael S. Tsirkin wrote:
>>> On Mon, Dec 24, 2018 at 11:43:31AM +0800, Jason Wang wrote:
>>>> On 2018/12/14 下午9:20, Michael S. Tsirkin wrote:
>>>>> On Fri, Dec 14, 2018 at 10:43:03AM +0800, Jason Wang wrote:
>>>>>> On 2018/12/13 下午10:31, Michael S. Tsirkin wrote:
>>>>>>>> Just to make sure I understand this. It looks to me we should:
>>>>>>>>
>>>>>>>> - allow passing GIOVA->GPA through UAPI
>>>>>>>>
>>>>>>>> - cache GIOVA->GPA somewhere but still use GIOVA->HVA in device IOTLB for
>>>>>>>> performance
>>>>>>>>
>>>>>>>> Is this what you suggest?
>>>>>>>>
>>>>>>>> Thanks
>>>>>>> Not really. We already have GPA->HVA, so I suggested a flag to pass
>>>>>>> GIOVA->GPA in the IOTLB.
>>>>>>>
>>>>>>> This has advantages for security since a single table needs
>>>>>>> then to be validated to ensure guest does not corrupt
>>>>>>> QEMU memory.
>>>>>>>
>>>>>> I wonder how much we can gain through this. Currently, qemu IOMMU gives
>>>>>> GIOVA->GPA mapping, and qemu vhost code will translate GPA to HVA then pass
>>>>>> GIOVA->HVA to vhost. It looks no difference to me.
>>>>>>
>>>>>> Thanks
>>>>> The difference is in security not in performance.  Getting a bad HVA
>>>>> corrupts QEMU memory and it might be guest controlled. Very risky.
>>>> How can this be controlled by guest? HVA was generated from qemu ram blocks
>>>> which is totally under the control of qemu memory core instead of guest.
>>>>
>>>>
>>>> Thanks
>>> It is ultimately under guest influence as guest supplies IOVA->GPA
>>> translations.  qemu translates GPA->HVA and gives the translated result
>>> to the kernel.  If it's not buggy and kernel isn't buggy it's all
>>> fine.
>>
>> If qemu provides buggy GPA->HVA, we can't workaround this. And I don't get
>> the point why we even want to try this. Buggy qemu code can crash itself in
>> many ways.
>>
>>
>>> But that's the approach that was proven not to work in the 20th century.
>>> In the 21st century we are trying defence in depth approach.
>>>
>>> My point is that a single code path that is responsible for
>>> the HVA translations is better than two.
>>>
>> So the difference whether or not use memory table information:
>>
>> Current:
>>
>> 1) SET_MEM_TABLE: GPA->HVA
>>
>> 2) Qemu GIOVA->GPA
>>
>> 3) Qemu GPA->HVA
>>
>> 4) IOTLB_UPDATE: GIOVA->HVA
>>
>> If I understand correctly you want to drop step 3 consider it might be buggy
>> which is just 19 lines of code in qemu (vhost_memory_region_lookup()). This
>> will ends up:
>>
>> 1) Do GPA->HVA translation in IOTLB_UPDATE path (I believe we won't want to
>> do it during device IOTLB lookup).
>>
>> 2) Extra bits to enable this capability.
>>
>> So this looks need more codes in kernel than what qemu did in userspace.  Is
>> this really worthwhile?
>>
>> Thanks
> So there are several points I would like to make
>
> 1. At the moment without an iommu it is possible to
>     change GPA-HVA mappings and everything keeps working
>     because a change in memory tables flushes the rings.


Interesting, I don't know this before. But when can this happen?


>     However I don't see the iotlb cache being invalidated
>     on that path - did I miss it? If it is not there it's
>     a related minor bug.


It might have a bug. But a question is consider the case without IOMMU. 
We only update mem table (SET_MEM_TABLE), but not vring address. This 
looks like a bug as well?


>
> 2. qemu already has a GPA. Discarding it and re-calculating
>     when logging is on just seems wrong.
>     However if you would like to *also* keep the HVA in the iotlb
>     to avoid doing extra translations, that sounds like a
>     reasonable optimization.


Yes, traverse GPA->HVA mapping seems unnecessary.


>
> 3. it also means that the hva->gpa translation only runs
>     when logging is enabled. That is a rarely excercised
>     path so any bugs there will not be caught.


I wonder maybe some kind of unit-test may help here.


>
> So I really would like us long term to move away from
> hva->gpa translations, keep them for legacy userspace only
> but I don't really mind how we do it.
>
> How about
> - a new flag to pass an iotlb with *both* a gpa and hva
> - for legacy userspace, calculate the gpa on iotlb update
>    so the device then uses a shared code path
>
> what do you think?
>
>

I don't object this idea so I can try, just want to figure out why it 
was a must.

Thanks


