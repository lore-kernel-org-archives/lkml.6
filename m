Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE532C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D10320836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FLwge6MU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D10320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbeFTABj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:01:39 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55474 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeFTABh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:01:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5JNx0DZ046119;
        Wed, 20 Jun 2018 00:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=shkV2Dfc2U4CBg2R3KpEn+ysbz2A3EjuqvrTCQno8u8=;
 b=FLwge6MUrGljvV3BpNGA9lEK9D5S8iKMyeu7YhdmCW+Ce82LWuqclY+R+w9hmWlMtgWn
 g3ejOkRopVydhWsqP8CPnrseswieQoCuGrdhycaJcC/vWRgV/MWG3x4u7UIAqnB9IFX5
 Tf+aVz1jU+5/cpSuVnEX3gpo8mJAvJ+Mw3/KoAd7GPSVdzIzWR8GWLlpU1PzKYtgwRZm
 rtH/ZRx2JPU9rVCbOBYuK5QEd1K7hl2Mg9cLLarl+I0Ufk7QS08U3VHcJYmwpiEcBI/X
 GAXd4vTu0vd566UxgXx0FFSltTRd3cX1Z+r8Al3EN+pTJ3+6ZNI24Cyk/f+7fawjcVh+ iw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jmr2mjd19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 00:00:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5K00fIl018026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 00:00:41 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5K00dZw011129;
        Wed, 20 Jun 2018 00:00:39 GMT
