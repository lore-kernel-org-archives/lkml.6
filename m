Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF12BC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B03B2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B03B2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbeGSPzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:55:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33356 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731645AbeGSPzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:55:02 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fgAaG-0001gR-AG; Thu, 19 Jul 2018 17:11:12 +0200
Date:   Thu, 19 Jul 2018 17:11:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Tian, Baofeng" <baofeng.tian@intel.com>
cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Debug: Add cpu registers dump in case of kernel panic
In-Reply-To: <EEBA739CCF11FE49B73E1FB4690F5EE649E2A6D0@SHSMSX101.ccr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1807191703390.1693@nanos.tec.linutronix.de>
References: <0038B620BAC72941BCBF48AEB892976C02CBD787@SHSMSX101.ccr.corp.intel.com> <EEBA739CCF11FE49B73E1FB4690F5EE649E2A6D0@SHSMSX101.ccr.corp.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018, Tian, Baofeng wrote:

> From: "Tian, Baofeng" <baofeng.tian@intel.com>
> Subject: [PATCH] Debug: Add cpu registers dump in case of kernel panic
> 
> When kernel panic, the value of cpu registers are needed for analyzing, through whole ramdump to restore the crash point.
>

Please use proper line breaks at around 78 characters.

> We store CPU registers to RAM before cpu stopped, then get them with whole ram dump after warm reset.Those registers are used in analysis of dumped RAM image.
>

This is explaining what the patch does but not really why. And it does not
explain the scope of what is stored and why that would be helpful.

> Signed-off-by: Baofeng, Tian <baofeng.tian@intel.com>
> Signed-off-by: Emmanuel Berthier <emmanuel.berthier@intel.com>

This SOB chain is wrong. How is Emmmanuel involved here? He's even cc'ed on this.

> ---
>  arch/x86/kernel/smp.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c index 5c574df..484831d 100644
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -117,6 +117,20 @@
>  static atomic_t stopping_cpu = ATOMIC_INIT(-1);  static bool smp_no_nmi_ipi = false;
>  
> +static DEFINE_PER_CPU(struct pt_regs, cpu_regs);
> +
> +/* Store regs of this CPU for RAM dump decoding help */ static inline 
> +void store_regs(struct pt_regs *regs) {

That's surely not kernel coding style.

> +	struct pt_regs *print_regs;

print_regs ? There is nothing printed here.

> +
> +	print_regs = &get_cpu_var(cpu_regs);
> +	crash_setup_regs(print_regs, regs);
> +
> +	/* Flush CPU cache */
> +	wbinvd();
> +}
> +
>  /*
>   * this function sends a 'reschedule' IPI to another CPU.
>   * it goes straight through and wastes no time serializing @@ -163,6 +177,7 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
>  	if (raw_smp_processor_id() == atomic_read(&stopping_cpu))
>  		return NMI_HANDLED;
>  
> +	store_regs(regs);
>  	cpu_emergency_vmxoff();
>  	stop_this_cpu(NULL);
>  
> @@ -173,9 +188,10 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
>   * this function calls the 'stop' function on all other CPUs in the system.
>   */
>  
> -asmlinkage __visible void smp_reboot_interrupt(void)
> +__visible void smp_reboot_interrupt(struct pt_regs *regs)
>  {
>  	ipi_entering_ack_irq();
> +	store_regs(regs);
>  	cpu_emergency_vmxoff();
>  	stop_this_cpu(NULL);
>  	irq_exit();
> @@ -247,6 +263,7 @@ static void native_stop_other_cpus(int wait)
>  	}
>  
>  finish:
> +	store_regs(NULL);

How is storing regs _AFTER_ doing a lots of work helpful?

>  	local_irq_save(flags);
>  	disable_local_APIC();
>  	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));

I'm still not seeing how all that is helpful, so I'm waiting for a new
version with proper explanations.

Thanks,

	tglx
