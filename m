Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CBEC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CC320831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JZv2B+z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CC320831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbeKUBzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:55:10 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59552 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbeKUBzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9gzkO0aRs7pyFEWlidwDqwd0LshrUYaiJE9PzmIK/FE=; b=JZv2B+z1lkC779HL0WgVCD/08
        WUsuUDg97DYzwaZD3kvOa2jsoecH6sunv3U3tJqsroPd8YTgl0xZeS+HjGSV1DcOVLFFdznCL5lzX
        zFBoDn4bmiigy82FBOKl8vkal6KiO2AFQ7+1qB82qZHYMYmBMeK58XnMnqso85tEA5lTv0B5qhzk0
        cnyYdswG8hoDjPKdENNg/0mLDhvQfS5aqMGfD9zBAJh9Hd1wT4IFzVycVf5AHx++jhw7XoHusC+ye
        l4RETtTI0pCKhI9yPAqBojZ6Z89MsQpsrSkcxBJgQ5Uh1S6i8P6/gXFsZ1zK66mYmvXUeOZTPZkFn
        MddtT6JWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP7ts-0000gG-9t; Tue, 20 Nov 2018 15:25:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F02232029FD58; Tue, 20 Nov 2018 16:25:14 +0100 (CET)
Date:   Tue, 20 Nov 2018 16:25:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Quentin Perret <quentin.perret@arm.com>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, tkjos@google.com,
        joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v9 02/15] sched/cpufreq: Prepare schedutil for Energy
 Aware Scheduling
Message-ID: <20181120152514.GD2113@hirez.programming.kicks-ass.net>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-3-quentin.perret@arm.com>
 <20181120044602.bsfsp4alswbwoweu@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120044602.bsfsp4alswbwoweu@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:16:02AM +0530, Viresh Kumar wrote:
> On 19-11-18, 14:18, Quentin Perret wrote:
> > @@ -223,20 +222,33 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> 
> > -	if ((util + cpu_util_dl(rq)) >= max)
> > -		return max;
> > +	if (type == FREQUENCY_UTIL) {
> > +		/*
> > +		 * For frequency selection we do not make cpu_util_dl() a
> > +		 * permanent part of this sum because we want to use
> > +		 * cpu_bw_dl() later on, but we need to check if the
> > +		 * CFS+RT+DL sum is saturated (ie. no idle time) such
> > +		 * that we select f_max when there is no idle time.
> > +		 *
> > +		 * NOTE: numerical errors or stop class might cause us
> > +		 * to not quite hit saturation when we should --
> > +		 * something for later.
> > +		 */
> > +
> > +		if ((util + cpu_util_dl(rq)) >= max)
> > +			return max;
> > +	} else {
> > +		/*
> > +		 * OTOH, for energy computation we need the estimated
> > +		 * running time, so include util_dl and ignore dl_bw.
> > +		 */
> > +		util += cpu_util_dl(rq);
> > +		if (util >= max)
> > +			return max;
> > +	}
> 
> Maybe write above as:
> 
>         dl_util = cpu_util_dl(rq);
> 
>         if ((util + dl_util) >= max)
>                 return max;
> 
> 	if (type != FREQUENCY_UTIL)
> 		util += dl_util;
> 
> 
> as both the if/else parts were doing almost the same thing.

A little like so ?

--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -201,8 +201,8 @@ static unsigned int get_next_freq(struct
 unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
 				  unsigned long max, enum schedutil_type type)
 {
+	unsigned long dl_util, util, irq;
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long util, irq;
 
 	if (type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt))
 		return max;
@@ -225,30 +225,26 @@ unsigned long schedutil_freq_util(int cp
 	util = util_cfs;
 	util += cpu_util_rt(rq);
 
-	if (type == FREQUENCY_UTIL) {
-		/*
-		 * For frequency selection we do not make cpu_util_dl() a
-		 * permanent part of this sum because we want to use
-		 * cpu_bw_dl() later on, but we need to check if the
-		 * CFS+RT+DL sum is saturated (ie. no idle time) such
-		 * that we select f_max when there is no idle time.
-		 *
-		 * NOTE: numerical errors or stop class might cause us
-		 * to not quite hit saturation when we should --
-		 * something for later.
-		 */
-
-		if ((util + cpu_util_dl(rq)) >= max)
-			return max;
-	} else {
-		/*
-		 * OTOH, for energy computation we need the estimated
-		 * running time, so include util_dl and ignore dl_bw.
-		 */
-		util += cpu_util_dl(rq);
-		if (util >= max)
-			return max;
-	}
+	dl_util = cpu_util_dl(rq);
+
+	/*
+	 * NOTE: numerical errors or stop class might cause us to not quite hit
+	 * saturation when we should -- something for later.
+	 */
+	if (util + dl_util > max)
+		return max;
+
+	/*
+	 * For frequency selection we do not make cpu_util_dl() a permanent
+	 * part of this sum because we want to use cpu_bw_dl() later on, but we
+	 * need to check if the CFS+RT+DL sum is saturated (ie. no idle time)
+	 * such that we select f_max when there is no idle time.
+	 *
+	 * OTOH, for energy computation we need the estimated running time, so
+	 * do include util_dl and ignore dl_bw.
+	 */
+	if (type == ENERGY_UTIL)
+		util += dl_util;
 
 	/*
 	 * There is still idle time; further improve the number by using the
@@ -262,21 +258,18 @@ unsigned long schedutil_freq_util(int cp
 	util = scale_irq_capacity(util, irq, max);
 	util += irq;
 
-	if (type == FREQUENCY_UTIL) {
-		/*
-		 * Bandwidth required by DEADLINE must always be granted
-		 * while, for FAIR and RT, we use blocked utilization of
-		 * IDLE CPUs as a mechanism to gracefully reduce the
-		 * frequency when no tasks show up for longer periods of
-		 * time.
-		 *
-		 * Ideally we would like to set bw_dl as min/guaranteed
-		 * freq and util + bw_dl as requested freq. However,
-		 * cpufreq is not yet ready for such an interface. So,
-		 * we only do the latter for now.
-		 */
+	/*
+	 * Bandwidth required by DEADLINE must always be granted while, for
+	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
+	 * to gracefully reduce the frequency when no tasks show up for longer
+	 * periods of time.
+	 *
+	 * Ideally we would like to set bw_dl as min/guaranteed freq and util +
+	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
+	 * an interface. So, we only do the latter for now.
+	 */
+	if (type == FREQUENCY_UTIL)
 		util += cpu_bw_dl(rq);
-	}
 
 	return min(max, util);
 }
