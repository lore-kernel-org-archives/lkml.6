Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B9FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E7B2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E7B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbeGROZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:25:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731003AbeGROZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:25:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 424F37C6CA;
        Wed, 18 Jul 2018 13:47:44 +0000 (UTC)
Received: from [10.36.118.31] (unknown [10.36.118.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8339D10193;
        Wed, 18 Jul 2018 13:47:34 +0000 (UTC)
Subject: Re: [PATCH v1 00/10] mm: online/offline 4MB chunks controlled by
 device driver
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>, Jan Kara <jack@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Mel Gorman <mgorman@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miles Chen <miles.chen@mediatek.com>,
        Oscar Salvador <osalvador@techadventures.net>,
        Paul Mackerras <paulus@samba.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Reza Arbab <arbab@linux.vnet.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20180524075327.GU20441@dhcp22.suse.cz>
 <14d79dad-ad47-f090-2ec0-c5daf87ac529@redhat.com>
 <20180524093121.GZ20441@dhcp22.suse.cz>
 <c0b8bbd5-6c01-f550-ae13-ef80b2255ea6@redhat.com>
 <20180524120341.GF20441@dhcp22.suse.cz>
 <1a03ac4e-9185-ce8e-a672-c747c3e40ff2@redhat.com>
 <20180524142241.GJ20441@dhcp22.suse.cz>
 <819e45c5-6ae3-1dff-3f1d-c0411b6e2e1d@redhat.com>
 <20180718131905.GB7193@dhcp22.suse.cz>
 <c4c82cd3-c1be-dce8-af2e-fcd177cf7b54@redhat.com>
 <20180718134308.GF7193@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <84568c21-bdbd-5769-56dd-64d5e2378b91@redhat.com>
Date:   Wed, 18 Jul 2018 15:47:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180718134308.GF7193@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 18 Jul 2018 13:47:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 18 Jul 2018 13:47:44 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.2018 15:43, Michal Hocko wrote:
> On Wed 18-07-18 15:39:29, David Hildenbrand wrote:
>> On 18.07.2018 15:19, Michal Hocko wrote:
>>> [got back to this really late. Sorry about that]
>>>
>>> On Thu 24-05-18 23:07:23, David Hildenbrand wrote:
>>>> On 24.05.2018 16:22, Michal Hocko wrote:
>>>>> I will go over the rest of the email later I just wanted to make this
>>>>> point clear because I suspect we are talking past each other.
>>>>
>>>> It sounds like we are now talking about how to solve the problem. I like
>>>> that :)
>>>>
>>>>>
>>>>> On Thu 24-05-18 16:04:38, David Hildenbrand wrote:
>>>>> [...]
>>>>>> The point I was making is: I cannot allocate 8MB/128MB using the buddy
>>>>>> allocator. All I want to do is manage the memory a virtio-mem device
>>>>>> provides as flexible as possible.
>>>>>
>>>>> I didn't mean to use the page allocator to isolate pages from it. We do
>>>>> have other means. Have a look at the page isolation framework and have a
>>>>> look how the current memory hotplug (ab)uses it. In short you mark the
>>>>> desired physical memory range as isolated (nobody can allocate from it)
>>>>> and then simply remove it from the page allocator. And you are done with
>>>>> it. Your particular range is gone, nobody will ever use it. If you mark
>>>>> those struct pages reserved then pfn walkers should already ignore them.
>>>>> If you keep those pages with ref count 0 then even hotplug should work
>>>>> seemlessly (I would have to double check).
>>>>>
>>>>> So all I am arguing is that whatever your driver wants to do can be
>>>>> handled without touching the hotplug code much. You would still need
>>>>> to add new ranges in the mem section units and manage on top of that.
>>>>> You need to do that anyway to keep track of what parts are in use or
>>>>> offlined anyway right? Now the mem sections. You have to do that anyway
>>>>> for memmaps. Our sparse memory model simply works in those units. Even
>>>>> if you make a part of that range unavailable then the section will still
>>>>> be there.
>>>>>
>>>>> Do I make at least some sense or I am completely missing your point?
>>>>>
>>>>
>>>> I think we're heading somewhere. I understand that you want to separate
>>>> this "semi" offline part from the general offlining code. If so, we
>>>> should definitely enforce segment alignment for online_pages/offline_pages.
>>>>
>>>> Importantly, what I need is:
>>>>
>>>> 1. Indicate and prepare memory sections to be used for adding memory
>>>>    chunks (right now add_memory())
>>>
>>> Yes, this is section based. So you will always get memmap (struct page)
>>> for the whole section.
>>>
>>>> 2. Make memory chunks of a section available to the system (right now
>>>>    online_pages())
>>>
>>> Yes, this doesn't have to be section based. All you need is to mark
>>> remaining pages as offline. They are reserved at this moment so nobody
>>> should touch tehem.
>>>
>>>> 3. Remove memory chunks of a section from the system (right now
>>>>    offline_pages())
>>>
>>> Yes. All we need is to note that those reserved pages are actually good
>>> to offline. I have mentioned that reserved pages are yours at this stage
>>> so you can note the special state without an additional page flag.
>>>
>>> The generic hotplug code just have to learn about this new state.
>>> has_unmovable_pages sounds like a proper place to do that. You simply
>>> clear the offline state and the PageReserved and you are done with the
>>> page.
>>>
>>
>> I agree. This would be minimal invassive - notifiers are still called on
>> whole segment.
> 
> That shouldn't matter because notifiers should never step on pages they
> do not manage or own.
> 
>>>> 4. Remove memory sections from the system (right now remove_memory())
>>>
>>> no change needed
>>>
>>>> 5. Hinder dumping tools from reading memory chunks that are logically
>>>>    offline (right now PageOffline())
>>>
>>> I still fail to see why do we even care about some dumping tools. Pages
>>> are reserved so they simply shouldn't touch that memory at all.
>>>
>>
>> Thanks for having a look!
>>
>> I wonder why reserved pages never got excluded by dump tools. So I
>> assume there is some kind of magic hidden in it.
>>
>> `git grep SetPageReserved` returns a number of buffers that are not to
>> be swapped. So "reserved" there is used for:
>>   "PG_reserved is set for special pages, which can never be swapped out"
> 
> That was an ancient menaing of the flag. The flag in general means that
> you shouldn't touch it unless you own it.
> 
>> And my point would be that these pages are still to be dumped (just as
>> it is being done now). They are valid memory.
> 
> Then fix kdump or what ever is touching them.

If the rule is really reserved -> dontouch, then I agree.

> 
>> It seems like this bit is used for two different purposes. My take would
>> be then to have another way of indicating "don't swap" vs. "page not
>> accessible / offline". And that's why I propose PageOffline.
>>
>> I would even go one step further and rename "reserved" to "dontswap".
> 
> No, it really doesn't have that meaning for years.
> 

So would you agree to change the comment in page-flags.h to something like

"PG_reserved is set for special pages, that should never be touched
(read/written). Some of them might not even exist."

Thanks!

-- 

Thanks,

David / dhildenb
