Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC05ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8945721526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8945721526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeJQXNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:13:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:43202 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbeJQXNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:13:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 08:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,392,1534834800"; 
   d="scan'208";a="83363268"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.154]) ([10.7.198.154])
  by orsmga006.jf.intel.com with ESMTP; 17 Oct 2018 08:17:05 -0700
Subject: Re: [mm PATCH v3 3/6] mm: Use memblock/zone specific iterator for
 handling deferred page init
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        pavel.tatashin@microsoft.com, dave.jiang@intel.com,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        davem@davemloft.net, yi.z.zhang@linux.intel.com,
        khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
References: <20181015202456.2171.88406.stgit@localhost.localdomain>
 <20181015202709.2171.75580.stgit@localhost.localdomain>
 <20181017091154.GK18839@dhcp22.suse.cz>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <ff1add3a-446b-1e30-c4c2-cfab035f11f2@linux.intel.com>
Date:   Wed, 17 Oct 2018 08:17:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017091154.GK18839@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 2:11 AM, Michal Hocko wrote:
> On Mon 15-10-18 13:27:09, Alexander Duyck wrote:
>> This patch introduces a new iterator for_each_free_mem_pfn_range_in_zone.
>>
>> This iterator will take care of making sure a given memory range provided
>> is in fact contained within a zone. It takes are of all the bounds checking
>> we were doing in deferred_grow_zone, and deferred_init_memmap. In addition
>> it should help to speed up the search a bit by iterating until the end of a
>> range is greater than the start of the zone pfn range, and will exit
>> completely if the start is beyond the end of the zone.
>>
>> This patch adds yet another iterator called
>> for_each_free_mem_range_in_zone_from and then uses it to support
>> initializing and freeing pages in groups no larger than MAX_ORDER_NR_PAGES.
>> By doing this we can greatly improve the cache locality of the pages while
>> we do several loops over them in the init and freeing process.
>>
>> We are able to tighten the loops as a result since we only really need the
>> checks for first_init_pfn in our first iteration and after that we can
>> assume that all future values will be greater than this. So I have added a
>> function called deferred_init_mem_pfn_range_in_zone that primes the
>> iterators and if it fails we can just exit.
> 
> Numbers please.
> 
> Besides that, this adds a lot of code and I am not convinced the result
> is so much better to justify that.
If I recall most of the gains are due to better cache locality. Instead 
of running through all of memory once for init, and once for freeing 
this patch has us doing it in MAX_ORDER_NR_PAGES sized chunks. So the 
advantage is that we can keep most of the pages structs in the L2 cache 
at least on x86 processors to avoid having to go to memory as much.

I'll run performance numbers per patch today and try to make certain I 
have a line mentioning the delta for each patch in the v4 patch set.

- Alex
