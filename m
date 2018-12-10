Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75B1C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F932082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F932082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeLJOsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:48:10 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55590 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbeLJOsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:48:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2736C15AD;
        Mon, 10 Dec 2018 06:48:09 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 441273F59C;
        Mon, 10 Dec 2018 06:48:05 -0800 (PST)
Subject: Re: [RESEND PATCH v2] clocksource/arm_arch_timer: fix a lockdep
 warning
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
Cc:     mark.rutland@arm.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        longman@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1543877121-4098-1-git-send-email-cai@gmx.us>
 <20181210135228.49751-1-cai@lca.pw>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <68e11ecf-f0b3-6486-63af-c05086c947c3@arm.com>
Date:   Mon, 10 Dec 2018 14:48:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210135228.49751-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2018 13:52, Qian Cai wrote:
> Booting this Huawei TaiShan 2280 arm64 server generated this lockdep
> warning.
> 
> [    0.000000]  lockdep_assert_cpus_held+0x50/0x60
> [    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
> [    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
> [    0.000000]  arch_timer_acpi_init+0x274/0x6ac
> [    0.000000]  acpi_table_parse+0x1ac/0x218
> [    0.000000]  __acpi_probe_device_table+0x164/0x1ec
> [    0.000000]  timer_probe+0x1bc/0x254
> [    0.000000]  time_init+0x44/0x98
> [    0.000000]  start_kernel+0x4ec/0x7d4
> 
> This is due to the commit cb538267ea1e ("jump_label/lockdep: Assert we hold
> the hotplug lock for _cpuslocked() operations").
> 
> Since it is applying a global workaround to all CPUs here, it did not hold
> any CPU locks in this path.
> 
> arch_timer_acpi_init
>   arch_timer_check_ool_workaround(ate_match_acpi_oem_info, table)
>     arch_timer_enable_workaround(wa, local = false)
>       for_each_possible_cpu()
> 	per_cpu()
> 
> There is also another path did not have any CPU lock.
> 
> time_init
>   clocksource_probe
>     arch_timer_of_init
>       arch_timer_check_ool_workaround(ate_match_dt, np)
>         arch_timer_enable_workaround(wa, local = false)
> 
> When hot-adding a CPU, it will go with a slightly different route.
> 
> arch_timer_starting_cpu
>   __arch_timer_setup
>     arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL)
>       arch_timer_enable_workaround(wa, local = true)
>         __this_cpu_write()
> 
> Hence, deal with them differently.
> 
> Fixes: 450f9689f294 (clocksource/arm_arch_timer: Use
> static_branch_enable_cpuslocked())
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: fix the root cause instead of a workaround.
> 
>  drivers/clocksource/arm_arch_timer.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 9a7d4dc00b6e..81dca7d31d13 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -492,17 +492,20 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
>  
>  	if (local) {
>  		__this_cpu_write(timer_unstable_counter_workaround, wa);
> +
> +		/*
> +		 * Use the locked version, as we're called from the CPU
> +		 * hotplug framework. Otherwise, we end-up in
> +		 * deadlock-land.
> +		 */
> +		static_branch_enable_cpuslocked(&arch_timer_read_ool_enabled);

I have the ugly feeling that it breaks the (equally ugly) big-little
stuff where the boot CPU is affected. In this context, you'd end-up
without the lock being taken and you'll get the same splat.

We could start testing the CPU number, but Peter's approach seem much
more palatable to me.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
