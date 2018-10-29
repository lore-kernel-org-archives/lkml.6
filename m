Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B161C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA8A2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA8A2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbeJ2VCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:02:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728772AbeJ2VCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:02:49 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D105FD0A64461;
        Mon, 29 Oct 2018 20:14:17 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Mon, 29 Oct 2018
 20:14:13 +0800
Subject: Re: [PATCH] arm64/numa: Add more vetting in numa_set_distance()
To:     Will Deacon <will.deacon@arm.com>
References: <1540562267-101152-1-git-send-email-john.garry@huawei.com>
 <20181029112504.GF14127@arm.com>
CC:     <catalin.marinas@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <925009c6-226d-213f-dbcb-68b772d80a18@huawei.com>
Date:   Mon, 29 Oct 2018 12:14:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181029112504.GF14127@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2018 11:25, Will Deacon wrote:
> Hi John,
>

Hi Will,

> On Fri, Oct 26, 2018 at 09:57:47PM +0800, John Garry wrote:
>> Currently it is acceptable to set the distance between 2 separate nodes to
>> LOCAL_DISTANCE.
>>
>> Reject this as it is invalid.
>>
>> This change avoids a crash reported in [1].
>>
>> [1] https://www.spinics.net/lists/arm-kernel/msg683304.html
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>> index 146c04c..6092e3d 100644
>> --- a/arch/arm64/mm/numa.c
>> +++ b/arch/arm64/mm/numa.c
>> @@ -335,7 +335,8 @@ void __init numa_set_distance(int from, int to, int distance)
>>  	}
>>
>>  	if ((u8)distance != distance ||
>> -	    (from == to && distance != LOCAL_DISTANCE)) {
>> +	    (from == to && distance != LOCAL_DISTANCE) ||
>> +	    (from != to && distance == LOCAL_DISTANCE)) {
>
> The current code here is more-or-less lifted from the x86 implementation
> of numa_set_distance().

Right, I did notice this. I didn't think that x86 folks would be so 
concerned since they generally only use ACPI, and the ACPI code already 
validates these distances in drivers/acpi/numa.c: slit_valid() [unlike 
OF code].

  I think we should either factor out the sanity check
> into a core helper or make the core code robust to these funny configurations.

OK, so to me it would make sense to factor out a sanity check into a 
core helper.

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
>


