Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7675C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C26214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfAJMJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:09:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59550 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727391AbfAJMJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:09:42 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 27B96DE8FB657DE1C470;
        Thu, 10 Jan 2019 20:09:39 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 10 Jan 2019
 20:09:35 +0800
Subject: Re: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
To:     James Morse <james.morse@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>
CC:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will.deacon@arm.com>,
        kvm-devel <kvm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
References: <0184EA26B2509940AA629AE1405DD7F201FFC21E@dggema523-mbx.china.huawei.com>
 <c01e3ed0-f66c-f7df-295a-70b44bad49ff@arm.com>
 <CAFEAcA8No4tti6o9oErdfGKyHqRTfXebO4fuEOhBApFAxw=LOg@mail.gmail.com>
 <1d73ec5a-b58d-1e00-b681-53cd80cba999@arm.com>
From:   gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <63a1ad58-b4db-c266-1077-0a3d0a3975d0@huawei.com>
Date:   Thu, 10 Jan 2019 20:09:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1d73ec5a-b58d-1e00-b681-53cd80cba999@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James/Peter,
   thanks for this discussion, and sorry for my late response due to vacation.

On 2018/12/22 2:17, James Morse wrote:
> Hi Peter,
> 
> On 19/12/2018 19:02, Peter Maydell wrote:
>> On Mon, 17 Dec 2018 at 15:56, James Morse <james.morse@arm.com> wrote:
>>> I don't think this really matters. Its only the NMIlike notifications that the
>>> guest doesn't have to register or poll. The ones we support today extend the
>>> architectures existing behaviour: you would have taken an external-abort on a
>>> real system, whether you know about the additional metadata doesn't matter to Qemu.
>>
>> Consider the case where we booted the guest using a DTB and no ACPI
>> table at all -- we certainly can't just call QEMU code that tries to
>> add entries to a nonexistent table.
> 
> Sure, because you know which of the two sets of firmware-table you're providing.
> 
> I'm taking the behaviour of physical machines as the template for what we should
> do here. I can boot a DT-only kernel on Seattle. Firmware has no idea I did
> this, it will still take DRAM uncorrected-error IRQs in firmware, and generate
> CPER records in the POLLed areas. But the kernel will never look, because it
> booted with DT.
> What happens if the kernel goes on to access the corrupt location? It either
> gets corrupt values back, or an external abort, depending on the design of the
> memory-controller.
> 
> X-gene uses an IRQ for its firmware-first notification. Booted with DT that
> interrupt can be asserted, but as the OS has didn't know to register it, its
> never taken. We eventually get the same corrupt-values/external-abort behaviour.
> 
> KVM/Linux is acting as the memory controller using stage2. When an error is
> detected by the host it unmaps the page from stage2, and refuses to map it again
> until its fixed up in Qemu's memory map (which can happen automatically). If the
> kernel can't fix it itself, the AO signal is like the DRAM-IRQ above, and the AR
> like the external abort.
> We don't have a parallel to the 'gets corrupt values back' behaviour as Linux
> will always unmap hwpoison pages from user-space/guests.
> 
> If the host-kernel wasn't build with CONFIG_MEMORY_FAILURE, its like the memory
> controller doesn't support any of the above. I think knowing this is the closest
> to what you want.
> 
> 
>> My main point is that there
>> needs to be logic in Dongjiu's QEMU patches that checks more than
>> just "does this KVM feature exist". I'm not sufficiently familiar
>> with all this RAS stuff to be certain what those checks should
>> be and what the right choices are; I just know we need to check
>> *something*...
> 
> I think this is the crux of where we don't see this the same way.
> The v8.2 RAS stuff is new, RAS support on arm64 is not. Kernel support arrived
> at roughly the same time, but not CPU support. There are v8.0 systems that
> support RAS. There are DT systems that can do the same with edac drivers.
> The physical v8.0 systems that do this, are doing it without any extra CPU support.
> 
> I think x86's behaviour here includes some history, which we don't have.
>>From the order of the HEST entries, it looks like the machine-check stuff came
> first, then firmware-first using a 'GHES' entry in that table.
> I think Qemu on x86 only supports the emulated machine check stuff, so it needs
> to check KVM has the widget to do this.
> If Qemu on x86 supported firmware-first, I don't think there would be anything
> to check. (details below)

