Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u8/N5M74"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C0F9606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeFFP1M (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:27:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37354 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbeFFP1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:27:09 -0400
Subject: Re: [RFC 2/2] x86, tsc: Enable clock for ealry printk timestamp
To: Feng Tang <feng.tang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, alek.du@intel.com,
        arjan@linux.intel.com, len.brown@intel.com
References: <1527672059-6225-1-git-send-email-feng.tang@intel.com>
 <1527672059-6225-2-git-send-email-feng.tang@intel.com>
 <20180531135542.4j7w7bxsw43ydx3j@pathway.suse.cz>
 <20180531155210.GL12180@hirez.programming.kicks-ass.net>
 <20180601161213.tm44nhrhwfxa2767@shbuild888>
 <20180606093833.vqg47yhdq7mnj2kp@shbuild888>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <db1b5457-bc8e-3994-3802-d8bcdd14e485@oracle.com>
Date: Wed, 6 Jun 2018 11:25:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606093833.vqg47yhdq7mnj2kp@shbuild888>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8916 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806060175
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Feng,

Using a global variable for this is not going to work, because you are adding a conditional branch and a load to a very hot path for the live of the system, not only for the duration of the boot.

Pavel

>  
> +int tsc_inited;
>  /*
>   * TSC can be unstable due to cpufreq or due to unsynced TSCs
>   */
> @@ -192,7 +193,7 @@ static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_
>   */
>  u64 native_sched_clock(void)
>  {
> -	if (static_branch_likely(&__use_tsc)) {
> +	if (static_branch_likely(&__use_tsc) || tsc_inited) {
>  		u64 tsc_now = rdtsc();
>  
>  		/* return the value in ns */
> @@ -1387,30 +1391,16 @@ static int __init init_tsc_clocksource(void)
>   */
>  device_initcall(init_tsc_clocksource);
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
>  void __init tsc_init(void)
>  {
>  	u64 lpj, cyc;
>  	int cpu;
>  
> +	if (tsc_inited)
> +		return;
> +
> +	tsc_inited = 1;
> +
>  	if (!boot_cpu_has(X86_FEATURE_TSC)) {
>  		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
>  		return;
> @@ -1474,11 +1464,15 @@ void __init tsc_init(void)
>  	lpj = ((u64)tsc_khz * 1000);
>  	do_div(lpj, HZ);
>  	lpj_fine = lpj;
> +	loops_per_jiffy = lpj;
>  
>  	use_tsc_delay();
>  
>  	check_system_tsc_reliable();
>  
> +	extern void early_set_sched_clock_stable(u64 sched_clock_offset);
> +	early_set_sched_clock_stable(div64_u64(rdtsc() * 1000, tsc_khz));
> +
>  	if (unsynchronized_tsc()) {
>  		mark_tsc_unstable("TSCs unsynchronized");
>  		return;
> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index 10c83e7..6c5c22d 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -119,6 +119,13 @@ static void __scd_stamp(struct sched_clock_data *scd)
>  	scd->tick_raw = sched_clock();
>  }
>  
> +
> +void early_set_sched_clock_stable(u64 sched_clock_offset)
> +{
> +	__sched_clock_offset = sched_clock_offset;
> +	static_branch_enable(&__sched_clock_stable);
> +}
> +
>  static void __set_sched_clock_stable(void)
>  {
>  	struct sched_clock_data *scd;
> @@ -342,12 +349,14 @@ static u64 sched_clock_remote(struct sched_clock_data *scd)
>   *
>   * See cpu_clock().
>   */
> +
> +extern int tsc_inited;
>  u64 sched_clock_cpu(int cpu)
>  {
>  	struct sched_clock_data *scd;
>  	u64 clock;
>  
> -	if (sched_clock_stable())
> +	if (sched_clock_stable() || tsc_inited)
>  		return sched_clock() + __sched_clock_offset;
>  
>  	if (unlikely(!sched_clock_running))
> 	   
> 
> 
> 
>>>
>>> If you have a dodgy part (sorry SKX), you'll just have to live with
>>> sched_clock starting late(r).
>>>
>>> Do not cobble things on the side, try and get the normal things running
>>> earlier.
