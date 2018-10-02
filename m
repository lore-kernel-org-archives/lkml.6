Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1264BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9AE2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zhaoxq6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9AE2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJBOnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:43:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47004 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeJBOnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Nnao7UNiyv0BKTr4F/eOZ/vfcYfrmePxat5helk4cRw=; b=zhaoxq6N+ysOsVA2yaS+L4a/b
        RlJ0M2s3qz5/jB9ItYuek8K31hmxsyH6fczRX6UpEX5bi+bhnkGUp6se/lEXIKCwJ3aGWtjqvt58i
        6rZwpvlxm6OH5CjSQhn3UQjL9drlB68yHKgi2PMtMozQCMvSOvDSDslvqtDoxGXhbBZ4JJ6putGoO
        a61dx49EGcwGE2PBd8p5mwbiHkLSVM1NkpMx47JF49699QI/VrpkP1eOnyNw5uH9yEk62xehhbugG
        1ndfcLGiZdiUpNdSd7piTXAKByuRxOMxT3goLBAwok6ydmYRsqexaox05ZXwBHpb02cr4bmLhevVc
        jcYg/18Wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7Fce-0003EN-4p; Tue, 02 Oct 2018 08:01:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1BD62025A358; Tue,  2 Oct 2018 10:01:34 +0200 (CEST)
Date:   Tue, 2 Oct 2018 10:01:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@gmail.com>
Subject: Re: [PATCH]  sched/rt : return accurate release rq lock info
Message-ID: <20181002080134.GR3439@hirez.programming.kicks-ass.net>
References: <1538490221-18028-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538490221-18028-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 10:23:41PM +0800, Peng Hao wrote:
> find_lock_lowest_rq may or not releease rq lock, but it is fuzzy.
> If not releasing rq lock, it is unnecessary to re-call
> pick_next_oushable_task.

You forgot to mention how much this matters. That is, why did you take
the effort to write this patch.

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  kernel/sched/rt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 2e2955a..4d7d322 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1719,6 +1719,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  {
>  	struct rq *lowest_rq = NULL;
>  	int tries;
> +	bool release_lock = false;
>  	int cpu;

We generally prefer to keep the variable definitions (reverse) ordered
on line length (reverse-xmas-tree).

>  
>  	for (tries = 0; tries < RT_MAX_TRIES; tries++) {
> @@ -1741,6 +1742,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  
>  		/* if the prio of this runqueue changed, try again */
>  		if (double_lock_balance(rq, lowest_rq)) {
> +			release_lock = true;
>  			/*
>  			 * We had to unlock the run queue. In
>  			 * the mean time, task could have
> @@ -1768,6 +1770,8 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  		lowest_rq = NULL;
>  	}
>  
> +	if (!lowest_rq && !release_lock)
> +		lowest_rq = (void *) -1;

We have a name for that thing, RETRY_TASK. Funnily it means the exact
opposite of what you did. So maybe use that and invert the logic.

>  	return lowest_rq;
>  }
>  

You also forgot to do the same to the deadline code; or explain why it
doesn't need it.
