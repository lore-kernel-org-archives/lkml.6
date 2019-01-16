Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15328C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09C0205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404774AbfAPPAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:00:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:48474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728675AbfAPPAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:00:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C189AC8A;
        Wed, 16 Jan 2019 15:00:23 +0000 (UTC)
Subject: Re: [PATCH 11/25] mm, compaction: Use free lists to quickly locate a
 migration source
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-12-mgorman@techsingularity.net>
 <f1e0e977-d901-776d-9a6a-799735ebd3bf@suse.cz>
 <20190116143308.GE27437@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <d232eb5a-065f-742f-35e3-b06cfdfbeb69@suse.cz>
Date:   Wed, 16 Jan 2019 16:00:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190116143308.GE27437@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 3:33 PM, Mel Gorman wrote:
>>> +				break;
>>> +			}
>>> +
>>> +			/*
>>> +			 * If low PFNs are being found and discarded then
>>> +			 * limit the scan as fast searching is finding
>>> +			 * poor candidates.
>>> +			 */
>>
>> I wonder about the "low PFNs are being found and discarded" part. Maybe
>> I'm missing it, but I don't see them being discarded above, this seems
>> to be the first check against cc->migrate_pfn. With the min() part in
>> update_fast_start_pfn(), does it mean we can actually go back and rescan
>> (or skip thanks to skip bits, anyway) again pageblocks that we already
>> scanned?
>>
> 
> Extremely poor phrasing. My mind was thinking in terms of discarding
> unsuitable candidates as they were below the migration scanner and it
> did not translate properly.
> 
> Based on your feedback, how does the following untested diff look?

IMHO better. Meanwhile I noticed that the next patch removes the
set_pageblock_skip() so maybe it's needless churn to introduce the
fast_find_block, but I'll check more closely.

The new comment about pfns below cc->migrate_pfn is better but I still
wonder if it would be better to really skip over those candidates (they
are still called unsuitable) and not go backwards with cc->migrate_pfn.
But if you think the pageblock skip bits and halving of limit minimizes
pointless rescan sufficiently, then fine.
