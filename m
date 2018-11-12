Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9018C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C9F20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0YbizrwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C9F20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbeKLJ7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:59:50 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34996 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731045AbeKLJ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 04:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MEPBEspqo1/sX1YIGNpJZ3Q8BKrPJh5IWW3uPkfAm/o=; b=0YbizrwBxsnnuNpCjT7TVzgq1
        oUG0ch2l+Pg3vAAn/FJ0HMB4WLAc0HCZ4EkF9WjoKcPoc4eakm5mCGlzuvAATzTEDAd3Dnl/z339c
        nSu+QLWB+LRn4KQJpMuLNOKXylnpc++FJmHd5QdqCWVuY5T1hO0Qka8irnEq1KcDeMrmbANDcNiT9
        MWwd/Xs6eXuxcU8RFB9My94zm3i0CdsIdphrMZkw5a90sv9ldwTkuqWJ2j7IChZ7oUE0hQymCrh+8
        +1fT3cTFg8A30zv4TMA34a9GzrAghIIQIktdshnhNs+ZEc9ieKuTABdt84cq9e3YVuxWVQiWQ5dhy
        7LeK/lEJg==;
Received: from [64.114.255.97] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLzmy-0004KQ-IS; Mon, 12 Nov 2018 00:09:12 +0000
Received: by worktop (Postfix, from userid 1000)
        id 4D9AA6E061A; Mon, 12 Nov 2018 01:09:10 +0100 (CET)
Date:   Mon, 12 Nov 2018 01:09:10 +0100
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
Subject: Re: [PATCH v5 07/15] sched/core: uclamp: add clamp group bucketing
 support
Message-ID: <20181112000910.GC3038@worktop>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-9-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029183311.29175-9-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 06:33:02PM +0000, Patrick Bellasi wrote:
> The number of clamp groups configured at compile time defines the range
> of utilization clamp values tracked by each CPU clamp group.
> For example, with the default configuration:
>    CONFIG_UCLAMP_GROUPS_COUNT 5
> we will have 5 clamp groups tracking 20% utilization each. In this case,
> a task with util_min=25% will have group_id=1.

OK I suppose; but should we not do a wholesale s/group/bucket/ at this
point?

We should probably raise the minimum number of buckets from 1 though :-)

> +/*
> + * uclamp_group_value: get the "group value" for a given "clamp value"
> + * @value: the utiliation "clamp value" to translate
> + *
> + * The number of clamp group, which is defined at compile time, allows to
> + * track a finite number of different clamp values. Thus clamp values are
> + * grouped into bins each one representing a different "group value".
> + * This method returns the "group value" corresponding to the specified
> + * "clamp value".
> + */
> +static inline unsigned int uclamp_group_value(unsigned int clamp_value)
> +{
> +#define UCLAMP_GROUP_DELTA (SCHED_CAPACITY_SCALE / CONFIG_UCLAMP_GROUPS_COUNT)
> +#define UCLAMP_GROUP_UPPER (UCLAMP_GROUP_DELTA * CONFIG_UCLAMP_GROUPS_COUNT)
> +
> +	if (clamp_value >= UCLAMP_GROUP_UPPER)
> +		return SCHED_CAPACITY_SCALE;
> +
> +	return UCLAMP_GROUP_DELTA * (clamp_value / UCLAMP_GROUP_DELTA);
> +}

Can't we further simplify; I mean, at this point all we really need to
know is the rq's highest group_id that is in use. We don't need to
actually track the value anymore.

