Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1780C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6992C2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BSqXYhbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6992C2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbeKHAPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:15:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40904 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeKHAPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dm6APZ19b4h/dWPymPVe7CblDVoI5A3SjlphVBU11lM=; b=BSqXYhbD5iOCul3nZlvqnYQSG
        76cLEPFY+1jGqG3M7lC1YtenN6TAwsj0sgxCQbfDvk3XHpW3bA//UD6MUBJZjkdBbVZ2w+nRdAFHi
        KOZANi3wVMZBWJ/xWEIjwOZsvM9bZcXMrD2/SGUFzoI9Io4WRaR+KCPFk2PA3fk3eezN2Yo6ukk+F
        Hnae+ztuA/464QcG+707cWbXQPMCQZkXY0uoA65hx2Rh/SqJMKVAOJjEZR67mQT4CsLrolWe5BZ2G
        SfOwvC0WBQL4jMcfvyfqDnkfEU/uUT7vbcVKb65Ios6PJdJcwk5imblhLeUsRLu7nEIBENmC4Kruc
        mdMvwb37Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKP4c-0007OJ-FC; Wed, 07 Nov 2018 14:44:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6FE5F20284F94; Wed,  7 Nov 2018 15:44:48 +0100 (CET)
Date:   Wed, 7 Nov 2018 15:44:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v5 03/15] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20181107144448.GH9761@hirez.programming.kicks-ass.net>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
 <20181107134414.GR9781@hirez.programming.kicks-ass.net>
 <20181107142428.GG14309@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107142428.GG14309@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 02:24:28PM +0000, Patrick Bellasi wrote:
> On 07-Nov 14:44, Peter Zijlstra wrote:
> > On Mon, Oct 29, 2018 at 06:32:57PM +0000, Patrick Bellasi wrote:

> > > +static void uclamp_group_get(struct uclamp_se *uc_se, unsigned int clamp_id,
> > > +			     unsigned int clamp_value)
> > > +{
> > > +	union uclamp_map *uc_maps = &uclamp_maps[clamp_id][0];
> > > +	unsigned int prev_group_id = uc_se->group_id;
> > > +	union uclamp_map uc_map_old, uc_map_new;
> > > +	unsigned int free_group_id;
> > > +	unsigned int group_id;
> > > +	unsigned long res;
> > > +
> > > +retry:
> > > +
> > > +	free_group_id = UCLAMP_GROUPS;
> > > +	for (group_id = 0; group_id < UCLAMP_GROUPS; ++group_id) {
> > > +		uc_map_old.data = atomic_long_read(&uc_maps[group_id].adata);
> > > +		if (free_group_id == UCLAMP_GROUPS && !uc_map_old.se_count)
> > > +			free_group_id = group_id;
> > > +		if (uc_map_old.value == clamp_value)
> > > +			break;
> > > +	}
> > > +	if (group_id >= UCLAMP_GROUPS) {
> > > +#ifdef CONFIG_SCHED_DEBUG
> > > +#define UCLAMP_MAPERR "clamp value [%u] mapping to clamp group failed\n"
> > > +		if (unlikely(free_group_id == UCLAMP_GROUPS)) {
> > > +			pr_err_ratelimited(UCLAMP_MAPERR, clamp_value);
> > > +			return;
> > > +		}
> > > +#endif
> > 
> > Can you please put in a comment, either here or on top, on why this can
> > not in fact happen? And we're always guaranteed a free group.
> 
> You right, that's confusing especially because up to this point we are
> not granted. We are always granted a free group once we add:
> 
>    sched/core: uclamp: add clamp group bucketing support
> 
> I've kept it separated to better document how we introduce that
> support.
> 
> Is it ok for for you if I better call out in the change log that the
> guarantee comes from a following patch... and add the comment in
> that later patch ?

Urgh.. that is mighty confusing and since this stuff actually 'works'
might result in bisection issues too, right?

I would really rather prefer a series that makes sense in the order you
read it.
