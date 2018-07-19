Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932E0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC5A20856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="w7eaUiZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC5A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbeGSSfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:35:33 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:46964 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731699AbeGSSfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:35:32 -0400
Received: by mail-yb0-f195.google.com with SMTP id c3-v6so3592653ybi.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 10:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eiqsWTxMloG3jXlacTFcz45bqVpxQEMMAp/qxR7ltn0=;
        b=w7eaUiZAJOauA9UXAmgmNehFlIEETn578nohUb1UsfkuyhK5uXadRY6591KPCN+pNb
         4Bqvwph9+44OIB0rZCeArggih+/aGAU3Gc6+SMw2C3XiUCPiLZ4GyqanA29sh6cuoo+1
         v2LIoNQj7GP+MxI+UN/AaXjiBbb9ZqVcoy3ISqyrf55ntpJBuEDkHPrkKdsMI1HSnxkp
         49eoYfAHQDh46odwRW/z6cVb+9bMPA4/x7dQpJG/C4/r58JfKiZxI6JwwSIt8i0htKmX
         z7vHjvMuKpSsURvswpZvahUk88TD+fxBhObJqa6+OwYJvszxca1zXzuKTBKZFZLU3F9O
         b1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eiqsWTxMloG3jXlacTFcz45bqVpxQEMMAp/qxR7ltn0=;
        b=h0+4RfAHwW5LxcjKR1AowAmZwHIAs5M687T6bOYK3uoEfrUspM9wfG0lX13WTleylr
         cnE5Hf/JU5frrDRTV+rhO4xf29QMg6fiYJ3lfV5SBxxrMQeWB2VF4gnCyIm2j6pFRFCw
         pfwTeXVWSwmfZs/udH44WzwX/M042clPNIFch+ELByTylQkNj+UVWnzfrC9NyRVujuYk
         aBoiunpQWG16nIZhzWiZETfDqbKgQDT1ixAQZrzAD6hZWqv6mJ3P6QTb8vhBc5wM5I5C
         TP5EEDOrwLt4zExZpT8rIRdIZYTj/9IihaOexSFbEDh/h/24pvo8hHfRG6lfuSEdbbXM
         a5IQ==
X-Gm-Message-State: AOUpUlHax2sOc4MgNg/WSLV0I74T8O8X938YI/RamNj6VAE390VDcxy+
        sNshg0ROrhtHLU00O3qHsy+SUQ==
X-Google-Smtp-Source: AAOMgpeE/5EIgAffJSPFEV5R4unXImzIYWXAIg2xrhLdCWa6Fc74mFLKmXN+nzbVTf1bNrHKdisz9w==
X-Received: by 2002:a25:9a04:: with SMTP id x4-v6mr5795045ybn.182.1532022678143;
        Thu, 19 Jul 2018 10:51:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:3a18])
        by smtp.gmail.com with ESMTPSA id z125-v6sm3886540ywg.57.2018.07.19.10.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 10:51:16 -0700 (PDT)
Date:   Thu, 19 Jul 2018 13:54:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, surenb@google.com,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christoph Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>, shakeelb@google.com,
        linux-mm <linux-mm@kvack.org>, cgroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180719175405.GA19230@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180718120318.GC2476@hirez.programming.kicks-ass.net>
 <CA+55aFw7t++BzEy-XsatNcauw3Wn22SSXfd3iTYECi4fJ97CCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFw7t++BzEy-XsatNcauw3Wn22SSXfd3iTYECi4fJ97CCg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 08:08:20AM -0700, Linus Torvalds wrote:
> On Wed, Jul 18, 2018 at 5:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > And as said before, we can compress the state from 12 bytes, to 6 bits
> > (or 1 byte), giving another 11 bytes for 59 bytes free.
> >
> > Leaving us just 5 bytes short of needing a single cacheline :/
> 
> Do you actually need 64 bits for the times?
> 
> That's the big cost. And it seems ridiculous, if you actually care about size.
> 
> You already have a 64-bit start time. Everything else is some
> cumulative relative time. Do those really need 64-bit and nanosecond
> resolution?
> 
> Maybe a 32-bit microsecond would be ok - would you ever account more
> than 35 minutes of anything without starting anew?

D'oh, you're right, the per-cpu buckets don't need to be this big at
all. In fact, we flush those deltas out every 2 seconds when there is
activity to maintain the running averages. Since we get 4.2s worth of
nanoseconds into a u32, we don't even need to divide in the hotpath.

Something along the lines of this here should work:

static void psi_group_change(struct psi_group *group, int cpu, u64 now,
			     unsigned int clear, unsigned int set)
{
	struct psi_group_cpu *groupc;
	unsigned int *tasks;
	unsigned int t;
	u32 delta;

	groupc = per_cpu_ptr(group->cpus, cpu);
	tasks = groupc->tasks;

	/* Time since last task change on this runqueue */
	delta = now - groupc->last_time;
	groupc->last_time = now;

	/* Tasks waited for IO? */
	if (tasks[NR_IOWAIT]) {
		if (!tasks[NR_RUNNING])
			groupc->full_time[PSI_IO] += delta;
		else
			groupc->some_time[PSI_IO] += delta;
	}

	/* Tasks waited for memory? */
	if (tasks[NR_MEMSTALL]) {
		if (!tasks[NR_RUNNING] ||
		    (cpu_curr(cpu)->flags & PF_MEMSTALL))
			groupc->full_time[PSI_MEM] += delta;
		else
			groupc->some_time[PSI_MEM] += delta;
	}

	/* Tasks waited for the CPU? */
	if (tasks[NR_RUNNING] > 1)
		groupc->some_time[PSI_CPU] += delta;

	/* Tasks were generally non-idle? To weigh the CPU in summaries */
	if (tasks[NR_RUNNING] || tasks[NR_IOWAIT] || tasks[NR_MEMSTALL])
		groupc->nonidle_time += delta;

	/* Update task counts according to the set/clear bitmasks */
	for (t = 0; clear; clear &= ~(1 << t), t++)
		if (clear & (1 << t))
			groupc->tasks[t]--;
	for (t = 0; set; set &= ~(1 << t), t++)
		if (set & (1 << t))
			groupc->tasks[t]++;

	/* Kick the stats aggregation worker if it's gone to sleep */
	if (!delayed_work_pending(&group->clock_work))
		schedule_delayed_work(&group->clock_work, PSI_FREQ);
}

And then we can pack it down to one cacheline:

struct psi_group_cpu {
	/* States of the tasks belonging to this group */
	unsigned int tasks[NR_PSI_TASK_COUNTS]; // 3

	/* Time sampling bucket for pressure states - no FULL for CPU */
	u32 some_time[NR_PSI_RESOURCES];
	u32 full_time[NR_PSI_RESOURCES - 1];

	/* Time sampling bucket for non-idle state (ns) */
	u32 nonidle_time;

	/* Time of last task change in this group (rq_clock) */
	u64 last_time;
};

I'm going to go test with this.

Thanks
