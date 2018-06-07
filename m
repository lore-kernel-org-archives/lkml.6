Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /ntlOj2LGFtPeAAAmS7hNA
	; Thu, 07 Jun 2018 01:32:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D16BA608B8; Thu,  7 Jun 2018 01:32:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4C2C3607DC;
	Thu,  7 Jun 2018 01:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C2C3607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeFGBcn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 21:32:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:46319 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752215AbeFGBcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 21:32:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2018 18:32:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,485,1520924400";
   d="scan'208";a="45863277"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2018 18:32:39 -0700
Date: Thu, 7 Jun 2018 09:34:27 +0800
From: Feng Tang <feng.tang@intel.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, alek.du@intel.com,
        arjan@linux.intel.com, len.brown@intel.com
Subject: Re: [RFC 2/2] x86, tsc: Enable clock for ealry printk timestamp
Message-ID: <20180607013427.7qvwzmi6d2c62y23@shbuild888>
References: <1527672059-6225-1-git-send-email-feng.tang@intel.com>
 <1527672059-6225-2-git-send-email-feng.tang@intel.com>
 <20180531135542.4j7w7bxsw43ydx3j@pathway.suse.cz>
 <20180531155210.GL12180@hirez.programming.kicks-ass.net>
 <20180601161213.tm44nhrhwfxa2767@shbuild888>
 <20180606093833.vqg47yhdq7mnj2kp@shbuild888>
 <db1b5457-bc8e-3994-3802-d8bcdd14e485@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db1b5457-bc8e-3994-3802-d8bcdd14e485@oracle.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thanks for the revew.

On Wed, Jun 06, 2018 at 11:25:22AM -0400, Pavel Tatashin wrote:
> Hi Feng,
> 
> Using a global variable for this is not going to work, because you are adding a conditional branch and a load to a very hot path for the live of the system, not only for the duration of the boot.

Exactly. As I explained, I wanted to use the "__use_tsc" and 
"__sched_clock_stable" without creating new gloabl variables, but
the problem is jump_label_init() can't be called that early,
so I used "tsc_inited" temply just to show tsc_init() could be call
early, and the printk timestamp could work much earlier.

Thanks,
Feng

> 
> Pavel
> 
> >  
> > +int tsc_inited;
> >  /*
> >   * TSC can be unstable due to cpufreq or due to unsynced TSCs
> >   */
> > @@ -192,7 +193,7 @@ static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_
> >   */
> >  u64 native_sched_clock(void)
> >  {
> > -	if (static_branch_likely(&__use_tsc)) {
> > +	if (static_branch_likely(&__use_tsc) || tsc_inited) {
> >  		u64 tsc_now = rdtsc();
> >  
> >  		/* return the value in ns */
> > @@ -1387,30 +1391,16 @@ static int __init init_tsc_clocksource(void)
> >   */
> >  device_initcall(init_tsc_clocksource);
> >  
> > -void __init tsc_early_delay_calibrate(void)
> > -{
> > -	unsigned long lpj;
> > -
> > -	if (!boot_cpu_has(X86_FEATURE_TSC))
> > -		return;
> > -
> > -	cpu_khz = x86_platform.calibrate_cpu();
> > -	tsc_khz = x86_platform.calibrate_tsc();
> > -
> > -	tsc_khz = tsc_khz ? : cpu_khz;
> > -	if (!tsc_khz)
> > -		return;
> > -
> > -	lpj = tsc_khz * 1000;
> > -	do_div(lpj, HZ);
> > -	loops_per_jiffy = lpj;
> > -}
> > -
> >  void __init tsc_init(void)
> >  {
> >  	u64 lpj, cyc;
> >  	int cpu;
> >  
> > +	if (tsc_inited)
> > +		return;
> > +
> > +	tsc_inited = 1;
> > +
> >  	if (!boot_cpu_has(X86_FEATURE_TSC)) {
> >  		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
> >  		return;
> > @@ -1474,11 +1464,15 @@ void __init tsc_init(void)
> >  	lpj = ((u64)tsc_khz * 1000);
> >  	do_div(lpj, HZ);
> >  	lpj_fine = lpj;
> > +	loops_per_jiffy = lpj;
> >  
> >  	use_tsc_delay();
> >  
> >  	check_system_tsc_reliable();
> >  
> > +	extern void early_set_sched_clock_stable(u64 sched_clock_offset);
> > +	early_set_sched_clock_stable(div64_u64(rdtsc() * 1000, tsc_khz));
> > +
> >  	if (unsynchronized_tsc()) {
> >  		mark_tsc_unstable("TSCs unsynchronized");
> >  		return;
> > diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> > index 10c83e7..6c5c22d 100644
> > --- a/kernel/sched/clock.c
> > +++ b/kernel/sched/clock.c
> > @@ -119,6 +119,13 @@ static void __scd_stamp(struct sched_clock_data *scd)
> >  	scd->tick_raw = sched_clock();
> >  }
> >  
> > +
> > +void early_set_sched_clock_stable(u64 sched_clock_offset)
> > +{
> > +	__sched_clock_offset = sched_clock_offset;
> > +	static_branch_enable(&__sched_clock_stable);
> > +}
> > +
> >  static void __set_sched_clock_stable(void)
> >  {
> >  	struct sched_clock_data *scd;
> > @@ -342,12 +349,14 @@ static u64 sched_clock_remote(struct sched_clock_data *scd)
> >   *
> >   * See cpu_clock().
> >   */
> > +
> > +extern int tsc_inited;
> >  u64 sched_clock_cpu(int cpu)
> >  {
> >  	struct sched_clock_data *scd;
> >  	u64 clock;
> >  
> > -	if (sched_clock_stable())
> > +	if (sched_clock_stable() || tsc_inited)
> >  		return sched_clock() + __sched_clock_offset;
> >  
> >  	if (unlikely(!sched_clock_running))
> > 	   
> > 
> > 
> > 
> >>>
> >>> If you have a dodgy part (sorry SKX), you'll just have to live with
> >>> sched_clock starting late(r).
> >>>
> >>> Do not cobble things on the side, try and get the normal things running
> >>> earlier.
