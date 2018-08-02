Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A785C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63D021530
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63D021530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbeHBSXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:23:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbeHBSW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:22:59 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D864F2152E;
        Thu,  2 Aug 2018 16:31:05 +0000 (UTC)
Date:   Thu, 2 Aug 2018 12:31:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [rt-patch 4/3] arm,KVM: Move phys_timer handling to hard irq
 context
Message-ID: <20180802123104.7fed73b4@gandalf.local.home>
In-Reply-To: <1533192980.11791.8.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
        <1532764179.9882.14.camel@gmx.de>
        <1532768853.9882.73.camel@gmx.de>
        <1533192980.11791.8.camel@gmx.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Aug 2018 08:56:20 +0200
Mike Galbraith <efault@gmx.de> wrote:

> (arm-land adventures 1/3 take2 will have to wait, my cup runeth over) 
> 
> v4.14..v4.15 timer handling changes including calling kvm_timer_vcpu_load()

I take it that this should be added to v4.16-rt and marked stable-rt?

-- Steve

> during kvm_preempt_ops.sched_in and taking vgic_dist.lpi_list_lock in the
> timer interrupt handler required locks for which locking rules/context had
> been changed be converted to raw_spinlock_t...
> 
> Quoting virt/kvm/arm/vgic/vgic.c:
>  * Locking order is always:
>  * kvm->lock (mutex)
>  *   its->cmd_lock (mutex)
>  *     its->its_lock (mutex)
>  *       vgic_cpu->ap_list_lock         must be taken with IRQs disabled
>  *         kvm->lpi_list_lock           must be taken with IRQs disabled
>  *           vgic_irq->irq_lock         must be taken with IRQs disabled
>  *
>  * As the ap_list_lock might be taken from the timer interrupt handler,
>  * we have to disable IRQs before taking this lock and everything lower
>  * than it.
> 
> ...and fixed the obvious bricking consequence of those changes for RT,
> but left an RT specific kvm unit test timer failure in its wake.  Handling
> phys_timer in hard interrupt context as expected cures that failure.
> 
> Pre:
> PASS selftest-setup (2 tests)
> PASS selftest-vectors-kernel (2 tests)
> PASS selftest-vectors-user (2 tests)
> PASS selftest-smp (65 tests)
> PASS pci-test (1 tests)
> PASS pmu (3 tests)
> PASS gicv2-ipi (3 tests)
> PASS gicv3-ipi (3 tests)
> PASS gicv2-active (1 tests)
> PASS gicv3-active (1 tests)
> PASS psci (4 tests)
> FAIL timer (8 tests, 1 unexpected failures)
> 
> Post:
> PASS selftest-setup (2 tests)
> PASS selftest-vectors-kernel (2 tests)
> PASS selftest-vectors-user (2 tests)
> PASS selftest-smp (65 tests)
> PASS pci-test (1 tests)
> PASS pmu (3 tests)
> PASS gicv2-ipi (3 tests)
> PASS gicv3-ipi (3 tests)
> PASS gicv2-active (1 tests)
> PASS gicv3-active (1 tests)
> PASS psci (4 tests)
> PASS timer (8 tests)
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>  virt/kvm/arm/arch_timer.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -634,7 +634,7 @@ void kvm_timer_vcpu_init(struct kvm_vcpu
>  	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
>  	timer->bg_timer.function = kvm_bg_timer_expire;
>  
> -	hrtimer_init(&timer->phys_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
> +	hrtimer_init(&timer->phys_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
>  	timer->phys_timer.function = kvm_phys_timer_expire;
>  
>  	vtimer->irq.irq = default_vtimer_irq.irq;

