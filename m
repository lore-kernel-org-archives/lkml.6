Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2F3C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD58526FA5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD58526FA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965979AbeF1NTf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:19:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47566 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753784AbeF1NTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:19:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FAA218A;
        Thu, 28 Jun 2018 06:19:33 -0700 (PDT)
Received: from [192.168.100.244] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 320493F5C0;
        Thu, 28 Jun 2018 06:19:33 -0700 (PDT)
Subject: Re: [RFC PATCH] arm64: topology: Map PPTT node offset to logic
 physical package id
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Jones <drjones@redhat.com>
Cc:     Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org,
        Joey Zheng <yu.zheng@hxt-semitech.com>
References: <1530177508-15298-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <cb057c6a-0eb4-581e-c259-7a31545e0ae7@arm.com>
 <20180628115748.kprobde6c3joc6ll@kamzik.brq.redhat.com>
 <f9376e47-e2ae-b2f4-db23-07698364f1bb@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <b9b537e7-8f7b-07cc-a99d-bcaa8f5d60d5@arm.com>
Date:   Thu, 28 Jun 2018 08:19:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f9376e47-e2ae-b2f4-db23-07698364f1bb@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/28/2018 07:12 AM, Sudeep Holla wrote:
> 
> 
> On 28/06/18 12:57, Andrew Jones wrote:
>> On Thu, Jun 28, 2018 at 10:38:24AM +0100, Sudeep Holla wrote:
>>> Hi Shunyong,
>>>
>>> On 28/06/18 10:18, Shunyong Yang wrote:
>>>> As PPTT spec doesn't define the physical package id,
>>>> find_acpi_cpu_topology_package() will return offset of the node with
>>>> Physical package field set when querying physical package id. So, it
>>>> returns 162(0xA2) in following example.
>>>>
>>>> [0A2h 0162   1]                Subtable Type : 00 [Processor Hierarchy
>>>> Node]
>>>> [0A3h 0163   1]                       Length : 1C
>>>> [0A4h 0164   2]                     Reserved : 0000
>>>> [0A6h 0166   4]        Flags (decoded below) : 00000003
>>>>                              Physical package : 1
>>>>                       ACPI Processor ID valid : 1
>>>> [0AAh 0170   4]                       Parent : 00000000
>>>> [0AEh 0174   4]            ACPI Processor ID : 00001000
>>>> [0B2h 0178   4]      Private Resource Number : 00000002
>>>> [0B6h 0182   4]             Private Resource : 0000006C
>>>> [0BAh 0186   4]             Private Resource : 00000084
>>>>
>>>> So, when "cat physical_package" in /sys/devices/system/cpu/cpu0/topology/,
>>>> it will output 162(0xA2). And if some items are added before the node
>>>> above, the output will change to other value.
>>>>
>>>> This patch maps the node offset to a logic package id. It maps the first
>>>> node offset to 0, the second to 1, and so on.
>>>>
>>>> Then, it will not output a big value, such as 162 above. And it will
>>>> not change when some nodes(Physical package not set) are added.
>>>>
>>>> And as long as the nodes with Physical package field set in PPTT keeps
>>>> the real hardware order, the logic id can map to hardware package id to
>>>> some extent.
>>>>
>>>> Hope to get feedback from you.
>>>
>>> Thanks for the patch, but Andrew Jones has also posted a patch[1] which
>>> I had a look but was not sure what is the best approach to fix it yet.
>>> I will think about it and respond to that.
>>>
>>
>> I'll send a v1 yet today. The RFC version was actually OK, as the concern
>> with ACPI nodes not being in the expected order wasn't actually a problem.
>> The thread-id or core-id would only be reset to zero when a yet to be
>> remapped core-id (and all its peers) was found when iterating the PEs.
>> Since all peers were handled at the same time, the counter reset was
>> correct, even when the ACPI nodes were out-of-order. The code didn't make
>> that very obvious, though, and there was some room for other cleanups,
>> so I've reworked it. Once I run it through a couple more rounds of testing
>> I'll repost.
>>
> 
> OK sure. I liked the approach in Shunyong's patch. I was thinking if we
> can avoid the list and dynamic allocation on each addition and make it
> more simpler.
> 

This one reads simpler, but yes I agree we should try to avoid the 
dynamic allocation.

OTOH, I think that dropping the dynamic allocation leads to an algorithm 
that picks a value and replaces all the matches. Which of course is 
Andrew's patch, although I did have to read it a couple times to get a 
grasp how it works. I'm guessing that is due to the fact that he seems 
to have optimized 3 double loops into a single loop with two individual 
nested loops. AKA its probably more efficient than the naive 
implementation, but readability seems to have suffered a bit in the 
initial version he posted. I'm not sure the optimization is worth it, 
but I'm guessing there is a middle ground which makes it more readable.

Finally, @Shunyong, thanks for putting the effort into this...
