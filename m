Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A050C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0081E20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rJzaAYvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0081E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIMMtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:49:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeIMMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rwu5nHS+YtKYcregdpnqjfkf50U5AzMbgfwEtt4P7Gg=; b=rJzaAYvB7CkX4CdWLMWaMXsiF
        9x7dXYzPQQYmr4lNwbbK41h1c/BjouFQ6K4bwoB5+Z3iEhDYgwtN/0/9kbacs8yTFQBbkYKSxkbl1
        1c6+q21TA3PpxMjtSd769sO2QSGsLJU0ivheqYLEKruYnps4LC7TavmegGuUJ/7yh1i23bda0lYcS
        HarSFrjs5POim7bvdy5clny3Ejv3Q2Qh9CsO7Ewx7kecKc4k5T/7G3vKyWei1pg/BMEGOzqamfLmK
        nb00Z7gC5O1t66PwMK+hS9u6HeAalDU1oJ7Kners05XeijSBaWd3UuIDq2fDAgPzU8ZeOOc2YR1sJ
        aPORX6DtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0MF2-0008Rx-KB; Thu, 13 Sep 2018 07:40:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE65120587670; Thu, 13 Sep 2018 09:40:42 +0200 (CEST)
Date:   Thu, 13 Sep 2018 09:40:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] perf: Prevent recursion in ring buffer
Message-ID: <20180913074042.GU24124@hirez.programming.kicks-ass.net>
References: <20180912193317.10339-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912193317.10339-1-jolsa@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 09:33:17PM +0200, Jiri Olsa wrote:

>   # perf record -e 'sched:sched_switch,sched:sched_wakeup' perf bench sched messaging

> The reason for the corruptions are some of the scheduling tracepoints,
> that have __perf_task dfined and thus allow to store data to another
> cpu ring buffer:
> 
>   sched_waking
>   sched_wakeup
>   sched_wakeup_new
>   sched_stat_wait
>   sched_stat_sleep
>   sched_stat_iowait
>   sched_stat_blocked

> And then iterates events of the 'task' and store the sample
> for any task's event that passes tracepoint checks:
> 
>   ctx = rcu_dereference(task->perf_event_ctxp[perf_sw_context]);
> 
>   list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
>     if (event->attr.type != PERF_TYPE_TRACEPOINT)
>       continue;
>     if (event->attr.config != entry->type)
>       continue;
> 
>     perf_swevent_event(event, count, &data, regs);
>   }
> 
> Above code can race with same code running on another cpu,
> ending up with 2 cpus trying to store under the same ring
> buffer, which is not handled at the moment.

It can yes, however the only way I can see this breaking is if we use
!inherited events with a strict per-task buffer, but your record command
doesn't use that.

Now, your test-case uses inherited events, which would all share the
buffer, however IIRC inherited events require per-task-per-cpu buffers,
because there is already no guarantee the various tasks run on the same
CPU in the first place.

This means we _should_ write to the @task's local CPU buffer, and that
would work again.

Let me try and figure out where this is going wrong.
