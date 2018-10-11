Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7E9C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C732087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C732087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeJKRU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:20:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:25530 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbeJKRU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:20:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 02:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,368,1534834800"; 
   d="scan'208";a="98253284"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2018 02:53:55 -0700
Date:   Thu, 11 Oct 2018 17:59:41 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] panic: Avoid extra noisy messages due to stopped cpus
Message-ID: <20181011095941.mlh675ag5v4fpgos@shbuild888>
References: <1539242268-63036-1-git-send-email-feng.tang@intel.com>
 <20181011093500.GB9848@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011093500.GB9848@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Oct 11, 2018 at 11:35:00AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 11, 2018 at 03:17:48PM +0800, Feng Tang wrote:
> > Sometimes when debugging kernel panic, we saw many extra noisy error
> > messages after the expected end:
> > 
> > [   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
> > [   35.749975] ------------[ cut here ]------------
> > 
> > These messages may overflow the sceen (framebuffer) and make debugging
> > much difficulter.
> 
> *blink* you actually using the framebuffer for debugging ?! Why the heck
> are you doing that?

I didn't make it clear.

I just wanted to show some use case, that when I work under command line
mode, if the kernel panic (without reboot configured), it will pop out
the panic message, and these noisy message may keep poping up and I
hardly see the actual panic message on the screen.

> 
> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index c93fcfd..b703862 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -520,6 +520,7 @@ void stop_this_cpu(void *dummy)
> >  	 * Remove this CPU:
> >  	 */
> >  	set_cpu_online(smp_processor_id(), false);
> > +	set_cpu_active(smp_processor_id(), false);
> >  	disable_local_APIC();
> >  	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
> >  
> 
> WTH is stop_this_cpu() and how do we even get here with active still
> set?

Current panic() will call
	smp_send_stop
		native_stop_other_cpus
			apic->send_IPI_allbutself(REBOOT_VECTOR)
				smp_reboot_interrupt
					stop_this_cpu

> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 7fc4a37..cf41b7b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9034,7 +9034,7 @@ static inline int find_new_ilb(void)
> >  {
> >  	int ilb = cpumask_first(nohz.idle_cpus_mask);
> >  
> > -	if (ilb < nr_cpu_ids && idle_cpu(ilb))
> > +	if (ilb < nr_cpu_ids && idle_cpu(ilb) && cpu_online(ilb))
> >  		return ilb;
> >  
> >  	return nr_cpu_ids;
> 
> 
> Similar, this is the result of taking the CPU away without going through
> the normal path. You're doing something dodgy.

You are right, it's hacky. As I said in the commit log, suggestions are
appreciated.

Current emergercy handling of panic didn't notify the idle subsystem of
other cpus being stopped.

I have tried several other ways:
a) add a panic notifier to cancel the schdule timer when panic happens
b) don't re-enable the local interrupt inside panic() after normal panic
handling.

Thanks,
Feng


