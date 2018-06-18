Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2782C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561B22083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561B22083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755425AbeFRVgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:36:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755344AbeFRVgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:36:38 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AE2F2075E;
        Mon, 18 Jun 2018 21:36:37 +0000 (UTC)
Date:   Mon, 18 Jun 2018 17:36:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        raistlin@linux.it, linux-kernel@vger.kernel.org,
        juri.lelli@gmail.com, bristot@redhat.com, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: Re: [RESEND PATCH v12 1/2] sched/deadline: Add support for
 SD_PREFER_SIBLING on find_later_rq()
Message-ID: <20180618173635.2a89b580@gandalf.local.home>
In-Reply-To: <1529297889-24551-2-git-send-email-byungchul.park@lge.com>
References: <1529297889-24551-1-git-send-email-byungchul.park@lge.com>
        <1529297889-24551-2-git-send-email-byungchul.park@lge.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 13:58:08 +0900
Byungchul Park <byungchul.park@lge.com> wrote:

> Hello Juri,
> 
> I've changed the code a little bit to avoid a compile warning caused by
> 'const' args of find_cpu(). Can I keep your Acked-by?
> 
> BEFORE:
> static int find_cpu(const struct cpumask *mask,
> 		    const struct sched_domain *sd,
> 		    const struct sched_domain *prefer)
> 
> AFTER:
> static int find_cpu(const struct cpumask *mask,
> 		    struct sched_domain *sd,
> 		    struct sched_domain *prefer)
> 

Instead of doing that, why not fix sched_domain_span() to take a
constant. There's no reason that function should be modifying the
sched_domain.

-- Steve

> (I temporarily removed the Acked-by you gave me.)
> Acked-by: Juri Lelli <juri.lelli@arm.com>
> 
> -----8<-----
> >From 5a4753e8c15369420a16fa04026f74ae5c9d377c Mon Sep 17 00:00:00 2001  
> From: Byungchul Park <byungchul.park@lge.com>
> Date: Mon, 4 Jun 2018 16:46:56 +0900
> Subject: [RESEND PATCH v12 1/2] sched/deadline: Add support for SD_PREFER_SIBLING on
>  find_later_rq()
> 
> It would be better to try to check other siblings first if
> SD_PREFER_SIBLING is flaged when pushing tasks - migration.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> ---
>  kernel/sched/deadline.c | 80 ++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 73 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 1356afd..6130d40 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1853,12 +1853,33 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
>  
>  static DEFINE_PER_CPU(cpumask_var_t, local_cpu_mask_dl);
>  
> +/*
> + * Find the first CPU in: mask & sd & ~prefer
> + */
> +static int find_cpu(const struct cpumask *mask,
> +		    struct sched_domain *sd,
> +		    struct sched_domain *prefer)
> +{
> +	int cpu;
> +
> +	for_each_cpu(cpu, mask) {
> +		if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
> +			continue;
> +		if (prefer && cpumask_test_cpu(cpu, sched_domain_span(prefer)))
> +			continue;
> +		break;
> +	}
> +
> +	return cpu;
> +}
> +
> 
