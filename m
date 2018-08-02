Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E540C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3A9214FB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3A9214FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbeHBLjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:39:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36240 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeHBLjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:39:24 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flAE3-0002t1-EJ; Thu, 02 Aug 2018 11:48:55 +0200
Date:   Thu, 2 Aug 2018 11:48:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>
cc:     palmer@sifive.com, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, anup@brainfault.org,
        atish.patra@wdc.com, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, shorne@gmail.com
Subject: Re: [PATCH 5/9] RISC-V: implement low-level interrupt handling
In-Reply-To: <20180726143723.16585-6-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1808021147540.2037@nanos.tec.linutronix.de>
References: <20180726143723.16585-1-hch@lst.de> <20180726143723.16585-6-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018, Christoph Hellwig wrote:
> Add support for a routine that dispatches exceptions with the interrupt
> flags set to either the IPI or irqdomain code (and the clock source in the
> future).
> 
> Loosely based on the irq-riscv-int.c irqchip driver from the RISC-V tree.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/kernel/entry.S |  4 +--
>  arch/riscv/kernel/irq.c   | 52 ++++++++++++++++++++++++++++++++-------
>  2 files changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 9aaf6c986771..fa2c08e3c05e 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -168,8 +168,8 @@ ENTRY(handle_exception)
>  
>  	/* Handle interrupts */
>  	move a0, sp /* pt_regs */
> -	REG_L a1, handle_arch_irq
> -	jr a1
> +	move a1, s4 /* scause */
> +	tail do_IRQ

What's the reason for doing the whole exception dance in ASM ?

>  1:
>  	/* Exceptions run with interrupts enabled */
>  	csrs sstatus, SR_SIE

> +asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
> +{
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +
> +	irq_enter();
> +	switch (cause & ~INTERRUPT_CAUSE_FLAG) {
> +#ifdef CONFIG_SMP
> +	case INTERRUPT_CAUSE_SOFTWARE:
> +		/*
> +		 * We only use software interrupts to pass IPIs, so if a non-SMP
> +		 * system gets one, then we don't know what to do.
> +		 */
> +		riscv_software_interrupt();
> +		break;
> +#endif
> +	case INTERRUPT_CAUSE_EXTERNAL:
> +		handle_arch_irq(regs);
> +		break;
> +	default:
> +		panic("unexpected interrupt cause");
> +	}
> +	irq_exit();

Looks about right.

Thanks,

	tglx
