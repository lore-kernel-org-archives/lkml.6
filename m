Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeBWHI7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 02:08:59 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37969 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeBWHI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 02:08:58 -0500
X-Google-Smtp-Source: AH8x2250ROA2aS8eZr+leFjBYJb++EYiwkq7t4/Z2USi7x1HKYgO5vqvxNEOkj/BYp/c1bx1LfwVUg==
Date: Fri, 23 Feb 2018 08:08:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        ebiederm@xmission.com, bhe@redhat.com, andy.shevchenko@gmail.com
Subject: Re: [PATCH v2] x86/apic: Move pending intr check code into it's own
 function
Message-ID: <20180223070854.bjtybuj5qnztumaz@gmail.com>
References: <20180223033557.31116-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223033557.31116-1-douly.fnst@cn.fujitsu.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

> the pending interrupt check code is mixed with the local APIC setup code,
> that looks messy.
> 
> Extract the related code, move it into a new function named
> apic_pending_intr_clear().
> 
> bonus cleanups from Andy Shevchenko's suggestions:
> 
>   - for() -> for_each_set_bit()
>   - printk() -> pr_err()

Please split the cleanups (and the cleanups suggested further below) into a 
separate patch, so that there's a pure 'code movement' patch plus another patch 
that is easy to review.

> +	/*
> +	 * After a crash, we no longer service the interrupts and a pending
> +	 * interrupt from previous kernel might still have ISR bit set.
> +	 *
> +	 * Most probably by now CPU has serviced that pending interrupt and
> +	 * it might not have done the ack_APIC_irq() because it thought,
> +	 * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
> +	 * does not clear the ISR bit and cpu thinks it has already serivced
> +	 * the interrupt. Hence a vector might get locked. It was noticed
> +	 * for timer irq (vector 0x31). Issue an extra EOI to clear ISR.
> +	 */
> +	do {
> +		queued = 0;
> +		for (i = APIC_ISR_NR - 1; i >= 0; i--)
> +			queued |= apic_read(APIC_IRR + i*0x10);
> +
> +		for (i = APIC_ISR_NR - 1; i >= 0; i--) {
> +			value = apic_read(APIC_ISR + i*0x10);
> +			for_each_set_bit(j, &value, 32) {
> +				if (j) {
> +					ack_APIC_irq();
> +					acked++;
> +				}
> +			}
> +		}
> +		if (acked > 256) {
> +			pr_err("LAPIC pending interrupts after %d EOI\n",
> +				acked);

Please don't
	break the line of
	printk's.


> +		if (queued) {
> +			if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
> +				ntsc = rdtsc();
> +				max_loops = (cpu_khz << 10) - (ntsc - tsc);
> +			} else
> +				max_loops--;

unbalanced curly braces.

Thanks,

	Ingo
