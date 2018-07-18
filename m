Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292B2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E782084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="GJhavJ1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E782084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeGRWnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:43:33 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:40304 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeGRWnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:43:33 -0400
Received: by mail-yw0-f194.google.com with SMTP id p129-v6so2318958ywg.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wu822VWfbxTbIiJttkXqPEdGO8iaFFkoHKb0MR6LUhQ=;
        b=GJhavJ1CI0+lP0q3vonS3J1NpNHq1O0CDD50W8RtXWgK4ObbI+Qy65zeAny1IoopKz
         v2ufUHT03j4UlOJ0suI5T9mNRHmb9JggsFTdW3mwvtvmfBcYAY4j/eDflE6K1HkNnlcU
         uaIwZZ6AqIekkTX8a3jmHWli+PO64rvro6ZmvO6MhmKMvvuRInQuHEfV1cbZHUuvCcqX
         mgaSYVygsyr+VTBMJBBYg+SsxPDPb/Zv3xU41Q/fCuPtjgjtJdEStOQ+uhHE5jJcZ2p5
         DSS/VyrFd32GjrxEGrRJ2LHiAbNkKwU1fQVsiaBPjc98XodWakZjcIal0EzvPnwwooaS
         oo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wu822VWfbxTbIiJttkXqPEdGO8iaFFkoHKb0MR6LUhQ=;
        b=LyTW16Ng5gAahV61mzNR6n3tB7zM4BS8wZyYbp+FBebbre6wbxw85R8pzAYS7FM5K4
         GwsOTpptzqWyMM8Z3nuMF/UfoZ4XK5zHHccxbMwwNMZ71Dq1pMQ03wMLiyuCeeIKi8w9
         DrJIaAVGtSnD79yxgjYwoSI6+CDsnKPeJYyCsOao+dbmnWCrxmaA98H/vdWpdG+2pqNz
         EOOPTqerm28wh99SFuFVOvmJmNnFdQBGtlu31mXzLKIvfYxhyTnwC1PTicmI8lgCjp0h
         AjNVTOVg5g9N4c/nrqfb9Bf7LDCn9gYFEoVMatIqYdfWIfKIPPYdlKxU5htco8/zM89p
         ki8g==
X-Gm-Message-State: AOUpUlEFIWz/ksQ0jVpqTO0sPauaAOtPzG7Xjef6CMEVrpYwFriL4tx0
        pVsqH3oocXHF1Sc/0r5wPUQclw==
X-Google-Smtp-Source: AAOMgpcLm87eygjIaI8Zx/epYFlaLGqxI6Wwc7rO28o9ErKSiQXJqjBJHEzHnKeSklSkghH/u+7KaA==
X-Received: by 2002:a81:7742:: with SMTP id s63-v6mr4178720ywc.197.1531951417909;
        Wed, 18 Jul 2018 15:03:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:7eca])
        by smtp.gmail.com with ESMTPSA id o81-v6sm2120860ywb.76.2018.07.18.15.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 15:03:36 -0700 (PDT)
Date:   Wed, 18 Jul 2018 18:06:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20180718220623.GE2838@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180717150142.GG2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717150142.GG2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 05:01:42PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> > +static bool psi_update_stats(struct psi_group *group)
> > +{
> > +	u64 some[NR_PSI_RESOURCES] = { 0, };
> > +	u64 full[NR_PSI_RESOURCES] = { 0, };
> > +	unsigned long nonidle_total = 0;
> > +	unsigned long missed_periods;
> > +	unsigned long expires;
> > +	int cpu;
> > +	int r;
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
> > +	 * We could pin the online CPUs here, but the noise introduced
> > +	 * by missing up to one sample period from CPUs that are going
> > +	 * away shouldn't matter in practice - just like the noise of
> > +	 * previously offlined CPUs returning with a non-zero sample.
> 
> But why!? cpuu_read_lock() is neither expensive nor complicated. So why
> try and avoid it?

Hm, I don't feel strongly about it either way. I'll add it.

> > +	/* total= */
> > +	for (r = 0; r < NR_PSI_RESOURCES; r++) {
> > +		do_div(some[r], max(nonidle_total, 1UL));
> > +		do_div(full[r], max(nonidle_total, 1UL));
> > +
> > +		group->some[r] += some[r];
> > +		group->full[r] += full[r];
> 
> 		group->some[r] = div64_ul(some[r], max(nonidle_total, 1UL));
> 		group->full[r] = div64_ul(full[r], max(nonidle_total, 1UL));
> 
> Is easier to read imo.

Sounds good to me, I'll change that.
