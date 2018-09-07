Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3270EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53452083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="HvDjD5P/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53452083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbeIGTZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:25:40 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36855 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbeIGTZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:25:39 -0400
Received: by mail-yw1-f65.google.com with SMTP id w202-v6so5478717yww.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xi0HJJ6Xvyxvxsf/RyFY/V2+9m/vHC2cCblt4mYHDoY=;
        b=HvDjD5P/BQXbDDhdfdULZUDgagz+ZGKyCQvSzj/DeNvuO2arah2uzdmDwHPNXd7BQo
         zmDnf0eddWXISnrmg/ks7id5jbGnPWFH1tOR9zeIMBXWVSxPxN44rGFFbUsTtozjR2MH
         oskyRNwOk+vRcUN6FCRDHX5+G7FR/AVhAbQVddoD22G2GNa/CBT5d8yY7idPuz+xNklS
         iEoXOia4czMku3vq+Vfajl+cymvDo6yB1aNgj+8BqMwRtvQhFs82QhSV+5kZm249krK5
         S5mLQRhVMptA9Djd+5avCf/1kPnhv+eth+7ra+Exjhk0UXUJv33qvDIy8rJpW0z1fQOw
         4LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xi0HJJ6Xvyxvxsf/RyFY/V2+9m/vHC2cCblt4mYHDoY=;
        b=d7Nu127JSAVQoYYcNzgZLTMUHQvd+uU0z4XDyPpSp5p9gACC213At4MwsQhz96DcKc
         7KC1o0vEtLNlFlIbcuAbeFPNO6ID4HS89k9Sqn5BLYaqK3LKrsVrp/K7/LclxVLRXYSa
         6mLKdBrd1K/IXSrZfonPo5gGKC4PVp56w8MN3VkBkF1rQ2fgXU0LWi1KBltDiRc2fKiF
         a/nve6Hdi6DI3ES8y6PQHwvwcr/EL94W0wSTfoNkEY0OB5w0YOrZqoHzOMyWnhmLZXZm
         T4FJZGxqrh34kmYRZ9veKjSe3Xeu0nzFuoCXXgxUMVlINr0c8dzX/AJwl+fdzrqugyE0
         dtBw==
X-Gm-Message-State: APzg51Cd7IaBEbonBR9M75jLrPUUwK49vKFKTAfHevOch7kuD2Rsr3IQ
        2FEBKxcwMhkhidS/LuzC6VA0Ug==
X-Google-Smtp-Source: ANB0VdZxD5dCDWMEDBptWHdlotwvJa79UvbpmA8ZJScou0g9BWaH8CmnYX9j2hbZBth3op2OKfjuMA==
X-Received: by 2002:a81:4956:: with SMTP id w83-v6mr4125529ywa.482.1536331464682;
        Fri, 07 Sep 2018 07:44:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:96d9])
        by smtp.gmail.com with ESMTPSA id c69-v6sm3244968ywb.11.2018.09.07.07.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 07:44:23 -0700 (PDT)
Date:   Fri, 7 Sep 2018 10:44:22 -0400
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
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 8/9] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180907144422.GA11088@cmpxchg.org>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
 <20180828172258.3185-9-hannes@cmpxchg.org>
 <20180907101634.GO24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907101634.GO24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:16:34PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 28, 2018 at 01:22:57PM -0400, Johannes Weiner wrote:
> > +enum psi_states {
> > +	PSI_IO_SOME,
> > +	PSI_IO_FULL,
> > +	PSI_MEM_SOME,
> > +	PSI_MEM_FULL,
> > +	PSI_CPU_SOME,
> > +	/* Only per-CPU, to weigh the CPU in the global average: */
> > +	PSI_NONIDLE,
> > +	NR_PSI_STATES,
> > +};
> 
> > +static u32 get_recent_time(struct psi_group *group, int cpu,
> > +			   enum psi_states state)
> > +{
> > +	struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
> > +	unsigned int seq;
> > +	u32 time, delta;
> > +
> > +	do {
> > +		seq = read_seqcount_begin(&groupc->seq);
> > +
> > +		time = groupc->times[state];
> > +		/*
> > +		 * In addition to already concluded states, we also
> > +		 * incorporate currently active states on the CPU,
> > +		 * since states may last for many sampling periods.
> > +		 *
> > +		 * This way we keep our delta sampling buckets small
> > +		 * (u32) and our reported pressure close to what's
> > +		 * actually happening.
> > +		 */
> > +		if (test_state(groupc->tasks, state))
> > +			time += cpu_clock(cpu) - groupc->state_start;
> > +	} while (read_seqcount_retry(&groupc->seq, seq));
> > +
> > +	delta = time - groupc->times_prev[state];
> > +	groupc->times_prev[state] = time;
> > +
> > +	return delta;
> > +}
> 
> > +static bool update_stats(struct psi_group *group)
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
> > +	 */
> > +	for_each_possible_cpu(cpu) {
> > +		u32 nonidle;
> > +
> > +		nonidle = get_recent_time(group, cpu, PSI_NONIDLE);
> > +		nonidle = nsecs_to_jiffies(nonidle);
> > +		nonidle_total += nonidle;
> > +
> > +		for (s = 0; s < PSI_NONIDLE; s++) {
> > +			u32 delta;
> > +
> > +			delta = get_recent_time(group, cpu, s);
> > +			deltas[s] += (u64)delta * nonidle;
> > +		}
> > +	}
> 
> This does the whole seqcount thing 6x, which is a bit of a waste.

[...]

> It's a bit cumbersome, but that's because of C.

I was actually debating exactly this with Suren before, but since this
is a super cold path I went with readability. I was also thinking that
restarts could happen quite regularly under heavy scheduler load, and
so keeping the individual retry sections small could be helpful - but
I didn't instrument this in any way.

No strong opinion from me, I can send an updated patch if you prefer.
