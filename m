Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B61C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737D921477
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QZdn44VC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737D921477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeINAZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:25:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33780 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeINAZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kQqF44iSaC/2GXba2pvHI10oNcBtoe3SJvjDaOOgK90=; b=QZdn44VCcxW2zM4/uR3H/e7s/
        UuGp54RzQhKn3rBGXm7W9RwroxudXwRXICDsc9xZqdANwV4KfRKJlIgEows7f8+mxLGqLIKtsBcMs
        pSCUAZ9MP5nwNLUryT+4vzh85sNNX6fC8oVBm3onKxOxEJoAvq+DifDyU8T4ZL9OnnbxDT8Kid1c/
        0S5xH2ud1wwOP1xEtdIUGad5+UqyTNqVCLfqyrmtapqRqxJKD+nA6591T8IxHvuPADEyIWRbftOm8
        aGYox8hrATQn+O3AH+3MxA/f8uRtuD0CE7LjopFulqUOYgjFW4XO5jJsx5Ifbr/1NYS8tf3FmmWGl
        Oke7piFFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0X4K-0005FY-0N; Thu, 13 Sep 2018 19:14:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A89D2202C1A34; Thu, 13 Sep 2018 21:14:22 +0200 (CEST)
Date:   Thu, 13 Sep 2018 21:14:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20180913191422.GZ24082@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <20180912134945.GZ24106@hirez.programming.kicks-ass.net>
 <20180912155619.GG1413@e110439-lin>
 <20180912161218.GW24082@hirez.programming.kicks-ass.net>
 <20180912173515.GH1413@e110439-lin>
 <20180912174236.GB24106@hirez.programming.kicks-ass.net>
 <20180912175202.GK1413@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912175202.GK1413@e110439-lin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 06:52:02PM +0100, Patrick Bellasi wrote:
> On 12-Sep 19:42, Peter Zijlstra wrote:
> > On Wed, Sep 12, 2018 at 06:35:15PM +0100, Patrick Bellasi wrote:
> > > On 12-Sep 18:12, Peter Zijlstra wrote:
> > 
> > > > No idea; but if you want to go all fancy you can replace he whole
> > > > uclamp_map thing with something like:
> > > > 
> > > > struct uclamp_map {
> > > > 	union {
> > > > 		struct {
> > > > 			unsigned long v : 10;
> > > > 			unsigned long c : BITS_PER_LONG - 10;
> > > > 		};
> > > > 		atomic_long_t s;
> > > > 	};
> > > > };
> > > 
> > > That sounds really cool and scary at the same time :)
> > > 
> > > The v:10 requires that we never set SCHED_CAPACITY_SCALE>1024
> > > or that we use it to track a percentage value (i.e. [0..100]).
> > 
> > Or we pick 11 bits, it seems unlikely that capacity be larger than 2k.
> 
> Just remembered a past experience where we had unaligned access traps
> on some machine because... don't you see any potentially issue on
> using bitfleds like you suggest above ?
> 
> I'm thinking to:
> 
>    commit 317d359df95d ("sched/core: Force proper alignment of 'struct util_est'")

There should not be (and I'm still confused by that particular commit
you reference). If we access everything through the uclamp_map::s, and
only use the bitfields to interpret the results, it all 'works'.

The tricky thing we did earlier was trying to use u64 accesses for 2
u32 variables. And somehow ia64 didn't get the alignment right.
