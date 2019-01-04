Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE6AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5EF2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfADVow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:44:52 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:47833 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbfADVow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:44:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0THYCz9Q_1546638111;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THYCz9Q_1546638111)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 05 Jan 2019 05:42:06 +0800
Subject: Re: [RFC PATCH 0/3] mm: memcontrol: delayed force empty
To:     Greg Thelen <gthelen@google.com>, Michal Hocko <mhocko@kernel.org>
Cc:     hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1546459533-36247-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190103101215.GH31793@dhcp22.suse.cz>
 <b3ad06ed-f620-7aa0-5697-a1bbe2d7bfe1@linux.alibaba.com>
 <20190103181329.GW31793@dhcp22.suse.cz>
 <6f43e926-3bb5-20d1-2e39-1d30bf7ad375@linux.alibaba.com>
 <20190103185333.GX31793@dhcp22.suse.cz>
 <d610c665-890f-3bf0-1e2a-437150b6ddfb@linux.alibaba.com>
 <20190103192339.GA31793@dhcp22.suse.cz>
 <88b4d986-0b3c-cbf0-65ad-95f3e8ccd870@linux.alibaba.com>
 <xr93y380xk9k.fsf@gthelen.svl.corp.google.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <344793c0-f987-85a1-2a75-bc27083f52f4@linux.alibaba.com>
Date:   Fri, 4 Jan 2019 13:41:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xr93y380xk9k.fsf@gthelen.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/19 12:03 PM, Greg Thelen wrote:
> Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>> On 1/3/19 11:23 AM, Michal Hocko wrote:
>>> On Thu 03-01-19 11:10:00, Yang Shi wrote:
>>>> On 1/3/19 10:53 AM, Michal Hocko wrote:
>>>>> On Thu 03-01-19 10:40:54, Yang Shi wrote:
>>>>>> On 1/3/19 10:13 AM, Michal Hocko wrote:
>>> [...]
>>>>>>> Is there any reason for your scripts to be strictly sequential here? In
>>>>>>> other words why cannot you offload those expensive operations to a
>>>>>>> detached context in _userspace_?
>>>>>> I would say it has not to be strictly sequential. The above script is just
>>>>>> an example to illustrate the pattern. But, sometimes it may hit such pattern
>>>>>> due to the complicated cluster scheduling and container scheduling in the
>>>>>> production environment, for example the creation process might be scheduled
>>>>>> to the same CPU which is doing force_empty. I have to say I don't know too
>>>>>> much about the internals of the container scheduling.
>>>>> In that case I do not see a strong reason to implement the offloding
>>>>> into the kernel. It is an additional code and semantic to maintain.
>>>> Yes, it does introduce some additional code and semantic, but IMHO, it is
>>>> quite simple and very straight forward, isn't it? Just utilize the existing
>>>> css offline worker. And, that a couple of lines of code do improve some
>>>> throughput issues for some real usecases.
>>> I do not really care it is few LOC. It is more important that it is
>>> conflating force_empty into offlining logic. There was a good reason to
>>> remove reparenting/emptying the memcg during the offline. Considering
>>> that you can offload force_empty from userspace trivially then I do not
>>> see any reason to implement it in the kernel.
>> Er, I may not articulate in the earlier email, force_empty can not be
>> offloaded from userspace *trivially*. IOWs the container scheduler may
>> unexpectedly overcommit something due to the stall of synchronous force
>> empty, which can't be figured out by userspace before it actually
>> happens. The scheduler doesn't know how long force_empty would take. If
>> the force_empty could be offloaded by kernel, it would make scheduler's
>> life much easier. This is not something userspace could do.
> If kernel workqueues are doing more work (i.e. force_empty processing),
> then it seem like the time to offline could grow.  I'm not sure if
> that's important.

Yes, it would grow. I'm not sure, but it seems fine with our workloads.

The reclaim can be placed at the last step of offline, and it can be 
interrupted by some signals, i.e. fatal signal in current code.

>
> I assume that if we make force_empty an async side effect of rmdir then
> user space scheduler would not be unable to immediately assume the
> rmdir'd container memory is available without subjecting a new container
> to direct reclaim.  So it seems like user space would use a mechanism to
> wait for reclaim: either the existing sync force_empty or polling
> meminfo/etc waiting for free memory to appear.

Yes, it is expected side effect, the memory reclaim would happen in a 
short while. In this series I keep sync reclaim behavior of force_empty 
by checking the written value. Michal suggested a new knob do the 
offline reclaim, and keep force_empty intact.

I think using which knob is user's discretion.

Thanks,
Yang

>
>>>>> I think it is more important to discuss whether we want to introduce
>>>>> force_empty in cgroup v2.
>>>> We would prefer have it in v2 as well.
>>> Then bring this up in a separate email thread please.
>> Sure. Will prepare the patches later.
>>
>> Thanks,
>> Yang

