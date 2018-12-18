Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E37BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDC420873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeLRN6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:58:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:47784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbeLRN6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:58:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6BD05B104;
        Tue, 18 Dec 2018 13:58:34 +0000 (UTC)
Subject: Re: [PATCH 09/14] mm, compaction: Ignore the fragmentation avoidance
 boost for isolation and compaction
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20181214230310.572-1-mgorman@techsingularity.net>
 <20181214230310.572-10-mgorman@techsingularity.net>
 <f8aeec16-65de-b873-3362-3c7cb30c4ac6@suse.cz>
 <20181218135156.GK29005@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <adae728e-0e62-abb3-901e-0696930bb7dd@suse.cz>
Date:   Tue, 18 Dec 2018 14:58:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181218135156.GK29005@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 2:51 PM, Mel Gorman wrote:
> On Tue, Dec 18, 2018 at 01:36:42PM +0100, Vlastimil Babka wrote:
>> On 12/15/18 12:03 AM, Mel Gorman wrote:
>>> When pageblocks get fragmented, watermarks are artifically boosted to pages
>>> are reclaimed to avoid further fragmentation events. However, compaction
>>> is often either fragmentation-neutral or moving movable pages away from
>>> unmovable/reclaimable pages. As the actual watermarks are preserved,
>>> allow compaction to ignore the boost factor.
>>
>> Right, I should have realized that when reviewing the boost patch. I
>> think it would be useful to do the same change in
>> __compaction_suitable() as well. Compaction has its own "gap".
>>
> 
> That gap is somewhat static though so I'm a bit more wary of it. However,

Well, watermark boost is dynamic, but based on allocations stealing from
other migratetypes, not reflecting compaction chances of success.

> the check in __isolate_free_page looks too agressive. We isolate in
> units of COMPACT_CLUSTER_MAX yet the watermark check there is based on
> the allocation request. That means for THP that we check if 512 pages
> can be allocated when only somewhere between 1 and 32 is needed for that
> compaction cycle to complete. Adjusting that might be more appropriate?

AFAIU the code in __isolate_free_page() reflects that if there's less
than 512 free pages gap, we might form a high-order page for THP but
won't be able to allocate it afterwards due to watermark.
