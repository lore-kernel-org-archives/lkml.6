Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61877C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DEA2089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SzE+QGGP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pu2A6DCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DEA2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeKHThv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:37:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50296 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeKHThv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:37:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A29F560A98; Thu,  8 Nov 2018 10:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541671388;
        bh=6IDd1Jq2sv4LEEOynU038asATcnpHpWcOhDj9SU8c4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SzE+QGGP4kai8vTOtJQvvX4II0qxQp2GmfrSHtGJ271NkZa4m+uCapmjAH5BSAzbD
         zoPZ4XylLo+b7dKLku8TaQdIUjk9Vz9AbrSd3q+vZpieKWtuTgdRLeqoIsRkuRv++q
         lwz1g6xug1cXcl2x49joaEcAHjD3nnHMdcYF9+Cc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C50B1601A8;
        Thu,  8 Nov 2018 10:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541671386;
        bh=6IDd1Jq2sv4LEEOynU038asATcnpHpWcOhDj9SU8c4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pu2A6DCWZQdErSxudGMm8elQ5mxaYDHJY1ilQWYnvpVlinniL0vyTbdbCsAInYHNH
         Jqh40/RTsM4Iyt+WpMYnJoZz+mUHeFfXSKg6ek5nH0cBT6FSpZTySlAk7s1PsDl1mw
         zeQEcKeUVKQMcHwdwtJ/KATeAngTeH3q8f5koOBQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Nov 2018 15:33:06 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        khlebnikov@yandex-team.ru, minchan@kernel.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v3 4/4] mm: Remove managed_page_count spinlock
In-Reply-To: <20181108083400.GQ27423@dhcp22.suse.cz>
References: <1541665398-29925-1-git-send-email-arunks@codeaurora.org>
 <1541665398-29925-5-git-send-email-arunks@codeaurora.org>
 <20181108083400.GQ27423@dhcp22.suse.cz>
Message-ID: <4e5e2923a424ab2e2c50e56b2e538a3c@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-08 14:04, Michal Hocko wrote:
> On Thu 08-11-18 13:53:18, Arun KS wrote:
>> Now totalram_pages and managed_pages are atomic varibles. No need
>> of managed_page_count spinlock.
> 
> As explained earlier. Please add a motivation here. Feel free to reuse
> wording from 
> http://lkml.kernel.org/r/20181107103630.GF2453@dhcp22.suse.cz

Sure. Will add in next spin.

Regards,
Arun
> 
>> 
>> Signed-off-by: Arun KS <arunks@codeaurora.org>
>> Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  include/linux/mmzone.h | 6 ------
>>  mm/page_alloc.c        | 5 -----
>>  2 files changed, 11 deletions(-)
>> 
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index e73dc31..c71b4d9 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -428,12 +428,6 @@ struct zone {
>>  	 * Write access to present_pages at runtime should be protected by
>>  	 * mem_hotplug_begin/end(). Any reader who can't tolerant drift of
>>  	 * present_pages should get_online_mems() to get a stable value.
>> -	 *
>> -	 * Read access to managed_pages should be safe because it's unsigned
>> -	 * long. Write access to zone->managed_pages and totalram_pages are
>> -	 * protected by managed_page_count_lock at runtime. Idealy only
>> -	 * adjust_managed_page_count() should be used instead of directly
>> -	 * touching zone->managed_pages and totalram_pages.
>>  	 */
>>  	atomic_long_t		managed_pages;
>>  	unsigned long		spanned_pages;
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index f8b64cc..26c5e14 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -122,9 +122,6 @@
>>  };
>>  EXPORT_SYMBOL(node_states);
>> 
>> -/* Protect totalram_pages and zone->managed_pages */
>> -static DEFINE_SPINLOCK(managed_page_count_lock);
>> -
>>  atomic_long_t _totalram_pages __read_mostly;
>>  EXPORT_SYMBOL(_totalram_pages);
>>  unsigned long totalreserve_pages __read_mostly;
>> @@ -7065,14 +7062,12 @@ static int __init 
>> cmdline_parse_movablecore(char *p)
>> 
>>  void adjust_managed_page_count(struct page *page, long count)
>>  {
>> -	spin_lock(&managed_page_count_lock);
>>  	atomic_long_add(count, &page_zone(page)->managed_pages);
>>  	totalram_pages_add(count);
>>  #ifdef CONFIG_HIGHMEM
>>  	if (PageHighMem(page))
>>  		totalhigh_pages_add(count);
>>  #endif
>> -	spin_unlock(&managed_page_count_lock);
>>  }
>>  EXPORT_SYMBOL(adjust_managed_page_count);
>> 
>> --
>> 1.9.1
