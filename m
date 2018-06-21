Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B82FC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0F021A58
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZzCPc8HY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0F021A58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933229AbeFUSuu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:50:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932719AbeFUSut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/IG6tElobdxp1Kx6n8/fVriaFBHTjnwE/Zl9FElAV6A=; b=ZzCPc8HYhCkpY5HyeqV+KHfQu
        75IkoChoZfKRhQ9Fyz3l1IwnKBi7x4jJteE9p6tp2n479Cu6QH8W+ipwUXs9deIeoMhrBtLYGm7hV
        VP9P17kEGptzL2ceDE/48M/Xq5y1cYrPb5xwJ2xQXMe2kqTyBmgr3QmdIWBxX9ctHrvLrvlgwZo/r
        qqiUFkKAfJt7FZgp7agzb1/lHIS1oh2b38gABAoAAtxR8qXrSxoB/L1BOrx6eF4+DV2iZxoaBklzR
        Ni3NeQJFv7nILyVx5bb5wIf6YzPyhzCU034S2FhVYuN9HpZ43JcJrKi4QpC2POMfr6/U0PkKvFA5a
        eeVK9a62g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW4fJ-0007RV-PC; Thu, 21 Jun 2018 18:50:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 297B12029FA0A; Thu, 21 Jun 2018 20:50:40 +0200 (CEST)
Date:   Thu, 21 Jun 2018 20:50:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 03/11] sched/rt: add rt_rq utilization tracking
Message-ID: <20180621185040.GC27616@hirez.programming.kicks-ass.net>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-4-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528459794-13066-4-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 02:09:46PM +0200, Vincent Guittot wrote:
> +int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
> +{
> +	if (___update_load_sum(now, rq->cpu, &rq->avg_rt,
> +				running,
> +				running,
> +				running)) {

For code like this I wish C had grown named arguments for calls, just
like it has named initializers.

Something like:

	___update_load_sum(now, rq->cpu, &rq->avg_rt,
			   .load = running, .runnable = running,
			   .running = running)

would be so much easier to read... a well, maybe in another 30 years or
so.

> +		___update_load_avg(&rq->avg_rt, 1, 1);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
