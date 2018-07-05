Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3F2C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854912403D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854912403D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753804AbeGELCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:02:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47652 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753548AbeGELCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:02:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B30CD7A9;
        Thu,  5 Jul 2018 04:02:20 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 595853F2EA;
        Thu,  5 Jul 2018 04:02:17 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] efi/arm: map UEFI memory map earlier on boot
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-4-takahiro.akashi@linaro.org>
 <20180704170655.GD8370@arm.com>
 <CAKv+Gu9_rYYyQ+t89otz46DR0D4GDj-cCjhx9q=p+D8LWFRkgQ@mail.gmail.com>
 <20180705094313.GL28220@linaro.org>
From:   James Morse <james.morse@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Message-ID: <ec1a5f0f-99e3-fda1-9a64-5c2539817190@arm.com>
Date:   Thu, 5 Jul 2018 12:02:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705094313.GL28220@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 05/07/18 10:43, AKASHI Takahiro wrote:
> On Wed, Jul 04, 2018 at 08:49:32PM +0200, Ard Biesheuvel wrote:
>> On 4 July 2018 at 19:06, Will Deacon <will.deacon@arm.com> wrote:
>>> On Tue, Jun 19, 2018 at 03:44:23PM +0900, AKASHI Takahiro wrote:
>>>> Since arm_enter_runtime_services() was modified to always create a virtual
>>>> mapping of UEFI memory map in the previous patch, it is now renamed to
>>>> efi_enter_virtual_mode() and called earlier before acpi_load_tables()
>>>> in acpi_early_init().
>>>>
>>>> This will allow us to use UEFI memory map in acpi_os_ioremap() to create
>>>> mappings of ACPI tables using memory attributes described in UEFI memory
>>>> map.

>>> Hmm, this is ugly as hell. Is there nothing else we can piggy-back off?
>>> It's also fairly jarring that, on x86, efi_enter_virtual_mode() is called
>>> a few lines later, *after* acpi_early_init() has been called.

>> Currently, there is a gap where we have already torn down the early
>> mapping and haven't created the definitive mapping of the UEFI memory
>> map. There are other reasons why this is an issue, and I recently
>> proposed [0] myself to address one of them

>> Akashi-san, could you please confirm whether the patch below would be
>> sufficient for you? Apologies for going back and forth on this, but I
>> agree with Will that we should try to avoid warts like the one above
>> in generic code.
>>
>> [0] https://marc.info/?l=linux-efi&m=152930773507524&w=2
> 
> I think that this patch will also work.
> Please drop my patch#2 and #3 if you want to pick up my patchset, Will.

Patch 2 is what changes arm_enable_runtime_services() to map the efi memory map
before bailing out due to efi=noruntime.

Without it, 'efi=noruntime' means no-acpi-tables.


Thanks,

James
