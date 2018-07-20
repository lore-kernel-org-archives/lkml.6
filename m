Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2F1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5587120652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bw7AT1Qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5587120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeGTVZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:25:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbeGTVZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m3AslJrSGa4nehnkgY8erbmLSTX1GfmZUOxFRyZpk00=; b=Bw7AT1QhwIyLllWPym/ObCcIa
        aMQipMCI7ue8NSvd2gNzBmagWYuNwazbNgvTjCmlZktCqhKTrfR4MecTzZMs9r/s7mOmXJXC9B+2y
        gLJh52QBN7KleX2Jk9WQnBOeNiHUknwaowOaTuhf2+XtJg2qG9dmjQfPJIPPmhJWbx0wSfM3zjoRR
        AuJ00r6VXE7np61qBxUTLgz5G5FqWQMrQGiBzRL9Q+elD4oIWYsQ3aEPDnsk+xvF4rokNE1AndoAj
        S8ow6KuKhWgR0jJ8lKqWtyDMikXj0eNbH5UF5xh5Wqljx2G97RHNrlSf9YukM0wtKPsOEj84XVjFU
        tF4x7gH2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgc7c-0006CJ-Ag; Fri, 20 Jul 2018 20:35:28 +0000
Received: by worktop (Postfix, from userid 1000)
        id DD9BB6E0A92; Fri, 20 Jul 2018 22:35:24 +0200 (CEST)
Date:   Fri, 20 Jul 2018 22:35:24 +0200
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
Message-ID: <20180720203524.GD4920@worktop.programming.kicks-ass.net>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712172942.10094-9-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> +static bool psi_update_stats(struct psi_group *group)
> +{

> +	for_each_online_cpu(cpu) {
> +		struct psi_group_cpu *groupc = per_cpu_ptr(group->cpus, cpu);
> +		unsigned long nonidle;
> +
> +		if (!groupc->nonidle_time)
> +			continue;
> +
> +		nonidle = nsecs_to_jiffies(groupc->nonidle_time);
> +		groupc->nonidle_time = 0;
> +		nonidle_total += nonidle;
> +
> +		for (r = 0; r < NR_PSI_RESOURCES; r++) {
> +			struct psi_resource *res = &groupc->res[r];
> +
> +			some[r] += (res->times[0] + res->times[1]) * nonidle;
> +			full[r] += res->times[1] * nonidle;
> +
> +			/* It's racy, but we can tolerate some error */
> +			res->times[0] = 0;
> +			res->times[1] = 0;
> +		}
> +	}

An alternative for this, that also allows that ondemand update, but
without spamming the rq->lock would be something like:

struct psi_group_cpu {
	u32 tasks[3];
	u32 cpu_state : 2;
	u32 mem_state : 2;
	u32 io_state  : 2;
	u32 :0;

	u64 last_update_time;

	u32 nonidle;
	u32 full[2];
	u32 some[3];
} ____cacheline_aligned_in_smp;

/* Allocate _2_ copies */
DEFINE_PER_CPU_ALIGNED_SHARED(struct psi_group_cpu[2], psi_cpus);

struct psi_group global_psi = {
	.cpus = &psi_cpus[0],
};


	u64 sums[6] = { 0, };

	for_each_possible_cpu(cpu) {
		struct psi_group_cpu *pgc = per_cpu_ptr(group->cpus, cpu);
		u32 *active, *shadow;

		active = &pgc[0].nonidle;
		shadow = &pgc[1].nonidle;

		/*
		 * Compare the active count to the shadow count
		 * if different, compute the delta and update the shadow
		 * copy.
		 * This only writes to the shadow copy (separate line)
		 * and leaves the active a read-only access.
		 */
		for (i = 0; i < 6; i++) {
			u32 old = READ_ONCE(shadow[i]);
			u32 new = READ_ONCE(active[i]);

			delta = (new - old);
			if (!delta) {
				if (!i)
					goto next;
				continue;
			}

			WRITE_ONCE(shadow[i], new);

			sums[i] += delta;
		}
next:		;
	}
