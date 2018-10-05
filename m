Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4DEC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BC020875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OZ4+7ydT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f0vuY2V8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BC020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeJEOWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:22:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49950 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeJEOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:22:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9729B60C72; Fri,  5 Oct 2018 07:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538724287;
        bh=NIX8VMloPWrwsEOvJqzrL0iO5uHzA015ASINX4eBK9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OZ4+7ydT1U0t/FybaRnFnHeVyL/6RyXOiRWQaasI0zomtAcMhvMi3UIbakMLbvtBa
         M6zhgzhhF2/3DNCQCgD6tftGSJkxUzMAVQ5wbq+5G+wHv3eXZlw6WuX2nsEIStq484
         H9s8p5q89G5EvFpZK1yu/iL1eQ+yBIiq9SUrvm3Q=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 11E6160818;
        Fri,  5 Oct 2018 07:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538724286;
        bh=NIX8VMloPWrwsEOvJqzrL0iO5uHzA015ASINX4eBK9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f0vuY2V8S9O3efCBZXVBhazWs8Lx0djtvmYJR4aA2obmAoQRitZ0B12Sdc1wc52CR
         JgLgAPFj7lHZZ0CRcYu3SGVqAc0Hie45UQ5GR4gg1u4m/YgORvZ+2iAZKuaIq8FuJe
         AEJJ4jHg9XeBYCdfJm6sx338SBld+9NHTf0T2d1E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Oct 2018 12:54:45 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        vbabka@suse.cz, iamjoonsoo.kim@lge.com, gregkh@linuxfoundation.org,
        osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v4] memory_hotplug: Free pages as higher order
In-Reply-To: <20181004145108.GH22173@dhcp22.suse.cz>
References: <1538573979-28365-1-git-send-email-arunks@codeaurora.org>
 <20181004145108.GH22173@dhcp22.suse.cz>
Message-ID: <9ed0de45f2d7257c56e39efe43606d27@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-04 20:21, Michal Hocko wrote:
> On Wed 03-10-18 19:09:39, Arun KS wrote:
> [...]
>> +static int online_pages_blocks(unsigned long start, unsigned long 
>> nr_pages)
>> +{
>> +	unsigned long end = start + nr_pages;
>> +	int order, ret, onlined_pages = 0;
>> +
>> +	while (start < end) {
>> +		order = min(MAX_ORDER - 1UL, __ffs(start));
>> +
>> +		while (start + (1UL << order) > end)
>> +			order--;
> 
> this really made me scratch my head. Wouldn't it be much simpler to do
> the following?
> 		order = min(MAX_ORDER - 1, get_order(end - start))?

Yes. Much better. Will change to,

                 order = min(MAX_ORDER - 1,
                         get_order(PFN_PHYS(end) - PFN_PHYS(start)));

> 
>> +
>> +		ret = (*online_page_callback)(pfn_to_page(start), order);
>> +		if (!ret)
>> +			onlined_pages += (1UL << order);
>> +		else if (ret > 0)
>> +			onlined_pages += ret;
>> +
>> +		start += (1UL << order);
>> +	}
>> +	return onlined_pages;
>>  }
> [...]
>> -static void __init __free_pages_boot_core(struct page *page, unsigned 
>> int order)
>> +void __free_pages_core(struct page *page, unsigned int order)
>>  {
>>  	unsigned int nr_pages = 1 << order;
>>  	struct page *p = page;
>>  	unsigned int loop;
>> 
>> -	prefetchw(p);
>> -	for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
>> -		prefetchw(p + 1);
>> +	for (loop = 0; loop < nr_pages; loop++, p++) {
>>  		__ClearPageReserved(p);
>>  		set_page_count(p, 0);
>>  	}
>> -	__ClearPageReserved(p);
>> -	set_page_count(p, 0);
>> 
>>  	page_zone(page)->managed_pages += nr_pages;
>>  	set_page_refcounted(page);
> 
> I think this is wort a separate patch as it is unrelated to the patch.
Sure. Will split the patch.

Regards,
Arun
