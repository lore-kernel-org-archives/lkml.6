Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B04DDC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E5F208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E5F208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755172AbeFNMdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:33:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:43199 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752767AbeFNMdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:33:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9F32EAF5F;
        Thu, 14 Jun 2018 12:33:00 +0000 (UTC)
Subject: Re: [PATCH] mm, page_alloc: actually ignore mempolicies for high
 priority allocations
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20180612122624.8045-1-vbabka@suse.cz>
 <alpine.DEB.2.21.1806131241300.32038@chino.kir.corp.google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5b3946ee-7723-a6b8-0347-3b08eb6ca1ea@suse.cz>
Date:   Thu, 14 Jun 2018 14:32:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806131241300.32038@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 09:42 PM, David Rientjes wrote:
> On Tue, 12 Jun 2018, Vlastimil Babka wrote:
> 
>> The __alloc_pages_slowpath() function has for a long time contained code to
>> ignore node restrictions from memory policies for high priority allocations.
>> The current code that resets the zonelist iterator however does effectively
>> nothing after commit 7810e6781e0f ("mm, page_alloc: do not break __GFP_THISNODE
>> by zonelist reset") removed a buggy zonelist reset. Even before that commit,
>> mempolicy restrictions were still not ignored, as they are passed in
>> ac->nodemask which is untouched by the code.
>>
>> We can either remove the code, or make it work as intended. Since
>> ac->nodemask can be set from task's mempolicy via alloc_pages_current() and
>> thus also alloc_pages(), it may indeed affect kernel allocations, and it makes
>> sense to ignore it to allow progress for high priority allocations.
>>
>> Thus, this patch resets ac->nodemask to NULL in such cases. This assumes all
>> callers can handle it (i.e. there are no guarantees as in the case of
>> __GFP_THISNODE) which seems to be the case. The same assumption is already
>> present in check_retry_cpuset() for some time.
>>
>> The expected effect is that high priority kernel allocations in the context of
>> userspace tasks (e.g. OOM victims) restricted by mempolicies will have higher
>> chance to succeed if they are restricted to nodes with depleted memory, while
>> there are other nodes with free memory left.
>>
> 
> Hi Vlastimil,
> 
> Is this expected as a change back to previous behavior that we have lost 
> or is this new development for high priority allocations?  I don't think 
> we have ignored mempolicies for things like GFP_ATOMIC allocations in the 
> past.

Well, it's not a new intention, but for the first time the code will
match the intention, AFAICS. It was intended by commit 183f6371aac2
("mm: ignore mempolicies when using ALLOC_NO_WATERMARK") in v3.6 but I
think it never really worked, as mempolicy restriction was already
encoded in nodemask, not zonelist, at that time.

So originally that was for ALLOC_NO_WATERMARK only. Then it was adjusted
by e46e7b77c909 ("mm, page_alloc: recalculate the preferred zoneref if
the context can ignore memory policies") and cd04ae1e2dc8 ("mm, oom: do
not rely on TIF_MEMDIE for memory reserves access") to the current
state. So yeah even GFP_ATOMIC would now ignore mempolicies after the
initial attempts fail... if the code worked as people thought it does.

>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>> ---
>>  mm/page_alloc.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 07b3c23762ad..ec8c92ff8b3c 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -4164,11 +4164,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>>  		alloc_flags = reserve_flags;
>>  
>>  	/*
>> -	 * Reset the zonelist iterators if memory policies can be ignored.
>> -	 * These allocations are high priority and system rather than user
>> -	 * orientated.
>> +	 * Reset the nodemask and zonelist iterators if memory policies can be
>> +	 * ignored. These allocations are high priority and system rather than
>> +	 * user oriented.
>>  	 */
>>  	if (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
>> +		ac->nodemask = NULL;
>>  		ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
>>  					ac->high_zoneidx, ac->nodemask);
>>  	}

