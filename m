Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31B4C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948D62080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfBEMFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:05:34 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61822 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEMFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:05:33 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 62423c3be29b0c35; Tue, 5 Feb 2019 13:05:30 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'LKML' <linux-kernel@vger.kernel.org>,
        'Linux PM' <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Rework iowait boosting to be less aggressive
Date:   Tue, 05 Feb 2019 13:04:17 +0100
Message-ID: <2490415.lMhmKlOKko@aspire.rjw.lan>
In-Reply-To: <000001d4ba4e$d33c3220$79b49660$@net>
References: <000001d4ba4e$d33c3220$79b49660$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 1, 2019 5:54:37 PM CET Doug Smythies wrote:
> On 2019.01.30 16:05 Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The current iowait boosting mechanism in intel_pstate_update_util()
> > is quite aggressive, as it goes to the maximum P-state right away,
> > and may cause excessive amounts of energy to be used, which is not
> > desirable and arguably isn't necessary too.
> >
> > Follow commit a5a0809bc58e ("cpufreq: schedutil: Make iowait boost
> > more energy efficient") that reworked the analogous iowait boost
> > mechanism in the schedutil governor and make the iowait boosting
> > in intel_pstate_update_util() work along the same lines.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c |   46 +++++++++++++++++++++++++----------------
> >  1 file changed, 29 insertions(+), 17 deletions(-)
> >
> > Index: linux-pm/drivers/cpufreq/intel_pstate.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> > +++ linux-pm/drivers/cpufreq/intel_pstate.c
> > @@ -50,6 +50,8 @@
> >  #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
> >  #define fp_toint(X) ((X) >> FRAC_BITS)
> > 
> > +#define ONE_EIGHTH_FP ((int64_t)1 << (FRAC_BITS - 3))
> > +
> >  #define EXT_BITS 6
> >  #define EXT_FRAC_BITS (EXT_BITS + FRAC_BITS)
> >  #define fp_ext_toint(X) ((X) >> EXT_FRAC_BITS)
> > @@ -1678,17 +1680,14 @@ static inline int32_t get_avg_pstate(str
> >  static inline int32_t get_target_pstate(struct cpudata *cpu)
> >  {
> > 	struct sample *sample = &cpu->sample;
> > -	int32_t busy_frac, boost;
> > +	int32_t busy_frac;
> > 	int target, avg_pstate;
> > 
> > 	busy_frac = div_fp(sample->mperf << cpu->aperf_mperf_shift,
> > 			   sample->tsc);
> > 
> > -	boost = cpu->iowait_boost;
> > -	cpu->iowait_boost >>= 1;
> > -
> > -	if (busy_frac < boost)
> > -		busy_frac = boost;
> > +	if (busy_frac < cpu->iowait_boost)
> > +		busy_frac = cpu->iowait_boost;
> > 
> > 	sample->busy_scaled = busy_frac * 100;
> > 
> > @@ -1767,22 +1766,35 @@ static void intel_pstate_update_util(str
> > 	if (smp_processor_id() != cpu->cpu)
> >  		return;
> >
> > +	delta_ns = time - cpu->last_update;
> > 	if (flags & SCHED_CPUFREQ_IOWAIT) {
> > -		cpu->iowait_boost = int_tofp(1);
> > -		cpu->last_update = time;
> > -		/*
> > -		 * The last time the busy was 100% so P-state was max anyway
> > -		 * so avoid overhead of computation.
> > -		 */
> > -		if (fp_toint(cpu->sample.busy_scaled) == 100)
> > -			return;
> > -
> > -		goto set_pstate;
> > +		/* Start over if the CPU may have been idle. */
> > +		if (delta_ns > TICK_NSEC) {
> > +			cpu->iowait_boost = ONE_EIGHTH_FP;
> > +		} else if (cpu->iowait_boost) {
> > +			cpu->iowait_boost <<= 1;
> > +			if (cpu->iowait_boost >= int_tofp(1)) {
> > +				cpu->iowait_boost = int_tofp(1);
> > +				cpu->last_update = time;
> > +				/*
> > +				 * The last time the busy was 100% so P-state
> > +				 * was max anyway, so avoid the overhead of
> > +				 * computation.
> > +				 */
> > +				if (fp_toint(cpu->sample.busy_scaled) == 100)
> > +					return;
> 
> Hi Rafael,
> 
> By exiting here, the trace, if enabled, is also bypassed.
> We want the trace sample.

Fair enough, but the return is there regardless of this patch.

Maybe it should be fixed separately?

> Also, there is a generic:
> "If the target ptstate is the same as before, then don't set it"
> later on.
> Suggest to delete this test and exit condition. (I see that this early
> exit was done before also.)

Well, exactly.

It is not unreasonable to boost the frequency right away for an IO-waiter
without waiting for the next sample time IMO.

