Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87838C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A5F2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfAGNom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:44:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfAGNom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:44:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 517D3C058CBD;
        Mon,  7 Jan 2019 13:44:41 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.34.244.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0FC4171AD;
        Mon,  7 Jan 2019 13:44:31 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     David Hildenbrand <david@redhat.com>, devel@linuxdriverproject.org
Cc:     Sasha Levin <sashal@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] hv_balloon: avoid touching uninitialized struct page during tail onlining
In-Reply-To: <2ea7e975-6aae-de71-83e5-9302518802ef@redhat.com>
References: <20190104141942.19126-1-vkuznets@redhat.com> <2ea7e975-6aae-de71-83e5-9302518802ef@redhat.com>
Date:   Mon, 07 Jan 2019 14:44:30 +0100
Message-ID: <87d0p837lt.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 07 Jan 2019 13:44:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 04.01.19 15:19, Vitaly Kuznetsov wrote:
>> Hyper-V memory hotplug protocol has 2M granularity and in Linux x86 we use
>> 128M. To deal with it we implement partial section onlining by registering
>> custom page onlining callback (hv_online_page()). Later, when more memory
>> arrives we try to online the 'tail' (see hv_bring_pgs_online()).
>> 
>> It was found that in some cases this 'tail' onlining causes issues:
>> 
>>  BUG: Bad page state in process kworker/0:2  pfn:109e3a
>>  page:ffffe08344278e80 count:0 mapcount:1 mapping:0000000000000000 index:0x0
>>  flags: 0xfffff80000000()
>>  raw: 000fffff80000000 dead000000000100 dead000000000200 0000000000000000
>>  raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>  page dumped because: nonzero mapcount
>>  ...
>>  Workqueue: events hot_add_req [hv_balloon]
>>  Call Trace:
>>   dump_stack+0x5c/0x80
>>   bad_page.cold.112+0x7f/0xb2
>>   free_pcppages_bulk+0x4b8/0x690
>>   free_unref_page+0x54/0x70
>>   hv_page_online_one+0x5c/0x80 [hv_balloon]
>>   hot_add_req.cold.24+0x182/0x835 [hv_balloon]
>>   ...
>> 
>> Turns out that we now have deferred struct page initialization for memory
>> hotplug so e.g. memory_block_action() in drivers/base/memory.c does
>> pages_correctly_probed() check and in that check it avoids inspecting
>> struct pages and checks sections instead. But in Hyper-V balloon driver we
>> do PageReserved(pfn_to_page()) check and this is now wrong.
>> 
>> Switch to checking online_section_nr() instead.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  drivers/hv/hv_balloon.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
>> index 5301fef16c31..7c6349a50ef1 100644
>> --- a/drivers/hv/hv_balloon.c
>> +++ b/drivers/hv/hv_balloon.c
>> @@ -888,12 +888,14 @@ static unsigned long handle_pg_range(unsigned long pg_start,
>>  			pfn_cnt -= pgs_ol;
>>  			/*
>>  			 * Check if the corresponding memory block is already
>> -			 * online by checking its last previously backed page.
>> -			 * In case it is we need to bring rest (which was not
>> -			 * backed previously) online too.
>> +			 * online. It is possible to observe struct pages still
>> +			 * being uninitialized here so check section instead.
>> +			 * In case the section is online we need to bring the
>> +			 * rest of pfns (which were not backed previously)
>> +			 * online too.
>>  			 */
>>  			if (start_pfn > has->start_pfn &&
>> -			    !PageReserved(pfn_to_page(start_pfn - 1)))
>> +			    online_section_nr(pfn_to_section_nr(start_pfn)))
>>  				hv_bring_pgs_online(has, start_pfn, pgs_ol);
>>  
>>  		}
>> 
>
> I wonder if you should use pfn_to_online_page() and check for PageOffline().
>
> (I guess online_section_nr() should also do the trick)

I'm worried a bit about racing with mm code here as we're not doing
mem_hotplug_begin()/done() so I'd slightly prefer keeping
online_section_nr() (pfn_to_online_page() also uses it but then it gets
to the particular struct page). Moreover, with pfn_to_online_page() we
will be looking at some other pfn - because the start_pfn is definitelly
offline (pre-patch we were looking at start_pfn-1). Just looking at the
whole section seems cleaner.

P.S. I still think about bringing mem_hotplug_begin()/done() to
hv_balloon but that's going to be a separate discussion, here I want to
have a small fix backportable to stable.

Thanks,

-- 
Vitaly
