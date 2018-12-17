Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270E1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3792145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbeLQP4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:56:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59282 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387981AbeLQP4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:56:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCA45A78;
        Mon, 17 Dec 2018 07:56:01 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCC753F575;
        Mon, 17 Dec 2018 07:55:59 -0800 (PST)
Subject: Re: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
To:     gengdongjiu <gengdongjiu@huawei.com>,
        Peter Maydell <peter.maydell@linaro.org>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvm-devel <kvm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
References: <0184EA26B2509940AA629AE1405DD7F201FFC21E@dggema523-mbx.china.huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <c01e3ed0-f66c-f7df-295a-70b44bad49ff@arm.com>
Date:   Mon, 17 Dec 2018 15:55:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F201FFC21E@dggema523-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi gengdongjiu, Peter,

I think the root issue here is the name of the cpufeature 'RAS Extensions', this
doesn't mean RAS is new, or even requires these features. It's just standardised
records, classification and a barrier.
Not only is it possible to build a platform that supports RAS without this
extensions: there are at least three platforms out there that do!


On 15/12/2018 00:12, gengdongjiu wrote:
>> On Fri, 14 Dec 2018 at 13:56, James Morse <james.morse@arm.com> wrote:
>>> On 14/12/2018 10:15, Dongjiu Geng wrote:
>>>> When user space do memory recovery, it will check whether KVM and 
>>>> guest support the error recovery, only when both of them support, 
>>>> user space will do the error recovery. This patch exports this 
>>>> capability of KVM to user space.
>>>
>>> I can understand user-space only wanting to do the work if host and 
>>> guest support the feature. But 'error recovery' isn't a KVM feature, 
>>> its a Linux kernel feature.

[...]

> Thanks Peter's explanation. Frankly speaking, I agree Peter's suggestion.
> 
> To James, I explain more to you, as peter said QEMU needs to check whether
> the guest CPU is a type which can handle the error though guest ACPI table.

I don't think this really matters. Its only the NMIlike notifications that the
guest doesn't have to register or poll. The ones we support today extend the
architectures existing behaviour: you would have taken an external-abort on a
real system, whether you know about the additional metadata doesn't matter to Qemu.


> Let us see the X86's QEMU logic:
> 1. Before the vCPU created, it will set a default env->mcg_cap value with

> MCE_CAP_DEF flag, MCG_SER_P means it expected the guest CPU model supports
> RAS error recovery.[1] 2. when the vCPU initialize, it will check whether host
> kernel support this feature[2]. Only when host kernel and default env->mcg_cap
> value all expected this feature, then it will setup vCPU support RAS error
> recovery[3].

This looks like KVM exposing a CPU capability to Qemu, which then configures the
behaviour KVM gives to the guest. This doesn't tell you anything about what the
guest supports. This doesn't tell you if the host-kernel supports
memory_failure(). You can think of this as being equivalent to the VSESR_EL2
support. Just because the CPU has it doesn't mean the host or guest kernel have
been built to know what to do.

I test NOTIFY_SEA by injecting an address into memory_failure() using
CONFIG_HWPOISON_INJECT. This causes kvmtool to take an AR signal next time the
guest accesses the page, which then gets presented to the guest as an
external-abort, with the CPER records describing the abort created by kvmtool.
This is all on v8.0 hardware, nothing about the CPU is relevant here.


> -------------------------------------For James's comments---------------------------------------------------------------------
>> KVM doesn't detect these errors.
>> The hardware detects them and notifies the OS via one of a number of mechanisms.
>> This gets plumbed into memory_failure(), which sets a flag that the mm 
>> code uses to prevent the page being used again.
> 
>> KVM is only involved when it tries to map a page at stage2 and the mm 
>> code rejects it with -EHWPOISON. This is the same as the architectures
>> do_page_fault() checking for (fault & VM_FAULT_HWPOISON) out of 
>> handle_mm_fault(). We don't have a KVM cap for this, nor do we need one.
> ------------------------------------------------------------------------------------------------------------------------------
> James, for your above comments, I completed understand, but KVM also delivered
> the SIGBUS,

kvm_send_hwpoison_signal()? This is just making guest-accesses look like
Qemu-acesses to linux. It's just plumbing.

You could just as easily take the signal from memory_failure()s kill_proc() code.


> which means KVM supports guest memory RAS error recovery, so maybe
> we need to tell user space this capability.

It was merged with ARCH_SUPPORTS_MEMORY_FAILURE. You're really asking if the
host kernel supports CONFIG_MEMORY_FAILURE, and its plumbed in in all the right
places.

It's not practical for user-space to know this, handling the signal when it
arrives is the best thing to do.


> ---------------------------------------------- For James's comments ---------------------------------------------------
>> The CPU RAS Extensions are not at all relevant here. It is perfectly 
>> possible to support memory-failure without them, AMD-Seattle and 
>> APM-X-Gene do this. These systems would report not-supported here, but the kernel does support this stuff.
>> Just because the CPU supports this, doesn't mean the kernel was built 
>> with CONFIG_MEMORY_FAILURE. The CPU reports may be ignored, or upgraded to SIGKILL.
> --------------------------------------------------------------------------------------------------------------------------------------
> James, for your above comments, if you think we should not check the> "cpus_have_const_cap(ARM64_HAS_RAS_EXTN)", which do you prefer we should check?

> In the X86 KVM code, it uses hardcode to tell use space the host/KVM support RAS error
> software recovery[4]. If KVM does not check the " cpus_have_const_cap(ARM64_HAS_RAS_EXTN)",
> we have to check the hardcode as X86's method.

There is no CPU property that means the platform has RAS support. Platforms can
support RAS for memory errors (which is all we are talking about here) without them.
The guest can't know from a CPU property that the platform supports RAS. If it
finds a HEST with GHES entries it can register interrupts and polling-timers. If
it can probe an edac driver, it can use that.


Thanks,

James
