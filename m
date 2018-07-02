Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF83C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 04:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BEC2523A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 04:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BEC2523A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeGBETM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 00:19:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9189 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752294AbeGBETI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 00:19:08 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DCF72E9C4A0A7;
        Mon,  2 Jul 2018 12:18:53 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.382.0; Mon, 2 Jul 2018
 12:18:51 +0800
Subject: Re: [PATCH v5 2/2] arm64: KVM: export the capability to set guest
 SError syndrome
To:     James Morse <james.morse@arm.com>
CC:     <rkrcmar@redhat.com>, <corbet@lwn.net>, <christoffer.dall@arm.com>,
        <marc.zyngier@arm.com>, <linux@armlinux.org.uk>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <1529960309-2513-1-git-send-email-gengdongjiu@huawei.com>
 <1529960309-2513-3-git-send-email-gengdongjiu@huawei.com>
 <bca12032-c465-1d10-f7d4-71fc044ac695@arm.com>
From:   gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <fd33f8b6-db05-f956-a1fc-ecb4fa3f1b79@huawei.com>
Date:   Mon, 2 Jul 2018 12:18:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <bca12032-c465-1d10-f7d4-71fc044ac695@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2018/6/29 23:58, James Morse wrote:
> Hi Dongjiu Geng,
> 
> This patch doesn't apply on v4.18-rc2.
> 
> Documentation/virtual/kvm/api.txt already has a 8.18 section. I guess you based
> this on v4.17.

Yes, indeed I based on v4.17.

> 
> For posting patches, please use the latest 'rc' from Linus' tree, (or the
> maintainer's tree listed in MAINTAINERS for the tree you are targeting if the
> maintainer has started to pick up patches).
Ok, I will rebase it using the latest 'rc' from Linus' tree. thanks for the reminder.


> 
> 
> Thanks,
> 
> James
> 
> 
> On 25/06/18 21:58, Dongjiu Geng wrote:
>> For the arm64 RAS Extension, user space can inject a virtual-SError
>> with specified ESR. So user space needs to know whether KVM support
>> to inject such SError, this interface adds this query for this capability.
>>
>> KVM will check whether system support RAS Extension, if supported, KVM
>> returns true to user space, otherwise returns false.
> 
> 
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index 3732097..86b3808 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -4628,3 +4628,14 @@ Architectures: s390
>>  This capability indicates that kvm will implement the interfaces to handle
>>  reset, migration and nested KVM for branch prediction blocking. The stfle
>>  facility 82 should not be provided to the guest without this capability.
>> +
>> +8.14 KVM_CAP_ARM_SET_SERROR_ESR
>> +
>> +Architectures: arm, arm64
>> +
>> +This capability indicates that userspace can specify the syndrome value reported
>> +to the guest OS when guest takes a virtual SError interrupt exception.
>> +If KVM has this capability, userspace can only specify the ISS field for the ESR
>> +syndrome, it can not specify the EC field which is not under control by KVM.
>> +If this virtual SError is taken to EL1 using AArch64, this value will be reported
>> +in ISS filed of ESR_EL1.
> 
> 
> 
> 
> .
> 

