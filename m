Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3D5C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39A720880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e8Riz9nI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39A720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeILSyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:54:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44262 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeILSyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mp0YXKFlQIq/FJvz2sWZBGc7Ylr8qJapgT2GhAH03n0=; b=e8Riz9nIdRlcnmcZeDxZZtlFG
        dsW8wq3BZ3nBmSYq/Tx4N2YddtRuDl52OpFmjJecIsEoZ6g8EiSozj27gDXwtS6LgF1NptP7EqRGi
        PAFbqliXsASaXkkgeSgK7MDwGwaJOZQ2DKBkFuh9k3e8YZ8lJj31QbYUr548FoVNhFaLdNcoZo7vQ
        1mGIK4odUChdlcFzt0d4CMhNSwhKYgLvQkrSwKycTzb4gihPiiviUEVxfRLnZTcKH5xTGJSQxkKZv
        Pw/N9xSHbrDK05fsoXd3x1P6leGRB/bqQWm3KqeBPCpy0aS1LQLP8EvPjQsF1Zhp50xT4uJhcyUZn
        NFW344z1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g05Wd-000367-NR; Wed, 12 Sep 2018 13:49:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 211D7202C1A2E; Wed, 12 Sep 2018 15:49:45 +0200 (CEST)
Date:   Wed, 12 Sep 2018 15:49:45 +0200
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
Message-ID: <20180912134945.GZ24106@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-3-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 02:53:10PM +0100, Patrick Bellasi wrote:
> +/**
> + * Utilization's clamp group
> + *
> + * A utilization clamp group maps a "clamp value" (value), i.e.
> + * util_{min,max}, to a "clamp group index" (group_id).
> + */
> +struct uclamp_se {
> +	unsigned int value;
> +	unsigned int group_id;
> +};

> +/**
> + * uclamp_map: reference counts a utilization "clamp value"
> + * @value:    the utilization "clamp value" required
> + * @se_count: the number of scheduling entities requiring the "clamp value"
> + * @se_lock:  serialize reference count updates by protecting se_count

Why do you have a spinlock to serialize a single value? Don't we have
atomics for that?

> + */
> +struct uclamp_map {
> +	int value;
> +	int se_count;
> +	raw_spinlock_t se_lock;
> +};
> +
> +/**
> + * uclamp_maps: maps each SEs "clamp value" into a CPUs "clamp group"
> + *
> + * Since only a limited number of different "clamp values" are supported, we
> + * need to map each different clamp value into a "clamp group" (group_id) to
> + * be used by the per-CPU accounting in the fast-path, when tasks are
> + * enqueued and dequeued.
> + * We also support different kind of utilization clamping, min and max
> + * utilization for example, each representing what we call a "clamp index"
> + * (clamp_id).
> + *
> + * A matrix is thus required to map "clamp values" to "clamp groups"
> + * (group_id), for each "clamp index" (clamp_id), where:
> + * - rows are indexed by clamp_id and they collect the clamp groups for a
> + *   given clamp index
> + * - columns are indexed by group_id and they collect the clamp values which
> + *   maps to that clamp group
> + *
> + * Thus, the column index of a given (clamp_id, value) pair represents the
> + * clamp group (group_id) used by the fast-path's per-CPU accounting.
> + *
> + * NOTE: first clamp group (group_id=0) is reserved for tracking of non
> + * clamped tasks.  Thus we allocate one more slot than the value of
> + * CONFIG_UCLAMP_GROUPS_COUNT.
> + *
> + * Here is the map layout and, right below, how entries are accessed by the
> + * following code.
> + *
> + *                          uclamp_maps is a matrix of
> + *          +------- UCLAMP_CNT by CONFIG_UCLAMP_GROUPS_COUNT+1 entries
> + *          |                                |
> + *          |                /---------------+---------------\
> + *          |               +------------+       +------------+
> + *          |  / UCLAMP_MIN | value      |       | value      |
> + *          |  |            | se_count   |...... | se_count   |
> + *          |  |            +------------+       +------------+
> + *          +--+            +------------+       +------------+
> + *             |            | value      |       | value      |
> + *             \ UCLAMP_MAX | se_count   |...... | se_count   |
> + *                          +-----^------+       +----^-------+
> + *                                |                   |
> + *                      uc_map =  +                   |
> + *                     &uclamp_maps[clamp_id][0]      +
> + *                                                clamp_value =
> + *                                       uc_map[group_id].value
> + */
> +static struct uclamp_map uclamp_maps[UCLAMP_CNT]
> +				    [CONFIG_UCLAMP_GROUPS_COUNT + 1]
> +				    ____cacheline_aligned_in_smp;
> +

I'm still completely confused by all this.

sizeof(uclamp_map) = 12

that array is 2*6=12 of those, so the whole thing is 144 bytes. which is
more than 2 (64 byte) cachelines. What's the purpose of that cacheline
align statement?

Note that without that apparently superfluous lock, it would be 8*12 =
96 bytes, which is 1.5 lines and would indeed suggest you default to
GROUP_COUNT=7 by default to fill 2 lines.

Why are the min and max things torn up like that?  I'm fairly sure I
asked some of that last time; but the above comments only try to explain
what, not why.
