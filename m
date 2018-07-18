Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A845ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E57F20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E57F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbeGRQLu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:11:50 -0400
Received: from shelob.surriel.com ([96.67.55.147]:52518 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730926AbeGRQLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:11:49 -0400
Received: from [2620:10d:c091:200::1:ca15] (helo=[IPv6:2620:10d:c0a3:10fb:4c:7ee9:b6e2:d1d5])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1ffoRs-0005Vu-LL; Wed, 18 Jul 2018 11:33:04 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [tip:x86/mm] x86/mm/tlb: Make lazy TLB mode lazier
From:   Rik van Riel <riel@surriel.com>
In-Reply-To: <20180717113330.GU2476@hirez.programming.kicks-ass.net>
Date:   Wed, 18 Jul 2018 11:33:02 -0400
Cc:     songliubraving@fb.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, torvalds@linux-foundation.org,
        linux-tip-commits@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <08AC2AF2-17DE-4416-BBBD-B6B950D20906@surriel.com>
References: <20180716190337.26133-5-riel@surriel.com>
 <tip-ac0315896970d8589291e9d8a1569fc65967b7f1@git.kernel.org>
 <20180717113330.GU2476@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 17, 2018, at 7:33 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Tue, Jul 17, 2018 at 02:35:08AM -0700, tip-bot for Rik van Riel wrote:
>> @@ -242,17 +244,40 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>> 			   next->context.ctx_id);
>> 
>> 		/*
>> +		 * Even in lazy TLB mode, the CPU should stay set in the
>> +		 * mm_cpumask. The TLB shootdown code can figure out from
>> +		 * from cpu_tlbstate.is_lazy whether or not to send an IPI.
>> 		 */
>> 		if (WARN_ON_ONCE(real_prev != &init_mm &&
>> 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
>> 			cpumask_set_cpu(cpu, mm_cpumask(next));
>> 
>> +		/*
>> +		 * If the CPU is not in lazy TLB mode, we are just switching
>> +		 * from one thread in a process to another thread in the same
>> +		 * process. No TLB flush required.
>> +		 */
>> +		if (!was_lazy)
>> +			return;
>> +
>> +		/*
>> +		 * Read the tlb_gen to check whether a flush is needed.
>> +		 * If the TLB is up to date, just use it.
>> +		 * The barrier synchronizes with the tlb_gen increment in
>> +		 * the TLB shootdown code.
>> +		 */
>> +		smp_mb();
> 
> What exactly is this smp_mb() ordering? The above comment is
> insufficient. Is it the cpumask_set_cpu() vs the atomic64_read() ?
> 
> If so, should this not be smp_mb__after_atomic() (iow a NO-OP on x86)
> 
> If it is not so, please fix the comment to explain things.
> 
> 
The tlb flush code first increments mm->context.tlb_gen, and then sends
shootdown IPIs to CPUs that have this mm loaded and are not in lazy
TLB mode.

At context switch time, we have to ensure that we check the tlb_gen after
we load the old is_lazy state.

Maybe something like this?
 
                /*
                 * Read the tlb_gen to check whether a flush is needed.
                 * If the TLB is up to date, just use it.
                 * The TLB shootdown code first increments tlb_gen, and then
                 * sends IPIs to CPUs that have this CPU loaded and are not
                 * in lazy TLB mode. The barrier ensures we handle
                 * cpu_tlbstate.is_lazy before tlb_gen, keeping this code
                 * synchronized with the TLB flush code.
                 */


