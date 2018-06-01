Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbeFAPwk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:52:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36772 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeFAPwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:52:36 -0400
X-Google-Smtp-Source: ADUXVKKYr7RUoUjZIe6G6r+WMA3ykb34NayS3YZI7I+0/OWk0tje5+WC2kpkDWSNgVfmxVuPfFHkww==
Date: Fri, 1 Jun 2018 08:52:35 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Byungchul Park <byungchul.park@lge.com>
Cc: peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org,
        tglx@linutronix.de, raistlin@linux.it, linux-kernel@vger.kernel.org,
        juri.lelli@gmail.com, bristot@redhat.com, kernel-team@lge.com,
        kernel-team@android.com
Subject: Re: [RESEND, v3, 2/2] sched/deadline: Initialize cp->elements[].cpu
 to an invalid value
Message-ID: <20180601155235.GA66123@joelaf.mtv.corp.google.com>
References: <1515392081-32320-2-git-send-email-byungchul.park@lge.com>
 <20180601061255.GA189147@joelaf.mtv.corp.google.com>
 <20180601061841.GA191514@joelaf.mtv.corp.google.com>
 <b61c30fe-bc16-0f12-7a20-46a89f7cea55@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b61c30fe-bc16-0f12-7a20-46a89f7cea55@lge.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 04:10:56PM +0900, Byungchul Park wrote:
> > On Thu, May 31, 2018 at 11:12:55PM -0700, Joel Fernandes wrote:
> > > On Mon, Jan 08, 2018 at 03:14:41PM +0900, byungchul park wrote:
> > > > Currently, migrating tasks to cpu0 unconditionally happens when the
> > > > heap is empty, since cp->elements[].cpu was initialized to 0(=cpu0).
> > > > We have to distinguish between the empty case and cpu0 to avoid the
> > > > unnecessary migrations. Therefore, it has to return an invalid value
> > > > e.i. -1 in that case.
> > > > 
> > > > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > > > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > > Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> > > > ---
> > > >   kernel/sched/cpudeadline.c | 10 +++++++++-
> > > >   1 file changed, 9 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> > > > index 9f02035..bcf903f 100644
> > > > --- a/kernel/sched/cpudeadline.c
> > > > +++ b/kernel/sched/cpudeadline.c
> > > > @@ -138,6 +138,12 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
> > > >   		int best_cpu = cpudl_maximum_cpu(cp);
> > > >   		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
> > > > +		/*
> > > > +		 * The heap tree is empty for now, just return.
> > > > +		 */
> > > > +		if (best_cpu == -1)
> > > > +			return 0;
> > > > +
> > > >   		if (cpumask_test_cpu(best_cpu, &p->cpus_allowed) &&
> > > >   		    dl_time_before(dl_se->deadline, cpudl_maximum_dl(cp))) {
> > > >   			if (later_mask)
> > > > @@ -265,8 +271,10 @@ int cpudl_init(struct cpudl *cp)
> > > >   		return -ENOMEM;
> > > >   	}
> > > > -	for_each_possible_cpu(i)
> > > > +	for_each_possible_cpu(i) {
> > > > +		cp->elements[i].cpu = -1;
> > > >   		cp->elements[i].idx = IDX_INVALID;
> > > 
> > > Shouldn't you also set cp->elements[cpu].cpu to -1 in cpudl_clear (when you
> > > set cp->elements[cpu].cpu to IDX_INVALID there)?
> > 
> > I messed up my words, I meant : "when setting cp->elements[cpu].idx to
> > IDX_INVALID there". Which means I need to call it a day :-)
> 
> Ah.. I agree with you. It might be a problem when removing the last
> element.. Then I think the following change should also be applied
> additionally. Right?

Yes.

> ---
> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> index 8d9562d..44d4c88 100644
> --- a/kernel/sched/cpudeadline.c
> +++ b/kernel/sched/cpudeadline.c
> @@ -172,12 +172,14 @@ void cpudl_clear(struct cpudl *cp, int cpu)
>         } else {
>                 new_cpu = cp->elements[cp->size - 1].cpu;
>                 cp->elements[old_idx].dl = cp->elements[cp->size - 1].dl;
> -               cp->elements[old_idx].cpu = new_cpu;
> +               cp->elements[old_idx].cpu = (new_cpu == cpu) ? -1 : new_cpu;
>                 cp->size--;
> -               cp->elements[new_cpu].idx = old_idx;
>                 cp->elements[cpu].idx = IDX_INVALID;
> -               cpudl_heapify(cp, old_idx);
> 
> +               if (new_cpu != cpu) {
> +                       cp->elements[new_cpu].idx = old_idx;
> +                       cpudl_heapify(cp, old_idx);
> +               }
>                 cpumask_set_cpu(cpu, cp->free_cpus);

This looks a bit confusing. How about the following? (untested)

thanks,

 - Joel

---8<-----------------------

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 50316455ea66..741a97e58c05 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -129,6 +129,10 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 	} else {
 		int best_cpu = cpudl_maximum(cp);
 
+		/* The max-heap is empty, just return. */
+		if (best_cpu == -1)
+			return 0;
+
 		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
 
 		if (cpumask_test_cpu(best_cpu, &p->cpus_allowed) &&
@@ -167,6 +171,12 @@ void cpudl_clear(struct cpudl *cp, int cpu)
 		 * This could happen if a rq_offline_dl is
 		 * called for a CPU without -dl tasks running.
 		 */
+	} else if (cp->size == 1) {
+		/* Only one element in max-heap, clear it */
+		cp->elements[0].cpu = -1;
+		cp->elements[cpu].idx = IDX_INVALID;
+		cp->size--;
+		cpumask_set_cpu(cpu, cp->free_cpus);
 	} else {
 		new_cpu = cp->elements[cp->size - 1].cpu;
 		cp->elements[old_idx].dl = cp->elements[cp->size - 1].dl;
@@ -262,6 +272,9 @@ int cpudl_init(struct cpudl *cp)
 	for_each_possible_cpu(i)
 		cp->elements[i].idx = IDX_INVALID;
 
+	/* Mark heap as initially empty */
+	cp->elements[0].cpu = -1;
+
 	return 0;
 }
 
