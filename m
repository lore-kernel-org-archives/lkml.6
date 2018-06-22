Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A52C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6040323C3F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6040323C3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934302AbeFVCNX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:13:23 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:54142 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933905AbeFVCNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:13:22 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.53 with ESMTP; 22 Jun 2018 11:13:19 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.151 with ESMTP; 22 Jun 2018 11:13:19 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 22 Jun 2018 11:13:16 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        raistlin@linux.it, linux-kernel@vger.kernel.org,
        juri.lelli@gmail.com, bristot@redhat.com, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: Re: [RESEND PATCH v5 2/2] sched/deadline: Set cp->elements[0].cpu to
 -1 when the heap is empty
Message-ID: <20180622021316.GA17010@X58A-UD3R>
References: <1529297905-24703-1-git-send-email-byungchul.park@lge.com>
 <1529297905-24703-2-git-send-email-byungchul.park@lge.com>
 <20180621150452.4480c33f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621150452.4480c33f@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 03:04:52PM -0400, Steven Rostedt wrote:
> On Mon, 18 Jun 2018 13:58:25 +0900
> Byungchul Park <byungchul.park@lge.com> wrote:
> 
> > Hello Steven and Daniel,
> > 
> > I've changed the 2nd patch a little bit to consider cpudl_clear()
> > additionally. Can I keep your Acked-by on?
> 
> Actually, I think this should be a separate patch. It handles a
> different issue.

Do you think this should be a separate patch even though both are
anyway for considering empty one properly?

OK, I will then.

Thanks a lot, Steve.

> > (I temporarily removed the Acked-by you gave me.)
> > 
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> > 
> > -----8<-----
> > >From 1e368d276186c22f9da298206c718b33e805828d Mon Sep 17 00:00:00 2001  
> > From: Byungchul Park <byungchul.park@lge.com>
> > Date: Mon, 4 Jun 2018 15:05:08 +0900
> > Subject: [RESEND PATCH v5 2/2] sched/deadline: Set cp->elements[0].cpu to -1 when the
> >  heap is empty
> > 
> > Currently, migrating tasks to cpu0 unconditionally happens when the
> > heap is empty, since cp->elements[0].cpu is initialized to 0(=cpu0).
> > We have to distinguish between the empty case and cpu0 to avoid the
> > unnecessary migrations. Therefore, it has to return an invalid value
> > e.i. -1 in the case the heap is empty.
> > 
> > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > Suggested-by: Joel Fernandes <joelaf@google.com>
> > ---
> >  kernel/sched/cpudeadline.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> > index ae4fbdc..a200b36 100644
> > --- a/kernel/sched/cpudeadline.c
> > +++ b/kernel/sched/cpudeadline.c
> > @@ -136,6 +136,10 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
> >  
> >  		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
> >  
> > +		/* The heap tree is empty, just return. */
> > +		if (best_cpu == -1)
> > +			return 0;
> > +
> 
> Actually, why not put the if before the WARN_ON, and then we can
> simplify the WARN_ON:
> 
> 	if (best_cpu == -1)
> 		return 0;
> 
> 	WARN_ON(!cpu_present(best_cpu));
> 
> -- Steve
> 
> >  		if (cpumask_test_cpu(best_cpu, &p->cpus_allowed) &&
> >  		    dl_time_before(dl_se->deadline, cpudl_maximum_dl(cp))) {
> >  			if (later_mask)
> > @@ -172,6 +176,13 @@ void cpudl_clear(struct cpudl *cp, int cpu)
> >  		 * This could happen if a rq_offline_dl is
> >  		 * called for a CPU without -dl tasks running.
> >  		 */
> > +	} else if (cp->size == 1){
> > +		/* Only one element in the heap, clear it. */
> > +		cp->elements[0].cpu = -1;
> > +		cp->elements[cpu].idx = IDX_INVALID;
> > +		cp->size = 0;
> > +
> > +		cpumask_set_cpu(cpu, cp->free_cpus);
> >  	} else {
> >  		new_cpu = cp->elements[cp->size - 1].cpu;
> >  		cp->elements[old_idx].dl = cp->elements[cp->size - 1].dl;
> > @@ -267,6 +278,9 @@ int cpudl_init(struct cpudl *cp)
> >  	for_each_possible_cpu(i)
> >  		cp->elements[i].idx = IDX_INVALID;
> >  
> > +	/* Mark heap as initially empty. */
> > +	cp->elements[0].cpu = -1;
> > +
> >  	return 0;
> >  }
> >  
