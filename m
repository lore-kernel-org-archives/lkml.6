Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3391FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A47214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A47214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbeKVEWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:22:13 -0500
Received: from foss.arm.com ([217.140.101.70]:56176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729279AbeKVEWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:22:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF4D23617;
        Wed, 21 Nov 2018 09:46:51 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9EA073F5AF;
        Wed, 21 Nov 2018 09:46:51 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 61FEA1AE100A; Wed, 21 Nov 2018 17:47:07 +0000 (GMT)
Date:   Wed, 21 Nov 2018 17:47:07 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        rppt@linux.vnet.ibm.com, mhocko@suse.com,
        ard.biesheuvel@linaro.org, andrew.murray@arm.com,
        james.morse@arm.com, marc.zyngier@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm64: Early boot time stamps
Message-ID: <20181121174706.GC9801@arm.com>
References: <20181120144340.30201-1-pasha.tatashin@soleen.com>
 <20181120144340.30201-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120144340.30201-2-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Tue, Nov 20, 2018 at 09:43:40AM -0500, Pavel Tatashin wrote:
> Allow printk time stamps/sched_clock() to be available from the early
> boot.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/kernel/setup.c            | 25 +++++++++++++++++++++++++
>  drivers/clocksource/arm_arch_timer.c |  8 ++++----
>  include/clocksource/arm_arch_timer.h |  3 +++
>  3 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index f4fc1e0544b7..7a43e63b737b 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -40,6 +40,7 @@
>  #include <linux/efi.h>
>  #include <linux/psci.h>
>  #include <linux/sched/task.h>
> +#include <linux/sched_clock.h>
>  #include <linux/mm.h>
>  
>  #include <asm/acpi.h>
> @@ -279,8 +280,32 @@ arch_initcall(reserve_memblock_reserved_regions);
>  
>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>  
> +/*
> + * Get time stamps available early in boot, useful to identify boot time issues
> + * from the early boot.
> + */
> +static __init void sched_clock_early_init(void)
> +{
> +	u64 freq = arch_timer_get_cntfrq();
> +
> +	/*
> +	 * The arm64 boot protocol mandates that CNTFRQ_EL0 reflects
> +	 * the timer frequency. To avoid breakage on misconfigured
> +	 * systems, do not register the early sched_clock if the
> +	 * programmed value if zero. Other random values will just
> +	 * result in random output.
> +	 */
> +	if (!freq)
> +		return;
> +
> +	arch_timer_read_counter = arch_counter_get_cntvct;

Why do you need to assign this here?

> +	sched_clock_register(arch_timer_read_counter, ARCH_TIMER_NBITS, freq);

arch_timer_read_counter can be reassigned once the arm_arch_timer driver
has probed; what stops this from being unused as the sched_clock after that
has happened? I worry that toggling the function pointer could lead to
sched_clock() going backwards.

> +}
> +
>  void __init setup_arch(char **cmdline_p)
>  {
> +	sched_clock_early_init();
> +
>  	init_mm.start_code = (unsigned long) _text;
>  	init_mm.end_code   = (unsigned long) _etext;
>  	init_mm.end_data   = (unsigned long) _edata;

The patch from this point onwards just looks like a refactoring to me which
should be independent of adding early printk timestamps. Also, it doesn't
update the vdso logic, which hardwires a 56-bit mask for the counter values.

Will

> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 9a7d4dc00b6e..e4843ad48bd3 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -175,13 +175,13 @@ static struct clocksource clocksource_counter = {
>  	.name	= "arch_sys_counter",
>  	.rating	= 400,
>  	.read	= arch_counter_read,
> -	.mask	= CLOCKSOURCE_MASK(56),
> +	.mask	= CLOCKSOURCE_MASK(ARCH_TIMER_NBITS),
>  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
>  };
>  
>  static struct cyclecounter cyclecounter __ro_after_init = {
>  	.read	= arch_counter_read_cc,
> -	.mask	= CLOCKSOURCE_MASK(56),
> +	.mask	= CLOCKSOURCE_MASK(ARCH_TIMER_NBITS),
>  };
>  
>  struct ate_acpi_oem_info {
> @@ -963,8 +963,8 @@ static void __init arch_counter_register(unsigned type)
>  	timecounter_init(&arch_timer_kvm_info.timecounter,
>  			 &cyclecounter, start_count);
>  
> -	/* 56 bits minimum, so we assume worst case rollover */
> -	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
> +	sched_clock_register(arch_timer_read_counter, ARCH_TIMER_NBITS,
> +			     arch_timer_rate);
>  }
>  
>  static void arch_timer_stop(struct clock_event_device *clk)
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index 349e5957c949..c485512e1d01 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -71,6 +71,9 @@ enum arch_timer_spi_nr {
>  #define ARCH_TIMER_EVT_STREAM_FREQ				\
>  	(USEC_PER_SEC / ARCH_TIMER_EVT_STREAM_PERIOD_US)
>  
> +/* 56 bits minimum, so we assume worst case rollover */
> +#define	ARCH_TIMER_NBITS		56
> +
>  struct arch_timer_kvm_info {
>  	struct timecounter timecounter;
>  	int virtual_irq;
> -- 
> 2.19.1
> 
