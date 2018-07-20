Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFD2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24951205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="akk6uf5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24951205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbeGTO7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:59:36 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37276 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731203AbeGTO7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:59:36 -0400
Received: by mail-qt0-f193.google.com with SMTP id n6-v6so5809359qtl.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1eKckAY6Q8yGz2v8taoR+58hqhVZAG5hgWuBNXgBA8U=;
        b=akk6uf5jnv3Zy1VFcpTFGgNmaYsJXuDrFH5QUCroLeAF902e3LhFgsUOau+Rbmb69q
         pOsOnvJfUd61S6IgFhCdCenoMS2fG87oXUatq/Y/QVZ8cDIbJ/vM+qmZmmKnRXCkCfPJ
         goofJZTR1N1BD9ct9W7dcOxXr2Jw75gMl6EEGqseQIYZKSaJu7lUJLCSGbcZqSSL45eJ
         jUI0UgMryTmnFRX+6E4ZrC0OWt4mhwe6oHaF21QuAmnUds1FnsmJ3gJDCSBurlox4m98
         zPRTBFzWh9dc0Cg0cfWx6B1UOFSf9Htl6afr6qx/At7erTcDqGGgB1l+O+R6lBNVeZAr
         a1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1eKckAY6Q8yGz2v8taoR+58hqhVZAG5hgWuBNXgBA8U=;
        b=B79pjCWQhop3Y4pzAQGvJ7UXU2dTYxDUC1Pse9m3qTlxQZmJDuU8iK+LqPYFKcvI0R
         q/j3eUhcSTJ6ie51yQnLmpmmDEdlJRlaFQfOxGTgrDGwTUARuwIWKWRkz2I9Ee6NV9KN
         ynOmLQsgCmc5WEae/AJBJ27OjdpNJe2T6RWdHH1ODuK/QUo8rf6kHcuMUcOaX3TJMiIx
         A0qWv7XfsTw+lZ9mxoh8tzO7B89NvNQCtqtYILbyZ45fmQXri53zeSDL4usE8CpjOyl5
         ucFMFdOfs1yKDQbuPoCm9oJySxEjipXPnRBU2mUk00j9BongCXPF5qve2V5A3kEUE1pE
         RAvA==
X-Gm-Message-State: AOUpUlEu3VVTMqvjh8B6SgxPoIQT3G5Im1f/2NebSk8u+ljNZot7IeNn
        8aORh1UnTTZENfSzq1ksmrSWeGYOmeI=
X-Google-Smtp-Source: AAOMgpf/ccr2HrnJhtX4dzY7omx2HsjLnic3CTnd40iTr79oeKNg2VqkzX0I4clgYcMDlb+WVVT9tA==
X-Received: by 2002:aed:3803:: with SMTP id j3-v6mr2065466qte.353.1532095867530;
        Fri, 20 Jul 2018 07:11:07 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id v129-v6sm1195039qkd.86.2018.07.20.07.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 07:11:06 -0700 (PDT)
Date:   Fri, 20 Jul 2018 10:13:54 -0400
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
Message-ID: <20180720141354.GA1729@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180717150142.GG2494@hirez.programming.kicks-ass.net>
 <20180718220623.GE2838@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718220623.GE2838@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 06:06:23PM -0400, Johannes Weiner wrote:
> On Tue, Jul 17, 2018 at 05:01:42PM +0200, Peter Zijlstra wrote:
> > On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> > > +static bool psi_update_stats(struct psi_group *group)
> > > +{
> > > +	u64 some[NR_PSI_RESOURCES] = { 0, };
> > > +	u64 full[NR_PSI_RESOURCES] = { 0, };
> > > +	unsigned long nonidle_total = 0;
> > > +	unsigned long missed_periods;
> > > +	unsigned long expires;
> > > +	int cpu;
> > > +	int r;
> > > +
> > > +	mutex_lock(&group->stat_lock);
> > > +
> > > +	/*
> > > +	 * Collect the per-cpu time buckets and average them into a
> > > +	 * single time sample that is normalized to wallclock time.
> > > +	 *
> > > +	 * For averaging, each CPU is weighted by its non-idle time in
> > > +	 * the sampling period. This eliminates artifacts from uneven
> > > +	 * loading, or even entirely idle CPUs.
> > > +	 *
> > > +	 * We could pin the online CPUs here, but the noise introduced
> > > +	 * by missing up to one sample period from CPUs that are going
> > > +	 * away shouldn't matter in practice - just like the noise of
> > > +	 * previously offlined CPUs returning with a non-zero sample.
> > 
> > But why!? cpuu_read_lock() is neither expensive nor complicated. So why
> > try and avoid it?
> 
> Hm, I don't feel strongly about it either way. I'll add it.

Thinking more about it, this really doesn't buy anything. Whether a
CPU comes online or goes offline during the loop is no different than
that happening right before grabbing the cpus_read_lock(). If we see a
sample from a CPU, we incorporate it, if not we don't.

So it's not so much avoidance as it's lack of reason for synchronizing
against hotplugging in any fashion. The comment is wrong. This noise
it points to is there with and without the lock, and the only way to
avoid it would be to do either for_each_possible_cpu() in that loop or
having a hotplug callback that would flush the offlining CPU bucket
into a holding place for missed dead cpu samples that the aggregation
loop checks every time. Neither of these seem remotely worth the cost.

I'll fix the comment instead.
