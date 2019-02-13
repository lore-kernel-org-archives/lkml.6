Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD57DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878C4222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392248AbfBMOae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:30:34 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46651 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbfBMOae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:30:34 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gtvYT-0003RW-9D; Wed, 13 Feb 2019 15:30:29 +0100
Date:   Wed, 13 Feb 2019 15:30:29 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, Dave.Martin@arm.com,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
References: <20190208165513.8435-1-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208165513.8435-1-julien.grall@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-08 16:55:13 [+0000], Julien Grall wrote:
> When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
> the kernel may be able to use FPSIMD/SVE. This is for instance the case
> for crypto code.
> 
> Any use of FPSIMD/SVE in the kernel are clearly marked by using the
> function kernel_neon_{begin, end}. Furthermore, this can only be used
> when may_use_simd() returns true.

This is equal what x86 is currently doing. The naming is slightly
different, there is irq_fpu_usable().

> The current implementation of may_use_simd() allows softirq to use
> FPSIMD/SVE unless it is currently in used (i.e kernel_neon_busy is true).
> When in used, softirqs usually fallback to a software method.
> 
> At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
> when touching the FPSIMD/SVE context. This has the drawback to disable
> all softirqs even if they are not using FPSIMD/SVE.

Is this bad? This means also that your crypto code will not be
interrupted by a softirq. Also if you would get rid of it, you could
avoid the software fallback in case may_use_simd() says false.

> As a softirq should not rely on been able to use simd at a given time,
> there are limited reason to keep softirq disabled when touching the
> FPSIMD/SVE context. Instead, we can only disable preemption and tell
> the NEON unit is currently in use.
> 
> This patch introduces two new helpers kernel_neon_{disable, enable} to
> mark the area using FPSIMD/SVE context and use them in replacement of
> local_bh_{disable, enable}. The functions kernel_neon_{begin, end} are
> also re-implemented to use the new helpers.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> 
> ---
> 
> I have been exploring this solution as an alternative approach to the RT
> patch "arm64: fpsimd: use preemp_disable in addition to local_bh_disable()".
> 
> So far, the patch has only been lightly tested.
> 
> For RT-linux, it might be possible to use migrate_{enable, disable}. I
> am quite new with RT and have some trouble to understand the semantics
> of migrate_{enable, disable}. So far, I am still unsure if it is possible
> to run another userspace task on the same CPU while getting preempted
> when the migration is disabled.

In RT:
- preemt_disable() is the same as !RT. A thread can not be suspend. An
  interrupt may interrupt. However on RT we have threaded interrupts so
  the interrupt is limited to the first-level handler (not the threaded
  handler).

- migrate_disable() means that the thread can not be moved to another
  CPU. It can be suspended.

- local_bh_disable() disables the BH: No softirq can run. In RT
  local_bh_disable() does not inherit preempt_disable(). Two different
  softirqs can be executed in parallel.
  The BH is usually invoked at the end of the threaded interrupt
  (because the threaded interrupt handler raises the softirq). It can
  also run in the ksoftirqd.

Usually you should not get preempted in a migrate_disable() section. A
SCHED_OTHER task should not interrupt another SCHED_OTHER task in a
migrate_disable() section. A task with a higher priority (a RT/DL task)
will. Since threaded interrupts run with a RT priority of 50, they will
interrupt your task in a migrate_disable() section.


Sebastian
