Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC8AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4932085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BEejzrZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4932085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeKHANl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:13:41 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33532 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeKHANl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kW150as6jh2xgxsgE/o7JvaN4EvlRt/v4i2mEbQdYJg=; b=BEejzrZt+wWFD10L3pVHREJ4C
        J/Px4kHhmMU+IMr5Z5GNflhSzdxMS4eX7SbMcXVxpYQFW4dwH6ljw9BiicMSnC3ntqLPJd3fyhae/
        2QsxuI/wYGmnrHUnng4sKm/b9dsr/rzAW2cijgwTbeI9YkU2kF/IRhv+Mgx3ErBvk4lI9uvJokmgV
        q0aZizfoDVDcZnAajwsu1AoiwdLRPHlOOftD3xzRB5KSy+ebv8NfJHRzdkvWinm3V4JcWv+BNd/+L
        jPOPc+nXg7IcpGXoK1FCn6iR3c4WL5oHPhxHWlbMEMXgKBklPtxIUzmZMNcfweWbLdPgD5aOzy+GN
        DD7f0Jtog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKP2k-0006PD-IF; Wed, 07 Nov 2018 14:42:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1EB7720284F94; Wed,  7 Nov 2018 15:42:52 +0100 (CET)
Date:   Wed, 7 Nov 2018 15:42:52 +0100
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
Message-ID: <20181107144252.GG9761@hirez.programming.kicks-ass.net>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
 <20181107121908.GO9781@hirez.programming.kicks-ass.net>
 <20181107141949.GF14309@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107141949.GF14309@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 02:19:49PM +0000, Patrick Bellasi wrote:
> On 07-Nov 13:19, Peter Zijlstra wrote:
> > On Mon, Oct 29, 2018 at 06:32:57PM +0000, Patrick Bellasi wrote:
> > > +struct uclamp_se {
> > > +	unsigned int value		: SCHED_CAPACITY_SHIFT + 1;
> > > +	unsigned int group_id		: order_base_2(UCLAMP_GROUPS);
> > 
> > Are you sure about ob2() ? seems weird we'll end up with 0 for
> > UCLAMP_GROUPS==1.
> 
> So, we have:
> 
>    #define UCLAMP_GROUPS (CONFIG_UCLAMP_GROUPS_COUNT + 1)
> 
> because one clamp group is always reserved for defaults.
> Thus, ob2(in) is always called with n>=2.
> 
> ... should be safe no ?

+config UCLAMP_GROUPS_COUNT
+       int "Number of different utilization clamp values supported"
+       range 0 32
+       default 5

0+1 == 1

Increase the min range and you should be good I think.
