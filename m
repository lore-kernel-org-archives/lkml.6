Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeESMdB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 08:33:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55695 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeESMc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 08:32:59 -0400
Date: Sat, 19 May 2018 14:32:55 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        hpa@zytor.com
Subject: Re: [PATCH] x86/idt: Simplify the idt_setup_apic_and_irq_gates()
In-Reply-To: <20180426054452.32308-1-douly.fnst@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1805191424560.1599@nanos.tec.linutronix.de>
References: <20180426054452.32308-1-douly.fnst@cn.fujitsu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2018, Dou Liyang wrote:

> The vectors between FIRST_SYSTEM_VECTOR and NR_VECTORS are special IRQ
> vectors used by the SMP architecture. But, if X86_LOCAL_APIC=n, it will
> not be used, and the FIRST_SYSTEM_VECTOR is equal to NR_VECTORS.

Correct, but that function has nothing to do with FIRST_SYSTEM_VECTOR.

> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index 2c3a1b4294eb..8b4174890706 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -317,15 +317,16 @@ void __init idt_setup_apic_and_irq_gates(void)
>  		set_intr_gate(i, entry);
>  	}
>  
> -	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
> +	/*
> +	 * If X86_LOCAL_APIC=n, the FIRST_SYSTEM_VECTOR is equal to NR_VECTORS
> +	 * Just consider the X86_LOCAL_APIC=y case
> +	 */
>  #ifdef CONFIG_X86_LOCAL_APIC
> +	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
>  		set_bit(i, system_vectors);
>  		set_intr_gate(i, spurious_interrupt);
> -#else
> -		entry = irq_entries_start + 8 * (i - FIRST_EXTERNAL_VECTOR);
> -		set_intr_gate(i, entry);
> -#endif
>  	}
> +#endif

That change breaks the LOCAL_APIC=n case in a subtle way. What the function
does is to set _ALL_ entries starting from FIRST_EXTERNAL_VECTOR up to
NR_VECTORS in the IDT to a known target, except those which are already
occupied by a system vector.

So for APIC=y this sets them to: spurious vector and for APIC=n it sets it
to the corresppnding vector entry. You remove the latter...

Thanks,

	tglx
