Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D9BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F9D2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbfBROdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:33:47 -0500
Received: from foss.arm.com ([217.140.101.70]:60342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388743AbfBROdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:33:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06046A78;
        Mon, 18 Feb 2019 06:33:45 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95D9E3F589;
        Mon, 18 Feb 2019 06:33:38 -0800 (PST)
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, Dave.Martin@arm.com,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <205c0b3a-d905-544f-31c3-1bb6ab68bb5b@arm.com>
Date:   Mon, 18 Feb 2019 14:33:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sebastian,

On 13/02/2019 14:30, Sebastian Andrzej Siewior wrote:
> On 2019-02-08 16:55:13 [+0000], Julien Grall wrote:
>> When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
>> the kernel may be able to use FPSIMD/SVE. This is for instance the case
>> for crypto code.
>>
>> Any use of FPSIMD/SVE in the kernel are clearly marked by using the
>> function kernel_neon_{begin, end}. Furthermore, this can only be used
>> when may_use_simd() returns true.
> 
> This is equal what x86 is currently doing. The naming is slightly
> different, there is irq_fpu_usable().
The idea behind the patch was taken from x86. On x86, softirq does not seem to 
be disabled when context switching the FPUs registers.

> 
>> The current implementation of may_use_simd() allows softirq to use
>> FPSIMD/SVE unless it is currently in used (i.e kernel_neon_busy is true).
>> When in used, softirqs usually fallback to a software method.
>>
>> At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
>> when touching the FPSIMD/SVE context. This has the drawback to disable
>> all softirqs even if they are not using FPSIMD/SVE.
> 
> Is this bad? This means also that your crypto code will not be
> interrupted by a softirq. Also if you would get rid of it, you could
> avoid the software fallback in case may_use_simd() says false.

There seem to have some misunderstanding about the purpose of this patch. Any 
use of crypto in the kernel is only protected by preempt_disable(). softirqs are 
only disabled when context switching the FPU register between two userspace tasks.

 From the commit log cb84d11e1625 "arm64: neon: Remove support for nested or 
hardirq kernel-mode NEON" this was done to protect against rare softirqs use 
crypto. It seems to me this is a bit overkill to increase softirq latency if 
they barely use FPSIMD/SVE. Indeed, the SVE context can be quite large, 
therefore it can take some times to save/restore it.

[...]

>> For RT-linux, it might be possible to use migrate_{enable, disable}. I
>> am quite new with RT and have some trouble to understand the semantics
>> of migrate_{enable, disable}. So far, I am still unsure if it is possible
>> to run another userspace task on the same CPU while getting preempted
>> when the migration is disabled.
> 
> In RT:
> - preemt_disable() is the same as !RT. A thread can not be suspend. An
>    interrupt may interrupt. However on RT we have threaded interrupts so
>    the interrupt is limited to the first-level handler (not the threaded
>    handler).
> 
> - migrate_disable() means that the thread can not be moved to another
>    CPU. It can be suspended.
> 
> - local_bh_disable() disables the BH: No softirq can run. In RT
>    local_bh_disable() does not inherit preempt_disable(). Two different
>    softirqs can be executed in parallel.
>    The BH is usually invoked at the end of the threaded interrupt
>    (because the threaded interrupt handler raises the softirq). It can
>    also run in the ksoftirqd.
> 
> Usually you should not get preempted in a migrate_disable() section. A
> SCHED_OTHER task should not interrupt another SCHED_OTHER task in a
> migrate_disable() section. A task with a higher priority (a RT/DL task)
> will. Since threaded interrupts run with a RT priority of 50, they will
> interrupt your task in a migrate_disable() section.

Thank you for the explanation!

Cheers,

-- 
Julien Grall
