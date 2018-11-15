Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DCEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328192086A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328192086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeKOK4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:56:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:14100 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeKOKz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 05:55:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 16:50:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,234,1539673200"; 
   d="scan'208";a="100330509"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.251.21.216]) ([10.251.21.216])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2018 16:50:23 -0800
Subject: Re: [mm PATCH v5 0/7] Deferred page init improvements
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
References: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
 <20181114150742.GZ23419@dhcp22.suse.cz>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <9e8218eb-80bf-fc02-ae56-42ccfddb572e@linux.intel.com>
Date:   Wed, 14 Nov 2018 16:50:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181114150742.GZ23419@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/2018 7:07 AM, Michal Hocko wrote:
> On Mon 05-11-18 13:19:25, Alexander Duyck wrote:
>> This patchset is essentially a refactor of the page initialization logic
>> that is meant to provide for better code reuse while providing a
>> significant improvement in deferred page initialization performance.
>>
>> In my testing on an x86_64 system with 384GB of RAM and 3TB of persistent
>> memory per node I have seen the following. In the case of regular memory
>> initialization the deferred init time was decreased from 3.75s to 1.06s on
>> average. For the persistent memory the initialization time dropped from
>> 24.17s to 19.12s on average. This amounts to a 253% improvement for the
>> deferred memory initialization performance, and a 26% improvement in the
>> persistent memory initialization performance.
>>
>> I have called out the improvement observed with each patch.
> 
> I have only glanced through the code (there is a lot of the code to look
> at here). And I do not like the code duplication and the way how you
> make the hotplug special. There shouldn't be any real reason for that
> IMHO (e.g. why do we init pfn-at-a-time in early init while we do
> pageblock-at-a-time for hotplug). I might be wrong here and the code
> reuse might be really hard to achieve though.

Actually it isn't so much that hotplug is special. The issue is more 
that the non-hotplug case is special in that you have to perform a 
number of extra checks for things that just aren't necessary for the 
hotplug case.

If anything I would probably need a new iterator that would be able to 
take into account all the checks for the non-hotplug case and then 
provide ranges of PFNs to initialize.

> I am also not impressed by new iterators because this api is quite
> complex already. But this is mostly a detail.

Yeah, the iterators were mostly an attempt at hiding some of the 
complexity. Being able to break a loop down to just an iterator provding 
the start of the range and the number of elements to initialize is 
pretty easy to visualize, or at least I thought so.

> Thing I do not like is that you keep microptimizing PageReserved part
> while there shouldn't be anything fundamental about it. We should just
> remove it rather than make the code more complex. I fell more and more
> guilty to add there actually.

I plan to remove it, but don't think I can get to it in this patch set.

I was planning to submit one more iteration of this patch set early next 
week, and then start focusing more on the removal of the PageReserved 
bit for hotplug. I figure it is probably going to be a full patch set 
onto itself and as you pointed out at the start of this email there is 
already enough code to review without adding that.


