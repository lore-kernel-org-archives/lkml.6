Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34582C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1DA216EE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1DA216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeHCFMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 01:12:02 -0400
Received: from foss.arm.com ([217.140.101.70]:37180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbeHCFMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 01:12:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3432318A;
        Thu,  2 Aug 2018 20:17:51 -0700 (PDT)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23DF43F5BA;
        Thu,  2 Aug 2018 20:17:50 -0700 (PDT)
Subject: Re: [RFC 2/2] mm: harden alloc_pages code paths against bogus nodes
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, Punit.Agrawal@arm.com,
        Lorenzo.Pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
 <20180801200418.1325826-3-jeremy.linton@arm.com>
 <20180802073147.GA10808@dhcp22.suse.cz>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <5ed35dfa-5f02-55cb-9b84-b944394e1a5a@arm.com>
Date:   Thu, 2 Aug 2018 22:17:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180802073147.GA10808@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/02/2018 02:31 AM, Michal Hocko wrote:
> On Wed 01-08-18 15:04:18, Jeremy Linton wrote:
>> Its possible to crash __alloc_pages_nodemask by passing it
>> bogus node ids. This is caused by NODE_DATA() returning null
>> (hopefully) when the requested node is offline. We can
>> harded against the basic case of a mostly valid node, that
>> isn't online by checking for null and failing prepare_alloc_pages.
>>
>> But this then suggests we should also harden NODE_DATA() like this
>>
>> #define NODE_DATA(nid)         ( (nid) < MAX_NUMNODES ? node_data[(nid)] : NULL)
>>
>> eventually this starts to add a bunch of generally uneeded checks
>> in some code paths that are called quite frequently.
> 
> But the page allocator is really a hot path and people will not be happy
> to have yet another branch there. No code should really use invalid numa
> node ids in the first place.
> 
> If I remember those bugs correctly then it was the arch code which was
> doing something wrong. I would prefer that code to be fixed instead.

Yes, I think the consensus is that 2/2 should be dropped.

The arch code is being fixed (both cases) this patch set is just an 
attempt to harden this code path against future failures like that so 
that we get some warnings/ugly messages rather than early boot failures.

Thanks,



>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   include/linux/gfp.h | 2 ++
>>   mm/page_alloc.c     | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index a6afcec53795..17d70271c42e 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -436,6 +436,8 @@ static inline int gfp_zonelist(gfp_t flags)
>>    */
>>   static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
>>   {
>> +	if (unlikely(!NODE_DATA(nid))) //VM_WARN_ON?
>> +		return NULL;
>>   	return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
>>   }
>>   
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index a790ef4be74e..3a3d9ac2662a 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -4306,6 +4306,8 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
>>   {
>>   	ac->high_zoneidx = gfp_zone(gfp_mask);
>>   	ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
>> +	if (!ac->zonelist)
>> +		return false;
>>   	ac->nodemask = nodemask;
>>   	ac->migratetype = gfpflags_to_migratetype(gfp_mask);
>>   
>> -- 
>> 2.14.3
>>
> 

