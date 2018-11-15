Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD91C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1346421582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1346421582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbeKPCK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:10:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:62690 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeKPCK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:10:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 08:02:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,236,1539673200"; 
   d="scan'208";a="100519336"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.251.21.216]) ([10.251.21.216])
  by orsmga003.jf.intel.com with ESMTP; 15 Nov 2018 08:02:33 -0800
Subject: Re: [mm PATCH v5 0/7] Deferred page init improvements
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
References: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
 <20181114150742.GZ23419@dhcp22.suse.cz>
 <9e8218eb-80bf-fc02-ae56-42ccfddb572e@linux.intel.com>
 <20181115081006.GC23831@dhcp22.suse.cz>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <b4a4d2ca-da7a-b8cd-bf0f-a119ebd67da8@linux.intel.com>
Date:   Thu, 15 Nov 2018 08:02:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181115081006.GC23831@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/2018 12:10 AM, Michal Hocko wrote:
> On Wed 14-11-18 16:50:23, Alexander Duyck wrote:
>>
>>
>> On 11/14/2018 7:07 AM, Michal Hocko wrote:
>>> On Mon 05-11-18 13:19:25, Alexander Duyck wrote:
>>>> This patchset is essentially a refactor of the page initialization logic
>>>> that is meant to provide for better code reuse while providing a
>>>> significant improvement in deferred page initialization performance.
>>>>
>>>> In my testing on an x86_64 system with 384GB of RAM and 3TB of persistent
>>>> memory per node I have seen the following. In the case of regular memory
>>>> initialization the deferred init time was decreased from 3.75s to 1.06s on
>>>> average. For the persistent memory the initialization time dropped from
>>>> 24.17s to 19.12s on average. This amounts to a 253% improvement for the
>>>> deferred memory initialization performance, and a 26% improvement in the
>>>> persistent memory initialization performance.
>>>>
>>>> I have called out the improvement observed with each patch.
>>>
>>> I have only glanced through the code (there is a lot of the code to look
>>> at here). And I do not like the code duplication and the way how you
>>> make the hotplug special. There shouldn't be any real reason for that
>>> IMHO (e.g. why do we init pfn-at-a-time in early init while we do
>>> pageblock-at-a-time for hotplug). I might be wrong here and the code
>>> reuse might be really hard to achieve though.
>>
>> Actually it isn't so much that hotplug is special. The issue is more that
>> the non-hotplug case is special in that you have to perform a number of
>> extra checks for things that just aren't necessary for the hotplug case.
> 
> Can we hide those behind a helper (potentially with a jump label if
> necessary) and still share a large part of the code? Also this code is
> quite old and maybe we are overzealous with the early checks. Do we
> really need them. Why should be early boot memory any different from the
> hotplug. The only exception I can see should really be deferred
> initialization check.
> 
>> If anything I would probably need a new iterator that would be able to take
>> into account all the checks for the non-hotplug case and then provide ranges
>> of PFNs to initialize.
>>
>>> I am also not impressed by new iterators because this api is quite
>>> complex already. But this is mostly a detail.
>>
>> Yeah, the iterators were mostly an attempt at hiding some of the complexity.
>> Being able to break a loop down to just an iterator provding the start of
>> the range and the number of elements to initialize is pretty easy to
>> visualize, or at least I thought so.
> 
> I am not against hiding the complexity. I am mostly concerned that we
> have too many of those iterators. Maybe we can reuse existing ones in
> some way. If that is not really possible or it would make even more mess
> then fair enough and go with new ones.
> 
>>> Thing I do not like is that you keep microptimizing PageReserved part
>>> while there shouldn't be anything fundamental about it. We should just
>>> remove it rather than make the code more complex. I fell more and more
>>> guilty to add there actually.
>>
>> I plan to remove it, but don't think I can get to it in this patch set.
> 
> What I am trying to argue is that we should simply drop the
> __SetPageReserved as an independent patch prior to this whole series.
> As I've mentioned earlier, I have added this just to be sure and part of
> that was that __add_section has set the reserved bit. This is no longer
> the case since d0dc12e86b31 ("mm/memory_hotplug: optimize memory
> hotplug").
> 
> Nobody should really depend on that because struct pages are in
> undefined state after __add_pages and they should get fully initialized
> after move_pfn_range_to_zone.
> 
> If you really insist on setting the reserved bit then it really has to
> happen much sooner than it is right now. So I do not really see any
> point in doing so. Sure there are some pfn walkers that really need to
> do pfn_to_online_page because pfn_valid is not sufficient but that is
> largely independent on any optimization work in this area.
> 
> I am sorry if I haven't been clear about that before. Does it make more
> sense to you now?

I get what you are saying I just don't agree with the ordering. I have 
had these patches in the works for a couple months now. You are 
essentially telling me to defer these in favor of taking care of the 
reserved bit first.

The only spot where I think we disagree is that I would prefer to get 
these in first, and then focus on the reserved bit. I'm not saying we 
shouldn't do the work, but I would rather take care of the immediate 
issue, and then "clean house" as it were. I've done that sort of thing 
in the past where I start deferring patches and then by the end of 
things I have a 60 patch set I am trying to push because one fix gets 
ahead of another and another.

My big concern is that dropping the reserved bit is going to be much 
more error prone than the work I have done in this patch set since it is 
much more likely that somebody somewhere has made a false reliance on it 
being set. If you have any tests you usually run for memory hotplug it 
would be useful if you could point me in that direction. Then I can move 
forward with the upcoming patch set with a bit more confidence.

> P.S.
> There is always that tempting thing to follow the existing code and
> tweak it for a new purpose. This approach, however, adds more and more
> complex code on top of something that might be wrong or stale already.
> I have seen that in MM code countless times and I have contributed to
> that myself. I am sorry to push back on this so hard but this code is
> a mess and any changes to make it more optimal should really make sure
> the foundations are solid before. Been there done that, not a huge fun
> but that is the price for having basically unmaintained piece of code
> that random usecases stop by and do what they need without ever
> following up later.

That is what I am doing. That is why I found and dropped the check for 
the NUMA not in the deferred init. I am pushing back on code where it 
makes sense to do so and determine what actually is adding value. My 
concern is more that I am worried that trying to make things "perfect" 
might be getting in the way of "good". Kernel development has always 
been an incremental process. My preference would be to lock down what we 
have before I go diving in and cleaning up other bits of the memory init.
