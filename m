Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B34C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB0820896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB0820896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966185AbeFOQuG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:50:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44654 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966026AbeFOQuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:50:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A9971529;
        Fri, 15 Jun 2018 09:50:04 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A2263F25D;
        Fri, 15 Jun 2018 09:50:01 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] arm64: handle NOTIFY_SEI notification by the APEI
 driver
To:     gengdongjiu <gengdongjiu@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
        erik.schmauss@intel.com, dave.martin@arm.com,
        ard.biesheuvel@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <1527770506-8076-1-git-send-email-gengdongjiu@huawei.com>
 <1527770506-8076-3-git-send-email-gengdongjiu@huawei.com>
 <20180531110115.uglmicy3nzwfoyx3@lakrids.cambridge.arm.com>
 <71afa669-e3c5-979e-da5b-1d9cb7056fd6@arm.com>
 <f000549e-bd9c-323d-bcf9-04c2df029670@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <917a1e1d-23cc-bab7-4a9c-c1766b36f3bc@arm.com>
Date:   Fri, 15 Jun 2018 17:49:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f000549e-bd9c-323d-bcf9-04c2df029670@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi gengdongjiu,

On 01/06/18 08:21, gengdongjiu wrote:
> On 2018/6/1 0:51, James Morse wrote:
>> On 31/05/18 12:01, Mark Rutland wrote:
>>> In do_serror() we already handle nmi_{enter,exit}(), so there's no need
>>> for that here.
>>
>> Even better: nmi_enter() has a BUG_ON(in_nmi()).
> 
> There are two places call the arm64_is_fatal_ras_serror():
> 1. do_serror()
> 2. kvm_handle_guest_serror()
> 
> Yes, the do_serror() already handle nmi_{enter,exit}(), so the arm64_is_fatal_ras_serror() does not need to handle it again.

> For the kvm_handle_guest_serror(), it does not handle the nmi_{enter,exit}(),
> so should we add nmi_{enter,exit}() in  kvm_handle_guest_serror() before calling
> arm64_is_fatal_ras_serror()?

kvm_handle_guest_serror() never interrupts anything, so its not an NMI, this is
why the KVM code doesn't do this today. We can take another SError from there
without issue.

But once we call APEI, it needs to prevent re-entrance, so SError has to be
masked. If we're using the estatus-queue (which we should), then we should
always call the notification helper in the same context. If do_serror() is
in_nmi(), then we should fake it up in the appropriate helper.

Given the latest review comments from Borislav, the in_nmi() weirdness in APEI
may all disappear, in which case all that matters is we call APEI with SError
masked.


> > For the NOTIFY_SEA, I do not know why handle_guest_sea() does not handle
> the nmi_{enter,exit}(). James, does we miss it in handle_guest_sea()?

The exception went to the hypervisor, it only interrupted the guest. KVM returns
to process context, and KVM then goes on to call handle_guest_sea().

nmi_enter() is to tell things like printk() that we may have interrupted its
IRQ-masked regions, and it can't take any locks to do the work. We know this is
never true for KVM at this point.


>>> TBH, I don't understand why do_sea() does that conditionally today.
>>> Unless there's some constraint I'm missing, 
>>
>> APEI uses a different fixmap entry and locks when in_nmi(). This was because we
>> may interrupt the irq-masked region in APEI that was using the regular memory.
>> (e.g. the 'polled' notification, or something backed by an interrupt.) But,
>> Borislav has spotted other things in here that are broken[0]. I'm working on
>> rolling all that into 'v5' of the in_nmi() rework stuff.
>>
>> We currently get away with this on arm because 'SEA' is the only NMI-like thing,
>> and it occurs synchronously. The problem cases are all also cases where the
>> kernel text is corrupt, which we can't possibly hope to handle.
>>
>> For NOTIFY_SDEI and NOTIFY_SEI this is the wrong pattern as these are
>> asynchronous. do_serror() has already done most of the work for NOTIFY_SEI, but
>> we need to use the estatus queue in APEI, which is currently x86 only.

> I think this patch can based on you 'v5' of the in_nmi() rework stuff

I think NOTIFY_SEI needs the estatus-queue, so yes. But the KVM changes mean
this will need doing as a separate series.


>>> I think it would make more
>>> sense to do that regardless of whether the interrupted context had
>>> interrupts enabled. James -- does that make sense to you?
>>>
>>> If you update the prior patch with a stub for !CONFIG_ACPI_APEI_SEI, you
>>> can simplify all of the above additions down to:
>>>
>>> 	if (!ghes_notify_sei())
>>> 		return;
>>>
>>> ... which would look a lot nicer.
>>
>> The code that calls ghes_notify_sei() may need calling by KVM too, but its
>> default action to an 'unclaimed' SError will be different.
>> Because of the race between memory_failure() and return-to-userspace, we may
>> need to kick the irq work queue (if we can), as we return from do_serror(). [1]
>> and [2] provide an example for NOTIFY_SEA. SDEI does this by returning to the
>> kernel through the IRQ handler, (which handles the KVM case too).

> I can kick the IRQ work queue as you do for the NOTIFY_SEA and NOTIFY_SDEI.

(NOTIFY_SDEI has its own tricks: it returns to the kernel through the IRQ VBAR
entry)

I think this needs something like the apei_claim_sea() in that series, probably
with some __ version called from do_serror() to avoid the BUG_ON(in_nmi()).


>> I think this series is unsafe until we can use the estatus queue in APEI. Its
>> also missing the handling for an SError interrupting a KVM guest.
> 
> how about this series is based on your patches that uses the estatus queue in APEI to make it safe?
> 
> when an SError interrupting a KVM guest, it will trap to hypervisor, hypervisor will call
> below software stack to handle it:
> kvm_handle_guest_serror()->arm64_is_fatal_ras_serror()->ghes_notify_sei()
> 
> so it already handles the case that an SError interrupting a KVM guest.

It already calls it at some point... this was called out in the cover-letter
(and maybe commit messages) of the series that added that code: We will need to
do more once this is used as a notification from firmware.

That series was about unmasking SError as much as possible, and enabling IESB.
We then had to handle any case where we may now take an SError, but without
kernel-first support (which requires some topology information) all we could do
is ignore corrected/restartable errors, and panic() otherwise. This isn't
actually trying to handle the error.

KVM calls this code quite late. Now that we are trying to handle the error, the
'when' matters. SError is unmasked when we return to the run-loop, we may take
another, less severe, SError before checking the value we had from guest-exit.
We unmask interrupts, we may take an interrupt and run some other code, while
holding an SError ESR that says the system can't be trusted anymore.

(incidentally ... firmware should avoid making two NOTIFY_SEI pending for the
system at the same time. The SError doesn't tell us which GHES or set of CPER
records correspond with this error, so we have to walk the list and process
whatever we find. Two CPUs doing this at the same time will do the wrong thing
if the CPU-context on one of them matters.).


Thanks,

James
