Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC28C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9347A2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfA1Lsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:48:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44030 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbfA1Lsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:48:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FB72EBD;
        Mon, 28 Jan 2019 03:48:53 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B85C3F59C;
        Mon, 28 Jan 2019 03:48:51 -0800 (PST)
Subject: Re: [PATCH v9 01/26] arm64: Fix HCR.TGE status for NMI contexts
To:     Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        stable@vger.kernel.org
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-2-git-send-email-julien.thierry@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <8e8c4f5b-5b83-7bbc-1b84-36d68e210968@arm.com>
Date:   Mon, 28 Jan 2019 11:48:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548084825-8803-2-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 21/01/2019 15:33, Julien Thierry wrote:
> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
> to interract with guest TLBs, switching from EL2&0 translation regime

(interact)


> to EL1&0.
> 
> However, some non-maskable asynchronous event could happen while TGE is
> cleared like SDEI. Because of this address translation operations
> relying on EL2&0 translation regime could fail (tlb invalidation,
> userspace access, ...).
> 
> Fix this by properly setting HCR_EL2.TGE when entering NMI context and
> clear it if necessary when returning to the interrupted context.

Yes please. This would not have been fun to debug!

Reviewed-by: James Morse <james.morse@arm.com>



I was looking for why we need core code to do this, instead of updating the
arch's call sites. Your 'irqdesc: Add domain handlers for NMIs' patch (pointed
to from the cover letter) is the reason: core-code calls nmi_enter()/nmi_exit()
itself.


Thanks,

James


> diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
> index 1473fc2..94b7481 100644
> --- a/arch/arm64/include/asm/hardirq.h
> +++ b/arch/arm64/include/asm/hardirq.h
> @@ -19,6 +19,7 @@
>  #include <linux/cache.h>
>  #include <linux/threads.h>
>  #include <asm/irq.h>
> +#include <asm/kvm_arm.h>

percpu.h?
sysreg.h?
barrier.h?


> @@ -37,6 +38,33 @@
>  
>  #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
>  
> +struct nmi_ctx {
> +	u64 hcr;
> +};
> +
> +DECLARE_PER_CPU(struct nmi_ctx, nmi_contexts);
> +
> +#define arch_nmi_enter()							\
> +	do {									\
> +		if (is_kernel_in_hyp_mode()) {					\
> +			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
> +			nmi_ctx->hcr = read_sysreg(hcr_el2);			\
> +			if (!(nmi_ctx->hcr & HCR_TGE)) {			\
> +				write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);	\
> +				isb();						\
> +			}							\
> +		}								\
> +	} while (0)
> +
> +#define arch_nmi_exit()								\
> +	do {									\
> +		if (is_kernel_in_hyp_mode()) {					\
> +			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
> +			if (!(nmi_ctx->hcr & HCR_TGE))				\
> +				write_sysreg(nmi_ctx->hcr, hcr_el2);		\
> +		}								\
> +	} while (0)
> +
>  static inline void ack_bad_irq(unsigned int irq)
>  {
>  	extern unsigned long irq_err_count;



> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> index 0fbbcdf..da0af63 100644
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -60,8 +60,14 @@ static inline void rcu_nmi_exit(void)
>   */
>  extern void irq_exit(void);
>  
> +#ifndef arch_nmi_enter
> +#define arch_nmi_enter()	do { } while (0)
> +#define arch_nmi_exit()		do { } while (0)
> +#endif
> +
>  #define nmi_enter()						\
>  	do {							\
> +		arch_nmi_enter();				\
>  		printk_nmi_enter();				\
>  		lockdep_off();					\
>  		ftrace_nmi_enter();				\
> @@ -80,6 +86,7 @@ static inline void rcu_nmi_exit(void)
>  		ftrace_nmi_exit();				\
>  		lockdep_on();					\
>  		printk_nmi_exit();				\
> +		arch_nmi_exit();				\
>  	} while (0)
>  
>  #endif /* LINUX_HARDIRQ_H */
> 

