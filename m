Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ED0ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCFF2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCFF2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeKIAhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:37:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14630 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726469AbeKIAhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:37:34 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 802FDA61D1582;
        Thu,  8 Nov 2018 23:01:29 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 8 Nov 2018
 23:01:22 +0800
Subject: Re: [PATCH v2] of, numa: Validate some distance map rules
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>
References: <1541672223-131326-1-git-send-email-john.garry@huawei.com>
 <ee4cc102-6602-9f4f-d00c-d07ad7567401@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <will.deacon@arm.com>,
        <peterz@infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ec84abdd-ad11-329c-e859-20bfe71d5771@huawei.com>
Date:   Thu, 8 Nov 2018 15:01:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <ee4cc102-6602-9f4f-d00c-d07ad7567401@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2018 13:41, Anshuman Khandual wrote:
> On 11/08/2018 03:47 PM, John Garry wrote:
>> Currently the NUMA distance map parsing does not validate the distance
>> table for the distance-matrix rules 1-2 in [1].
>
> Right.
>
>>
>> However the arch NUMA code may enforce some of these rules, but not all.
>
> Either it does enforce all these rules again or it does not. What is the
> purpose it serves when enforcing parts of it ! Rather it should focus on
> looking for boundary conditions (e.g maximum number of nodes supported
> on a platform against whats present on the table) which are important
> from kernel point of view.
>
>> Such is the case for the arm64 port, which does not enforce the rule that
>> the distance between separates nodes cannot equal LOCAL_DISTANCE.
>>
>> The patch adds the following rules validation:
>> - distance of node to self equals LOCAL_DISTANCE
>> - distance of separate nodes > LOCAL_DISTANCE
>
> Which exactly corresponds to first two rules as mentioned in the DT doc
> (Documents/devicetree/bindings/numa.txt)
>
>         1. Each entry represents distance from first node to second node.
>         The distances are equal in either direction.
>         2. The distance from a node to self (local distance) is represented
>         with value 10 and all internode distance should be represented with
>         a value greater than 10.
>
>>

Not exactly. As you know, it does not add validation of distance 
equality in either direction (for values present in the table).

>> This change avoids a yet-unresolved crash reported in [2].
>>
>> A note on dealing with symmetrical distances between nodes:
>>
>> Validating symmetrical distances between nodes is difficult. If it were
>> mandated in the bindings that every distance must be recorded in the
>> table, then it would be easy. However, it isn't.
>
> But if [a, b] and [b, a] both are present, they must be equal.
>
>>
>> In addition to this, it is also possible to record [b, a] distance only
>> (and not [a, b]). So, when processing the table for [b, a], we cannot
>> assert that current distance of [a, b] != [b, a] as invalid, as [a, b]
>> distance may not be present in the table and current distance would be
>> default at REMOTE_DISTANCE.
>
> Falling back to REMOTE_DISTANCE is right in case one of the symmetrical
> distances is not present. But it must abort if they are present and not
> identical. That rule should be enforced here while processing DT.

Do you really think it's worth the effort?

For this, we would need something considerably more complicated than 
what we have today. Maybe similar to the arm64 NUMA code does, in 
allocating a memblock and then doing some 2-phase table parsing. But 
then we're just replicated this same functionality.

On this point, I will also note that there is another problem with the 
DT NUMA bindings (first problem being that both distance entries are not 
required to be present in the table).

That is, it's inconsistency with ACPI SLIT. ACPI SLIT allows 
asymmetrical distance. So that's why I'm not too hung up on this issue 
of validating equality of distances.

This patch does not change the current kernel policy: if the table has 
entries with unequal distances, then it's not rejected nor fixed up.

>
>>
>> As such, we maintain the policy that we overwrite distance [a, b] = [b, a]
>> for b > a. This policy is different to kernel ACPI SLIT validation, which
>> allows non-symmetrical distances (ACPI spec SLIT rules allow it). However,
>> the distance debug message is dropped as it may be misleading (for a distance
>> which is later overwritten).
>
> We could override but if the DT passed table is inconsistent then it must
> abort as non-symmetrical distance is not supported. Hence overriding the
> distance should happen only in case the inverse set is absent (probably
> outside the first loop).
>
>>
>> Some final notes on semantics:
>>
>> - It is implied that it is the responsibility of the arch NUMA code to
>>   reset the NUMA distance map for an error in distance map parsing.
>
> Right.
>
>>
>> - It is the responsibility of the FW NUMA topology parsing (whether OF or
>>   ACPI) to enforce NUMA distance rules, and not arch NUMA code.
>
> This is where we still have some inconsistencies. Arch NUMA code on arm64
> should either enforce rule 1 and 2 as stated above or should not at all.

It was implied that any validation can be later dropped from the arch 
NUMA code.

  As
> discussed previously numa_set_distance() enforces first part of rule 2
> (self distance should be 10) but not the second part of rule 2 (internode
> distance > 10). So either the following condition should be dropped from
>
> (from == to && distance != LOCAL_DISTANCE)
>
> or the following condition should be added to
>
> (from != to && distance <= LOCAL_DISTANCE)
>
> numa_set_distance() in order to conform to the semantics described above.
> But thats for a separate discussion how much and what should be enforced
> in any given DT compatible arch NUMA node. May not be part of this patch.
>
>>
>> [1] Documents/devicetree/bindings/numa.txt
>> [2] https://www.spinics.net/lists/arm-kernel/msg683304.html
>>
>> Cc: stable@vger.kernel.org # 4.7
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>> ---
>> Changes from v1:
>> - Add note on masking crash reported
>> - Add Will's tag
>> - Add cc stable
>>
>> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
>> index 35c64a4295e0..fe6b13608e51 100644
>> --- a/drivers/of/of_numa.c
>> +++ b/drivers/of/of_numa.c
>> @@ -104,9 +104,14 @@ static int __init of_numa_parse_distance_map_v1(struct device_node *map)
>>  		distance = of_read_number(matrix, 1);
>>  		matrix++;
>>
>> +		if ((nodea == nodeb && distance != LOCAL_DISTANCE) ||
>> +		    (nodea != nodeb && distance <= LOCAL_DISTANCE)) {
>> +			pr_err("Invalid distance[node%d -> node%d] = %d\n",
>> +			       nodea, nodeb, distance);
>> +			return -EINVAL;
>> +		}
>> +
>>  		numa_set_distance(nodea, nodeb, distance);
>> -		pr_debug("distance[node%d -> node%d] = %d\n",
>> -			 nodea, nodeb, distance);
>
> It makes sense to go through the table and print the finalized values
> (being passed to arch NUMA) out side of this loop after any identical
> replacement is done.
>>
>>  		/* Set default distance of node B->A same as A->B */
>>  		if (nodeb > nodea)
>>
>
> As mentioned before it should invalidate the table [a, b] != [b, a] in
> case they are present and not equal.
>

I think that most of these comments are related to earlier points.

> .
>

Thanks,
John


