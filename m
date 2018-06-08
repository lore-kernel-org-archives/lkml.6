Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Ko6oKhuLGls8KAAAmS7hNA
	; Fri, 08 Jun 2018 13:57:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D92BD607E4; Fri,  8 Jun 2018 13:57:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 60FFC606FA;
	Fri,  8 Jun 2018 13:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60FFC606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeFHN5M (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:57:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751604AbeFHN5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:57:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33FA7406E89B;
        Fri,  8 Jun 2018 13:57:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id B6D622166BB2;
        Fri,  8 Jun 2018 13:57:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  8 Jun 2018 15:57:05 +0200 (CEST)
Date: Fri, 8 Jun 2018 15:57:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, gkohli@codeaurora.org, tglx@linutronix.de,
        mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com
Subject: Re: [PATCH 2/4] watchdog/softlockup: Replace "watchdog/%u" threads
 with cpu_stop_work
Message-ID: <20180608135703.GD18941@redhat.com>
References: <20180607123310.866085998@infradead.org>
 <20180607124006.158330973@infradead.org>
 <20180607142405.GO12198@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607142405.GO12198@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 08 Jun 2018 13:57:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 08 Jun 2018 13:57:06 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07, Peter Zijlstra wrote:
>
> On Thu, Jun 07, 2018 at 02:33:12PM +0200, Peter Zijlstra wrote:
>
> > +static int softlockup_stop_fn(void *data)
> >  {
> > +	watchdog_disable(smp_processor_id());
> > +	return 0;
> >  }
> >
> > +static void softlockup_stop_all(void)
> >  {
> > +	int cpu;
> > +
> > +	for_each_cpu(cpu, &watchdog_allowed_mask)
> > +		stop_one_cpu(cpu, softlockup_stop_fn, NULL);
> > +
> > +	cpumask_clear(&watchdog_allowed_mask);
> >  }
>
> Bugger, that one doesn't quite work.. watchdog_disable() ends up calling
> a sleeping function. I forgot to enable all the debug cruft when
> testing..

And probably there is another problem. Both watchdog_disable(cpu) and
watchdog_nmi_disable(cpu) assume that cpu == smp_processor_id(), this arg
is simply ignored.

but lockup_detector_offline_cpu(cpu) is called by cpuhp_invoke_callback(),
so in this case watchdog_disable(dying_cpu) is simply wrong.

May be we can do something like below? Then softlockup_stop_all() can simply do

	for_each_cpu(cpu, &watchdog_allowed_mask)
		watchdog_disable(cpu);

watchdog_nmi_disable() is __weak, but at first glance arch/sparc/kernel/nmi.c
does everything correctly.

Oleg.

--- x/kernel/watchdog.c
+++ x/kernel/watchdog.c
@@ -108,13 +108,13 @@ __setup("hardlockup_all_cpu_backtrace=",
  */
 int __weak watchdog_nmi_enable(unsigned int cpu)
 {
-	hardlockup_detector_perf_enable();
+	hardlockup_detector_perf_enable(cpu);
 	return 0;
 }
 
 void __weak watchdog_nmi_disable(unsigned int cpu)
 {
-	hardlockup_detector_perf_disable();
+	hardlockup_detector_perf_disable(cpu);
 }
 
 /* Return 0, if a NMI watchdog is available. Error code otherwise */
@@ -479,7 +479,7 @@ static void watchdog_enable(unsigned int
 
 static void watchdog_disable(unsigned int cpu)
 {
-	struct hrtimer *hrtimer = this_cpu_ptr(&watchdog_hrtimer);
+	struct hrtimer *hrtimer = per_cpu_ptr(&watchdog_hrtimer, cpu);
 
 	watchdog_set_prio(SCHED_NORMAL, 0);
 	/*
--- x/kernel/watchdog_hld.c
+++ x/kernel/watchdog_hld.c
@@ -162,9 +162,8 @@ static void watchdog_overflow_callback(s
 	return;
 }
 
-static int hardlockup_detector_event_create(void)
+static int hardlockup_detector_event_create(int cpu)
 {
-	unsigned int cpu = smp_processor_id();
 	struct perf_event_attr *wd_attr;
 	struct perf_event *evt;
 
@@ -179,37 +178,37 @@ static int hardlockup_detector_event_cre
 			PTR_ERR(evt));
 		return PTR_ERR(evt);
 	}
-	this_cpu_write(watchdog_ev, evt);
+	raw_cpu_write(watchdog_ev, evt);
 	return 0;
 }
 
 /**
  * hardlockup_detector_perf_enable - Enable the local event
  */
-void hardlockup_detector_perf_enable(void)
+void hardlockup_detector_perf_enable(int cpu)
 {
-	if (hardlockup_detector_event_create())
+	if (hardlockup_detector_event_create(cpu))
 		return;
 
 	/* use original value for check */
 	if (!atomic_fetch_inc(&watchdog_cpus))
 		pr_info("Enabled. Permanently consumes one hw-PMU counter.\n");
 
-	perf_event_enable(this_cpu_read(watchdog_ev));
+	perf_event_enable(raw_cpu_read(watchdog_ev));
 }
 
 /**
  * hardlockup_detector_perf_disable - Disable the local event
  */
-void hardlockup_detector_perf_disable(void)
+void hardlockup_detector_perf_disable(int cpu)
 {
-	struct perf_event *event = this_cpu_read(watchdog_ev);
+	struct perf_event *event = per_cpu_read(watchdog_ev, cpu);
 
 	if (event) {
 		perf_event_disable(event);
-		this_cpu_write(watchdog_ev, NULL);
-		this_cpu_write(dead_event, event);
-		cpumask_set_cpu(smp_processor_id(), &dead_events_mask);
+		raw_cpu_write(watchdog_ev, cpu, NULL);
+		raw_cpu_write(dead_event, cpu, event);
+		cpumask_set_cpu(cpu, &dead_events_mask);
 		atomic_dec(&watchdog_cpus);
 	}
 }
