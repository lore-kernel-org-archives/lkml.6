Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1320C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909ED2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909ED2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbeLDRa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:30:58 -0500
Received: from foss.arm.com ([217.140.101.70]:37766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLDRa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:30:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F19CA78;
        Tue,  4 Dec 2018 09:30:57 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FF833F59C;
        Tue,  4 Dec 2018 09:30:55 -0800 (PST)
Subject: Re: [PATCH v6 07/24] arm64: Make PMR part of task context
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, daniel.thompson@linaro.org,
        marc.zyngier@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
        james.morse@arm.com, joel@joelfernandes.org,
        Dave Martin <Dave.Martin@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-8-git-send-email-julien.thierry@arm.com>
 <20181204170908.GB19210@arrakis.emea.arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <d7651225-97ed-02a1-dd87-87cdbd36bca5@arm.com>
Date:   Tue, 4 Dec 2018 17:30:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181204170908.GB19210@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/18 17:09, Catalin Marinas wrote:
> On Mon, Nov 12, 2018 at 11:56:58AM +0000, Julien Thierry wrote:
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index 039144e..eb8120e 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -249,6 +249,12 @@ alternative_else_nop_endif
>>  	msr	sp_el0, tsk
>>  	.endif
>>  
>> +	/* Save pmr */
>> +alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>> +	mrs_s	x20, SYS_ICC_PMR_EL1
>> +	str	x20, [sp, #S_PMR_SAVE]
>> +alternative_else_nop_endif
>> +
>>  	/*
>>  	 * Registers that may be useful after this macro is invoked:
>>  	 *
>> @@ -269,6 +275,13 @@ alternative_else_nop_endif
>>  	/* No need to restore UAO, it will be restored from SPSR_EL1 */
>>  	.endif
>>  
>> +	/* Restore pmr */
>> +alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>> +	ldr	x20, [sp, #S_PMR_SAVE]
>> +	msr_s	SYS_ICC_PMR_EL1, x20
>> +	dsb	sy
>> +alternative_else_nop_endif
> 
> What's this DSB for? If it's needed, please add a comment.
> 

The DSB is to make sure that, in the case we are unmasking interrupt
priorities, the unmasking is seen by the redistributor. Without it the
redistributor might only start forwarding interrupts (if their
priorities are too low) to the CPU once it has seen that PMR was
modified, which could happen after the CPU has returned from the exception.

I'll add a comment.

> I would have expected an ISB (or none at all as we are going to return
> from an exception).

So the two reasons we don't need an ISB are:
- the only thing that matter is that PMR modification + DSB happens
before exception return
- writes to ICC_PMR_EL1 are self synchronizing so we don't need an ISB
before the DSB

Thanks,

-- 
Julien Thierry
