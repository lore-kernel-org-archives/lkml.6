Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC21C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BA4223D0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BA4223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbeKMBGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:06:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:21937 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbeKMBGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:06:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 07:12:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,495,1534834800"; 
   d="scan'208";a="88679704"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.251.10.23]) ([10.251.10.23])
  by orsmga007.jf.intel.com with ESMTP; 12 Nov 2018 07:12:14 -0800
Subject: Re: [mm PATCH v5 7/7] mm: Use common iterator for deferred_init_pages
 and deferred_free_pages
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mhocko@suse.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
References: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
 <154145280115.30046.13334106887516645119.stgit@ahduyck-desk1.jf.intel.com>
 <20181110041338.7ttram7po7a2ssz7@xakep.localdomain>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <ce8504f0-5963-7415-8e8d-7454b0e68fe5@linux.intel.com>
Date:   Mon, 12 Nov 2018 07:12:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181110041338.7ttram7po7a2ssz7@xakep.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/2018 8:13 PM, Pavel Tatashin wrote:
> On 18-11-05 13:20:01, Alexander Duyck wrote:
>> +static unsigned long __next_pfn_valid_range(unsigned long *i,
>> +					    unsigned long end_pfn)
>>   {
>> -	if (!pfn_valid_within(pfn))
>> -		return false;
>> -	if (!(pfn & (pageblock_nr_pages - 1)) && !pfn_valid(pfn))
>> -		return false;
>> -	return true;
>> +	unsigned long pfn = *i;
>> +	unsigned long count;
>> +
>> +	while (pfn < end_pfn) {
>> +		unsigned long t = ALIGN(pfn + 1, pageblock_nr_pages);
>> +		unsigned long pageblock_pfn = min(t, end_pfn);
>> +
>> +#ifndef CONFIG_HOLES_IN_ZONE
>> +		count = pageblock_pfn - pfn;
>> +		pfn = pageblock_pfn;
>> +		if (!pfn_valid(pfn))
>> +			continue;
>> +#else
>> +		for (count = 0; pfn < pageblock_pfn; pfn++) {
>> +			if (pfn_valid_within(pfn)) {
>> +				count++;
>> +				continue;
>> +			}
>> +
>> +			if (count)
>> +				break;
>> +		}
>> +
>> +		if (!count)
>> +			continue;
>> +#endif
>> +		*i = pfn;
>> +		return count;
>> +	}
>> +
>> +	return 0;
>>   }
>>   
>> +#define for_each_deferred_pfn_valid_range(i, start_pfn, end_pfn, pfn, count) \
>> +	for (i = (start_pfn),						     \
>> +	     count = __next_pfn_valid_range(&i, (end_pfn));		     \
>> +	     count && ({ pfn = i - count; 1; });			     \
>> +	     count = __next_pfn_valid_range(&i, (end_pfn)))
> 
> Can this be improved somehow? It took me a while to understand this
> piece of code. i is actually end of block, and not an index by PFN, ({pfn = i - count; 1;}) is
> simply hard to parse. Why can't we make __next_pfn_valid_range() to
> return both end and a start of a block?

One thing I could do is flip the direction and work from the end to the 
start. If I did that then 'i' and 'pfn' would be the same value and I 
wouldn't have to do the subtraction. If that works for you I could 
probably do that and it may actually be more efficient.

Otherwise I could probably pass pfn as a reference, and compute it in 
the case where count is non-zero.

> The rest is good:
> 
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> 
> Thank you,
> Pasha
> 
