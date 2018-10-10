Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89E5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910922077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XtVbpkRo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HPRAe2pT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910922077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJKATn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:19:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45146 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJKATn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:19:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9A0EC600C1; Wed, 10 Oct 2018 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539190602;
        bh=rTGq1MPcA4dcO+RD/B2LbWZW48cyLy+nfDnbfxXA1ww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XtVbpkRoEHl7b9QaVc9wVwDg3x0fA8fpZofmWCTy4FtL/y1G/AEAxnFXBM4J1hXRR
         wtf4hkIP4T720sKwGEHleyOIJQcvjU8DdFAXVcGUExXqw+trjd9UafxKpzmvw7OcWA
         8PHBOn0vItXcRnEG/aQ1l2q0VbwGJmYmTBTb/XDo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 70230600C1;
        Wed, 10 Oct 2018 16:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539190601;
        bh=rTGq1MPcA4dcO+RD/B2LbWZW48cyLy+nfDnbfxXA1ww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HPRAe2pTi4fIjuP6cbqZBujeqYkRZqLUtZOup/ouA+GCr8xukld3hRtmx29MpMfEb
         k4mQOCFTTKLAAVIRPNmHsnpoiq7nHG6PudXbXHfHr4T96ZKNvDHDZuouMCslCZLzLy
         5Tu6EirhAnCYKXRI2vYyOha1R7NWub9G06jeUtA4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Oct 2018 22:26:41 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, iamjoonsoo.kim@lge.com,
        gregkh@linuxfoundation.org, osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v5 1/2] memory_hotplug: Free pages as higher order
In-Reply-To: <72215e75-6c7e-0aef-c06e-e3aba47cf806@suse.cz>
References: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
 <72215e75-6c7e-0aef-c06e-e3aba47cf806@suse.cz>
Message-ID: <efb65160af41d0e18cb2dcb30c2fb86a@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-10 21:00, Vlastimil Babka wrote:
> On 10/5/18 10:10 AM, Arun KS wrote:
>> When free pages are done with higher order, time spend on
>> coalescing pages by buddy allocator can be reduced. With
>> section size of 256MB, hot add latency of a single section
>> shows improvement from 50-60 ms to less than 1 ms, hence
>> improving the hot add latency by 60%. Modify external
>> providers of online callback to align with the change.
>> 
>> Signed-off-by: Arun KS <arunks@codeaurora.org>
> 
> [...]
> 
>> @@ -655,26 +655,44 @@ void __online_page_free(struct page *page)
>>  }
>>  EXPORT_SYMBOL_GPL(__online_page_free);
>> 
>> -static void generic_online_page(struct page *page)
>> +static int generic_online_page(struct page *page, unsigned int order)
>>  {
>> -	__online_page_set_limits(page);
> 
> This is now not called anymore, although the xen/hv variants still do
> it. The function seems empty these days, maybe remove it as a followup
> cleanup?
> 
>> -	__online_page_increment_counters(page);
>> -	__online_page_free(page);
>> +	__free_pages_core(page, order);
>> +	totalram_pages += (1UL << order);
>> +#ifdef CONFIG_HIGHMEM
>> +	if (PageHighMem(page))
>> +		totalhigh_pages += (1UL << order);
>> +#endif
> 
> __online_page_increment_counters() would have used
> adjust_managed_page_count() which would do the changes under
> managed_page_count_lock. Are we safe without the lock? If yes, there
> should perhaps be a comment explaining why.

Looks unsafe without managed_page_count_lock. I think better have a 
similar implementation of free_boot_core() in memory_hotplug.c like we 
had in version 1 of patch. And use adjust_managed_page_count() instead 
of page_zone(page)->managed_pages += nr_pages;

https://lore.kernel.org/patchwork/patch/989445/

-static void generic_online_page(struct page *page)
+static int generic_online_page(struct page *page, unsigned int order)
  {
-	__online_page_set_limits(page);
-	__online_page_increment_counters(page);
-	__online_page_free(page);
+	unsigned long nr_pages = 1 << order;
+	struct page *p = page;
+
+	for (loop = 0 ; loop < nr_pages ; loop++, p++) {
+		__ClearPageReserved(p);
+		set_page_count(p, 0);
+	}
+
+	adjust_managed_page_count(page, nr_pages);
+	set_page_refcounted(page);
+	__free_pages(page, order);
+
+	return 0;
+}


Regards,
Arun

