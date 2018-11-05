Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF13C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C6C20869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C6C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbeKEUAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:00:49 -0500
Received: from relay.sw.ru ([185.231.240.75]:46850 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbeKEUAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:00:49 -0500
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gJcKC-0007Kb-EN; Mon, 05 Nov 2018 13:41:40 +0300
Subject: Re: [PATCH 2/2] mm: avoid unnecessary swap_info_struct allocation
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
References: <a24bf353-8715-2bee-d0fa-96ca06c5b69f@virtuozzo.com>
 <87sh0gbau6.fsf@yhuang-dev.intel.com>
 <bf132d36-e9cd-8c27-fffa-f3e734065aec@virtuozzo.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <94e89c5b-a7c3-2b5f-d509-df29fb07c53c@virtuozzo.com>
Date:   Mon, 5 Nov 2018 13:41:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bf132d36-e9cd-8c27-fffa-f3e734065aec@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was wrong, openVz blocks sys_swapon/swapoff syscalls inside containers.
Our kernel just emulates /proc/swaps output inside containers,
it is enough for 'swapon' userspace to do not fail and show required info.

So I do not have any special arguments for proposed patch.

On 11/5/18 8:19 AM, Vasily Averin wrote:
> On 11/5/18 3:57 AM, Huang, Ying wrote:
>> Vasily Averin <vvs@virtuozzo.com> writes:
>>
>>> Currently newly allocated swap_info_struct can be quickly freed.
>>> This patch avoid uneccessary high-order page allocation and helps
>>> to decrease the memory pressure.
>>
>> I think swapon/swapoff are rare operations, so it will not increase the
>> memory pressure much.
> 
> You are right, typically it should not affect usual nodes.
> 
> It's OpenVz-specific usecase.
> 
> OpenVz allows hosters to run hundreds of non-trusted containers per node.
> Our containers have enabled "virtual swap" functionality, 
> and container's owners can call sys_swapon without any limits.
> Containers can be restarted in any time and we would like to 
> decrease number of unnecessary high-order memory allocations.
> 
>>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>>> ---
>>>  mm/swapfile.c | 18 +++++++++++++-----
>>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index 8688ae65ef58..53ec2f0cdf26 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -2809,14 +2809,17 @@ late_initcall(max_swapfiles_check);
>>>  
>>>  static struct swap_info_struct *alloc_swap_info(void)
>>>  {
>>> -	struct swap_info_struct *p;
>>> +	struct swap_info_struct *p = NULL;
>>>  	unsigned int type;
>>>  	int i;
>>> +	bool force_alloc = false;
>>>  
>>> -	p = kvzalloc(sizeof(*p), GFP_KERNEL);
>>> -	if (!p)
>>> -		return ERR_PTR(-ENOMEM);
>>> -
>>> +retry:
>>> +	if (force_alloc) {
>>> +		p = kvzalloc(sizeof(*p), GFP_KERNEL);
>>> +		if (!p)
>>> +			return ERR_PTR(-ENOMEM);
>>> +	}
>>>  	spin_lock(&swap_lock);
>>>  	for (type = 0; type < nr_swapfiles; type++) {
>>>  		if (!(swap_info[type]->flags & SWP_USED))
>>> @@ -2828,6 +2831,11 @@ static struct swap_info_struct *alloc_swap_info(void)
>>>  		return ERR_PTR(-EPERM);
>>>  	}
>>>  	if (type >= nr_swapfiles) {
>>> +		if (!force_alloc) {
>>> +			force_alloc = true;
>>> +			spin_unlock(&swap_lock);
>>> +			goto retry;
>>> +		}
>>>  		p->type = type;
>>>  		swap_info[type] = p;
>>>  		/*
>>
