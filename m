Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CB9C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDED920882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDED920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeLGOtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:49:33 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46528 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeLGOtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:49:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFE2315AB;
        Fri,  7 Dec 2018 06:49:31 -0800 (PST)
Received: from [10.1.196.55] (e112269-lin.cambridge.arm.com [10.1.196.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF0AB3F575;
        Fri,  7 Dec 2018 06:49:30 -0800 (PST)
Subject: Re: [PATCH] kvm/arm: return 0 when the number of objects is not less
 than min
To:     Andrew Jones <drjones@redhat.com>, Peng Hao <peng.hao2@zte.com.cn>
Cc:     marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
References: <1543972551-60951-1-git-send-email-peng.hao2@zte.com.cn>
 <20181205083236.5tzhnxfhi4h4nknn@kamzik.brq.redhat.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <4c32963e-0dc7-1867-aa76-7314334315c4@arm.com>
Date:   Fri, 7 Dec 2018 14:49:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205083236.5tzhnxfhi4h4nknn@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2018 08:32, Andrew Jones wrote:
> On Wed, Dec 05, 2018 at 09:15:51AM +0800, Peng Hao wrote:
>> Return 0 when there is enough kvm_mmu_memory_cache object.
>>
>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>> ---
>>  virt/kvm/arm/mmu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index ed162a6..fcda0ce 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -127,7 +127,7 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
>>  	while (cache->nobjs < max) {
>>  		page = (void *)__get_free_page(PGALLOC_GFP);
>>  		if (!page)
>> -			return -ENOMEM;
>> +			return cache->nobjs >= min ? 0 : -ENOMEM;
> 
> This condition will never be true here, as the exact same condition is
> already checked above, and if it had been true, then we wouldn't be here.

The condition can be true if the loop is executed at least once. This
change would appear to allow the call to succeed in the case where the
cache can be topped up to at least "min", but not as far as "max".

It would be good to know in what situation this has actually been hit
though (and indeed whether this has actually been seen) - the system
must be very short on memory to need this, and I'd be surprised if
further failures didn't happen later on.

> What problem are you attempting to solve?
> 
>>  		cache->objects[cache->nobjs++] = page;
>>  	}
>>  	return 0;
>> -- 
>> 1.8.3.1
>>
>> _______________________________________________
>> kvmarm mailing list
>> kvmarm@lists.cs.columbia.edu
>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 

