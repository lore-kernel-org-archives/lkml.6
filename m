Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714D4C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442E12085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfAWQtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:49:06 -0500
Received: from foss.arm.com ([217.140.101.70]:44100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfAWQtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:49:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BA3AEBD;
        Wed, 23 Jan 2019 08:49:06 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBBDD3F237;
        Wed, 23 Jan 2019 08:49:04 -0800 (PST)
Subject: Re: [PATCH] ARM: prevent tracing IPI_CPU_BACKTRACE
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <Marc.Zyngier@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1538019697-14673-1-git-send-email-chunyan.zhang@unisoc.com>
 <1539851039-15778-1-git-send-email-zhang.chunyan@linaro.org>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <b7a99b4e-c269-e2ac-81ab-226b80cdd099@arm.com>
Date:   Wed, 23 Jan 2019 16:49:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1539851039-15778-1-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/10/2018 09:23, Chunyan Zhang wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When function tracing for IPIs is enabled, we get a warning for an
> overflow of the ipi_types array with the IPI_CPU_BACKTRACE type
> as triggered by raise_nmi():
> 
> arch/arm/kernel/smp.c: In function 'raise_nmi':
> arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
> 	trace_ipi_raise(target, ipi_types[ipinr]);
> 
> This is a correct warning as we actually overflow the array here.
> 
> This patch raise_nmi() to call __smp_cross_call() instead of
> smp_cross_call(), to avoid calling into ftrace. For clarification,
> I'm also adding a two new code comments describing how this one
> is special.
> 
> The warning appears to have shown up after patch e7273ff49acf
> ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI"), which
> changed the number assignment from '15' to '8', but as far as I can
> tell has existed since the IPI tracepoints were first introduced.
> If we decide to backport this patch to stable kernels, we probably
> need to backport e7273ff49acf as well.
> 
> Resubmitting this patch is because that I found coverity is complaining
> the issue this patch fixed, and also I got the traces like below:
> "ipi_raise: target_mask=00000001 (machine_suspend)" which actually was
> the TPS of suspend_resume[1] rather that ipi_raise.
> 

What's the status on this patch? it does not seem to be in v5.0-rc3 nor
linux-next and looks like an actual issue.

Also, I'm assuming the patch is avoiding the tracing of
IPI_CPU_BACKTRACE because the tracing is not NMI safe. It would be good
to have a comment about that either near NR_IPI or ipi_types stating why
this IPI is excluded.

Thanks,

> [1]
> https://elixir.bootlin.com/linux/latest/source/kernel/power/suspend.c#L80
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: e7273ff49acf ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI")
> Fixes: 365ec7b17327 ("ARM: add IPI tracepoints") # v3.17
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  arch/arm/include/asm/hardirq.h | 1 +
>  arch/arm/kernel/smp.c          | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
> index cba23ea..7a88f16 100644
> --- a/arch/arm/include/asm/hardirq.h
> +++ b/arch/arm/include/asm/hardirq.h
> @@ -6,6 +6,7 @@
>  #include <linux/threads.h>
>  #include <asm/irq.h>
>  
> +/* number of IPIS _not_ including IPI_CPU_BACKTRACE */
>  #define NR_IPI	7
>  
>  typedef struct {
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 0978282..ddd48e2 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -75,6 +75,10 @@ enum ipi_msg_type {
>  	IPI_CPU_STOP,
>  	IPI_IRQ_WORK,
>  	IPI_COMPLETION,
> +	/*
> +	 * CPU_BACKTRACE is special and not included in NR_IPI
> +	 * or tracable with trace_ipi_*
> +	 */
>  	IPI_CPU_BACKTRACE,
>  	/*
>  	 * SGI8-15 can be reserved by secure firmware, and thus may
> @@ -755,7 +759,7 @@ core_initcall(register_cpufreq_notifier);
>  
>  static void raise_nmi(cpumask_t *mask)
>  {
> -	smp_cross_call(mask, IPI_CPU_BACKTRACE);
> +	__smp_cross_call(mask, IPI_CPU_BACKTRACE);
>  }
>  
>  void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> 

-- 
Julien Thierry
