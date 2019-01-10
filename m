Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97550C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657F420675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbfAJS0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:26:00 -0500
Received: from foss.arm.com ([217.140.101.70]:42156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729480AbfAJS0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:26:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E0ADA78;
        Thu, 10 Jan 2019 10:25:59 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B00763F694;
        Thu, 10 Jan 2019 10:25:58 -0800 (PST)
Subject: Re: Question about qspinlock nest
To:     Waiman Long <longman@redhat.com>
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SRINIVAS <srinivas.eeda@oracle.com>
References: <e784a592-5dec-b0b3-6c70-d9ef775621d5@oracle.com>
 <910e9fb6-d0df-4711-fe2b-244b3c20eb82@redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <d06126a1-1db8-f937-2084-2c1234b6f56f@arm.com>
Date:   Thu, 10 Jan 2019 18:25:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <910e9fb6-d0df-4711-fe2b-244b3c20eb82@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Longman, Zhenzhong,

On 10/01/2019 14:43, Waiman Long wrote:
> On 01/10/2019 03:02 AM, Zhenzhong Duan wrote:
>> There is a question confused me for days. Appreciate an answer.
>>
>> In below code, the comment says we never have more than 4 nested
>> contexts.
>>
>> What happen if debug and mce exceptions nest with the four, or we
>> ensure it never happen?
>>
>>
>> /*
>>  * Per-CPU queue node structures; we can never have more than 4 nested
>>  * contexts: task, softirq, hardirq, nmi.
>>  *
>>  * Exactly fits one 64-byte cacheline on a 64-bit architecture.
>>  *
>>  * PV doubles the storage and uses the second cacheline for PV state.
>>  */
>> static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);

> Yes, both debug and mce exceptions are some kind of NMIs. So
> theoretically, it is possible to have more than four. Are you aware of
> any debug and MCE exception handlers that need to take a spinlock for
> synchronization?

On arm64 if all the RAS and psuedo-NMI patches land, our worst-case interleaving
jumps to at least 7. The culprit is APEI using spinlocks to protect fixmap slots.

I have an RFC to bump the number of node bits from 2 to 3, but as this is APEI
four times, it may be preferable to make it use something other than spinlocks.


The worst-case order is below. Each one masks those before it:
1. process context
2. soft-irq
3. hard-irq
4. psuedo-nmi [0]
   - using the irqchip priorities to configure some IRQs as NMI.
5. SError [1]
   - a bit like an asynchronous MCE. ACPI allows this to convey CPER records,
     requiring an APEI call.
6&7. SDEI [2]
     - a firmware triggered software interrupt, only its two of them, either of
       which could convey CPER records.
8. Synchronous external abort
   - again, similar to MCE. There are systems using this with APEI.


Thanks,

James


[0] lore.kernel.org/r/1546956464-48825-1-git-send-email-julien.thierry@arm.com
[1]
https://lore.kernel.org/r/1527770506-8076-1-git-send-email-gengdongjiu@huawei.com
[2]
https://lore.kernel.org/linux-arm-kernel/20181203180613.228133-26-james.morse@arm.com/

