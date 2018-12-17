Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEEFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255932084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbeLQItH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:49:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51082 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbeLQItG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:49:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF390A78;
        Mon, 17 Dec 2018 00:49:05 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A89D43F5C0;
        Mon, 17 Dec 2018 00:49:03 -0800 (PST)
Subject: Re: [PATCH v7 01/25] arm64: Fix HCR.TGE status for NMI contexts
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        stable@vger.kernel.org
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
 <1544633245-6036-2-git-send-email-julien.thierry@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <19f8c91b-0879-30dd-09dd-c0657b53bb33@arm.com>
Date:   Mon, 17 Dec 2018 08:49:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544633245-6036-2-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2018 16:47, Julien Thierry wrote:
> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
> to interract with guest TLBs, switching from EL2&0 translation regime
> to EL1&0.
> 
> However, some non-maskable asynchronous event could happen while TGE is
> cleared like SDEI. Because of this address translation operations
> relying on EL2&0 translation regime could fail (tlb invalidation,
> userspace access, ...).
> 
> Fix this by properly setting HCR_EL2.TGE when entering NMI context and
> clear it if necessary when returning to the interrupted context.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: linux-arch@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/hardirq.h | 28 ++++++++++++++++++++++++++++
>  arch/arm64/kernel/irq.c          |  3 +++
>  include/asm-generic/hardirq.h    |  3 +++
>  include/linux/hardirq.h          |  2 ++
>  4 files changed, 36 insertions(+)
> 
> diff --git a/include/asm-generic/hardirq.h b/include/asm-generic/hardirq.h
> index d14214d..c33b53f20 100644
> --- a/include/asm-generic/hardirq.h
> +++ b/include/asm-generic/hardirq.h
> @@ -12,6 +12,9 @@
>  #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
>  #include <linux/irq.h>
>  
> +#define arch_nmi_enter()	do { } while (0)
> +#define arch_nmi_exit()		do { } while (0)
> +

As spotted by the build bot, this needs to go in include/linux/hardirq.h
under a #ifndef arch_nmi_enter.

>  #ifndef ack_bad_irq
>  static inline void ack_bad_irq(unsigned int irq)
>  {
> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> index 0fbbcdf..776a60f 100644
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -62,6 +62,7 @@ static inline void rcu_nmi_exit(void)
>  
>  #define nmi_enter()						\
>  	do {							\
> +		arch_nmi_enter();				\
>  		printk_nmi_enter();				\
>  		lockdep_off();					\
>  		ftrace_nmi_enter();				\
> @@ -80,6 +81,7 @@ static inline void rcu_nmi_exit(void)
>  		ftrace_nmi_exit();				\
>  		lockdep_on();					\
>  		printk_nmi_exit();				\
> +		arch_nmi_exit();				\
>  	} while (0)
>  
>  #endif /* LINUX_HARDIRQ_H */
> 

-- 
Julien Thierry
