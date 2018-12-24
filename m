Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01344C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C9121721
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbeLXIo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:44:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbeLXIoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:44:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7B0337E85;
        Mon, 24 Dec 2018 08:44:24 +0000 (UTC)
Received: from [10.72.12.206] (ovpn-12-206.pek2.redhat.com [10.72.12.206])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3326608C6;
        Mon, 24 Dec 2018 08:44:18 +0000 (UTC)
Subject: Re: [PATCH net-next 0/3] vhost: accelerate metadata access through
 vmap()
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Miller <davem@davemloft.net>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213144116-mutt-send-email-mst@kernel.org>
 <836932fc-9266-b73d-2ee5-645f399e1a54@redhat.com>
 <20181215.114308.647436101869587689.davem@davemloft.net>
 <20181216144200-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f6ce1fbb-b634-b17d-e9cf-36c662f49d75@redhat.com>
Date:   Mon, 24 Dec 2018 16:44:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181216144200-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 24 Dec 2018 08:44:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/17 上午3:57, Michael S. Tsirkin wrote:
> On Sat, Dec 15, 2018 at 11:43:08AM -0800, David Miller wrote:
>> From: Jason Wang <jasowang@redhat.com>
>> Date: Fri, 14 Dec 2018 12:29:54 +0800
>>
>>> On 2018/12/14 上午4:12, Michael S. Tsirkin wrote:
>>>> On Thu, Dec 13, 2018 at 06:10:19PM +0800, Jason Wang wrote:
>>>>> Hi:
>>>>>
>>>>> This series tries to access virtqueue metadata through kernel virtual
>>>>> address instead of copy_user() friends since they had too much
>>>>> overheads like checks, spec barriers or even hardware feature
>>>>> toggling.
>>>>>
>>>>> Test shows about 24% improvement on TX PPS. It should benefit other
>>>>> cases as well.
>>>>>
>>>>> Please review
>>>> I think the idea of speeding up userspace access is a good one.
>>>> However I think that moving all checks to start is way too aggressive.
>>>
>>> So did packet and AF_XDP. Anyway, sharing address space and access
>>> them directly is the fastest way. Performance is the major
>>> consideration for people to choose backend. Compare to userspace
>>> implementation, vhost does not have security advantages at any
>>> level. If vhost is still slow, people will start to develop backends
>>> based on e.g AF_XDP.
>> Exactly, this is precisely how this kind of problem should be solved.
>>
>> Michael, I strongly support the approach Jason is taking here, and I
>> would like to ask you to seriously reconsider your objections.
>>
>> Thank you.
> Okay. Won't be the first time I'm wrong.
>
> Let's say we ignore security aspects, but we need to make sure the
> following all keep working (broken with this revision):
> - file backed memory (I didn't see where we mark memory dirty -
>    if we don't we get guest memory corruption on close, if we do
>    then host crash as https://lwn.net/Articles/774411/ seems to apply here?)


We only pin metadata pages, so I don't think they can be used for DMA. 
So it was probably not an issue. The real issue is zerocopy codes, maybe 
it's time to disable it by default?


> - THP


We will miss 2 or 4 pages for THP, I wonder whether or not it's measurable.


> - auto-NUMA


I'm not sure auto-NUMA will help for the case of IPC. It can damage the 
performance in the worst case if vhost and userspace are running in two 
different nodes. Anyway I can measure.


>
> Because vhost isn't like AF_XDP where you can just tell people "use
> hugetlbfs" and "data is removed on close" - people are using it in lots
> of configurations with guest memory shared between rings and unrelated
> data.


This series doesn't share data, only metadata is shared.


>
> Jason, thoughts on these?
>

Based on the above, I can measure the impact of THP to see how it impacts.

For unsafe variants, it can only work for when we can batch the access 
and it needs non trivial rework on the vhost codes with unexpected 
amount of work for archs other than x86. I'm not sure it's worth to try.

Thanks

