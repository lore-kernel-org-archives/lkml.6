Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeFELbS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:31:18 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61529 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751572AbeFELbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:31:17 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="40759063"
Subject: Re: [patch 3/8] x86/apic: Provide apic_ack_irq()
To: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>, Song Liu <liu.song.a23@gmail.com>,
        Joerg Roedel <jroedel@suse.de>, Mike Travis <mike.travis@hpe.com>,
        <stable@vger.kernel.org>
References: <20180604162224.471925894@linutronix.de>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <94117bd8-352b-1077-e8ae-8722d7ec213f@cn.fujitsu.com>
Date: Tue, 5 Jun 2018 19:31:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180604162224.471925894@linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: C23954B41E80.AA595
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

At 06/04/2018 11:33 PM, Thomas Gleixner wrote:
> apic_ack_edge() is explicitely for handling interrupt affinity cleanup when
> interrupt remapping is not available or disable.
> 
> Remapped interrupts and also some of the platform specific special
> interrupts, e.g. UV, invoke ack_APIC_irq() directly.
> 
> To address the issue of failing an affinity update with -EBUSY the delayed
> affinity mechanism can be reused, but ack_APIC_irq() does not handle
> that. Adding this to ack_APIC_irq() is not possible, because that function
> is also used for exceptions and directly handled interrupts like IPIs.
> 
> Create a new function, which just contains the conditional invocation of
> irq_move_irq() and the final ack_APIC_irq(). Making the invocation of
> irq_move_irq() conditional avoids the out of line call if the pending bit
> is not set.
> 
> Reuse the new function in apic_ack_edge().
> 
> Preparatory change for the real fix
> 
> Fixes: dccfe3147b42 ("x86/vector: Simplify vector move cleanup")
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> Cc:stable@vger.kernel.org
> ---
>   arch/x86/include/asm/apic.h   |    2 ++
>   arch/x86/kernel/apic/vector.c |   10 ++++++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -436,6 +436,8 @@ static inline void apic_set_eoi_write(vo
>   
>   #endif /* CONFIG_X86_LOCAL_APIC */
>   
> +extern void apic_ack_irq(struct irq_data *data);
> +
>   static inline void ack_APIC_irq(void)
>   {
>   	/*
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -809,11 +809,17 @@ static int apic_retrigger_irq(struct irq
>   	return 1;
>   }
>   
> +void apic_ack_irq(struct irq_data *irqd)
> +{
> +	if (unlikely(irqd_is_setaffinity_pending(irqd)))

Affinity pending is also judged in

> +		irq_move_irq(irqd);

If we can remove the if(...) statement here

Thanks,
	dou

> +	ack_APIC_irq();
> +}
> +
>   void apic_ack_edge(struct irq_data *irqd)
>   {
>   	irq_complete_move(irqd_cfg(irqd));
> -	irq_move_irq(irqd);
> -	ack_APIC_irq();
> +	apic_ack_irq(irqd);
>   }
>   
>   static struct irq_chip lapic_controller = {
