Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6213C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A68E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbfA3O44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:56:56 -0500
Received: from foss.arm.com ([217.140.101.70]:55622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3O44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:56:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A53B5EBD;
        Wed, 30 Jan 2019 06:56:55 -0800 (PST)
Received: from [10.37.9.196] (unknown [10.37.9.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24B3C3F589;
        Wed, 30 Jan 2019 06:56:53 -0800 (PST)
Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
To:     Catalin Marinas <catalin.marinas@arm.com>,
        "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Cc:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Mark Rutland' <mark.rutland@arm.com>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'will.deacon@arm.com'" <will.deacon@arm.com>
References: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
 <20190129181032.GC224095@arrakis.emea.arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <57c09d48-2c09-f1e1-0f70-c8249bc8329f@arm.com>
Date:   Wed, 30 Jan 2019 14:56:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190129181032.GC224095@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 01/29/2019 06:10 PM, Catalin Marinas wrote:
> Could you please copy the whole description from the cover letter to the
> actual patch and only send one email (full description as in here
> together with the patch)? If we commit this to the kernel, it would be
> useful to have the information in the log for reference later on.
> 
> More comments below:
> 
> On Tue, Jan 29, 2019 at 12:29:58PM +0000, Zhang, Lei wrote:
>> On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1),
>> memory accesses may cause undefined fault (Data abort, DFSC=0b111111).
>> This problem will be fixed by next version of Fujitsu-A64FX.
>>
>> This fault occurs under a specific hardware condition
>> when a load/store instruction perform an address translation using:
>>    case-1  TTBR0_EL1 with TCR_EL1.NFD0 == 1.
>>    case-2  TTBR0_EL2 with TCR_EL2.NFD0 == 1.
>>    case-3  TTBR1_EL1 with TCR_EL1.NFD1 == 1.
>>    case-4  TTBR1_EL2 with TCR_EL2.NFD1 == 1.
>> And this fault occurs completely spurious.
> 
> So this looks like new information on the hardware behaviour since the
> v2 of the patch. Can this fault occur for any type of instruction
> accessing the memory or only for SVE instructions?
> 
>> Since TCR_ELx.NFD1 is set to '1' at the kernel in versions
>> past 4.17, the case-3 or case-4 may happen.
>>
>> This fault can be taken only at stage-1,
>> so this fault is taken from EL0 to EL1/EL2, from EL1 to EL1,
>> or from EL2 to EL2.
>>
>> I would like to post a workaround to avoid this problem on
>> existing Fujitsu-A64FX version.
> 
> How likely is it to trigger this erratum? In other words, aren't we
> better off with a spurious fault that we ignore rather than toggling the
> TCR_ELx.NFD1 bit?

It sounds like the spurious fault can occur as a result of load/store. 
('there is no load/store instruction between'...).

If this can happen in kernel_enter it will overwrite the exception 
registers, and we lose the original ELR.

If load/store trigger it, I don't think we can ignore it.

Thanks,

James
