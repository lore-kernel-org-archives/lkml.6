Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B745BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909562087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfAHLmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:42:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfAHLmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:42:55 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71A0C7F6BB;
        Tue,  8 Jan 2019 11:42:54 +0000 (UTC)
Received: from [10.72.12.122] (ovpn-12-122.pek2.redhat.com [10.72.12.122])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D2E71057065;
        Tue,  8 Jan 2019 11:42:47 +0000 (UTC)
Subject: Re: [RFC PATCH V3 0/5] Hi:
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
References: <20181229124656.3900-1-jasowang@redhat.com>
 <20190102154038-mutt-send-email-mst@kernel.org>
 <0efd115a-a7fb-54bf-5376-59d047a15fd3@redhat.com>
 <20190106221832-mutt-send-email-mst@kernel.org>
 <c15a17b3-b604-a105-af44-a7e6dfd79801@redhat.com>
 <20190106230224-mutt-send-email-mst@kernel.org>
 <CAPcyv4iXFy0jfoQ_jQYq2yA7cqu4_Jcap4mvQesRRrV-hahGvQ@mail.gmail.com>
 <20190107084853-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <2187b6ea-19f8-5894-f94e-3e042844bf96@redhat.com>
Date:   Tue, 8 Jan 2019 19:42:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107084853-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 08 Jan 2019 11:42:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/7 下午10:11, Michael S. Tsirkin wrote:
> On Sun, Jan 06, 2019 at 11:15:20PM -0800, Dan Williams wrote:
>> On Sun, Jan 6, 2019 at 8:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>> On Mon, Jan 07, 2019 at 11:53:41AM +0800, Jason Wang wrote:
>>>> On 2019/1/7 上午11:28, Michael S. Tsirkin wrote:
>>>>> On Mon, Jan 07, 2019 at 10:19:03AM +0800, Jason Wang wrote:
>>>>>> On 2019/1/3 上午4:47, Michael S. Tsirkin wrote:
>>>>>>> On Sat, Dec 29, 2018 at 08:46:51PM +0800, Jason Wang wrote:
>>>>>>>> This series tries to access virtqueue metadata through kernel virtual
>>>>>>>> address instead of copy_user() friends since they had too much
>>>>>>>> overheads like checks, spec barriers or even hardware feature
>>>>>>>> toggling.
>>>>>>> Will review, thanks!
>>>>>>> One questions that comes to mind is whether it's all about bypassing
>>>>>>> stac/clac.  Could you please include a performance comparison with
>>>>>>> nosmap?
>>>>>>>
>>>>>> On machine without SMAP (Sandy Bridge):
>>>>>>
>>>>>> Before: 4.8Mpps
>>>>>>
>>>>>> After: 5.2Mpps
>>>>> OK so would you say it's really unsafe versus safe accesses?
>>>>> Or would you say it's just a better written code?
>>>>
>>>> It's the effect of removing speculation barrier.
>>>
>>> You mean __uaccess_begin_nospec introduced by
>>> commit 304ec1b050310548db33063e567123fae8fd0301
>>> ?
>>>
>>> So fundamentally we do access_ok checks when supplying
>>> the memory table to the kernel thread, and we should
>>> do the spec barrier there.
>>>
>>> Then we can just create and use a variant of uaccess macros that does
>>> not include the barrier?
>>>
>>> Or, how about moving the barrier into access_ok?
>>> This way repeated accesses with a single access_ok get a bit faster.
>>> CC Dan Williams on this idea.
>> It would be interesting to see how expensive re-doing the address
>> limit check is compared to the speculation barrier. I.e. just switch
>> vhost_get_user() to use get_user() rather than __get_user(). That will
>> sanitize the pointer in the speculative path without a barrier.
> Hmm it's way cheaper even though IIRC it's measureable.
> Jason, would you like to try?


0.5% regression after using get_user()/put_user()/...


> Although frankly __get_user being slower than get_user feels very wrong.
> Not yet sure what to do exactly but would you agree?
>
>
>> I recall we had a convert access_ok() discussion with this result here:
>>
>> https://lkml.org/lkml/2018/1/17/929
> Sorry let me try to clarify. IIUC speculating access_ok once
> is harmless. As Linus said the problem is with "_subsequent_
> accesses that can then be used to perturb the cache".
>
> Thus:
>
> 1. if (!access_ok)
> 2.	return
> 3.  get_user
> 4. if (!access_ok)
> 5.	return
> 6.  get_user
>
> Your proposal that Linus nacked was to effectively add a barrier after
> lines 2 and 5 (also using the array_index_nospec trick for speed),
> right? Unfortunately that needs a big API change.
>
> I am asking about adding barrier_nospec within access_ok.
> Thus effectively before lines 1 and 4.
> access_ok will be slower but after all the point of access_ok is
> to then access the same memory multiple times.
> So we should be making __get_user faster and access_ok slower ...


And the barrier_nospec() was completely necessary if you want to do 
write instead read.


Thanks


>
>> ...but it sounds like you are proposing a smaller scope fixup for the
>> vhost use case? Something like barrier_nospec() in the success path
>> for all vhost access_ok() checks and then a get_user() variant that
>> disables the barrier.
> Maybe we'll have to. Except I hope vhost won't end up being the
> only user otherwise it will be hard to maintain.
>
>
