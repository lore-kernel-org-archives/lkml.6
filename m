Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F74BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3422084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3422084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeJFAuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbeJFAuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:50:24 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D11E206B2;
        Fri,  5 Oct 2018 17:50:37 +0000 (UTC)
Date:   Fri, 5 Oct 2018 13:50:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     mingo@redhat.com, peterz@infradead.org,
        andrea.parri@amarulasolutions.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  sched/dl : return accurate release rq lock info
Message-ID: <20181005135035.10a99573@gandalf.local.home>
In-Reply-To: <1538788117-45448-1-git-send-email-peng.hao2@zte.com.cn>
References: <1538788117-45448-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Oct 2018 09:08:37 +0800
Peng Hao <peng.hao2@zte.com.cn> wrote:

> find_lock_later_rq may or not releease rq lock when return
> later_rq=NULL, but it is fuzzy.
> If not releasing rq lock, it is unnecessary to re-call
> pick_next_pushable_dl_task.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>


Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/sched/deadline.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 997ea7b..8e875ec 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1979,7 +1979,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
>  				     !dl_task(task) ||
>  				     !task_on_rq_queued(task))) {
>  				double_unlock_balance(rq, later_rq);
> -				later_rq = NULL;
> +				later_rq = RETRY_TASK;
>  				break;
>  			}
>  		}
> @@ -2063,7 +2063,9 @@ static int push_dl_task(struct rq *rq)
>  
>  	/* Will lock the rq it'll find */
>  	later_rq = find_lock_later_rq(next_task, rq);
> -	if (!later_rq) {
> +	if (!later_rq)
> +		goto out;
> +	if (later_rq == RETRY_TASK) {
>  		struct task_struct *task;
>  
>  		/*

