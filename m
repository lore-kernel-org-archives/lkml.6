Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56461C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1293321A73
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1293321A73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbeFUTE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752650AbeFUTEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:04:55 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77EE821A6F;
        Thu, 21 Jun 2018 19:04:54 +0000 (UTC)
Date:   Thu, 21 Jun 2018 15:04:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        raistlin@linux.it, linux-kernel@vger.kernel.org,
        juri.lelli@gmail.com, bristot@redhat.com, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: Re: [RESEND PATCH v5 2/2] sched/deadline: Set cp->elements[0].cpu
 to -1 when the heap is empty
Message-ID: <20180621150452.4480c33f@gandalf.local.home>
In-Reply-To: <1529297905-24703-2-git-send-email-byungchul.park@lge.com>
References: <1529297905-24703-1-git-send-email-byungchul.park@lge.com>
        <1529297905-24703-2-git-send-email-byungchul.park@lge.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 13:58:25 +0900
Byungchul Park <byungchul.park@lge.com> wrote:

> Hello Steven and Daniel,
> 
> I've changed the 2nd patch a little bit to consider cpudl_clear()
> additionally. Can I keep your Acked-by on?

Actually, I think this should be a separate patch. It handles a
different issue.

> 
> (I temporarily removed the Acked-by you gave me.)
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> 
> -----8<-----
> >From 1e368d276186c22f9da298206c718b33e805828d Mon Sep 17 00:00:00 2001  
> From: Byungchul Park <byungchul.park@lge.com>
> Date: Mon, 4 Jun 2018 15:05:08 +0900
> Subject: [RESEND PATCH v5 2/2] sched/deadline: Set cp->elements[0].cpu to -1 when the
>  heap is empty
> 
> Currently, migrating tasks to cpu0 unconditionally happens when the
> heap is empty, since cp->elements[0].cpu is initialized to 0(=cpu0).
> We have to distinguish between the empty case and cpu0 to avoid the
> unnecessary migrations. Therefore, it has to return an invalid value
> e.i. -1 in the case the heap is empty.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> Suggested-by: Joel Fernandes <joelaf@google.com>
> ---
>  kernel/sched/cpudeadline.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> index ae4fbdc..a200b36 100644
> --- a/kernel/sched/cpudeadline.c
> +++ b/kernel/sched/cpudeadline.c
> @@ -136,6 +136,10 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
>  
>  		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
>  
> +		/* The heap tree is empty, just return. */
> +		if (best_cpu == -1)
> +			return 0;
> +

Actually, why not put the if before the WARN_ON, and then we can
simplify the WARN_ON:

	if (best_cpu == -1)
		return 0;

	WARN_ON(!cpu_present(best_cpu));

-- Steve

>  		if (cpumask_test_cpu(best_cpu, &p->cpus_allowed) &&
>  		    dl_time_before(dl_se->deadline, cpudl_maximum_dl(cp))) {
>  			if (later_mask)
> @@ -172,6 +176,13 @@ void cpudl_clear(struct cpudl *cp, int cpu)
>  		 * This could happen if a rq_offline_dl is
>  		 * called for a CPU without -dl tasks running.
>  		 */
> +	} else if (cp->size == 1){
> +		/* Only one element in the heap, clear it. */
> +		cp->elements[0].cpu = -1;
> +		cp->elements[cpu].idx = IDX_INVALID;
> +		cp->size = 0;
> +
> +		cpumask_set_cpu(cpu, cp->free_cpus);
>  	} else {
>  		new_cpu = cp->elements[cp->size - 1].cpu;
>  		cp->elements[old_idx].dl = cp->elements[cp->size - 1].dl;
> @@ -267,6 +278,9 @@ int cpudl_init(struct cpudl *cp)
>  	for_each_possible_cpu(i)
>  		cp->elements[i].idx = IDX_INVALID;
>  
> +	/* Mark heap as initially empty. */
> +	cp->elements[0].cpu = -1;
> +
>  	return 0;
>  }
>  

