Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C97C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA3820645
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA3820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeLNEaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:30:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeLNEaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 23:30:05 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBD413078A5D;
        Fri, 14 Dec 2018 04:30:04 +0000 (UTC)
Received: from [10.72.12.142] (ovpn-12-142.pek2.redhat.com [10.72.12.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01A7F662CF;
        Fri, 14 Dec 2018 04:29:57 +0000 (UTC)
Subject: Re: [PATCH net-next 0/3] vhost: accelerate metadata access through
 vmap()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213144116-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <836932fc-9266-b73d-2ee5-645f399e1a54@redhat.com>
Date:   Fri, 14 Dec 2018 12:29:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213144116-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 14 Dec 2018 04:30:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/14 上午4:12, Michael S. Tsirkin wrote:
> On Thu, Dec 13, 2018 at 06:10:19PM +0800, Jason Wang wrote:
>> Hi:
>>
>> This series tries to access virtqueue metadata through kernel virtual
>> address instead of copy_user() friends since they had too much
>> overheads like checks, spec barriers or even hardware feature
>> toggling.
>>
>> Test shows about 24% improvement on TX PPS. It should benefit other
>> cases as well.
>>
>> Please review
> I think the idea of speeding up userspace access is a good one.
> However I think that moving all checks to start is way too aggressive.


So did packet and AF_XDP. Anyway, sharing address space and access them 
directly is the fastest way. Performance is the major consideration for 
people to choose backend. Compare to userspace implementation, vhost 
does not have security advantages at any level. If vhost is still slow, 
people will start to develop backends based on e.g AF_XDP.


> Instead, let's batch things up but let's not keep them
> around forever.
> Here are some ideas:
>
>
> 1. Disable preemption, process a small number of small packets
>     directly in an atomic context. This should cut latency
>     down significantly, the tricky part is to only do it
>     on a light load and disable this
>     for the streaming case otherwise it's unfair.
>     This might fail, if it does just bounce things out to
>     a thread.


I'm not sure what context you meant here. Is this for TX path of TUN? 
But a fundamental difference is my series is targeted for extreme heavy 
load not light one, 100% cpu for vhost is expected.


>
> 2. Switch to unsafe_put_user/unsafe_get_user,
>     and batch up multiple accesses.


As I said, unless we can batch accessing of two difference places of 
three of avail, descriptor and used. It won't help for batching the 
accessing of a single place like used. I'm even not sure this can be 
done consider the case of packed virtqueue, we have a single descriptor 
ring. Batching through unsafe helpers may not help in this case since 
it's equivalent to safe ones . And This requires non trivial refactoring 
of vhost. And such refactoring itself make give us noticeable impact 
(e.g it may lead regression).


>
> 3. Allow adding a fixup point manually,
>     such that multiple independent get_user accesses
>     can get a single fixup (will allow better compiler
>     optimizations).
>

So for metadata access, I don't see how you suggest here can help in the 
case of heavy workload.

For data access, this may help but I've played to batch the data copy to 
reduce SMAP/spec barriers in vhost-net but I don't see performance 
improvement.

Thanks


>
>
>
>> Jason Wang (3):
>>    vhost: generalize adding used elem
>>    vhost: fine grain userspace memory accessors
>>    vhost: access vq metadata through kernel virtual address
>>
>>   drivers/vhost/vhost.c | 281 ++++++++++++++++++++++++++++++++++++++----
>>   drivers/vhost/vhost.h |  11 ++
>>   2 files changed, 266 insertions(+), 26 deletions(-)
>>
>> -- 
>> 2.17.1
