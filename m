Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E718EC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A850620820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A850620820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbeKAUmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:42:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56669 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727507AbeKAUmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:42:43 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4757388917CA6;
        Thu,  1 Nov 2018 19:40:04 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Thu, 1 Nov 2018
 19:39:55 +0800
Subject: Re: [PATCH] arm64/numa: Add more vetting in numa_set_distance()
To:     Will Deacon <will.deacon@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <1540562267-101152-1-git-send-email-john.garry@huawei.com>
 <20181029112504.GF14127@arm.com>
 <925009c6-226d-213f-dbcb-68b772d80a18@huawei.com>
 <20181029121638.GB15446@arm.com>
 <839acfc7-6b3a-b7ac-2f4a-713960ece457@huawei.com>
 <17e3006a-7ecd-968e-7e67-ea7d08858ec3@arm.com>
 <bc7bd118-82f2-86be-71ea-46704df864a5@huawei.com>
 <45a8e09d-b32b-df32-ba34-5aa1909fb11f@arm.com>
 <20181101112743.GB31099@arm.com>
CC:     <catalin.marinas@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1a2526e6-9ae7-88b1-76af-f1ef78c55580@huawei.com>
Date:   Thu, 1 Nov 2018 11:39:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181101112743.GB31099@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
>
> I'm not willing to accept the check in the arm64 code if we update the
> OF code.
>
> I think the way forward here is for John to fix the crash he reported by
> adding the check to the OF code.

I was planning on doing that.

If somebody wants to follow up with
> subsequent patches to move more of the checking out of the arch code, then
> we can review that as a separate series.

Cheers,
John

>
> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .
>


