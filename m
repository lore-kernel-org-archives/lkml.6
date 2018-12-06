Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084FFC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1B1208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1B1208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeLFTS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:18:26 -0500
Received: from foss.arm.com ([217.140.101.70]:59078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbeLFTS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:18:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C699DA78;
        Thu,  6 Dec 2018 11:18:25 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 96B863F59C;
        Thu,  6 Dec 2018 11:18:25 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B9BB81AE0BAD; Thu,  6 Dec 2018 19:18:46 +0000 (GMT)
Date:   Thu, 6 Dec 2018 19:18:46 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com, rml@tech9.net,
        tglx@linutronix.de, schwidefsky@de.ibm.com
Subject: Re: [PATCH v2 0/2] arm64: Only call into preempt_schedule() if
 need_resched()
Message-ID: <20181206191846.GB20796@arm.com>
References: <1543599271-14339-1-git-send-email-will.deacon@arm.com>
 <20181206150850.GI13538@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206150850.GI13538@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Dec 06, 2018 at 04:08:50PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 30, 2018 at 05:34:29PM +0000, Will Deacon wrote:
> > This is version two of the patches I originally posted here:
> > 
> >   http://lkml.kernel.org/r/1543347902-21170-1-git-send-email-will.deacon@arm.com
> > 
> > The only change since v1 is that  __preempt_count_dec_and_test() now
> > reloads the need_resched flag if it initially saw that it was set. This
> > resolves the issue spotted by Peter, where an IRQ coming in during the
> > decrement can cause a reschedule to be missed.
> 
> Yes, I think this one will work, so:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!

> However, this leaves me wondering if the sequence is actually much
> better than what you had?
> 
> I suppose there's a win due to cache locality -- you only have to load a
> single line -- but I'm thinking that on pure instruction count, you're
> not actually winning much.

The fast path is still slightly shorter in terms of executed instructions,
but you're right that the win is likely to be because everything hits in the
cache or the store buffer when we're not preempting, so we should run
through the code reasonably quickly and avoid the unconditional call to
preempt_schedule().

Will

--->8

// Before
  20:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
  24:   910003fd        mov     x29, sp
  28:   d5384101        mrs     x1, sp_el0
  2c:   b9401020        ldr     w0, [x1, #16]
  30:   51000400        sub     w0, w0, #0x1
  34:   b9001020        str     w0, [x1, #16]
  38:   350000a0        cbnz    w0, 4c <preempt_enable+0x2c>
  3c:   f9400020        ldr     x0, [x1]
  40:   721f001f        tst     w0, #0x2
  44:   54000040        b.eq    4c <preempt_enable+0x2c>  // b.none
  48:   94000000        bl      0 <preempt_schedule>
  4c:   a8c17bfd        ldp     x29, x30, [sp], #16
  50:   d65f03c0        ret

// After
  20:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
  24:   910003fd        mov     x29, sp
  28:   d5384101        mrs     x1, sp_el0
  2c:   f9400820        ldr     x0, [x1, #16]
  30:   d1000400        sub     x0, x0, #0x1
  34:   b9001020        str     w0, [x1, #16]
  38:   b5000080        cbnz    x0, 48 <preempt_enable+0x28>
  3c:   94000000        bl      0 <preempt_schedule>
  40:   a8c17bfd        ldp     x29, x30, [sp], #16
  44:   d65f03c0        ret
  48:   f9400820        ldr     x0, [x1, #16]
  4c:   b5ffffa0        cbnz    x0, 40 <preempt_enable+0x20>
  50:   94000000        bl      0 <preempt_schedule>
  54:   17fffffb        b       40 <will_preempt_enable+0x20>
