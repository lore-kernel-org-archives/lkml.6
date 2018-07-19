Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD3EC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1FF20856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1FF20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeGSLYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:24:04 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52603 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeGSLYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:24:04 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id ecdca475272b9dce; Thu, 19 Jul 2018 12:41:28 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/26] kernel/cpu_pm: Manage runtime PM in the idle path for CPUs
Date:   Thu, 19 Jul 2018 12:39:49 +0200
Message-ID: <1726374.375PCQfjLZ@aspire.rjw.lan>
In-Reply-To: <2205807.cU2puvubpP@aspire.rjw.lan>
References: <20180620172226.15012-1-ulf.hansson@linaro.org> <2056372.NMt4aPaF4h@aspire.rjw.lan> <2205807.cU2puvubpP@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 19, 2018 12:12:55 PM CEST Rafael J. Wysocki wrote:
> On Wednesday, July 18, 2018 12:11:06 PM CEST Rafael J. Wysocki wrote:
> > On Wednesday, June 20, 2018 7:22:09 PM CEST Ulf Hansson wrote:
> > > To allow CPUs being power managed by PM domains, let's deploy support for
> > > runtime PM for the CPU's corresponding struct device.
> > > 
> > > More precisely, at the point when the CPU is about to enter an idle state,
> > > decrease the runtime PM usage count for its corresponding struct device,
> > > via calling pm_runtime_put_sync_suspend(). Then, at the point when the CPU
> > > resumes from idle, let's increase the runtime PM usage count, via calling
> > > pm_runtime_get_sync().
> > > 
> > > Cc: Lina Iyer <ilina@codeaurora.org>
> > > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > 
> > I finally got to this one, sorry for the huge delay.
> > 
> > Let me confirm that I understand the code flow correctly.
> > 
> > > ---
> > >  kernel/cpu_pm.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> > > index 67b02e138a47..492d4a83dca0 100644
> > > --- a/kernel/cpu_pm.c
> > > +++ b/kernel/cpu_pm.c
> > > @@ -16,9 +16,11 @@
> > >   */
> > >  
> > >  #include <linux/kernel.h>
> > > +#include <linux/cpu.h>
> > >  #include <linux/cpu_pm.h>
> > >  #include <linux/module.h>
> > >  #include <linux/notifier.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/spinlock.h>
> > >  #include <linux/syscore_ops.h>
> > >  
> > > @@ -91,6 +93,7 @@ int cpu_pm_enter(void)
> > 
> > This is called from a cpuidle driver's ->enter callback for the target state
> > selected by the idle governor ->
> > 
> > >  {
> > >  	int nr_calls;
> > >  	int ret = 0;
> > > +	struct device *dev = get_cpu_device(smp_processor_id());
> > >  
> > >  	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
> > >  	if (ret)
> > > @@ -100,6 +103,9 @@ int cpu_pm_enter(void)
> > >  		 */
> > >  		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
> > >  
> > > +	if (!ret && dev && dev->pm_domain)
> > > +		pm_runtime_put_sync_suspend(dev);
> > 
> > -> so this is going to invoke genpd_runtime_suspend() if the usage
> > counter of dev is 0.
> > 
> > That will cause cpu_power_down_ok() to be called (because this is
> > a CPU domain) and that will walk the domain cpumask and compute the
> > estimated idle duration as the minimum of tick_nohz_get_next_wakeup()
> > values over the CPUs in that cpumask.  [Note that the weight of the
> > cpumask must be seriously limited for that to actually work, as this
> > happens in the idle path.]  Next, it will return "true" if it can
> > find a domain state with residency within the estimated idle
> > duration.  [Note that this sort of overlaps with the idle governor's
> > job.]
> > 
> > Next, __genpd_runtime_suspend() will be invoked to run the device-specific
> > callback if any [Note that this has to be suitable for the idle path if
> > present.] and genpd_stop_dev() runs (which, again, may invoke a callback)
> > and genpd_power_off() runs under the domain lock (which must be a spinlock
> > then).
> > 
> > > +
> > >  	return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(cpu_pm_enter);
> > > @@ -118,6 +124,11 @@ EXPORT_SYMBOL_GPL(cpu_pm_enter);
> > >   */
> > >  int cpu_pm_exit(void)
> > >  {
> > > +	struct device *dev = get_cpu_device(smp_processor_id());
> > > +
> > > +	if (dev && dev->pm_domain)
> > > +		pm_runtime_get_sync(dev);
> > > +
> > >  	return cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
> > >  }
> > >  EXPORT_SYMBOL_GPL(cpu_pm_exit);
> > > 
> > 
> > And this is called on wakeup when the cpuidle driver's ->enter callback
> > is about to return and it reverses the suspend flow (except that the
> > governor doesn't need to be called now).
> > 
> > Have I got that right?
> 
> Assuming that I have got that right, there are concerns, mostly regarding
> patch [07/26], but I will reply to that directly.

Well, I haven't got that right, so never mind.

There are a few minor things to address, but apart from that the general
genpd patches look ready.

> The $subject patch is fine by me by itself, but it obviously depends on the
> previous ones.  Patches [01-02/26] are fine too, but they don't seem to be
> particularly useful without the rest of the series.
> 
> As far as patches [10-26/26] go, I'd like to see some review comments and/or
> tags from the people with vested interest in there, in particular from Daniel
> on patch [12/26] and from Sudeep on the PSCI ones.

But this still holds.

Thanks,
Rafael

