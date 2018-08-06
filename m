Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1AFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B6721A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="WaGZApsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B6721A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbeHFR0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:26:06 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39056 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730598AbeHFR0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:26:05 -0400
Received: by mail-qt0-f195.google.com with SMTP id q12-v6so14185193qtp.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sd6+AX5ValtK5nonsSEKPN6Q0xXyBVYmGqNm1ZxeJn8=;
        b=WaGZApsc8HB0EGax2FAsXPazDIuX6tMngH0dPD5qKuzqzXYU7oJxVI3hzFbINw42yR
         jwuHFttFt9Vt3NOMrYwxJ5QnaruOE/WVQk0zq4rKa7F/QQYgIqlvc8edlVIGtUv9vptS
         ckSuKZIjn7b3GXserFRGevOLZIvv9w6zPJYhZrqi4bvtLicuvelp8pGFS8j1ub9X9yw+
         HQi5uhJDdbDq38q5o4O6YjnCCtTvXVCM5tQGVQ9v7VQMTrcbDcj49aQGNVzF+XcP8WlL
         rH+dUWfdrH3fIEFn0JY8sWyKEup0Jpt5m1wCWhScICbnCE1FP6LzYAoPYzWW6V16bWIO
         S3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sd6+AX5ValtK5nonsSEKPN6Q0xXyBVYmGqNm1ZxeJn8=;
        b=ZmCa/5Hhsv0AHQ9absmSeqA9j4sYOwlaGg9kWGnO42/reByA7dgjdU6NgVRScmMKSJ
         uFEpskV8tLENWj59gyuT2gW900ZugaSMqpUs9/OHOjhkjsa9hQ97YS2kHXP9SLSZZ9Uy
         kwck/O3i1RoJj4kZAmf389L4L7+l2cEbTw9p62StidvWnudAJtugNH2MUUDCckQUefGj
         RQJDYSsC4iiVvbYw6Pg0m3/wuEbq8YUp17AA3ESoyQ27lmDs1xrIq/EVgKrra9cVH6kM
         Rar8RhlYqaT9hPTq3a0ljXVRpLjQToJt8UOzuZZ7WObfPla6KdNPR7S3Qy6VJM36MlIO
         Vu/w==
X-Gm-Message-State: AOUpUlEtNj4cMRnt7PNVYzbrGpLEUDVn4wvqwSrdhhPeEdFc7ML8QfiI
        4DP4ax9xYYPqS5O6o0iZCrAMIw==
X-Google-Smtp-Source: AAOMgpfxrIaHuLAIoWR5qT0f5ZSbS7LuHgq8wnrer5iMXfT7X3eKN8WCrwF9Ho3QmdomRaQk7QbhIw==
X-Received: by 2002:ac8:1b07:: with SMTP id y7-v6mr14199423qtj.166.1533568590955;
        Mon, 06 Aug 2018 08:16:30 -0700 (PDT)
Received: from localhost (pool-96-246-38-36.nycmny.fios.verizon.net. [96.246.38.36])
        by smtp.gmail.com with ESMTPSA id g19-v6sm8314625qtk.80.2018.08.06.08.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 08:16:29 -0700 (PDT)
Date:   Mon, 6 Aug 2018 11:19:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20180806151928.GB9888@cmpxchg.org>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
 <20180801151958.32590-9-hannes@cmpxchg.org>
 <20180803165641.GA2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803165641.GA2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 06:56:41PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 01, 2018 at 11:19:57AM -0400, Johannes Weiner wrote:
> > +static bool psi_update_stats(struct psi_group *group)
> > +{
> > +	u64 deltas[NR_PSI_STATES - 1] = { 0, };
> > +	unsigned long missed_periods = 0;
> > +	unsigned long nonidle_total = 0;
> > +	u64 now, expires, period;
> > +	int cpu;
> > +	int s;
> > +
> > +	mutex_lock(&group->stat_lock);
> > +
> > +	/*
> > +	 * Collect the per-cpu time buckets and average them into a
> > +	 * single time sample that is normalized to wallclock time.
> > +	 *
> > +	 * For averaging, each CPU is weighted by its non-idle time in
> > +	 * the sampling period. This eliminates artifacts from uneven
> > +	 * loading, or even entirely idle CPUs.
> > +	 *
> > +	 * We don't need to synchronize against CPU hotplugging. If we
> > +	 * see a CPU that's online and has samples, we incorporate it.
> > +	 */
> > +	for_each_online_cpu(cpu) {
> > +		struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
> > +		u32 uninitialized_var(nonidle);
> 
> urgh.. I can see why the compiler got confused. Dodgy :-)

:-) I think we can make this cleaner. Something like this (modulo the
READ_ONCE/WRITE_ONCE you pointed out in the other email)?

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index abccfddba5d5..ce6f02ada1cd 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -220,6 +220,49 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 	}
 }
 
