Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06A2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540A82082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540A82082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeJ2XeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:34:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14157 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbeJ2XeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:34:10 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B9B9F769C8DD1;
        Mon, 29 Oct 2018 22:45:04 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Mon, 29 Oct 2018
 22:44:56 +0800
Subject: Re: [PATCH] arm64/numa: Add more vetting in numa_set_distance()
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <1540562267-101152-1-git-send-email-john.garry@huawei.com>
 <20181029112504.GF14127@arm.com>
 <925009c6-226d-213f-dbcb-68b772d80a18@huawei.com>
 <20181029121638.GB15446@arm.com>
 <839acfc7-6b3a-b7ac-2f4a-713960ece457@huawei.com>
 <17e3006a-7ecd-968e-7e67-ea7d08858ec3@arm.com>
CC:     <catalin.marinas@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bc7bd118-82f2-86be-71ea-46704df864a5@huawei.com>
Date:   Mon, 29 Oct 2018 14:44:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <17e3006a-7ecd-968e-7e67-ea7d08858ec3@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>
>>>>  I think we should either factor out the sanity check
>>>>> into a core helper or make the core code robust to these funny configurations.
>>>>
>>>> OK, so to me it would make sense to factor out a sanity check into a core
>>>> helper.
>>>
>>> That, or have the OF code perform the same validation that slit_valid() is
>>> doing for ACPI. I'm just trying to avoid other architectures running into
>>> this problem down the line.
>>>
>>
>> Right, OF code should do this validation job if ACPI is doing it (especially since the DT bindings actually specify the distance rules), and not rely on the arch NUMA code to accept/reject numa_set_distance() combinations.
>
> I would say this particular condition checking still falls under arch NUMA init
> code sanity check like other basic tests what numa_set_distance() currently does
> already but it should not be a necessity for the OF driver to check these.

The checks in the arch NUMA code mean that invalid inter-node distance 
combinations are ignored.

However, if any entries in the table are invalid, then the whole table 
can be discarded as none of it can be believed, i.e. it's better to 
validate the table.

It can
> choose to check but arch NUMA should check basic things like two different NUMA
> nodes should not have LOCAL_DISTANCE as distance like in this case.
>
> 	(from == to && distance != LOCAL_DISTANCE) ||
> 		(from != to && distance == LOCAL_DISTANCE))
>
>
>>
>> And, in addition to this, I'd say OF should disable NUMA if given an invalid table (like ACPI does).
>
> Taking a decision to disable NUMA should be with kernel (arch NUMA) once kernel
> starts booting. Platform should have sent right values, OF driver trying to
> adjust stuff what platform has sent with FDT once the kernel starts booting is
> not right. For example "Kernel NUMA wont like the distance factors lets clean
> then up before passing on to MM".

Sorry, but I don't know who was advocating this.

Disabling NUMA is one such major decision which
> should be with arch NUMA code not with OF driver.

I meant parsing the table would fail, so arch NUMA would fall back on 
dummy NUMA.

>

Thanks,
John


