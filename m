Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182B7C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3A620671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="phMWhlSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3A620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbeGZVWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:22:53 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:41589 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731321AbeGZVWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:22:53 -0400
Received: by mail-yb0-f196.google.com with SMTP id s8-v6so1134883ybe.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 13:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S06jft4YnWx4UT7YoeoGB9ShXqMj43Cxz83s8sP/Sck=;
        b=phMWhlSfNKWjvsFkc3g7/135Q2Psobwy3XANCxOvpnKJbRLdQl/6EdBVSLOAVXPu02
         BsB3KFz8fmUSrrnTlxvLCF+s2aGYxeEhjbJLYKtgO7n8dZhZJs3X2ax8CuO0MIZBbmUy
         7Ia1Sd82mt+ZrctSl1iVQWYK6iB6cIG1AZ/oz69JdqoKOKdlGllFqXqb0TjdliVOFN+f
         4tA+2AMnzhb9wxnQqPCawOaqu2HRieJkUcxOaWoQpIBONC5JW2ggCy/QOFJTl/oXr/mw
         QjDeFHKo/KYY4D6Szg1H48fTMjNnh/bPHJr+VMYN7zkazZZ4ejjodtWTj7aCZ2EVLxhn
         fK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S06jft4YnWx4UT7YoeoGB9ShXqMj43Cxz83s8sP/Sck=;
        b=NFVdfb7eBWaBrMEmR4kfHP29wCywE/jx/fm1cPrcVmJyOdmi8ActoR2laN9AdHYqdj
         qLCDuUDrTNxFZb4uexLc+UrPlasMWGYU+oexMvK7vQN94jNxu8PoJiLwH1VFG6/trAeO
         c0jCuZmvxuLDU06vap14DQ42uts219sVnfhhqB4rF9ChJCgoyyA0rUIEPl7jiHFEu4S/
         QFd0wLbfCeRlDefilz0GNwanK5p7V7IbwNaG1M/XfqU7aZSGB5gkSpytDFQS/FMDab2x
         hZqN9B3CaujsitNuwa0toqK/538GvWjmKS8wKDVlCz2REy8VhodyYcmwxsyGvFCe2h68
         WZqQ==
X-Gm-Message-State: AOUpUlFEBwu6XSaepFyDqjqsbLP2FrNUyUP7iriwnz/arG+JfFWaOdKW
        UEQsPQgoVZ9fVAjzpHLZ3RT/rA==
X-Google-Smtp-Source: AAOMgpck7soeqV9J9OFba6n2ojl+5f6ad/vXOFet/u97ngYwO+KjDu9lXcuSIhy3VEU1d2N614v9eQ==
X-Received: by 2002:a5b:18d:: with SMTP id r13-v6mr1931537ybl.316.1532635468662;
        Thu, 26 Jul 2018 13:04:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b9f])
        by smtp.gmail.com with ESMTPSA id k200-v6sm1825388ywe.1.2018.07.26.13.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 13:04:27 -0700 (PDT)
Date:   Thu, 26 Jul 2018 16:07:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Singh, Balbir" <bsingharora@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, surenb@google.com,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christoph Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>,
        linux-mm <linux-mm@kvack.org>, cgroups@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory,
 and IO v2
Message-ID: <20180726200718.GA23307@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <CAKTCnzmt_CnfZMMdK9_-rBrL4kUmoE70nVbnE58CJp++FP0CCQ@mail.gmail.com>
 <20180724151519.GA11598@cmpxchg.org>
 <268c2b08-6c90-de2b-d693-1270bb186713@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <268c2b08-6c90-de2b-d693-1270bb186713@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 11:07:32AM +1000, Singh, Balbir wrote:
> On 7/25/18 1:15 AM, Johannes Weiner wrote:
> > On Tue, Jul 24, 2018 at 07:14:02AM +1000, Balbir Singh wrote:
> >> Does the mechanism scale? I am a little concerned about how frequently
> >> this infrastructure is monitored/read/acted upon.
> > 
> > I expect most users to poll in the frequency ballpark of the running
> > averages (10s, 1m, 5m). Our OOMD defaults to 5s polling of the 10s
> > average; we collect the 1m average once per minute from our machines
> > and cgroups to log the system/workload health trends in our fleet.
> > 
> > Suren has been experimenting with adaptive polling down to the
> > millisecond range on Android.
> > 
> 
> I think this is a bad way of doing things, polling only adds to
> overheads, there needs to be an event driven mechanism and the
> selection of the events need to happen in user space.

Of course, I'm not saying you should be doing this, and in fact Suren
and I were talking about notification/event infrastructure.

You asked if this scales and I'm telling you it's not impossible to
read at such frequencies.

Maybe you can clarify your question.

> >> Why aren't existing mechanisms sufficient
> > 
> > Our existing stuff gives a lot of indication when something *may* be
> > an issue, like the rate of page reclaim, the number of refaults, the
> > average number of active processes, one task waiting on a resource.
> > 
> > But the real difference between an issue and a non-issue is how much
> > it affects your overall goal of making forward progress or reacting to
> > a request in time. And that's the only thing users really care
> > about. It doesn't matter whether my system is doing 2314 or 6723 page
> > refaults per minute, or scanned 8495 pages recently. I need to know
> > whether I'm losing 1% or 20% of my time on overcommitted memory.
> > 
> > Delayacct is time-based, so it's a step in the right direction, but it
> > doesn't aggregate tasks and CPUs into compound productivity states to
> > tell you if only parts of your workload are seeing delays (which is
> > often tolerable for the purpose of ensuring maximum HW utilization) or
> > your system overall is not making forward progress. That aggregation
> > isn't something you can do in userspace with polled delayacct data.
> 
> By aggregation you mean cgroup aggregation?

System-wide and per cgroup.
