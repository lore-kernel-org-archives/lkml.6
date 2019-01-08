Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324A0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07838206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfAHJnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:43:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfAHJnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:43:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC08EA10DA;
        Tue,  8 Jan 2019 09:43:07 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.34.248.165])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AAA945D756;
        Tue,  8 Jan 2019 09:42:58 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     David Hildenbrand <david@redhat.com>, devel@linuxdriverproject.org
Cc:     Sasha Levin <sashal@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] hv_balloon: avoid touching uninitialized struct page during tail onlining
In-Reply-To: <39a3ac32-6569-d19f-c87c-da6d72251748@redhat.com>
References: <20190104141942.19126-1-vkuznets@redhat.com> <2ea7e975-6aae-de71-83e5-9302518802ef@redhat.com> <87d0p837lt.fsf@vitty.brq.redhat.com> <39a3ac32-6569-d19f-c87c-da6d72251748@redhat.com>
Date:   Tue, 08 Jan 2019 10:42:56 +0100
Message-ID: <877eff32ov.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 08 Jan 2019 09:43:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 07.01.19 14:44, Vitaly Kuznetsov wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
...
>>> On 04.01.19 15:19, Vitaly Kuznetsov wrote:
>>>>  			if (start_pfn > has->start_pfn &&
>>>> -			    !PageReserved(pfn_to_page(start_pfn - 1)))
>>>> +			    online_section_nr(pfn_to_section_nr(start_pfn)))
>>>>  				hv_bring_pgs_online(has, start_pfn, pgs_ol);
>>>>  
>>>>  		}
>>>>
>>>
>>> I wonder if you should use pfn_to_online_page() and check for PageOffline().
>>>
>>> (I guess online_section_nr() should also do the trick)
>> 
>> I'm worried a bit about racing with mm code here as we're not doing
>> mem_hotplug_begin()/done() so I'd slightly prefer keeping
>> online_section_nr() (pfn_to_online_page() also uses it but then it gets
>> to the particular struct page). Moreover, with pfn_to_online_page() we
>> will be looking at some other pfn - because the start_pfn is definitelly
>> offline (pre-patch we were looking at start_pfn-1). Just looking at the
>> whole section seems cleaner.
>
> Fine with me. I guess the section can never be offlined as it still
> contains reserved pages if not fully "fake-onlined" by HV code already.
>
> But we could still consider mem_hotplug_begin()/done() as we could have
> a online section although online_pages() has not completed yet. So we
> could actually touch some "semi onlined section".

Yes, exactly, if we race with section onlining here we may never online
the tail so it will remain 'semi onlined'. I'm going to propose
exporting mem_hotplug_begin()/done() to modules to fix this (in a
separate patch because I anticipate some pushback :-)

>
> Acked-by: David Hildenbrand <david@redhat.com>
>

Thanks!

-- 
Vitaly
