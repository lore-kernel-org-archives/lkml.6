Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946200AbeBOR7W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:59:22 -0500
Received: from foss.arm.com ([217.140.101.70]:58766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164177AbeBOR5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:57:31 -0500
Message-ID: <5A85C974.70500@arm.com>
Date: Thu, 15 Feb 2018 17:55:00 +0000
From: James Morse <james.morse@arm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
MIME-Version: 1.0
To: gengdongjiu <gengdongjiu@huawei.com>
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
Subject: Re: [PATCH v9 5/7] arm64: kvm: Introduce KVM_ARM_SET_SERROR_ESR ioctl
References: <0184EA26B2509940AA629AE1405DD7F201A9E8EA@DGGEMA503-MBS.china.huawei.com> <5A70C5A0.1050600@arm.com> <d1b17dae-9d9c-970a-d164-a41c618d449b@huawei.com> <5A7DDDEE.9050306@arm.com> <93d07d3e-8388-7814-d674-538071d84e2a@huawei.com>
In-Reply-To: <93d07d3e-8388-7814-d674-538071d84e2a@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi gengdongjiu,

On 12/02/18 10:19, gengdongjiu wrote:
> On 2018/2/10 1:44, James Morse wrote:
>> The point? We can't know what a CPU without the RAS extensions puts in there.
>>
>> Why Does this matter? When migrating a pending SError we have to know the
>> difference between 'use this 64bit value', and 'the CPU will generate it'.
>> If I make an SError pending with ESR=0 on a CPU with VSESR, I can't migrated to
>> a system that generates an impdef SError-ESR, because I can't know it will be 0.

> For the target system, before taking the SError, no one can know whether its syndrome value
> is IMPLEMENTATION DEFINED or architecturally defined.

For a virtual-SError, the hypervisor knows what it generated. (do I have
VSESR_EL2? What did I put in there?).


> when the virtual SError is taken, the ESR_ELx.IDS will be updated, then we can know
> whether the ESR value is impdef or architecturally defined.

True, the guest can't know anything about a pending virtual SError until it
takes it. Why is this a problem?


> It seems migration is only allowed only when target system and source system all support
> RAS extension, because we do not know whether its syndrome is IMPLEMENTATION DEFINED or
> architecturally defined.

I don't think Qemu allows migration between hosts with differing guest-ID
registers. But we shouldn't depend on this, and we may want to hide the v8.2 RAS
features from the guest's ID register, but still use them from the host.

The way I imagined it working was we would pack the following information into
that events struct:
{
	bool serror_pending;
	bool serror_has_esr;
	u64  serror_esr;
}

The problem I was trying to describe is because there is no value of serror_esr
we can use to mean 'Ignore this, I'm a v8.0 CPU'. VSESR_EL2 is a 64bit register,
any bits we abuse may get a meaning we want to use in the future.

When it comes to migration, v8.{0,1} systems can only GET/SET events where
serror_has_esr == false, they can't use the serror_esr. On v8.2 systems we
should require serror_has_esr to be true.

If we need to support migration from v8.{0,1} to v8.2, we can make up an impdef
serror_esr.

We will need to decide what KVM does when SET is called but an SError was
already pending. 2.5.3 "Multiple SError interrupts" of [0] has something to say.


Happy new year,

James


[0]
https://static.docs.arm.com/ddi0587/a/RAS%20Extension-release%20candidate_march_29.pdf
