Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B13C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2215020827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2215020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbeKHB4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:56:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727372AbeKHB4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:56:05 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8D64912FE9D66;
        Thu,  8 Nov 2018 00:24:58 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Thu, 8 Nov 2018
 00:24:50 +0800
Subject: Re: [PATCH] of, numa: Validate some distance map rules
To:     Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>
References: <1541507973-149965-1-git-send-email-john.garry@huawei.com>
 <20181107154430.GA9996@brain-police> <20181107155552.GB18618@bogus>
CC:     <frowand.list@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <anshuman.khandual@arm.com>, <peterz@infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5b81e832-4ad0-13f2-1857-0764d175c61b@huawei.com>
Date:   Wed, 7 Nov 2018 16:24:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181107155552.GB18618@bogus>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 15:55, Rob Herring wrote:
> On Wed, Nov 07, 2018 at 03:44:31PM +0000, Will Deacon wrote:
>> Hi John,
>>
>> On Tue, Nov 06, 2018 at 08:39:33PM +0800, John Garry wrote:
>>> Currently the NUMA distance map parsing does not validate the distance
>>> table for the distance-matrix rules 1-2 in [1].
>>>
>>> However the arch NUMA code may enforce some of these rules, but not all.
>>> Such is the case for the arm64 port, which does not enforce the rule that
>>> the distance between separates nodes cannot equal LOCAL_DISTANCE.
>>>
>>> The patch adds the following rules validation:
>>> - distance of node to self equals LOCAL_DISTANCE
>>> - distance of separate nodes > LOCAL_DISTANCE
>>>
>>> A note on dealing with symmetrical distances between nodes:
>>>
>>> Validating symmetrical distances between nodes is difficult. If it were
>>> mandated in the bindings that every distance must be recorded in the
>>> table, validating symmetrical distances would be straightforward. However,
>>> it isn't.
>>>
>>> In addition to this, it is also possible to record [b, a] distance only
>>> (and not [a, b]). So, when processing the table for [b, a], we cannot
>>> assert that current distance of [a, b] != [b, a] as invalid, as [a, b]
>>> distance may not be present in the table and current distance would be
>>> default at REMOTE_DISTANCE.
>>>
>>> As such, we maintain the policy that we overwrite distance [a, b] = [b, a]
>>> for b > a. This policy is different to kernel ACPI SLIT validation, which
>>> allows non-symmetrical distances (ACPI spec SLIT rules allow it). However,
>>> the debug message is dropped as it may be misleading (for a distance which
>>> is later overwritten).
>>>
>>> Some final notes on semantics:
>>>
>>> - It is implied that it is the responsibility of the arch NUMA code to
>>>   reset the NUMA distance map for an error in distance map parsing.
>>>
>>> - It is the responsibility of the FW NUMA topology parsing (whether OF or
>>>   ACPI) to enforce NUMA distance rules, and not arch NUMA code.
>>>
>>> [1] Documents/devicetree/bindings/numa.txt
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> Is it worth mentioning that the lack of this check was leading to a kernel
>> crash with a malformed DT entry?

Yeah, I was thinking in hindsight that I should have mentioned the 
yet-unresolved crash we avoid.

>
> So should be marked for stable too?

Probably. So this patch is masking a crash I have observed, which may be 
good enough reason on its own.

In addition, I would still say that failing to validate the distance map 
falls into the "oh, that's not good" category of stable rules.

>
>>
>>> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
>>> index 35c64a4295e0..fe6b13608e51 100644
>>> --- a/drivers/of/of_numa.c
>>> +++ b/drivers/of/of_numa.c
>>> @@ -104,9 +104,14 @@ static int __init of_numa_parse_distance_map_v1(struct device_node *map)
>>>  		distance = of_read_number(matrix, 1);
>>>  		matrix++;
>>>
>>> +		if ((nodea == nodeb && distance != LOCAL_DISTANCE) ||
>>> +		    (nodea != nodeb && distance <= LOCAL_DISTANCE)) {
>>> +			pr_err("Invalid distance[node%d -> node%d] = %d\n",
>>> +			       nodea, nodeb, distance);
>>> +			return -EINVAL;
>>> +		}
>>> +
>>>  		numa_set_distance(nodea, nodeb, distance);
>>> -		pr_debug("distance[node%d -> node%d] = %d\n",
>>> -			 nodea, nodeb, distance);
>>
>> Looks good to me, although I'm not sure which tree this should go through.
>>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>

Thanks Will.

> I'll take it. Please resend with the comment Will asked for.
>

OK, I'll repost an updated version.

> Rob
>

Cheers,
john

> .
>


