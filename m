Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D8FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D162173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeLXIcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:32:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbeLXIcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:32:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B1B581DEA;
        Mon, 24 Dec 2018 08:32:46 +0000 (UTC)
Received: from [10.72.12.206] (ovpn-12-206.pek2.redhat.com [10.72.12.206])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F273919743;
        Mon, 24 Dec 2018 08:32:41 +0000 (UTC)
Subject: Re: [PATCH net-next 0/3] vhost: accelerate metadata access through
 vmap()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213102315-mutt-send-email-mst@kernel.org>
 <9459e227-a943-8553-732b-d7f5225a0f22@redhat.com>
 <20181214072334-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <b10c99a2-a9c3-595f-983e-2547325e64ad@redhat.com>
Date:   Mon, 24 Dec 2018 16:32:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214072334-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 24 Dec 2018 08:32:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/14 下午8:33, Michael S. Tsirkin wrote:
> On Fri, Dec 14, 2018 at 11:42:18AM +0800, Jason Wang wrote:
>> On 2018/12/13 下午11:27, Michael S. Tsirkin wrote:
>>> On Thu, Dec 13, 2018 at 06:10:19PM +0800, Jason Wang wrote:
>>>> Hi:
>>>>
>>>> This series tries to access virtqueue metadata through kernel virtual
>>>> address instead of copy_user() friends since they had too much
>>>> overheads like checks, spec barriers or even hardware feature
>>>> toggling.
>>> Userspace accesses through remapping tricks and next time there's a need
>>> for a new barrier we are left to figure it out by ourselves.
>>
>> I don't get here, do you mean spec barriers?
> I mean the next barrier people decide to put into userspace
> memory accesses.
>
>> It's completely unnecessary for
>> vhost which is kernel thread.
> It's defence in depth. Take a look at the commit that added them.
> And yes quite possibly in most cases we actually have a spec
> barrier in the validation phase. If we do let's use the
> unsafe variants so they can be found.


unsafe variants can only work if you can batch userspace access. This is 
not necessarily the case for light load.


>
>> And even if you're right, vhost is not the
>> only place, there's lots of vmap() based accessing in kernel.
> For sure. But if one can get by without get user pages, one
> really should. Witness recently uncovered mess with file
> backed storage.


We only pin metadata pages, I don't believe they will be used by any DMA.


>
>> Think in
>> another direction, this means we won't suffer form unnecessary barriers for
>> kthread like vhost in the future, we will manually pick the one we really
>> need
> I personally think we should err on the side of caution not on the side of
> performance.


So what you suggest may lead unnecessary performance regression 
(10%-20%) which is part of the goal of this series. We should audit and 
only use the one we really need instead of depending on copy_user() 
friends().

If we do it our own, it could be slow for for security fix but it's no 
less safe than before with performance kept.


>
>> (but it should have little possibility).
> History seems to teach otherwise.


What case did you mean here?


>
>> Please notice we only access metdata through remapping not the data itself.
>> This idea has been used for high speed userspace backend for years, e.g
>> packet socket or recent AF_XDP.
> I think their justification for the higher risk is that they are mostly
> designed for priveledged userspace.


I think it's the same with TUN/TAP, privileged process can pass them to 
unprivileged ones.


>
>> The only difference is the page was remap to
>> from kernel to userspace.
> At least that avoids the g.u.p mess.


I'm still not very clear at the point. We only pin 2 or 4 pages, they're 
several other cases that will pin much more.


>
>>>     I don't
>>> like the idea I have to say.  As a first step, why don't we switch to
>>> unsafe_put_user/unsafe_get_user etc?
>>
>> Several reasons:
>>
>> - They only have x86 variant, it won't have any difference for the rest of
>> architecture.
> Is there an issue on other architectures? If yes they can be extended
> there.


Consider the unexpected amount of work and in the best case it can give 
the same performance to vmap(). I'm not sure it's worth.


>
>> - unsafe_put_user/unsafe_get_user is not sufficient for accessing structures
>> (e.g accessing descriptor) or arrays (batching).
> So you want unsafe_copy_xxx_user? I can do this. Hang on will post.
>
>> - Unless we can batch at least the accessing of two places in three of
>> avail, used and descriptor in one run. There will be no difference. E.g we
>> can batch updating used ring, but it won't make any difference in this case.
>>
> So let's batch them all?


Batching might not help for the case of light load. And we need to 
measure the gain/cost of batching itself.


>
>
>>> That would be more of an apples to apples comparison, would it not?
>>
>> Apples to apples comparison only help if we are the No.1. But the fact is we
>> are not. If we want to compete with e.g dpdk or AF_XDP, vmap() is the
>> fastest method AFAIK.
>>
>>
>> Thanks
> We need to speed up the packet access itself too though.
> You can't vmap all of guest memory.


This series only pin and vmap very few pages (metadata).

Thanks


>
>
>>>
>>>> Test shows about 24% improvement on TX PPS. It should benefit other
>>>> cases as well.
>>>>
>>>> Please review
>>>>
>>>> Jason Wang (3):
>>>>     vhost: generalize adding used elem
>>>>     vhost: fine grain userspace memory accessors
>>>>     vhost: access vq metadata through kernel virtual address
>>>>
>>>>    drivers/vhost/vhost.c | 281 ++++++++++++++++++++++++++++++++++++++----
>>>>    drivers/vhost/vhost.h |  11 ++
>>>>    2 files changed, 266 insertions(+), 26 deletions(-)
>>>>
>>>> -- 
>>>> 2.17.1
