Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeDDKUs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:20:48 -0400
Received: from ozlabs.org ([103.22.144.67]:44743 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750762AbeDDKUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:20:46 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>
Subject: Re: [PATCH 07/10] powerpc: Switch to generic local_softirq_pending() implementation
In-Reply-To: <1522467293-7320-8-git-send-email-frederic@kernel.org>
References: <1522467293-7320-1-git-send-email-frederic@kernel.org> <1522467293-7320-8-git-send-email-frederic@kernel.org>
Date: Wed, 04 Apr 2018 20:20:42 +1000
Message-ID: <87zi2jmfwl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:

> Remove the ad-hoc implementation, the generic code now allows us not to
> reinvent the wheel.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: James E.J. Bottomley <jejb@parisc-linux.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  arch/powerpc/include/asm/hardirq.h | 7 -------
>  1 file changed, 7 deletions(-)

If I'm reading it right the generic code implements exactly the same as
what we have now, so:

  Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
> index 5986d47..383f628 100644
> --- a/arch/powerpc/include/asm/hardirq.h
> +++ b/arch/powerpc/include/asm/hardirq.h
> @@ -25,15 +25,8 @@ typedef struct {
>  DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
>  
>  #define __ARCH_IRQ_STAT
> -
> -#define local_softirq_pending()	__this_cpu_read(irq_stat.__softirq_pending)
> -
> -#define __ARCH_SET_SOFTIRQ_PENDING
>  #define __ARCH_IRQ_EXIT_IRQS_DISABLED
>  
> -#define set_softirq_pending(x) __this_cpu_write(irq_stat.__softirq_pending, (x))
> -#define or_softirq_pending(x) __this_cpu_or(irq_stat.__softirq_pending, (x))
> -
>  static inline void ack_bad_irq(unsigned int irq)
>  {
>  	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
> -- 
> 2.7.4
