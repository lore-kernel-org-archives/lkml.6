Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372D8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70D020858
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TkSt3hfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70D020858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeH1WWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:22:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45488 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1WWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iJPoBcgz0duNyq8AStVYAktRorwejQEUhD7IQC46ZhQ=; b=TkSt3hfeUdZXTDOlmbjn1JXeM6
        AY6OCWE8Sug0adQ700ibUPXAGiUS6ofFR10eONR/zEYC3OXAuA8CLtYX+cNkduJhi39k7/rmxdYP0
        PNPzLYlQAUnzaJ0f01w1e6m8/01RyZuiF0ZIzYZ1dfva/Fb+oqaNSa0e0z19iJNndQZHsOAkhIoKz
        7WBIhyrGRQWzcyGR7skp321rOF5hVDJfWtpf40ARVHkk06fpYpUrx7hVQtgmBvmbvRVNa35QH09z+
        pdwXG4D3DOZk5gFbpIPVHjHtDTTeXMrp4HMxXKRgVSt3qE6fi90Y++WsHu3yiCphUhyDDFyjQWKgV
        O5QXfZYw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuijf-0002oz-94; Tue, 28 Aug 2018 18:29:03 +0000
Subject: Re: [PATCH v4 07/16] sched/core: uclamp: extend cpu's cgroup
 controller
To:     Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
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
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-8-patrick.bellasi@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ad7a1f15-d1ad-84f2-6b4d-cbfc4560a7a4@infradead.org>
Date:   Tue, 28 Aug 2018 11:29:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828135324.21976-8-patrick.bellasi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 06:53 AM, Patrick Bellasi wrote:
> +config UCLAMP_TASK_GROUP
> +	bool "Utilization clamping per group of tasks"
> +	depends on CGROUP_SCHED
> +	depends on UCLAMP_TASK
> +	default n
> +	help
> +	  This feature enables the scheduler to track the clamped utilization
> +	  of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
> +
> +	  When this option is enabled, the user can specify a min and max
> +	  CPU bandwidth which is allowed for each single task in a group.
> +	  The max bandwidth allows to clamp the maximum frequency a task
> +	  can use, while the min bandwidth allows to define a minimum
> +	  frequency a task will always use.
> +
> +	  When task group based utilization clamping is enabled, an eventually
> +          specified task-specific clamp value is constrained by the cgroup
> +	  specified clamp value. Both minimum and maximum task clamping cannot
> +          be bigger than the corresponding clamping defined at task group level.

The 4 lines above should all be indented the same (one tab + 2 spaces).

> +
> +	  If in doubt, say N.
> +


-- 
~Randy
