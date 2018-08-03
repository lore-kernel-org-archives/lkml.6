Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C61C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED1421711
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED1421711
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeHCFQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 01:16:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37282 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbeHCFQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 01:16:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B0D418A;
        Thu,  2 Aug 2018 20:21:55 -0700 (PDT)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AE163F5BA;
        Thu,  2 Aug 2018 20:21:54 -0700 (PDT)
Subject: Re: [RFC 1/2] slub: Avoid trying to allocate memory on offline nodes
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, Punit.Agrawal@arm.com,
        Lorenzo.Pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
 <20180801200418.1325826-2-jeremy.linton@arm.com>
 <20180802091554.GE10808@dhcp22.suse.cz>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <c6caddbf-e275-219e-12b6-538a53ced17d@arm.com>
Date:   Thu, 2 Aug 2018 22:21:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180802091554.GE10808@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/02/2018 04:15 AM, Michal Hocko wrote:
> On Wed 01-08-18 15:04:17, Jeremy Linton wrote:
> [...]
>> @@ -2519,6 +2519,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>   		if (unlikely(!node_match(page, searchnode))) {
>>   			stat(s, ALLOC_NODE_MISMATCH);
>>   			deactivate_slab(s, page, c->freelist, c);
>> +			if (!node_online(searchnode))
>> +				node = NUMA_NO_NODE;
>>   			goto new_slab;
> 
> This is inherently racy. Numa node can get offline at any point after
> you check it here. Making it race free would involve some sort of
> locking and I am not really convinced this is a good idea.

I spent some time looking/thinking about this, and i'm pretty sure its 
not creating any new problems. But OTOH, I think the node_online() check 
is probably a bit misleading as what we really want to assure is that 
node<MAX_NUMNODES and that there is going to be a valid entry in 
NODE_DATA() so we don't deference null.


> 
>>   		}
>>   	}
>> -- 
>> 2.14.3
>>
> 