+static u32 read_update_delta(struct psi_group_cpu *groupc,
+			     enum psi_states state, int cpu)
+{
+	u32 time, delta;
+
+	time = READ_ONCE(groupc->times[state]);
+	/*
+	 * In addition to already concluded states, we also
+	 * incorporate currently active states on the CPU, since
+	 * states may last for many sampling periods.
+	 *
+	 * This way we keep our delta sampling buckets small (u32) and
+	 * our reported pressure close to what's actually happening.
+	 */
+	if (test_state(groupc->tasks, state)) {
+		/*
+		 * We can race with a state change and need to make
+		 * sure the state_start update is ordered against the
+		 * updates to the live state and the time buckets
+		 * (groupc->times).
+		 *
+		 * 1. If we observe task state that needs to be
+		 * recorded, make sure we see state_start from when
+		 * that state went into effect or we'll count time
+		 * from the previous state.
+		 *
+		 * 2. If the time delta has already been added to the
+		 * bucket, make sure we don't see it in state_start or
+		 * we'll count it twice.
+		 *
+		 * If the time delta is out of state_start but not in
+		 * the time bucket yet, we'll miss it entirely and
+		 * handle it in the next period.
+		 */
+		smp_rmb();
+		time += cpu_clock(cpu) - groupc->state_start;
+	}
+	delta = time - groupc->times_prev[state];
+	groupc->times_prev[state] = time;
+
+	return delta;
+}
+
 static bool psi_update_stats(struct psi_group *group)
 {
 	u64 deltas[NR_PSI_STATES - 1] = { 0, };
@@ -244,60 +287,17 @@ static bool psi_update_stats(struct psi_group *group)
 	 */
 	for_each_online_cpu(cpu) {
 		struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
-		u32 uninitialized_var(nonidle);
-
-		BUILD_BUG_ON(PSI_NONIDLE != NR_PSI_STATES - 1);
-
-		for (s = PSI_NONIDLE; s >= 0; s--) {
-			u32 time, delta;
-
-			time = READ_ONCE(groupc->times[s]);
-			/*
-			 * In addition to already concluded states, we
-			 * also incorporate currently active states on
-			 * the CPU, since states may last for many
-			 * sampling periods.
-			 *
-			 * This way we keep our delta sampling buckets
-			 * small (u32) and our reported pressure close
-			 * to what's actually happening.
-			 */
-			if (test_state(groupc->tasks, cpu, s)) {
-				/*
-				 * We can race with a state change and
-				 * need to make sure the state_start
-				 * update is ordered against the
-				 * updates to the live state and the
-				 * time buckets (groupc->times).
-				 *
-				 * 1. If we observe task state that
-				 * needs to be recorded, make sure we
-				 * see state_start from when that
-				 * state went into effect or we'll
-				 * count time from the previous state.
-				 *
-				 * 2. If the time delta has already
-				 * been added to the bucket, make sure
-				 * we don't see it in state_start or
-				 * we'll count it twice.
-				 *
-				 * If the time delta is out of
-				 * state_start but not in the time
-				 * bucket yet, we'll miss it entirely
-				 * and handle it in the next period.
-				 */
-				smp_rmb();
-				time += cpu_clock(cpu) - groupc->state_start;
-			}
-			delta = time - groupc->times_prev[s];
-			groupc->times_prev[s] = time;
-
-			if (s == PSI_NONIDLE) {
-				nonidle = nsecs_to_jiffies(delta);
-				nonidle_total += nonidle;
-			} else {
-				deltas[s] += (u64)delta * nonidle;
-			}
+		u32 nonidle;
+
+		nonidle = read_update_delta(groupc, PSI_NONIDLE, cpu);
+		nonidle = nsecs_to_jiffies(nonidle);
+		nonidle_total += nonidle;
+
+		for (s = 0; s < PSI_NONIDLE; s++) {
+			u32 delta;
+
+			delta = read_update_delta(groupc, s, cpu);
+			deltas[s] += (u64)delta * nonidle;
 		}
 	}
 
