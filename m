Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F820C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF0E2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LzRt3K/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF0E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeIGPF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:05:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbeIGPF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B+dRi740mod0o9eX5oP25W/39hKnSCs5AlkFv7wdLzE=; b=LzRt3K/BCZhQ62ztfj5+Vuwzb
        1Wrcml2mW7uBnYKGj5V5s5xKbcv1VCEn8RG961+8Ly+wcTXcPgGcA9C3RB1jdthOjo27bO9TcBQ6B
        3ljyLbGR9O8e2PewO8nbTmHxph5auSHS5w8ZZPui1rT5wSXfB5K+yczMkgMHsbzEmA2bLZlS6Vhy+
        tJo9euLKQQsjKM5SoGYF8G0O916XE0j56/4JXQ13AmSeZ4KW6ehApLcpPpcKuJCL99X4l6r1E6W69
        dyDZSDqBkcTdcX2FG2DZkzrzOdHCysYo3xZEI2bkNNTE4Dp+HFIVk0ba1ih+uf4FntCsdVEVyVcGy
        biL11IbRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyDwh-0000ba-PJ; Fri, 07 Sep 2018 10:24:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44C86201F9C46; Fri,  7 Sep 2018 12:24:58 +0200 (CEST)
Date:   Fri, 7 Sep 2018 12:24:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 8/9] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180907102458.GP24106@hirez.programming.kicks-ass.net>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
 <20180828172258.3185-9-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828172258.3185-9-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 01:22:57PM -0400, Johannes Weiner wrote:
> +static void psi_clock(struct work_struct *work)
> +{
> +	struct delayed_work *dwork;
> +	struct psi_group *group;
> +	bool nonidle;
> +
> +	dwork = to_delayed_work(work);
> +	group = container_of(dwork, struct psi_group, clock_work);
> +
> +	/*
> +	 * If there is task activity, periodically fold the per-cpu
> +	 * times and feed samples into the running averages. If things
> +	 * are idle and there is no data to process, stop the clock.
> +	 * Once restarted, we'll catch up the running averages in one
> +	 * go - see calc_avgs() and missed_periods.
> +	 */
> +
> +	nonidle = update_stats(group);
> +
> +	if (nonidle) {
> +		unsigned long delay = 0;
> +		u64 now;
> +
> +		now = sched_clock();
> +		if (group->next_update > now)
> +			delay = nsecs_to_jiffies(group->next_update - now) + 1;
> +		schedule_delayed_work(dwork, delay);
> +	}
> +}

Just a little nit; I would expect a function called *clock() to return a
time.
