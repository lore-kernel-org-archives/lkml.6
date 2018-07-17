Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB525ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6833220850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NmCwbxcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6833220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbeGQPqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:46:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43914 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbeGQPqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t9ZAv4duUj3psYRV4CqKfV+SpMBL8ia1fEdGq4TRoS8=; b=NmCwbxcsh22vR+PAy9YlSa8ft
        V3EfCNxX/qzkaKCsr8QuGOnIvbdsH0DfZT3nOx+Ud3TFjZdoV4U2ka/Q7B6b8LEZOi+JLS/c4TKPI
        ARp/6Ij6FVegHxhEFsEAgTlnyWZhzAnq5r84MIcvbzNzGfdIluTtVQmL4Va1+msoEr40vR5l3AXnt
        jW7G9D8yifj1EmelmNq/jBoBC75SQaAItono+vtEzxaMnEM2eu3KSetWE25nCOQoj6gw5kbze7OF9
        E4PEkGWQi2HzajvQJEvG0fXbBn4TeGWcdshJLhLaVUpPHccYoqzLFd6n8wFU0GZxZY48GqH59HsIW
        k4vAk4/Ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffRfV-0001Ep-S2; Tue, 17 Jul 2018 15:13:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 835FA20289332; Tue, 17 Jul 2018 17:13:36 +0200 (CEST)
Date:   Tue, 17 Jul 2018 17:13:36 +0200
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
Subject: Re: [RFC PATCH 10/10] psi: aggregate ongoing stall events when
 somebody reads pressure
Message-ID: <20180717151336.GZ2476@hirez.programming.kicks-ass.net>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-11-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712172942.10094-11-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:29:42PM -0400, Johannes Weiner wrote:
> @@ -218,10 +216,36 @@ static bool psi_update_stats(struct psi_group *group)
>  	for_each_online_cpu(cpu) {
>  		struct psi_group_cpu *groupc = per_cpu_ptr(group->cpus, cpu);
>  		unsigned long nonidle;
> +		struct rq_flags rf;
> +		struct rq *rq;
> +		u64 now;
>  
> -		if (!groupc->nonidle_time)
> +		if (!groupc->nonidle_time && !groupc->nonidle)
>  			continue;
>  
> +		/*
> +		 * We come here for two things: 1) periodic per-cpu
> +		 * bucket flushing and averaging and 2) when the user
> +		 * wants to read a pressure file. For flushing and
> +		 * averaging, which is relatively infrequent, we can
> +		 * be lazy and tolerate some raciness with concurrent
> +		 * updates to the per-cpu counters. However, if a user
> +		 * polls the pressure state, we want to give them the
> +		 * most uptodate information we have, including any
> +		 * currently active state which hasn't been timed yet,
> +		 * because in case of an iowait or a reclaim run, that
> +		 * can be significant.
> +		 */
> +		if (ondemand) {
> +			rq = cpu_rq(cpu);
> +			rq_lock_irq(rq, &rf);

That's a DoS right there..
