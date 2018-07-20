Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D439AECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F7C20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F7C20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeGTHKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:10:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58282 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbeGTHKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:10:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A7B27A9;
        Thu, 19 Jul 2018 23:23:24 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 110D73F246;
        Thu, 19 Jul 2018 23:23:20 -0700 (PDT)
Date:   Fri, 20 Jul 2018 07:23:15 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, hoeun.ryu@gmail.com,
        adobriyan@gmail.com, zhizhouzhang@asrmicro.com,
        suzuki.poulose@arm.com, james.morse@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, Abhimanyu Kapur <abhimany@codeaurora.org>
Subject: Re: [PATCH] ARM64: smp: Fix cpu_up() racing with sys_reboot
Message-ID: <20180720062314.7qh23yfq2o5jciuh@salmiak>
References: <1532038726-3376-1-git-send-email-vnkgutta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532038726-3376-1-git-send-email-vnkgutta@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 03:18:46PM -0700, Venkata Narendra Kumar Gutta wrote:
> Nothing stops a process from hotplugging in a CPU concurrently
> with a sys_reboot() call. In such a situation we could have
> ipi_cpu_stop() mark a cpu as 'offline' and _cpu_up() ignore the
> fact that the CPU is not really offline and call the
> CPU_UP_PREPARE notifier. When this happens stop_machine code will
> complain that the cpu thread already exists and BUG_ON().
> 
> CPU0                      CPU1
> 
>  sys_reboot()
>  kernel_restart()
>  machine_restart()
>  machine_shutdown()
>  smp_send_stop()

From a quick look arm64's machine_restart() disables IRQs, calls
smp_send_stop(), then calls one of:

* efi_reboot()
* arm_pm_restart()
* do_kernel_restart()

... and I can't see any of these calling machine_shutdown() directly.

How does machine_shutdown() get called? Is that somewhere in the restart_list
associated with do_kernel_restart?

>  ...                   ipi_cpu_stop()
> 		       set_cpu_online(1, false)
>                        local_irq_disable()
>                        while(1)
>         <PREEMPT>

Given IRQs are disabled in machine_restart(), I don't understand how this
preemption can occur. Where do they get re-enabled?

>  cpu_up()
>  _cpu_up()
>  if (!cpu_online(1))
>  __cpu_notify(CPU_UP_PREPARE...)
> 
>  cpu_stop_cpu_callback()
>  BUG_ON(stopper->thread)
> 
> This is easily reproducible by hotplugging in and out in a tight
> loop while also rebooting.

Is this reproducible with mainline? e.g. v4.18-rc5?

I've packed away my HW in preparation for an office move, but I might be able
to give this a go in a VM.

> Since the CPU is not really offline and hasn't gone through the
> proper steps to be marked as such, let's mark the CPU as inactive.
> This is just as easily testable as online and avoids any possibility
> of _cpu_up() trying to bring the CPU back online when it never was
> offline to begin with. Based on the similar patchset by for arm
> targets 040c163( "ARM: smp: Fix cpu_up() racing with sys_reboot)"

Is this in mainline?

Looking at v4.18-rc5 I don't see arm's ipi_cpu_stop touching the active mask.

Thanks,
Mark.

> 
> Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> ---
>  arch/arm64/kernel/smp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 2faa986..adee4d3 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -790,7 +790,7 @@ void arch_irq_work_raise(void)
>   */
>  static void ipi_cpu_stop(unsigned int cpu)
>  {
> -	set_cpu_online(cpu, false);
> +	set_cpu_active(cpu, false);
>  
>  	local_daif_mask();
>  	sdei_mask_local_cpu();
> @@ -925,10 +925,10 @@ void smp_send_stop(void)
>  
>  	/* Wait up to one second for other CPUs to stop */
>  	timeout = USEC_PER_SEC;
> -	while (num_online_cpus() > 1 && timeout--)
> +	while (num_active_cpus() > 1 && timeout--)
>  		udelay(1);
>  
> -	if (num_online_cpus() > 1)
> +	if (num_active_cpus() > 1)
>  		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
>  			   cpumask_pr_args(cpu_online_mask));
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
