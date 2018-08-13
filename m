Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF790C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA6C2178F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA6C2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbeHMPJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:09:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33050 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbeHMPJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:09:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id i134-v6so281554wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 05:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JlIseKsdGdj6x6itYZiSC/IkLSPgz/oVcCsDK3QOYMs=;
        b=sUrr/2TSIXcVgdWCjgZrsg6GegZxq8PWA/XskjnV0JtMOPsp2GAPHPAve4HagqFGCu
         k/jABGUpI7v4X41e3skRWtNZFWx9F+JLKuI5d3L2RoBavUOJ6d2EQwqu1vUCBpW5dMt2
         GPS5SDUvQ7992vWqhYC35FS6qQE8cIDNEKJqlREd4YNAl8ty2GfK3gOZ4Q4PR5Xm1x1D
         E9nP++lBNJTIFfh0fVEho6E7it+4J82k0lbhPFgdp0K1tIBy6SMEx7yllOA2iG3mm/aI
         LeZDHfGqqDTKcZBRCgCHfwofR3Ht3tmLnUzhK5tjlNOsZy/MfVPCFthw2KQyJHxupPCF
         Bi+w==
X-Gm-Message-State: AOUpUlG8QF002cjwaeHSkvET9vbzuAO1B0UKCJ7kmy6mff2jXSsQlt4y
        8YVM5ARrPQkkVHwdf1HJa/umvw==
X-Google-Smtp-Source: AA+uWPyvc6ZFmJqaovDvrN5STDMw2Y+s+taU618sFdeiEPJgZ0g/m7lCrhEO9CSl7KoUUy+8amk3uA==
X-Received: by 2002:a1c:790b:: with SMTP id l11-v6mr7687799wme.66.1534163237855;
        Mon, 13 Aug 2018 05:27:17 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BCE7D88DAEEE59932720558.dip0.t-ipconnect.de. [2003:ef:2bce:7d88:daee:e599:3272:558])
        by smtp.gmail.com with ESMTPSA id h14-v6sm20890333wro.15.2018.08.13.05.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 05:27:17 -0700 (PDT)
Date:   Mon, 13 Aug 2018 14:27:14 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Message-ID: <20180813122714.GC9851@localhost.localdomain>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-2-patrick.bellasi@arm.com>
 <20180807095905.GB2288@localhost.localdomain>
 <20180813121441.GC2605@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813121441.GC2605@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/18 13:14, Patrick Bellasi wrote:
> On 07-Aug 11:59, Juri Lelli wrote:
> > Hi,
> > 
> > Minor comments below.
> > 
> > On 06/08/18 17:39, Patrick Bellasi wrote:
> > 
> > [...]
> > 
> > > + *
> > > + * Task Utilization Attributes
> > > + * ===========================
> > > + *
> > > + * A subset of sched_attr attributes allows to specify the utilization which
> > > + * should be expected by a task. These attributes allows to inform the
> >                                                        ^
> > 						     allow
> > 
> > > + * scheduler about the utilization boundaries within which is safe to schedule
> > 
> > Isn't all this more about providing hints than safety?
> 
> Yes, it's "just" hints... will rephrase to make it more clear.
> 
> > > + * the task. These utilization boundaries are valuable information to support
> > > + * scheduler decisions on both task placement and frequencies selection.
> > > + *
> > > + *  @sched_util_min	represents the minimum utilization
> > > + *  @sched_util_max	represents the maximum utilization
> > > + *
> > > + * Utilization is a value in the range [0..SCHED_CAPACITY_SCALE] which
> > > + * represents the percentage of CPU time used by a task when running at the
> > > + * maximum frequency on the highest capacity CPU of the system. Thus, for
> > > + * example, a 20% utilization task is a task running for 2ms every 10ms.
> > > + *
> > > + * A task with a min utilization value bigger then 0 is more likely to be
> > > + * scheduled on a CPU which can provide that bandwidth.
> > > + * A task with a max utilization value smaller then 1024 is more likely to be
> > > + * scheduled on a CPU which do not provide more then the required bandwidth.
> > 
> > Isn't s/bandwidth/capacity/ here, above, and in general where you use
> > the term "bandwidth" more appropriate? I wonder if overloading this term
> > (w.r.t. how is used with DEADLINE) might create confusion. In this case
> > we are not providing any sort of guarantees, it's a hint.
> 
> Yes, you right... here we are not really granting any bandwidth but
> just "improving" the bandwidth provisioning by hinting the scheduler
> about a certain min/max capacity required.
> 
> The problem related to using capacity is that, from kernel space,
> capacity is defined as a static quantity/property of CPUs. Still, I

Looks like it's also more inline with EAS terminology (i.e., capacity
states).
