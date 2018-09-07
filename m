Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8B7C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081902086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cO+ClPLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081902086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeIGPCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:02:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54888 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbeIGPCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Eq01cLMg5iKSpygwdgzLuH8ZJOgXQTo85H8k76w6kQE=; b=cO+ClPLjcCRKc9Vk5rAhcgKG5
        apmJAE4BZclQUraoT+/LshdygtxYfd7v68xRktCTMt5Q51zBa9FTLrtobQiJvZQE6IKMkING4KfRO
        hDVTIMT0daV0oTUzWvQwCy67rD35BcOS5rhOEuClnrOPCj04dsmy64sCXPWd+Uemsrd/brgGjU5sq
        1XOIhOXHBKbjIa0X4+Ke80qZ9AAL2J/mT5nT550p6dgWtfcpK5P+YOUq7zAslccDACWH5DJqAHUVs
        YBdhKSZJKeDLM3J0t8gWxnCCT08quaWfuiZBaw2/itFXSK9dmfbFCfGAu0qA+TPVI69vlMZii2EVN
        0gVsHx3Sw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyDtc-0000nB-FV; Fri, 07 Sep 2018 10:21:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EA24D201F9C46; Fri,  7 Sep 2018 12:21:46 +0200 (CEST)
Date:   Fri, 7 Sep 2018 12:21:46 +0200
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
Message-ID: <20180907102146.GI24142@hirez.programming.kicks-ass.net>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
 <20180828172258.3185-9-hannes@cmpxchg.org>
 <20180907101634.GO24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907101634.GO24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:16:34PM +0200, Peter Zijlstra wrote:
> This does the whole seqcount thing 6x, which is a bit of a waste.
> 
> struct snapshot {
> 	u32 times[NR_PSI_STATES];
> };
> 
> static inline struct snapshot get_times_snapshot(struct psi_group *pg, int cpu)
> {
> 	struct pci_group_cpu *pgc = per_cpu_ptr(pg->pcpu, cpu);
> 	struct snapshot s;
> 	unsigned int seq;
> 	u32 delta;
> 	int i;
> 
> 	do {
> 		seq = read_seqcount_begin(&pgc->seq);
> 
> 		delta = cpu_clock(cpu) - pgc->state_start;
> 		for (i = 0; i < NR_PSI_STATES; i++) {
> 			s.times[i] = gpc->times[i];
> 			if (test_state(pgc->tasks, i))
> 				s.times[i] += delta;
> 		}
> 
> 	} while (read_seqcount_retry(&pgc->seq, seq);

Sorry, I forgot the whole times_prev thing:

	for (i = 0; i < NR_PSI_STATES; i++) {
		tmp = s.times[i];
		s.times[i] -= pgc->times_prev[i];
		pgc->times_prev[i] = tmp;
	}

> 	return s;
> }
> 
> 
> 	for_each_possible_cpu(cpu) {
> 		struct snapshot s = get_times_snapshot(pg, cpu);
> 
> 		nonidle = nsecs_to_jiffies(s.times[PSI_NONIDLE]);
> 		nonidle_total += nonidle;
> 
> 		for (i = 0; i < PSI_NONIDLE; i++)
> 			deltas[s] += (u64)s.times[i] * nonidle;
> 
> 		/* ... */
> 
> 	}
> 
> 
> It's a bit cumbersome, but that's because of C.
