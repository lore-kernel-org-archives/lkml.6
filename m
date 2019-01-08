Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53014C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2050B2183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfAHJQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:16:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbfAHJQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:16:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FEEB89AE3;
        Tue,  8 Jan 2019 09:15:59 +0000 (UTC)
Received: from [10.36.117.234] (ovpn-117-234.ams2.redhat.com [10.36.117.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DEF4608DC;
        Tue,  8 Jan 2019 09:15:57 +0000 (UTC)
Subject: Re: [PATCH] hv_balloon: avoid touching uninitialized struct page
 during tail onlining
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org
Cc:     Sasha Levin <sashal@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
References: <20190104141942.19126-1-vkuznets@redhat.com>
 <2ea7e975-6aae-de71-83e5-9302518802ef@redhat.com>
 <87d0p837lt.fsf@vitty.brq.redhat.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <39a3ac32-6569-d19f-c87c-da6d72251748@redhat.com>
Date:   Tue, 8 Jan 2019 10:15:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <87d0p837lt.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 08 Jan 2019 09:15:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.01.19 14:44, Vitaly Kuznetsov wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 04.01.19 15:19, Vitaly Kuznetsov wrote:
>>> Hyper-V memory hotplug protocol has 2M granularity and in Linux x86 we use
>>> 128M. To deal with it we implement partial section onlining by registering
>>> custom page onlining callback (hv_online_page()). Later, when more memory
>>> arrives we try to online the 'tail' (see hv_bring_pgs_online()).
>>>
>>> It was found that in some cases this 'tail' onlining causes issues:
>>>
>>>  BUG: Bad page state in process kworker/0:2  pfn:109e3a
>>>  page:ffffe08344278e80 count:0 mapcount:1 mapping:0000000000000000 index:0x0
>>>  flags: 0xfffff80000000()
>>>  raw: 000fffff80000000 dead000000000100 dead000000000200 0000000000000000
>>>  raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>>  page dumped because: nonzero mapcount
>>>  ...
>>>  Workqueue: events hot_add_req [hv_balloon]
>>>  Call Trace:
>>>   dump_stack+0x5c/0x80
>>>   bad_page.cold.112+0x7f/0xb2
>>>   free_pcppages_bulk+0x4b8/0x690
>>>   free_unref_page+0x54/0x70
>>>   hv_page_online_one+0x5c/0x80 [hv_balloon]
>>>   hot_add_req.cold.24+0x182/0x835 [hv_balloon]
>>>   ...
>>>
>>> Turns out that we now have deferred struct page initialization for memory
>>> hotplug so e.g. memory_block_action() in drivers/base/memory.c does
>>> pages_correctly_probed() check and in that check it avoids inspecting
>>> struct pages and checks sections instead. But in Hyper-V balloon driver we
>>> do PageReserved(pfn_to_page()) check and this is now wrong.
>>>
>>> Switch to checking online_section_nr() instead.
>>>
>>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>> ---
>>>  drivers/hv/hv_balloon.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
>>> index 5301fef16c31..7c6349a50ef1 100644
>>> --- a/drivers/hv/hv_balloon.c
>>> +++ b/drivers/hv/hv_balloon.c
>>> @@ -888,12 +888,14 @@ static unsigned long handle_pg_range(unsigned long pg_start,
>>>  			pfn_cnt -= pgs_ol;
>>>  			/*
>>>  			 * Check if the corresponding memory block is already
>>> -			 * online by checking its last previously backed page.
>>> -			 * In case it is we need to bring rest (which was not
>>> -			 * backed previously) online too.
>>> +			 * online. It is possible to observe struct pages still
>>> +			 * being uninitialized here so check section instead.
>>> +			 * In case the section is online we need to bring the
>>> +			 * rest of pfns (which were not backed previously)
>>> +			 * online too.
>>>  			 */
>>>  			if (start_pfn > has->start_pfn &&
>>> -			    !PageReserved(pfn_to_page(start_pfn - 1)))
>>> +			    online_section_nr(pfn_to_section_nr(start_pfn)))
>>>  				hv_bring_pgs_online(has, start_pfn, pgs_ol);
>>>  
>>>  		}
>>>
>>
>> I wonder if you should use pfn_to_online_page() and check for PageOffline().
>>
>> (I guess online_section_nr() should also do the trick)
> 
> I'm worried a bit about racing with mm code here as we're not doing
> mem_hotplug_begin()/done() so I'd slightly prefer keeping
> online_section_nr() (pfn_to_online_page() also uses it but then it gets
> to the particular struct page). Moreover, with pfn_to_online_page() we
> will be looking at some other pfn - because the start_pfn is definitelly
> offline (pre-patch we were looking at start_pfn-1). Just looking at the
> whole section seems cleaner.

Fine with me. I guess the section can never be offlined as it still
contains reserved pages if not fully "fake-onlined" by HV code already.

But we could still consider mem_hotplug_begin()/done() as we could have
a online section although online_pages() has not completed yet. So we
could actually touch some "semi onlined section".

Acked-by: David Hildenbrand <david@redhat.com>

> 
> P.S. I still think about bringing mem_hotplug_begin()/done() to
> hv_balloon but that's going to be a separate discussion, here I want to
> have a small fix backportable to stable.
> 
> Thanks,
> 


-- 

Thanks,

David / dhildenb