Peter, I summarize James's main idea, James think QEMU does not needs to check *something* if Qemu support firmware-first.
What do we do for your comments?

> 
> 
>>>> Let us see the X86's QEMU logic:
>>>> 1. Before the vCPU created, it will set a default env->mcg_cap value with
>>>
>>>> MCE_CAP_DEF flag, MCG_SER_P means it expected the guest CPU model supports
>>>> RAS error recovery.[1] 2. when the vCPU initialize, it will check whether host
>>>> kernel support this feature[2]. Only when host kernel and default env->mcg_cap
>>>> value all expected this feature, then it will setup vCPU support RAS error
>>>> recovery[3].
>>>
>>> This looks like KVM exposing a CPU capability to Qemu, which then configures the
>>> behaviour KVM gives to the guest. This doesn't tell you anything about what the
>>> guest supports.
>>
>> It tells you what the *guest CPU* supports, which for x86 is a combination
>> of (a) what did the user/machine model ask for and (b) what can KVM
>> actually implement. I don't much care whether the guest OS supports
>> anything or not, that's its business... but it does seem odd to me
>> that the equivalent Arm code is not similarly saying "what were we
>> asked for, and what can we do?".
> 
> The flow is something like:
> For AO, generate CPER records, and notify the OS via NOTIFY_POLL (which isn't
> really a notification) or some flavour of IRQ.
> To do this, Qemu needs to be able to write to its reserved area of guest memory,
> and possibly trigger an interrupt.
> 
> For AR, generate CPER records and notify the OS via external abort. (the
> presence of the CPER records makes this NOTIFY_SEA or NOTIFY_SEI).
> To do this, Qemu again needs to be able to write to guest memory, set guest
> registers (KVM_SET_ONE_REG()). If it wants to inject an
> SError-Interrupt/Asynchronous-external-abort while the guest has it masked, it
> needs KVM_SET_VCPU_EVENTS().
> 
> Nothing here depends on the CPU or kernel configuration. This is all ACPI stuff,
> so its the same on x86. (The only difference is external-abort becomes NMI,
> which is probably done through SET_VCPU_EVENTS())
> 
> What were we asked for? Qemu wants to know if it can write to guest memory,
> guest registers (for synchronous external abort) and trigger interrupts. It has
> always been able to do these things.
> 
> 
>> I think one question here which it would be good to answer is:
>> if we are modelling a guest and we haven't specifically provided
>> it an ACPI table to tell it about memory errors, what do we do
>> when we get a sigbus from the host? We have basically two choices:
>>  (1) send the guest an SError (aka asynchronous external abort)
>>      anyway (with no further info about what the memory error is)
> 
> For an AR signal an external abort is valid. Its up to the implementation
> whether these are synchronous or asynchronous. Qemu can only take a signal for
> something that was synchronous, so you can choose between the two.
> Synchronous external abort is marginally better as an unaware OS knows its
> affects this thread, and may be able to kill it.
> SError with an imp-def ESR is indistinguishable from 'part of the soc fell out',
> and should always result in a panic().
> 
> 
>>  (2) just stop QEMU (as we would for a memory error in QEMU's
>>      own memory)
> 
> This is also valid. A machine may take external-abort to EL3 and then
> reboot/crash/burn.
> 
> 
> Just in case this is the deeper issue: I keep picking on memory-errors, what
> about CPU errors?
> Linux can't handle these at all, unless they are also memory errors. If we take
> an imprecise abort from a guest KVM can't tell Qemu using signals. We don't have
> any mechanism to tell user-space about imprecise exceptions. In this case KVM
> throws an imp-def SError back at the affected vcpu, these are allowed to be
> imprecise, as this is the closest thing we have.
> 
> This does mean that any AO/AR signal Qemu gets is a memory error.
> 
> 
> Happy New Year,
> 
> James
> 
> .
> 

