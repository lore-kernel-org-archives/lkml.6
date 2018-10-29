Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB71CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7FA2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7FA2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbeJ2VeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:34:22 -0400
Received: from foss.arm.com ([217.140.101.70]:40112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729201AbeJ2VeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:34:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF0AB80D;
        Mon, 29 Oct 2018 05:45:47 -0700 (PDT)
Received: from [10.163.1.105] (unknown [10.163.1.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFED73F6A8;
        Mon, 29 Oct 2018 05:45:45 -0700 (PDT)
Subject: Re: [PATCH] arm64/numa: Add more vetting in numa_set_distance()
To:     John Garry <john.garry@huawei.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
References: <1540562267-101152-1-git-send-email-john.garry@huawei.com>
 <20181029112504.GF14127@arm.com>
 <925009c6-226d-213f-dbcb-68b772d80a18@huawei.com>
 <20181029121638.GB15446@arm.com>
 <839acfc7-6b3a-b7ac-2f4a-713960ece457@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <17e3006a-7ecd-968e-7e67-ea7d08858ec3@arm.com>
Date:   Mon, 29 Oct 2018 18:15:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <839acfc7-6b3a-b7ac-2f4a-713960ece457@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2018 06:02 PM, John Garry wrote:
> On 29/10/2018 12:16, Will Deacon wrote:
>> On Mon, Oct 29, 2018 at 12:14:09PM +0000, John Garry wrote:
>>> On 29/10/2018 11:25, Will Deacon wrote:
>>>> On Fri, Oct 26, 2018 at 09:57:47PM +0800, John Garry wrote:
>>>>> Currently it is acceptable to set the distance between 2 separate nodes to
>>>>> LOCAL_DISTANCE.
>>>>>
>>>>> Reject this as it is invalid.
>>>>>
>>>>> This change avoids a crash reported in [1].
>>>>>
>>>>> [1] https://www.spinics.net/lists/arm-kernel/msg683304.html
>>>>>
>>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>>>
>>>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>>>>> index 146c04c..6092e3d 100644
>>>>> --- a/arch/arm64/mm/numa.c
>>>>> +++ b/arch/arm64/mm/numa.c
>>>>> @@ -335,7 +335,8 @@ void __init numa_set_distance(int from, int to, int distance)
>>>>>     }
>>>>>
>>>>>     if ((u8)distance != distance ||
>>>>> -        (from == to && distance != LOCAL_DISTANCE)) {
>>>>> +        (from == to && distance != LOCAL_DISTANCE) ||
>>>>> +        (from != to && distance == LOCAL_DISTANCE)) {
>>>>
>>>> The current code here is more-or-less lifted from the x86 implementation
>>>> of numa_set_distance().
>>>
>>> Right, I did notice this. I didn't think that x86 folks would be so
>>> concerned since they generally only use ACPI, and the ACPI code already
>>> validates these distances in drivers/acpi/numa.c: slit_valid() [unlike OF
>>> code].
>>>
>>>  I think we should either factor out the sanity check
>>>> into a core helper or make the core code robust to these funny configurations.
>>>
>>> OK, so to me it would make sense to factor out a sanity check into a core
>>> helper.
>>
>> That, or have the OF code perform the same validation that slit_valid() is
>> doing for ACPI. I'm just trying to avoid other architectures running into
>> this problem down the line.
>>
> 
> Right, OF code should do this validation job if ACPI is doing it (especially since the DT bindings actually specify the distance rules), and not rely on the arch NUMA code to accept/reject numa_set_distance() combinations.

I would say this particular condition checking still falls under arch NUMA init
code sanity check like other basic tests what numa_set_distance() currently does
already but it should not be a necessity for the OF driver to check these. It can
choose to check but arch NUMA should check basic things like two different NUMA
nodes should not have LOCAL_DISTANCE as distance like in this case.

	(from == to && distance != LOCAL_DISTANCE) ||
		(from != to && distance == LOCAL_DISTANCE))


> 
> And, in addition to this, I'd say OF should disable NUMA if given an invalid table (like ACPI does).

Taking a decision to disable NUMA should be with kernel (arch NUMA) once kernel
starts booting. Platform should have sent right values, OF driver trying to
adjust stuff what platform has sent with FDT once the kernel starts booting is
not right. For example "Kernel NUMA wont like the distance factors lets clean
then up before passing on to MM". Disabling NUMA is one such major decision which
should be with arch NUMA code not with OF driver.