Received: from [10.39.237.55] (/10.39.237.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 17:00:39 -0700
Subject: Re: [PATCH v10 7/7] x86/tsc: use tsc early
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
 <20180615174204.30581-8-pasha.tatashin@oracle.com>
 <alpine.DEB.2.21.1806192335390.10546@nanos.tec.linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <ebec563b-7bde-1121-487f-b6ec87c025a1@oracle.com>
Date:   Tue, 19 Jun 2018 20:00:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806192335390.10546@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/19/2018 07:52 PM, Thomas Gleixner wrote:
> On Fri, 15 Jun 2018, Pavel Tatashin wrote:
> 
>> tsc_early_init():
>> Determines offset, shift and multiplier for the early clock based on the
>> TSC frequency.
>>
>> tsc_early_fini()
>> Implement the finish part of early tsc feature, prints message about the
>> offset, which can be useful to find out how much time was spent in post and
>> boot manager (if TSC starts from 0 during boot)
>>
>> sched_clock_early():
>> TSC based implementation of early clock and is called from sched_clock().
>>
>> start_early_clock():
>> Calls tsc_early_init(), and makes sched_clock() to use early boot clock
>>
>> set_final_clock():
>> Sets the final clock which is either platform specific or
>> native_sched_clock(). Also calls tsc_early_fini() if early clock was
>> previously initialized.
>>
>> Call start_early_clock() to start using early boot time stamps
>> functionality on the supported x86 platforms, and call set_final_clock() to
>> finish this feature and switch back to the default clock. The supported x86
>> systems are those where TSC frequency is determined early in boot.
> 
> Lots of functions for dubious value.
>   
>> +static struct cyc2ns_data  cyc2ns_early;
>> +
>> +static u64 sched_clock_early(void)
>> +{
>> +	u64 ns = mul_u64_u32_shr(rdtsc(), cyc2ns_early.cyc2ns_mul,
>> +				 cyc2ns_early.cyc2ns_shift);
>> +	return ns + cyc2ns_early.cyc2ns_offset;
>> +}
>> +
>> +/*
>> + * Initialize clock for early time stamps
>> + */
>> +static void __init tsc_early_init(unsigned int khz)
>> +{
>> +	clocks_calc_mult_shift(&cyc2ns_early.cyc2ns_mul,
>> +			       &cyc2ns_early.cyc2ns_shift,
>> +			       khz, NSEC_PER_MSEC, 0);
>> +	cyc2ns_early.cyc2ns_offset = -sched_clock_early();
>> +}
>> +
>> +/*
>> + * Finish clock for early time stamps, and hand over to permanent clock by
>> + * setting __sched_clock_offset appropriately for continued time keeping.
>> + */
>> +static void __init tsc_early_fini(void)
>> +{
>> +	unsigned long long t;
>> +	unsigned long r;
>> +
>> +	t = -cyc2ns_early.cyc2ns_offset;
>> +	r = do_div(t, NSEC_PER_SEC);
>> +
>> +	__sched_clock_offset = sched_clock_early() - sched_clock();
>> +	pr_info("early sched clock is finished, offset [%lld.%09lds]\n", t, r);
>> +}
>> +
>> +#ifdef CONFIG_PARAVIRT
>> +static inline void __init start_early_clock(void)
>> +{
>> +	tsc_early_init(tsc_khz);
>> +	pv_time_ops.active_sched_clock = sched_clock_early;
>> +}
>> +
>> +static inline void __init set_final_clock(void)
>> +{
>> +	pv_time_ops.active_sched_clock = pv_time_ops.sched_clock;
>> +
>> +	/* We did not have early sched clock if multiplier is 0 */
>> +	if (cyc2ns_early.cyc2ns_mul)
>> +		tsc_early_fini();
>> +}
>> +#else /* CONFIG_PARAVIRT */
>> +/*
>> + * For native clock we use two switches static and dynamic, the static switch is
>> + * initially true, so we check the dynamic switch, which is initially false.
>> + * Later  when early clock is disabled, we can alter the static switch in order
>> + * to avoid branch check on every sched_clock() call.
>> + */
>> +static bool __tsc_early;
>> +static DEFINE_STATIC_KEY_TRUE(__tsc_early_static);
>> +
>> +static inline void __init start_early_clock(void)
>> +{
>> +	tsc_early_init(tsc_khz);
>> +	__tsc_early = true;
>> +}
>> +
>> +static inline void __init set_final_clock(void)
>> +{
>> +	__tsc_early = false;
>> +	static_branch_disable(&__tsc_early_static);
>> +
>> +	/* We did not have early sched clock if multiplier is 0 */
>> +	if (cyc2ns_early.cyc2ns_mul)
>> +		tsc_early_fini();
>> +}
>> +#endif /* CONFIG_PARAVIRT */
>> +
>>  /*
>>   * Scheduler clock - returns current time in nanosec units.
>>   */
>> @@ -194,6 +272,13 @@ u64 native_sched_clock(void)
>>  		return cycles_2_ns(tsc_now);
>>  	}
>>  
>> +#ifndef CONFIG_PARAVIRT
>> +	if (static_branch_unlikely(&__tsc_early_static)) {
>> +		if (__tsc_early)
>> +			return sched_clock_early();
>> +	}
>> +#endif /* !CONFIG_PARAVIRT */
>> +
> 
> This whole function maze plus the ifdeffery which comes with it is really
> horrible and not required. What's wrong with reusing the existing
> functionality?
> 
> The patch below (uncompiled and untested) should achieve the same thing
> without all the paravirt muck (which can be easily added w/o all the
> ifdeffery if really required) by just reusing the existing conversion and
> initialization functions.
> 
> If I'm not completely mistaken then the second invocation of
> set_cyc2ns_scale() from tsc_init() will also take care of the smooth
> sched_clock() transition from early to final w/o touching the core
> __sched_clock_offset at all. Though my tired brain might trick me.
> 
> It might not work as is, but it should not be rocket science to make it do
> so.
> 
> Thanks,
> 
> 	tglx
> 
> 8<----------------------
> 
> tsc.c |   59 ++++++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 44 insertions(+), 15 deletions(-)
> 
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -39,6 +39,9 @@ EXPORT_SYMBOL(tsc_khz);
>  static int __read_mostly tsc_unstable;
>  
>  static DEFINE_STATIC_KEY_FALSE(__use_tsc);
> +static DEFINE_STATIC_KEY_TRUE(tsc_early_enabled);
> +
> +static bool tsc_early_sched_clock;
>  
>  int tsc_clocksource_reliable;
>  
> @@ -133,18 +136,12 @@ static inline unsigned long long cycles_
>  	return ns;
>  }
>  
> -static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
> +static void __set_cyc2ns_scale(unsigned long khz, int cpu,
> +			       unsigned long long tsc_now)
>  {
>  	unsigned long long ns_now;
>  	struct cyc2ns_data data;
>  	struct cyc2ns *c2n;
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	sched_clock_idle_sleep_event();
> -
> -	if (!khz)
> -		goto done;
>  
>  	ns_now = cycles_2_ns(tsc_now);
>  
> @@ -176,22 +173,46 @@ static void set_cyc2ns_scale(unsigned lo
>  	c2n->data[0] = data;
>  	raw_write_seqcount_latch(&c2n->seq);
>  	c2n->data[1] = data;
> +}
> +
> +static void set_cyc2ns_scale(unsigned long khz, int cpu,
> +			     unsigned long long tsc_now)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	sched_clock_idle_sleep_event();
> +
> +	if (khz)
> +		__set_cyc2ns_scale(khz, cpu, tsc_now);
>  
> -done:
>  	sched_clock_idle_wakeup_event();
>  	local_irq_restore(flags);
>  }
>  
> +static void __init sched_clock_early_init(unsigned int khz)
> +{
> +	cyc2ns_init(smp_processor_id());
> +	__set_cyc2ns_scale(khz, smp_processor_id(), rdtsc());
> +	tsc_early_sched_clock = true;
> +}
> +
> +static void __init sched_clock_early_exit(void)
> +{
> +	static_branch_disable(&tsc_early_enabled);
> +}
> +
>  /*
>   * Scheduler clock - returns current time in nanosec units.
>   */
>  u64 native_sched_clock(void)
>  {
> -	if (static_branch_likely(&__use_tsc)) {
> -		u64 tsc_now = rdtsc();
> +	if (static_branch_likely(&__use_tsc))
> +		return cycles_2_ns(rdtsc());
>  
> -		/* return the value in ns */
> -		return cycles_2_ns(tsc_now);
> +	if (static_branch_unlikely(&tsc_early_enabled)) {
> +		if (tsc_early_sched_clock)
> +			return cycles_2_ns(rdtsc());
>  	}
>  
>  	/*
> @@ -1332,9 +1353,10 @@ void __init tsc_early_delay_calibrate(vo
>  	lpj = tsc_khz * 1000;
>  	do_div(lpj, HZ);
>  	loops_per_jiffy = lpj;
> +	sched_clock_early_init(tsc_khz);
>  }
>  
> -void __init tsc_init(void)
> +static void __init __tsc_init(void)
>  {
>  	u64 lpj, cyc;
>  	int cpu;
> @@ -1384,7 +1406,8 @@ void __init tsc_init(void)
>  	 */
>  	cyc = rdtsc();
>  	for_each_possible_cpu(cpu) {
> -		cyc2ns_init(cpu);
> +		if (!tsc_early_sched_clock || cpu != smp_processor_id())
> +			cyc2ns_init(cpu);
>  		set_cyc2ns_scale(tsc_khz, cpu, cyc);
>  	}
>  
> @@ -1411,6 +1434,12 @@ void __init tsc_init(void)
>  	detect_art();
>  }
>  
> +void __init tsc_init(void)
> +{
> +	__tsc_init();
> +	sched_clock_early_exit();
> +}
> +
>  #ifdef CONFIG_SMP
>  /*
>   * If we have a constant TSC and are using the TSC for the delay loop,
> 
> 
> 

Hi Thomas,

I like this approach, as you said in patch 6, new paravirt functions are not needed because if hypervisor provides sched_clock() just use it, so we do not need to have ifdefs for paravirt stuff here.

I will update the whole series and send it out again. It will be in a much better shape after your review!

Thank you,
Pavel
