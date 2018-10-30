Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E34C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BF42075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BF42075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeJ3LiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 07:38:03 -0400
Received: from foss.arm.com ([217.140.101.70]:48484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbeJ3LiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 07:38:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EBA8A78;
        Mon, 29 Oct 2018 19:46:30 -0700 (PDT)
Received: from [10.163.1.105] (unknown [10.163.1.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6535E3F5D3;
        Mon, 29 Oct 2018 19:46:27 -0700 (PDT)
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
 <17e3006a-7ecd-968e-7e67-ea7d08858ec3@arm.com>
 <bc7bd118-82f2-86be-71ea-46704df864a5@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <45a8e09d-b32b-df32-ba34-5aa1909fb11f@arm.com>
Date:   Tue, 30 Oct 2018 08:16:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bc7bd118-82f2-86be-71ea-46704df864a5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2018 08:14 PM, John Garry wrote:
>>>>>
>>>>>  I think we should either factor out the sanity check
>>>>>> into a core helper or make the core code robust to these funny configurations.
>>>>>
>>>>> OK, so to me it would make sense to factor out a sanity check into a core
>>>>> helper.
>>>>
>>>> That, or have the OF code perform the same validation that slit_valid() is
>>>> doing for ACPI. I'm just trying to avoid other architectures running into
>>>> this problem down the line.
>>>>
>>>
>>> Right, OF code should do this validation job if ACPI is doing it (especially since the DT bindings actually specify the distance rules), and not rely on the arch NUMA code to accept/reject numa_set_distance() combinations.
>>
>> I would say this particular condition checking still falls under arch NUMA init
>> code sanity check like other basic tests what numa_set_distance() currently does
>> already but it should not be a necessity for the OF driver to check these.
> 
> The checks in the arch NUMA code mean that invalid inter-node distance combinations are ignored.

Right and should not this new test (from != to && distance == LOCAL_DISTANCE) be
one of them as well ? numa_set_distance() updates the table or just throws some
warnings while skipping entries it deems invalid. It would be okay to have this
new check there in addition to others like this patch suggests.

> 
> However, if any entries in the table are invalid, then the whole table can be discarded as none of it can be believed, i.e. it's better to validate the table.
>

Agreed. slit_valid() on the ACPI parsing is currently enforcing that before
acpi_numa_slit_init() which would call into numa_set_distance(). Hence arch
NUMA code numa_set_distance() never had the opportunity to do the sanity
checks as ACPI slit_valid() has completely invalidated the table.

Unlike ACPI path, of_numa_parse_distance_map_v1() does not do any sanity
checks on the distance values parse from the "distance-matrix" property
and all the checks directly falls on numa_set_distance(). This needs to
be fixed in line with ACPI

* If (to == from) ---> distance = LOCAL_DISTANCE
* If (to != from) ---> distance > LOCAL_DISTANCE

At the same time its okay to just enhance numa_set_distance() test coverage
to include this new test. If we would have trusted firmware parsing all the
way, existing basic checks about node range, distance stuff should not have
been there in numa_set_distance(). Hence IMHO even if we fix the OF driver
part, we should include this new check there as well.

> It can
>> choose to check but arch NUMA should check basic things like two different NUMA
>> nodes should not have LOCAL_DISTANCE as distance like in this case.
>>
>>     (from == to && distance != LOCAL_DISTANCE) ||
>>         (from != to && distance == LOCAL_DISTANCE))
>>
>>
>>>
>>> And, in addition to this, I'd say OF should disable NUMA if given an invalid table (like ACPI does).
>>
>> Taking a decision to disable NUMA should be with kernel (arch NUMA) once kernel
>> starts booting. Platform should have sent right values, OF driver trying to
>> adjust stuff what platform has sent with FDT once the kernel starts booting is
>> not right. For example "Kernel NUMA wont like the distance factors lets clean
>> then up before passing on to MM".
> 
> Sorry, but I don't know who was advocating this.

I was just giving an example. Invalidating NUMA distance table during firmware
table (ACPI or FDT) parsing forces arm64_numa_init() to fall back on dummy NUMA
node which is like disabling NUMA. But that is the current semantics with ACPI
parsing which I overlooked. Fixing OF driver to do the same wont extend this
any further, hence my previous concern does not stand valid.

> 
> Disabling NUMA is one such major decision which
>> should be with arch NUMA code not with OF driver.
> 
> I meant parsing the table would fail, so arch NUMA would fall back on dummy NUMA.

Right and ACPI parsing does that and can force a fallback on a dummy NUMA node.
