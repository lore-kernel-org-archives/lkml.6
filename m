Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90F9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82ED12145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbeLQPz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:55:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59262 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbeLQPz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:55:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45C8D15AD;
        Mon, 17 Dec 2018 07:55:56 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 502083F575;
        Mon, 17 Dec 2018 07:55:54 -0800 (PST)
Subject: Re: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     gengdongjiu <gengdongjiu@huawei.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvm-devel <kvm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
References: <1544782537-13377-1-git-send-email-gengdongjiu@huawei.com>
 <f252e4ca-cdc2-bc42-32a6-5dae7dee51ee@arm.com>
 <CAFEAcA-ajJ_W0FtC00aEiG=wGgbbU_8OEt+B+B87647gTsSMvQ@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <1c532d67-104e-2c26-9cf9-289188a1f8b1@arm.com>
Date:   Mon, 17 Dec 2018 15:55:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ajJ_W0FtC00aEiG=wGgbbU_8OEt+B+B87647gTsSMvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 14/12/2018 14:33, Peter Maydell wrote:
> On Fri, 14 Dec 2018 at 13:56, James Morse <james.morse@arm.com> wrote:
>> On 14/12/2018 10:15, Dongjiu Geng wrote:
>>> When user space do memory recovery, it will check whether KVM and
>>> guest support the error recovery, only when both of them support,
>>> user space will do the error recovery. This patch exports this
>>> capability of KVM to user space.
>>
>> I can understand user-space only wanting to do the work if host and guest
>> support the feature. But 'error recovery' isn't a KVM feature, its a Linux
>> kernel feature.
>>
>> KVM will send it's user-space a SIGBUS with MCEERR code whenever its trying to
>> map a page at stage2 that the kernel-mm code refuses this because its poisoned.
>> (e.g. check_user_page_hwpoison(), get_user_pages() returns -EHWPOISON)
>>
>> This is exactly the same as happens to a normal user-space process.
>>
>> I think you really want to know if the host kernel was built with
>> CONFIG_MEMORY_FAILURE.
> 
> Does userspace need to care about that? Presumably if the host kernel
> wasn't built with that support then it will simply never deliver
> any memory failure events to QEMU, which is fine.

Aha, I thought this is what you wanted.
Always being prepared to handle the signals is the best choice.


> The point I was trying to make in the email Dongjiu references
> (https://patchwork.codeaurora.org/patch/652261/) is simply that
> "QEMU gets memory-failure notifications from the host kernel"
> does not imply "the guest is prepared to receive memory
> failure notifications", and so the code path which handles
> the SIGBUS must do some kind of check for whether the guest

> CPU is a type which expects them

I don't understand this bit.

The CPU support is just about barriers for containment and reporting a
standardised classification to software. Firmware-first replaces all this. It
doesn't depend on any CPU feature.
APM-X-Gene has firmware-first support, it uses some kind of external processor
that takes the error-interrupt from DRAM and generates CPER records, before
triggering the firmware-first notification.

> and that the board code
> set up the ACPI tables that it wants to fill in.
ACPI has some complex stuff around claiming 'platform-wide capabilities'. Qemu
could use this to know if the guest understands APEI.

Section 6.2.11.2 "Platform-Wide OSPM Capabilities" of ACPI v6.2 describes the
\_SB._OSC method, which has an APEI support bit. This is used in some kind of
handshake.

Linux does this during boot if its built with APEI GHES support. Linux seems to
think the APEI bit enables firmware-first:
| [   63.804907] GHES: APEI firmware first mode is enabled by APEI bit.

... but its not clear from the spec. (APEI is more than firmware-first)

(where do these things go? Platform AML in the DSDT)


I don't think this controls anything on a real system, (we've seen X-Gene
generate CPER records before Linux started booting), and I don't think it really
matters as 'what happens if the guest doesn't know' falls out of the way these
SIGBUS codes map back onto the firmware-first notifications:

For 'AO' signals you can dump CPER records in a NOTIFY_POLLed area. If the guest
doesn't care, it can avert is eyes. If you used one of the NOTIFY_$(interrupt)
types, the guest can not-register the interrupt.

The AR signals map to external-abort. On a firmware-first system EL3 takes
these, generates some extra metadata using CPER records in the agreed location,
and re-injects an emulated external-abort.
If Qemu takes an AR signal, this is effectively an external-abort, the page has
been accessed and the kernel will not map it because the page is poisoned. These
would have been an external-abort on a real system, its not a problem if the
guest doesn't know about the extra CPER metadata.

Centriq is an example of a system that does this external-abort+CPER-metadata
without the v8.2 CPU extensions.

All v8.0 CPUs have synchronous/asynchronous external abort, there is nothing new
going on here, its just extra metadata. (critically: the physical address of the
fault)


Thanks,

James
