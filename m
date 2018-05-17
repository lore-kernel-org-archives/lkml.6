Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeEQRxj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:53:39 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46072 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeEQRxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:53:38 -0400
X-Google-Smtp-Source: AB8JxZoXrP3+8HCrw6vnLHvOEruWcFykvy6MWosblcMFP0mlpWQNKZSI0Wj79e0BrgrJOgmnRTuh2Q==
Subject: Re: [PATCH] Revert "mm/cma: manage the memory of the CMA area by
 using the ZONE_MOVABLE"
To: Michal Hocko <mhocko@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Tony Lindgren <tony@atomide.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Nazarewicz <mina86@mina86.com>,
        Minchan Kim <minchan@kernel.org>, Rik van Riel <riel@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20180517125959.8095-1-ville.syrjala@linux.intel.com>
 <20180517132109.GU12670@dhcp22.suse.cz> <20180517133629.GH23723@intel.com>
 <20180517135832.GI23723@intel.com> <20180517164947.GV12670@dhcp22.suse.cz>
 <20180517170816.GW12670@dhcp22.suse.cz>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <ccbe3eda-0880-1d59-2204-6bd4b317a4fe@redhat.com>
Date: Thu, 17 May 2018 10:53:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517170816.GW12670@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2018 10:08 AM, Michal Hocko wrote:
> On Thu 17-05-18 18:49:47, Michal Hocko wrote:
>> On Thu 17-05-18 16:58:32, Ville Syrjälä wrote:
>>> On Thu, May 17, 2018 at 04:36:29PM +0300, Ville Syrjälä wrote:
>>>> On Thu, May 17, 2018 at 03:21:09PM +0200, Michal Hocko wrote:
>>>>> On Thu 17-05-18 15:59:59, Ville Syrjala wrote:
>>>>>> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
>>>>>>
>>>>>> This reverts commit bad8c6c0b1144694ecb0bc5629ede9b8b578b86e.
>>>>>>
>>>>>> Make x86 with HIGHMEM=y and CMA=y boot again.
>>>>>
>>>>> Is there any bug report with some more details? It is much more
>>>>> preferable to fix the issue rather than to revert the whole thing
>>>>> right away.
>>>>
>>>> The machine I have in front of me right now didn't give me anything.
>>>> Black screen, and netconsole was silent. No serial port on this
>>>> machine unfortunately.
>>>
>>> Booted on another machine with serial:
>>
>> Could you provide your .config please?
>>
>> [...]
>>> [    0.000000] cma: Reserved 4 MiB at 0x0000000037000000
>> [...]
>>> [    0.000000] BUG: Bad page state in process swapper  pfn:377fe
>>> [    0.000000] page:f53effc0 count:0 mapcount:-127 mapping:00000000 index:0x0
>>
>> OK, so this looks the be the source of the problem. -128 would be a
>> buddy page but I do not see anything that would set the counter to -127
>> and the real map count updates shouldn't really happen that early.
>>
>> Maybe CONFIG_DEBUG_VM and CONFIG_DEBUG_HIGHMEM will tell us more.
> 
> Looking closer, I _think_ that the bug is in set_highmem_pages_init->is_highmem
> and zone_movable_is_highmem might force CMA pages in the zone movable to
> be initialized as highmem. And that sounds supicious to me. Joonsoo?
> 

For a point of reference, arm with this configuration doesn't hit this bug
because highmem pages are freed via the memblock interface only instead
of iterating through each zone. It looks like the x86 highmem code
assumes only a single highmem zone and/or it's disjoint?

Thanks,
Laura
