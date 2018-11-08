Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7144EECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F4320825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F4320825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeKHX4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:56:21 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41780 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeKHX4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:56:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A183DEBD;
        Thu,  8 Nov 2018 06:20:38 -0800 (PST)
Received: from [10.163.1.249] (unknown [10.163.1.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BE343F5BD;
        Thu,  8 Nov 2018 06:20:36 -0800 (PST)
Subject: Re: [PATCH] arm64/numa: Add more vetting in numa_set_distance()
To:     Will Deacon <will.deacon@arm.com>
Cc:     John Garry <john.garry@huawei.com>, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxarm@huawei.com
References: <1540562267-101152-1-git-send-email-john.garry@huawei.com>
 <20181029112504.GF14127@arm.com>
 <925009c6-226d-213f-dbcb-68b772d80a18@huawei.com>
 <20181029121638.GB15446@arm.com>
 <839acfc7-6b3a-b7ac-2f4a-713960ece457@huawei.com>
 <17e3006a-7ecd-968e-7e67-ea7d08858ec3@arm.com>
 <bc7bd118-82f2-86be-71ea-46704df864a5@huawei.com>
 <45a8e09d-b32b-df32-ba34-5aa1909fb11f@arm.com>
 <20181101112743.GB31099@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d51511b3-009d-8adf-464a-ac8f7d106045@arm.com>
Date:   Thu, 8 Nov 2018 19:50:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181101112743.GB31099@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/01/2018 04:57 PM, Will Deacon wrote:
> [ Nit: Please wrap your lines when replying -- I've done it for you here ]
> 
> On Tue, Oct 30, 2018 at 08:16:21AM +0530, Anshuman Khandual wrote:
>> On 10/29/2018 08:14 PM, John Garry wrote:
>>>>>>>  I think we should either factor out the sanity check
>>>>>>>> into a core helper or make the core code robust to these funny configurations.
>>>>>>>
>>>>>>> OK, so to me it would make sense to factor out a sanity check into a core
>>>>>>> helper.
>>>>>>
>>>>>> That, or have the OF code perform the same validation that slit_valid() is
>>>>>> doing for ACPI. I'm just trying to avoid other architectures running into
>>>>>> this problem down the line.
>>>>>>
>>>>>
>>>>> Right, OF code should do this validation job if ACPI is doing it
>>>>> (especially since the DT bindings actually specify the distance
>>>>> rules), and not rely on the arch NUMA code to accept/reject
>>>>> numa_set_distance() combinations.
>>>>
>>>> I would say this particular condition checking still falls under arch NUMA init
>>>> code sanity check like other basic tests what numa_set_distance() currently does
>>>> already but it should not be a necessity for the OF driver to check these.
>>>
>>> The checks in the arch NUMA code mean that invalid inter-node distance
>>> combinations are ignored.
>>
>> Right and should not this new test (from != to && distance == LOCAL_DISTANCE) be
>> one of them as well ? numa_set_distance() updates the table or just throws some
>> warnings while skipping entries it deems invalid. It would be okay to have this
>> new check there in addition to others like this patch suggests.

I missed this response due to some problem in my mail client and re-iterated
some of the same points again on the V2 (https://lkml.org/lkml/2018/11/8/734).
My apologies for the same.

> 
> If we're changing numa_set_distance(), I'd actually be inclined to do the
> opposite of what you're suggesting and move as much of this boilerplate
> checking into the core code. Perhaps we could add something like
> check_fw_numa_topology() and have both ACPI and OF call that so that the
> arch doesn't need to worry about malformed tables at all.

Right although I doubt that we could ever have a common check_fw_numa_topology()
check as the semantics for the table and individual entries there in for DT and
ACPI might be different. But I agree what you are saying.

> 
>>> However, if any entries in the table are invalid, then the whole table
>>> can be discarded as none of it can be believed, i.e. it's better to
>>> validate the table.
>>>
>>
>> Agreed. slit_valid() on the ACPI parsing is currently enforcing that before
>> acpi_numa_slit_init() which would call into numa_set_distance(). Hence arch
>> NUMA code numa_set_distance() never had the opportunity to do the sanity
>> checks as ACPI slit_valid() has completely invalidated the table.
>>
>> Unlike ACPI path, of_numa_parse_distance_map_v1() does not do any sanity
>> checks on the distance values parse from the "distance-matrix" property
>> and all the checks directly falls on numa_set_distance(). This needs to
>> be fixed in line with ACPI
>>
>> * If (to == from) ---> distance = LOCAL_DISTANCE
>> * If (to != from) ---> distance > LOCAL_DISTANCE
>>
>> At the same time its okay to just enhance numa_set_distance() test coverage
>> to include this new test. If we would have trusted firmware parsing all the
>> way, existing basic checks about node range, distance stuff should not have
>> been there in numa_set_distance(). Hence IMHO even if we fix the OF driver
>> part, we should include this new check there as well.
> 
> I don't see what we gain by duplicating the check. In fact, it has a few
> downsides:
> 
>   (1) It confuses the semantics of the API, because it is no longer clear
>       who "owns" the check
> 
>   (2) It duplicates code in each architecture
> 
>   (3) Some clever-cloggs will remove at least some of the duplication in
>       future

Agreed, it has down sides.

> 
> I'm not willing to accept the check in the arm64 code if we update the
> OF code.

Okay, we should remove them instead.

> 
> I think the way forward here is for John to fix the crash he reported by
> adding the check to the OF code. If somebody wants to follow up with
> subsequent patches to move more of the checking out of the arch code, then
> we can review that as a separate series.

Okay. Anyways I had some other comments related to semantics checking at
the OF driver level but I can probably send them out as a separate patch
later. Once again it was my bad to miss this response in the first place.
