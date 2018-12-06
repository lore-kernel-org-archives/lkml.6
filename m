Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0971C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A262920892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kJJC3uZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A262920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbeLFJgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:36:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFJgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kFKxFmnUac1zJI2NH+/TkKsWwctBY4+B46W4a977s2E=; b=kJJC3uZvr8nXMqMhkN+fQW9hs
        2UgqmDL0dFw6TuuiZnPRsxdLa6SwEmOsmMV7GNOWWc/3VVBMxN9rAPLuimsRbLAcXqp6+eDTrEXK1
        idHePeNdp+KKRJxptkp0fNxkUFTR8MEI0L+nFk1xe9PwCvpHz0gXaXwsgVaNWsCpaw+HR+Lg4WBN9
        uUi+TBL1RbdY7RM877aCwZ+72M3DmSdQw0dZXyyyB9bU88immsXUFud73fYS6/K8S76gsKRh9B9xX
        bA5Wch92qa8T0INmbUmEIx/s/i3E7YCOuUCLoVjzcsl9C0clYFAE+eocVn13Lpt4XGYySaUZY/Kue
        pkIOswL9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUq5M-0004JQ-BP; Thu, 06 Dec 2018 09:36:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB4DD2029F4C1; Thu,  6 Dec 2018 10:36:40 +0100 (CET)
Date:   Thu, 6 Dec 2018 10:36:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "weiqi (C)" <weiqi4@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [RFC] sched/fair: Align vruntime to last_se when curr_se's
 timeslice run out
Message-ID: <20181206093640.GB13538@hirez.programming.kicks-ass.net>
References: <f4f56ab5-8f9e-9ee4-4db8-370bc4aa2556@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f56ab5-8f9e-9ee4-4db8-370bc4aa2556@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 08:41:39PM +0800, weiqi (C) wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ee271bb..1f61b9c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4020,7 +4020,23 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
>         ideal_runtime = sched_slice(cfs_rq, curr);
>         delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
>         if (delta_exec > ideal_runtime) {
> +               struct rb_node *next = NULL;
> +               struct rb_node *right_most = NULL;
> +               struct sched_entity *last;
>                 resched_curr(rq_of(cfs_rq));
> +
> +                /* always set to max vruntime */
> +                if (cfs_rq->nr_running > 1) {
> +                        next = &curr->run_node;
> +                        do {
> +                                right_most = next;
> +                                next = rb_next(next);
> +                        } while (next);
> +
> +                        last = rb_entry(right_most,
> +                                         struct sched_entity, run_node);

This you can obviously do better by tracking max_vruntime along side
min_vruntime. But for testing this should work fine I suppose.

> +                        curr->vruntime = last->vruntime + 1; // maybe +1 is not needed

This however is completely broken... you've basically reduced a virtual
runtime scheduler to a simple RR one.

Yes, place_entity() is not ideal, for starters we should not insert
relative to min_vruntime but to the 0-lag point (weighted average
vruntime). And IIRC, we should not let negative lag tasks reduce the
runqueue weight.

But those things are computationally expensive to do, so we fudged it.

> +                }
> +
>                 /*
>                  * The current task ran long enough, ensure it doesn't get
>                  * re-elected due to buddy favours.



