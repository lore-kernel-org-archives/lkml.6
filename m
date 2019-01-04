Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F8FC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6BB218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfADQtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:49:05 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60715 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbfADQtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:49:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0THXcS8M_1546620389;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THXcS8M_1546620389)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 05 Jan 2019 00:46:31 +0800
Subject: Re: [RFC PATCH 0/3] mm: memcontrol: delayed force empty
To:     Michal Hocko <mhocko@kernel.org>
Cc:     hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190103101215.GH31793@dhcp22.suse.cz>
 <b3ad06ed-f620-7aa0-5697-a1bbe2d7bfe1@linux.alibaba.com>
 <20190103181329.GW31793@dhcp22.suse.cz>
 <6f43e926-3bb5-20d1-2e39-1d30bf7ad375@linux.alibaba.com>
 <20190103185333.GX31793@dhcp22.suse.cz>
 <d610c665-890f-3bf0-1e2a-437150b6ddfb@linux.alibaba.com>
 <20190103192339.GA31793@dhcp22.suse.cz>
 <88b4d986-0b3c-cbf0-65ad-95f3e8ccd870@linux.alibaba.com>
 <20190103200111.GD31793@dhcp22.suse.cz>
 <146af1c6-4405-76c5-b253-c8fba11779bf@linux.alibaba.com>
 <20190104085547.GG31793@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <5b377ce9-2eea-628a-4da7-fe6d6db88863@linux.alibaba.com>
Date:   Fri, 4 Jan 2019 08:46:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190104085547.GG31793@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/19 12:55 AM, Michal Hocko wrote:
> On Thu 03-01-19 20:15:30, Yang Shi wrote:
>>
>> On 1/3/19 12:01 PM, Michal Hocko wrote:
>>> On Thu 03-01-19 11:49:32, Yang Shi wrote:
>>>> On 1/3/19 11:23 AM, Michal Hocko wrote:
>>>>> On Thu 03-01-19 11:10:00, Yang Shi wrote:
>>>>>> On 1/3/19 10:53 AM, Michal Hocko wrote:
>>>>>>> On Thu 03-01-19 10:40:54, Yang Shi wrote:
>>>>>>>> On 1/3/19 10:13 AM, Michal Hocko wrote:
>>>>> [...]
>>>>>>>>> Is there any reason for your scripts to be strictly sequential here? In
>>>>>>>>> other words why cannot you offload those expensive operations to a
>>>>>>>>> detached context in _userspace_?
>>>>>>>> I would say it has not to be strictly sequential. The above script is just
>>>>>>>> an example to illustrate the pattern. But, sometimes it may hit such pattern
>>>>>>>> due to the complicated cluster scheduling and container scheduling in the
>>>>>>>> production environment, for example the creation process might be scheduled
>>>>>>>> to the same CPU which is doing force_empty. I have to say I don't know too
>>>>>>>> much about the internals of the container scheduling.
>>>>>>> In that case I do not see a strong reason to implement the offloding
>>>>>>> into the kernel. It is an additional code and semantic to maintain.
>>>>>> Yes, it does introduce some additional code and semantic, but IMHO, it is
>>>>>> quite simple and very straight forward, isn't it? Just utilize the existing
>>>>>> css offline worker. And, that a couple of lines of code do improve some
>>>>>> throughput issues for some real usecases.
>>>>> I do not really care it is few LOC. It is more important that it is
>>>>> conflating force_empty into offlining logic. There was a good reason to
>>>>> remove reparenting/emptying the memcg during the offline. Considering
>>>>> that you can offload force_empty from userspace trivially then I do not
>>>>> see any reason to implement it in the kernel.
>>>> Er, I may not articulate in the earlier email, force_empty can not be
>>>> offloaded from userspace *trivially*. IOWs the container scheduler may
>>>> unexpectedly overcommit something due to the stall of synchronous force
>>>> empty, which can't be figured out by userspace before it actually happens.
>>>> The scheduler doesn't know how long force_empty would take. If the
>>>> force_empty could be offloaded by kernel, it would make scheduler's life
>>>> much easier. This is not something userspace could do.
>>> What exactly prevents
>>> (
>>> echo 1 > $memecg/force_empty
>>> rmdir $memcg
>>> ) &
>>>
>>> so that this sequence doesn't really block anything?
>> We have "restarting the same name job" logic in our usecase (I'm not quite
>> sure why they do so). Basically, it means to create memcg with the exact
>> same name right after the old one is deleted, but may have different limit
>> or other settings. The creation has to wait for rmdir is done. Even though
>> rmdir is done in background like the above, the stall still exists since
>> rmdir simply is waiting for force_empty.
> OK, I see. This is an important detail you didn't mention previously (or
> at least I didn't understand it). One thing is still not clear to me.

Sorry, I should articulated at the first place.

> "Restarting the same job" sounds as if the memcg itself could be
> recycled as well. You are saying that the setting might change but if
> that is about limits then we should handle that just fine. Or what other
> kind of setting changes that wouldn't work properly?

We did try resize limit, but it may also incur costly direct reclaim to 
block something. Other than this we also want to reset all the 
counters/stats to get clearer and cleaner resource isolation since the 
container may run different jobs although they use the same name.

>
> If the recycling is not possible then I would suggest to not reuse
> force_empty interface but add wipe_on_destruction or similar new knob
> which would enforce reclaim on offlining. It seems we have several
> people asking for something like that already.

We did have a new knob in our in-house implementation, it just did 
force_empty on offlining.

So, you mean to have a new knob to just do force empty offlining, and 
keep force_empty's behavior, right?

Thanks,
Yang


