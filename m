Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12E9C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FAB2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfAGGu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 01:50:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfAGGu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 01:50:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BFC032D7FF;
        Mon,  7 Jan 2019 06:50:26 +0000 (UTC)
Received: from [10.72.12.209] (ovpn-12-209.pek2.redhat.com [10.72.12.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 803DB1057058;
        Mon,  7 Jan 2019 06:50:20 +0000 (UTC)
Subject: Re: [RFC PATCH V3 0/5] Hi:
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, Dan Williams <dan.j.williams@intel.com>
References: <20181229124656.3900-1-jasowang@redhat.com>
 <20190102154038-mutt-send-email-mst@kernel.org>
 <0efd115a-a7fb-54bf-5376-59d047a15fd3@redhat.com>
 <20190106221832-mutt-send-email-mst@kernel.org>
 <c15a17b3-b604-a105-af44-a7e6dfd79801@redhat.com>
 <20190106230224-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <62f0fda8-92a4-b160-1b3b-4acdfef49d44@redhat.com>
Date:   Mon, 7 Jan 2019 14:50:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190106230224-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 07 Jan 2019 06:50:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/7 下午12:17, Michael S. Tsirkin wrote:
> On Mon, Jan 07, 2019 at 11:53:41AM +0800, Jason Wang wrote:
>> On 2019/1/7 上午11:28, Michael S. Tsirkin wrote:
>>> On Mon, Jan 07, 2019 at 10:19:03AM +0800, Jason Wang wrote:
>>>> On 2019/1/3 上午4:47, Michael S. Tsirkin wrote:
>>>>> On Sat, Dec 29, 2018 at 08:46:51PM +0800, Jason Wang wrote:
>>>>>> This series tries to access virtqueue metadata through kernel virtual
>>>>>> address instead of copy_user() friends since they had too much
>>>>>> overheads like checks, spec barriers or even hardware feature
>>>>>> toggling.
>>>>> Will review, thanks!
>>>>> One questions that comes to mind is whether it's all about bypassing
>>>>> stac/clac.  Could you please include a performance comparison with
>>>>> nosmap?
>>>>>
>>>> On machine without SMAP (Sandy Bridge):
>>>>
>>>> Before: 4.8Mpps
>>>>
>>>> After: 5.2Mpps
>>> OK so would you say it's really unsafe versus safe accesses?
>>> Or would you say it's just a better written code?
>>
>> It's the effect of removing speculation barrier.
>
> You mean __uaccess_begin_nospec introduced by
> commit 304ec1b050310548db33063e567123fae8fd0301
> ?

Yes.


>
> So fundamentally we do access_ok checks when supplying
> the memory table to the kernel thread, and we should
> do the spec barrier there.
>
> Then we can just create and use a variant of uaccess macros that does
> not include the barrier?


The unsafe ones?


>
> Or, how about moving the barrier into access_ok?
> This way repeated accesses with a single access_ok get a bit faster.
> CC Dan Williams on this idea.


The problem is, e.g for vhost control path. During mem table validation, 
we don't even want to access them there. So the spec barrier is not needed.


>
>
>>>> On machine with SMAP (Broadwell):
>>>>
>>>> Before: 5.0Mpps
>>>>
>>>> After: 6.1Mpps
>>>>
>>>> No smap: 7.5Mpps
>>>>
>>>>
>>>> Thanks
>>> no smap being before or after?
>>>
>> Let me clarify:
>>
>>
>> Before (SMAP on): 5.0Mpps
>>
>> Before (SMAP off): 7.5Mpps
>>
>> After (SMAP on): 6.1Mpps
>>
>>
>> Thanks
> How about after + smap off?


After (SMAP off): 8.0Mpps


>
> And maybe we want a module option just for the vhost thread to keep smap
> off generally since almost all it does is copy stuff from userspace into
> kernel anyway. Because what above numbers should is that we really
> really want a solution that isn't limited to just meta-data access,
> and I really do not see how any such solution can not also be
> used to make meta-data access fast.


As we've discussed in another thread of previous version. This requires 
lots of changes, the main issues is SMAP state was not saved/restored on 
explicit schedule(). Even if it did, since vhost will call lots of 
net/block codes, any kind of uaccess in those codes needs understand 
this special request from vhost e.g you provably need to invent a new 
kinds of iov iterator that does not touch SMAP at all. And I'm not sure 
this is the only thing we need to deal with.

So I still prefer to:

1) speedup the metadata access through vmap + MMU notifier

2) speedup the datacopy with batched copy (unsafe ones or other new 
interfaces)

Thanks


