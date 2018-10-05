Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6B4C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209C5213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209C5213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbeJEVZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:25:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbeJEVZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:25:57 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67B462087D;
        Fri,  5 Oct 2018 14:27:00 +0000 (UTC)
Date:   Fri, 5 Oct 2018 10:26:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt : return accurate release rq lock info
Message-ID: <20181005102658.38ecde83@gandalf.local.home>
In-Reply-To: <1538778131-44406-1-git-send-email-peng.hao2@zte.com.cn>
References: <1538778131-44406-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Oct 2018 06:22:11 +0800
Peng Hao <peng.hao2@zte.com.cn> wrote:

> find_lock_lowest_rq may or not releease rq lock when return
> lowest_rq=NULL, but it is fuzzy.
> If not releasing rq lock, it is unnecessary to re-call
> pick_next_pushable_task.
> When CONFIG_PREEMPT=n, not releasing rq lock and return
> lowest_rq=null frequently happens in a simple test case:
> Four different rt priority tasks run on limited two cpus.
> Thanks for Steven Rostedt's advice.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  kernel/sched/rt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 2e2955a..be0fc43 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1754,7 +1754,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  				     !task_on_rq_queued(task))) {
>  
>  				double_unlock_balance(rq, lowest_rq);
> -				lowest_rq = NULL;
> +				lowest_rq = RETRY_TASK;
>  				break;
>  			}
>  		}
> @@ -1830,7 +1830,9 @@ static int push_rt_task(struct rq *rq)
>  
>  	/* find_lock_lowest_rq locks the rq if found */
>  	lowest_rq = find_lock_lowest_rq(next_task, rq);
> -	if (!lowest_rq) {
> +	if (!lowest_rq)
> +		goto out;
> +	if (lowest_rq == RETRY_TASK) {

This probably makes no difference, and can be blown off as just a
preference, but should this be:

	if (!lowest_rq) {
		goto out;
	} else if (lowest_rq == RETRY_TASK) {

The logic is the same regardless, so it's really just a matter of taste.

That said:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


>  		struct task_struct *task;
>  		/*
>  		 * find_lock_lowest_rq releases rq->lock

