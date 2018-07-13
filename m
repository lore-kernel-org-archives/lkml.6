Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FFFECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E2A208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2U9ep7vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E2A208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbeGMJgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:36:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60964 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeGMJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2C5DiRxAKxunCQKYIQkx/Rgm0QgITk3DrBrhZP1/ja8=; b=2U9ep7vv5RmMFKsZ2dM9pT5Ti
        i8BxciHGxf+cWk+2GI5cZIN/g3ffUAmsyhMaiowS1NJP5D9UUkxUyC40tF1D230UEwSxL6aAfXiPf
        /tPAdkbI03Dn6Sdb1F+jw2PKIr9924iAdCfCU+KF8C7A7EO1rfH/JWEVeYju5pejy382JYX6VSD+y
        jYeBb9Bdi6vAjDkUNAVQpAJaDAWbSEO3iVlF309N7fiG0ZMZhknfwoGPGIPardBsdJ9Spl9FHcesO
        CpQjdwhQwqtv5tUGARrG47f1uvrQYycJbOMqj8phfm9u26VKoaj4VX3Z3b9F9rsKdPVKLTYYsWS17
        XkXAGvoOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fduH2-0002fE-F7; Fri, 13 Jul 2018 09:22:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 330AE20289330; Fri, 13 Jul 2018 11:21:53 +0200 (CEST)
Date:   Fri, 13 Jul 2018 11:21:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180713092153.GU2494@hirez.programming.kicks-ass.net>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712172942.10094-9-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> +static inline void psi_ttwu_dequeue(struct task_struct *p)
> +{
> +	if (psi_disabled)
> +		return;
> +	/*
> +	 * Is the task being migrated during a wakeup? Make sure to
> +	 * deregister its sleep-persistent psi states from the old
> +	 * queue, and let psi_enqueue() know it has to requeue.
> +	 */
> +	if (unlikely(p->in_iowait || (p->flags & PF_MEMSTALL))) {
> +		struct rq_flags rf;
> +		struct rq *rq;
> +		int clear = 0;
> +
> +		if (p->in_iowait)
> +			clear |= TSK_IOWAIT;
> +		if (p->flags & PF_MEMSTALL)
> +			clear |= TSK_MEMSTALL;
> +
> +		rq = __task_rq_lock(p, &rf);
> +		update_rq_clock(rq);
> +		psi_task_change(p, rq_clock(rq), clear, 0);
> +		p->sched_psi_wake_requeue = 1;
> +		__task_rq_unlock(rq, &rf);
> +	}
> +}

Still NAK, what happened to this here:

  https://lkml.kernel.org/r/20180514083353.GN12217@hirez.programming.kicks-ass.net

