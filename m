Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365D4C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1115A21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbfBROHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:07:40 -0500
Received: from foss.arm.com ([217.140.101.70]:59262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389283AbfBROHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:07:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 084E7A78;
        Mon, 18 Feb 2019 06:07:34 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A6C33F720;
        Mon, 18 Feb 2019 06:07:27 -0800 (PST)
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To:     Julia Cartwright <julia@ni.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190212171350.GB1002@jcartwri.amer.corp.natinst.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <7671d868-9d33-dfe1-851a-b72271f12d5f@arm.com>
Date:   Mon, 18 Feb 2019 14:07:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212171350.GB1002@jcartwri.amer.corp.natinst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2019 17:13, Julia Cartwright wrote:
> Hello Julien-

Hello Julien,

> 
> On Fri, Feb 08, 2019 at 04:55:13PM +0000, Julien Grall wrote:
>> When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
>> the kernel may be able to use FPSIMD/SVE. This is for instance the case
>> for crypto code.
>>
>> Any use of FPSIMD/SVE in the kernel are clearly marked by using the
>> function kernel_neon_{begin, end}. Furthermore, this can only be used
>> when may_use_simd() returns true.
>>
>> The current implementation of may_use_simd() allows softirq to use
>> FPSIMD/SVE unless it is currently in used (i.e kernel_neon_busy is true).
>> When in used, softirqs usually fallback to a software method.
>>
>> At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
>> when touching the FPSIMD/SVE context. This has the drawback to disable
>> all softirqs even if they are not using FPSIMD/SVE.
>>
>> As a softirq should not rely on been able to use simd at a given time,
>> there are limited reason to keep softirq disabled when touching the
>> FPSIMD/SVE context. Instead, we can only disable preemption and tell
>> the NEON unit is currently in use.
>>
>> This patch introduces two new helpers kernel_neon_{disable, enable} to
>> mark the area using FPSIMD/SVE context and use them in replacement of
>> local_bh_{disable, enable}. The functions kernel_neon_{begin, end} are
>> also re-implemented to use the new helpers.
>>
>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>
>> ---
>>
>> I have been exploring this solution as an alternative approach to the RT
>> patch "arm64: fpsimd: use preemp_disable in addition to local_bh_disable()".
>>
>> So far, the patch has only been lightly tested.
>>
>> For RT-linux, it might be possible to use migrate_{enable, disable}. I
>> am quite new with RT and have some trouble to understand the semantics
>> of migrate_{enable, disable}. So far, I am still unsure if it is possible
>> to run another userspace task on the same CPU while getting preempted
>> when the migration is disabled.
> 
> Yes, a thread in a migrate_disable()-protected critical section can be
> preempted, and another thread on the same CPU may enter the critical
> section.
> 
> If it's necessary to prevent this from happening, then you need to also
> make use of a per-CPU mutex.  On RT, this would do the right thing
> w.r.t. priority inheritance.

Thank you for the explanation, I now understand better the concept of 
migrate_disable.

Best regards,

-- 
Julien Grall
