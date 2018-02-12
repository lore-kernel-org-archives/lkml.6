Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933891AbeBLKV0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 05:21:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932868AbeBLKVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 05:21:23 -0500
Subject: Re: [PATCH v9 5/7] arm64: kvm: Introduce KVM_ARM_SET_SERROR_ESR ioctl
To: James Morse <james.morse@arm.com>
CC: "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "bp@alien8.de" <bp@alien8.de>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "lv.zheng@intel.com" <lv.zheng@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        Huangshaoyu <huangshaoyu@huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F201A9E8EA@DGGEMA503-MBS.china.huawei.com>
 <5A70C5A0.1050600@arm.com> <d1b17dae-9d9c-970a-d164-a41c618d449b@huawei.com>
 <5A7DDDEE.9050306@arm.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <93d07d3e-8388-7814-d674-538071d84e2a@huawei.com>
Date: Mon, 12 Feb 2018 18:19:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5A7DDDEE.9050306@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,
 Thanks for the mail.

On 2018/2/10 1:44, James Morse wrote:
[...]
> 
>> its ESR is 0, can not control the virtual SError's syndrom value, it does not have
>> such registers to control that.
> 
> My point was its more nuanced than this: the ARM-ARM's
> TakeVirtualSErrorException() pseudo-code lets virtual-SError have an
> implementation defined syndrome. I've never seen Juno generate anything other
> than '0', but it might do something different on a thursday.

I checked the "aarch64/exceptions/asynch/AArch64.TakeVirtualSErrorException",
you are right, the virtual SError's syndrome value can be 0 or implementation defined value, not always 0,
which is decided by the "exception.syndrome<24>".
thanks for the clarification.

> 
> The point? We can't know what a CPU without the RAS extensions puts in there.
> 
> Why Does this matter? When migrating a pending SError we have to know the
> difference between 'use this 64bit value', and 'the CPU will generate it'.
> If I make an SError pending with ESR=0 on a CPU with VSESR, I can't migrated to
> a system that generates an impdef SError-ESR, because I can't know it will be 0.
Yes,
But it will have a issue,
For the target system, before taking the SError, no one can know whether its syndrome value
is IMPLEMENTATION DEFINED or architecturally defined.

when the virtual SError is taken, the ESR_ELx.IDS will be updated, then we can know
whether the ESR value is impdef or architecturally defined.

It seems migration is only allowed only when target system and source system all support RAS extension, because we do not know
whether its syndrome is IMPLEMENTATION DEFINED or architecturally defined.

> 
> 
>> Does Juno not have RAS Extension? 
> 
> It's two types of v8.0 CPU, no RAS extensions.
> 
> 
>> if yes, I think we can only inject an SError, but can not change its ESR value,
>> because it does not have vsesr_el2.
> 
> I agree, this means we need to be able to tell the difference between 'pending'
> and 'pending with this ESR'.
> 
> 
>>> Just because we can't control the ESR doesn't mean injecting an SError isn't
>>> something user-space may want to do.
> 
>> yes, we may need to support user-space injects an SError even through CPU does not have RAS Extension.
>>
>>> If we tackle migration of pending-SError first, I think that will give us the
>>> API to create a new pending SError with/without an ESR as appropriate.
>>
>> sure, we should. Last week, I checked the KVM_GET/SET_VCPU_EVENTS IOCTL, it should meet our
>> migration requirements
> 
> Great!
> 
> 
> Thanks,
> 
> James
> 
> 
