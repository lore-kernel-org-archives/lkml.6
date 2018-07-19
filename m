Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54C3C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C312206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C312206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeGSGPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:15:00 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:55348 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbeGSGPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:15:00 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42404836"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Jul 2018 13:33:33 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 5EF804B625E5;
        Thu, 19 Jul 2018 13:33:30 +0800 (CST)
Received: from localhost.localdomain (10.167.226.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Thu, 19 Jul 2018 13:33:30 +0800
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
To:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        <steven.sistare@oracle.com>, <daniel.m.jordan@oracle.com>,
        <linux@armlinux.org.uk>, <schwidefsky@de.ibm.com>,
        <heiko.carstens@de.ibm.com>, <john.stultz@linaro.org>,
        <sboyd@codeaurora.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <hpa@zytor.com>, <peterz@infradead.org>,
        <prarit@redhat.com>, <feng.tang@intel.com>, <pmladek@suse.com>,
        <gnomes@lxorguk.ukuu.org.uk>, <linux-s390@vger.kernel.org>,
        <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <pbonzini@redhat.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-21-pasha.tatashin@oracle.com>
Message-ID: <4f0933a3-27b4-5468-83f5-af9b90842812@cn.fujitsu.com>
Date:   Thu, 19 Jul 2018 13:33:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180718022211.6259-21-pasha.tatashin@oracle.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 5EF804B625E5.ACF2F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Pavel

I am sorry, I didn't point out typo clearly in the previous version.
Please see the concerns below. ;-)

At 07/18/2018 10:22 AM, Pavel Tatashin wrote:
> During boot tsc is calibrated twice: once in tsc_early_delay_calibrate(),
> and the second time in tsc_init().
> 
> Rename tsc_early_delay_calibrate() to tsc_early_init(), and rework it so
> the calibration is done only early, and make tsc_init() to use the values
> already determined in tsc_early_init().
> 
> Sometimes it is not possible to determine tsc early, as the subsystem that
> is required is not yet initialized, in such case try again later in
> tsc_init().
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>   arch/x86/include/asm/tsc.h |  2 +-
>   arch/x86/kernel/setup.c    |  2 +-
>   arch/x86/kernel/tsc.c      | 86 ++++++++++++++++++++------------------
>   3 files changed, 48 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
> index 2701d221583a..c4368ff73652 100644
> --- a/arch/x86/include/asm/tsc.h
> +++ b/arch/x86/include/asm/tsc.h
> @@ -33,7 +33,7 @@ static inline cycles_t get_cycles(void)
>   extern struct system_counterval_t convert_art_to_tsc(u64 art);
>   extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
>   
> -extern void tsc_early_delay_calibrate(void);
> +extern void tsc_early_init(void);
>   extern void tsc_init(void);
>   extern void mark_tsc_unstable(char *reason);
>   extern int unsynchronized_tsc(void);
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 7490de925a81..5d32c55aeb8b 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1014,6 +1014,7 @@ void __init setup_arch(char **cmdline_p)
>   	 */
>   	init_hypervisor_platform();
>   
> +	tsc_early_init();
>   	x86_init.resources.probe_roms();
>   
>   	/* after parse_early_param, so could debug it */
> @@ -1199,7 +1200,6 @@ void __init setup_arch(char **cmdline_p)
>   
>   	memblock_find_dma_reserve();
>   
> -	tsc_early_delay_calibrate();
>   	if (!early_xdbc_setup_hardware())
>   		early_xdbc_register_console();
>   
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 186395041725..bc8eb82050a3 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -33,6 +33,8 @@ EXPORT_SYMBOL(cpu_khz);
>   unsigned int __read_mostly tsc_khz;
>   EXPORT_SYMBOL(tsc_khz);
>   
> +#define KHZ	1000
> +
>   /*
>    * TSC can be unstable due to cpufreq or due to unsynced TSCs
>    */
> @@ -1335,34 +1337,10 @@ static int __init init_tsc_clocksource(void)
>    */
>   device_initcall(init_tsc_clocksource);
>   
> -void __init tsc_early_delay_calibrate(void)
> -{
> -	unsigned long lpj;
> -
> -	if (!boot_cpu_has(X86_FEATURE_TSC))
> -		return;
> -
> -	cpu_khz = x86_platform.calibrate_cpu();
> -	tsc_khz = x86_platform.calibrate_tsc();
> -
> -	tsc_khz = tsc_khz ? : cpu_khz;
> -	if (!tsc_khz)
> -		return;
> -
> -	lpj = tsc_khz * 1000;
> -	do_div(lpj, HZ);
> -	loops_per_jiffy = lpj;
> -}
> -
> -void __init tsc_init(void)
> +static bool determine_cpu_tsc_frequncies(void)

