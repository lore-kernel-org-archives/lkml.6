Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35542C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39832070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546883815;
	bh=2fipaT8TEbUQVkA2WKBocakmjbLq4NlJxAI6lZWS89s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0yKHrIstEp2LyH78qi87kAoVpBUleR6pP2+TdTTPb+2TIUCaTIASODyRxV0IszPDl
	 zsduga43iVgcZvYzJGrtciFcmBG6Bh3zlv0NUferLXyQP8VwQVgSOkHPPtZb9oF84k
	 ozHZP4z4CxF4ihWeMVoflUmDV3D+o1xlo6A+Rfpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfAGR4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:56:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:57170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbfAGR4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:56:53 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA9242070B;
        Mon,  7 Jan 2019 17:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546883812;
        bh=2fipaT8TEbUQVkA2WKBocakmjbLq4NlJxAI6lZWS89s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmmDaT6XXEbNpFSRce17PgYhMPu5EVBrJUAJrCIjMKIzulQw4dP//if3OWn03OAEL
         M2igsr2/FJ+d67w+Rw7/3q2IWEDkEVW5s474QOPrmggeq/E4VSG89/jzyfaZ2Ab+z4
         lpuC11sMmmKKYka0fiOmq9IUCWY4ftTNJV8TMKFw=
Date:   Mon, 7 Jan 2019 12:56:50 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, devel@linuxdriverproject.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] hv_balloon: avoid touching uninitialized struct page
 during tail onlining
Message-ID: <20190107175650.GG166797@sasha-vm>
References: <20190104141942.19126-1-vkuznets@redhat.com>
 <2ea7e975-6aae-de71-83e5-9302518802ef@redhat.com>
 <87d0p837lt.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87d0p837lt.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:44:30PM +0100, Vitaly Kuznetsov wrote:
>David Hildenbrand <david@redhat.com> writes:
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
>I'm worried a bit about racing with mm code here as we're not doing
>mem_hotplug_begin()/done() so I'd slightly prefer keeping
>online_section_nr() (pfn_to_online_page() also uses it but then it gets
>to the particular struct page). Moreover, with pfn_to_online_page() we
>will be looking at some other pfn - because the start_pfn is definitelly
>offline (pre-patch we were looking at start_pfn-1). Just looking at the
>whole section seems cleaner.
>
>P.S. I still think about bringing mem_hotplug_begin()/done() to
>hv_balloon but that's going to be a separate discussion, here I want to
>have a small fix backportable to stable.

This should probably be marked for stable then :)

--
Thanks,
Sasha
