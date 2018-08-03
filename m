Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217FCC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC233216EE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC233216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeHCFII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 01:08:08 -0400
Received: from foss.arm.com ([217.140.101.70]:37022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbeHCFII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 01:08:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AA4B15A2;
        Thu,  2 Aug 2018 20:13:58 -0700 (PDT)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CC8A3F5BA;
        Thu,  2 Aug 2018 20:13:57 -0700 (PDT)
Subject: Re: [RFC 1/2] slub: Avoid trying to allocate memory on offline nodes
To:     Christopher Lameter <cl@linux.com>
Cc:     linux-mm@kvack.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, mhocko@suse.com,
        vbabka@suse.cz, Punit.Agrawal@arm.com, Lorenzo.Pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
 <20180801200418.1325826-2-jeremy.linton@arm.com>
 <01000164fb05bba7-1804e794-a08d-4ee0-b842-c44c89647716-000000@email.amazonses.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <fdcb2cd2-579f-8f90-1e2d-d144bb2768e1@arm.com>
Date:   Thu, 2 Aug 2018 22:12:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <01000164fb05bba7-1804e794-a08d-4ee0-b842-c44c89647716-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/02/2018 09:23 AM, Christopher Lameter wrote:
> On Wed, 1 Aug 2018, Jeremy Linton wrote:
> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 51258eff4178..e03719bac1e2 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2519,6 +2519,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>   		if (unlikely(!node_match(page, searchnode))) {
>>   			stat(s, ALLOC_NODE_MISMATCH);
>>   			deactivate_slab(s, page, c->freelist, c);
>> +			if (!node_online(searchnode))
>> +				node = NUMA_NO_NODE;
>>   			goto new_slab;
>>   		}
>>   	}
>>
> 
> Would it not be better to implement this check in the page allocator?
> There is also the issue of how to fallback to the nearest node.

Possibly? Falling back to the nearest node though, should be handled if 
memory-less nodes is enabled, which in the problematic case isn't.

> 
> NUMA_NO_NODE should fallback to the current memory allocation policy but
> it seems by inserting it here you would end up just with the default node
> for the processor.

I picked this spot (compared to 2/2) because a number of paths are 
funneling through here, and in this case it shouldn't be a very hot path.