this function need to be mark as __init.

And a typo here: frequency, s/frequncies/frequencies

>   {
> -	u64 lpj, cyc;
> -	int cpu;
> -
> -	if (!boot_cpu_has(X86_FEATURE_TSC)) {
> -		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
> -		return;
> -	}
> +	/* Make sure that cpu and tsc are not already calibrated */
> +	WARN_ON(cpu_khz || tsc_khz);
>   
>   	cpu_khz = x86_platform.calibrate_cpu();
>   	tsc_khz = x86_platform.calibrate_tsc();
> @@ -1377,20 +1355,51 @@ void __init tsc_init(void)
>   	else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
>   		cpu_khz = tsc_khz;
>   
> -	if (!tsc_khz) {
> -		mark_tsc_unstable("could not calculate TSC khz");
> -		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
> -		return;
> -	}
> +	if (tsc_khz == 0)
> +		return false;
>   
>   	pr_info("Detected %lu.%03lu MHz processor\n",
> -		(unsigned long)cpu_khz / 1000,
> -		(unsigned long)cpu_khz % 1000);
> +		(unsigned long)cpu_khz / KHZ,
> +		(unsigned long)cpu_khz % KHZ);
>   
>   	if (cpu_khz != tsc_khz) {
>   		pr_info("Detected %lu.%03lu MHz TSC",
> -			(unsigned long)tsc_khz / 1000,
> -			(unsigned long)tsc_khz % 1000);
> +			(unsigned long)tsc_khz / KHZ,
> +			(unsigned long)tsc_khz % KHZ);
> +	}

this curly brackets can be removed

> +	return true;
> +}
> +
> +static unsigned long get_loops_per_jiffy(void)

mark as __init as well.

> +{
> +	unsigned long lpj = tsc_khz * KHZ;
> +
> +	do_div(lpj, HZ);
> +	return lpj;
> +}
> +
> +void __init tsc_early_init(void)
> +{
> +	if (!boot_cpu_has(X86_FEATURE_TSC))
> +		return;
> +	if (!determine_cpu_tsc_frequncies())
> +		return;
> +	loops_per_jiffy = get_loops_per_jiffy();
> +}
> +
> +void __init tsc_init(void)
> +{
> +	if (!boot_cpu_has(X86_FEATURE_TSC)) {
> +		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
> +		return;
> +	}
> +
> +	if (!tsc_khz) {
> +		/* We failed to determine frequencies earlier, try again */
> +		if (!determine_cpu_tsc_frequncies()) {

Missing "setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER)" for local
APIC;

Thanks,	
	dou
> +			mark_tsc_unstable("could not calculate TSC khz");
> +			return;
> +		}
>   	}
>   
>   	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
> @@ -1413,10 +1422,7 @@ void __init tsc_init(void)
>   	if (!no_sched_irq_time)
>   		enable_sched_clock_irqtime();
>   
> -	lpj = ((u64)tsc_khz * 1000);
> -	do_div(lpj, HZ);
> -	lpj_fine = lpj;
> -
> +	lpj_fine = get_loops_per_jiffy();
>   	use_tsc_delay();
>   
>   	check_system_tsc_reliable();
> 


