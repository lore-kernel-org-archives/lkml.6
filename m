Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024AAC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC47A2178D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rPUzNrvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC47A2178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeHCTE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:04:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44236 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeHCTE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5szedLwDdh86mfXSaF1CUenBlLCBHTbq16JXDwCdXgM=; b=rPUzNrvviOfJj4rJWXZG62SRr
        ZA1XxmAH2aFsOgae2LLaWGe3xyNu6a+yTRm1AKeO96b09fHdfTZP6x9dQGUtPk4h0Y+mCr5n47VL+
        yT38RhAxlL8QQKNU6uX7OUGBpC4CFNEE/mhOWYLZlm1dEH3fS+5idtAF9VVMjtnOwHDuLe+NBGdsz
        JU3o7OIzEKPMe+99qPcimd98GXecyjUAj+dsRt94+eA4jmsX+cDTSSYenrF4fDXCooCHpC4IzW2Hy
        lXrb4Euqj1Q+omTfS6yyvwK0QMbikZ6jiQ63fE/Af/utB8uStbxStc+6NxGdrQ8BPUDnk59SuVn+d
        aGyT/ryMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fldY6-0007JT-S2; Fri, 03 Aug 2018 17:07:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C9F620267E51; Fri,  3 Aug 2018 19:07:33 +0200 (CEST)
Date:   Fri, 3 Aug 2018 19:07:33 +0200
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
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 8/9] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180803170733.GC2494@hirez.programming.kicks-ass.net>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
 <20180801151958.32590-9-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801151958.32590-9-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 11:19:57AM -0400, Johannes Weiner wrote:
> +static bool psi_update_stats(struct psi_group *group)
> +{
> +	u64 deltas[NR_PSI_STATES - 1] = { 0, };
> +	unsigned long missed_periods = 0;
> +	unsigned long nonidle_total = 0;
> +	u64 now, expires, period;
> +	int cpu;
> +	int s;
> +
> +	mutex_lock(&group->stat_lock);
> +
> +	/*
> +	 * Collect the per-cpu time buckets and average them into a
> +	 * single time sample that is normalized to wallclock time.
> +	 *
> +	 * For averaging, each CPU is weighted by its non-idle time in
> +	 * the sampling period. This eliminates artifacts from uneven
> +	 * loading, or even entirely idle CPUs.
> +	 *
> +	 * We don't need to synchronize against CPU hotplugging. If we
> +	 * see a CPU that's online and has samples, we incorporate it.
> +	 */
> +	for_each_online_cpu(cpu) {

I'm still puzzled by this.. for 99% of the machines online == possible.
Why not always iterate possible and leave it at that? This is hardly a
fast path.

