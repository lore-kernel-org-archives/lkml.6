Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE62C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1AC2173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1AC2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbeHCLiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:38:14 -0400
Received: from foss.arm.com ([217.140.101.70]:40726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbeHCLiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:38:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB2E580D;
        Fri,  3 Aug 2018 02:42:43 -0700 (PDT)
Received: from e120077-lin.cambridge.arm.com (e120077-lin.cambridge.arm.com [10.2.207.74])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8A913F5B3;
        Fri,  3 Aug 2018 02:42:41 -0700 (PDT)
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Andrew Pinski <pinskia@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
From:   "Richard Earnshaw (lists)" <Richard.Earnshaw@arm.com>
Openpgp: preference=signencrypt
Message-ID: <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com>
Date:   Fri, 3 Aug 2018 10:42:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/18 10:29, Ard Biesheuvel wrote:
> On 3 August 2018 at 11:15, Ramana Radhakrishnan
> <ramana.gcc@googlemail.com> wrote:
>> On Fri, Aug 3, 2018 at 8:53 AM, Florian Weimer <fweimer@redhat.com> wrote:
>>> On 08/03/2018 09:11 AM, Andrew Pinski wrote:
>>>>
>>>> Yes fix Links not to use memcpy on the framebuffer.
>>>> It is undefined behavior to use device memory with memcpy.
>>>
>>>
>>> Some (de facto) ABIs require that it is supported, though.  For example, the
>>> POWER string functions avoid unaligned loads and stores for this reason
>>> because the platform has the same issue with device memory.  And yes, GCC
>>> will expand memcpy on POWER to something that is incompatible with device
>>> memory. 8-(
>>
>> GCC for AArch64 - use -mstrict-align
>> GCC for AArch32 - use -mno-unaligned-access.
>>
>> If you see unaligned accesses coming out of the compiler for well
>> defined programs then that's a bug. Frequently we see undefined
>> programs that get the compiler to produce traps - atleast one or 2
>> bugs a year  in  GCC .
>>
>>
>>>
>>> If we don't want people to use memcpy, we probably need to provide a
>>> credible alternative.
>>
>> I believe a number of packages have rolled their own to take these
>> constraints into account
>> for AArch32, perhaps it needs to be expanded for AArch64 as well.
>>
> 
> I guess the semantics of a framebuffer are not strictly defined, but
> the current reality is that it is expected to have memory semantics
> (by Linux/glibc)
> 
> Matt is saying fundamental properties of the underlying interconnects
> (AMBA) make that impossible on ARM, but I'd like to understand better
> if that is universally the case, and whether such a system is still
> PCIe compliant.
> 
> The discussion about whether memcpy() should rely on unaligned
> accesses, and whether you should use it on device memory is orthogonal
> to that, and not the heart of the matter IMO
> 

Whoa, hold on.

Memcpy should never be used on device memory.  Period.  Memcpy doesn't
know anything about what size of access is needed for accessing a device.

But why is the buffer in device memory rather than some other form of
uncached memory?

If you change memcpy to deal with an aspect of the system hardware,
you'll end up hosing performance EVERYWHERE.  DON'T DO IT!

If you must, create a new API with tighter semantics, but don't change
memcpy to accommodate this.

Anyway, back to the original report.  What memory mapping is being used?
 In detail?

R.
