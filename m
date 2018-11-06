Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C67C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A9020685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RHd7XfBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A9020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbeKGAZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:25:45 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34626 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388800AbeKGAZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HZSYKT3uQCFQJBlGvwG2ps1CJ4htXqv8eg+KTQRCM6g=; b=RHd7XfBmujZLbiEty7C1kZK3b
        cEyUn6e8OhGUw6pLygs4Re7gzc6LGN55Xmq6UkfDXUPypSPyTTTBX8uT7EOS2tJqR0CHqxyILxG8R
        Ne64R0LxYKSAYZ7pBJF9AGfvm6QGc+9/cR91Q5NLgi4V176oqPQMMV8p6GfPvDZBel9xayVLh692o
        ri+HYNf//lZb1wb8/SHvNuHrRYVDoC5AFLL5+ZhbjWyO6OHLaMgjtmSkcGkMMPal+vNCnieulfdwy
        8oNsxk3e1yNMJcqkNsmwkYkY9uayWfeNitg2oxgw45z9bX4sLJAT+F4BLv4N/+Mjfi9rkemvGI0NB
        9Gl4tqKug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK2pm-0007c9-CR; Tue, 06 Nov 2018 15:00:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 371CA20284F96; Tue,  6 Nov 2018 15:59:56 +0100 (CET)
Date:   Tue, 6 Nov 2018 15:59:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org
Subject: Re: [PATCH v5 2/2] sched/fair: update scale invariance of PELT
Message-ID: <20181106145956.GA9761@hirez.programming.kicks-ass.net>
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
 <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org>
 <b89b6805-45c0-8462-b75b-b7da4a35c022@arm.com>
 <CAKfTPtBapA3JvbgUyESzE=2ZXOGLRLmZh7oi8N=H9PHubCCuNg@mail.gmail.com>
 <20181105145854.GA6401@e105550-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105145854.GA6401@e105550-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 02:58:54PM +0000, Morten Rasmussen wrote:

> It has always been debatable what to do with utilization when there are
> no spare cycles.
> 
> In Dietmar's example where two 25% tasks are put on a 512 (50%) capacity
> CPU we add just enough utilization to have no spare cycles left. One
> could argue that 25% is still the correct utilization for those tasks.
> However, we only know their true utilization because they just ran
> unconstrained on a higher capacity CPU. Once they are on the 512 capacity
> CPU we wouldn't know if the tasks grew in utilization as there are no
> spare cycles to use.
> 
> As I see it, the most fundamental difference between scaling
> contribution and time for PELT is the characteristics when CPUs are
> over-utilized.
> 
> With contribution scaling the PELT utilization of a task is a _minimum_
> utilization. Regardless of where the task is currently/was running (and
> provided that it doesn't change behaviour) its PELT utilization will
> approximate its _minimum_ utilization on an idle 1024 capacity CPU.
> 
> With time scaling the PELT utilization doesn't really have a meaning on
> its own. It has to be compared to the capacity of the CPU where it
> is/was running to know what the its current PELT utilization means. When
> the utilization over-shoots the capacity its value is no longer
> represents utilization, it just means that it has a higher compute
> demand than is offered on its current CPU and a high value means that it
> has been suffering longer. It can't be used to predict the actual
> utilization on an idle 1024 capacity any better than contribution scaled
> PELT utilization.
> 
> This change might not be a showstopper, but it is something to be aware
> off and take into account wherever PELT utilization is used.

So for things like x86, where we don't have immediate control over the
OPPs nor actually know the current dynamic max OPP (or even can know), I
much prefer the model Vincent proposes.

The one thing we do know is the lack of idle time, and I feel equating
no idle with u=1 makes perfect sense.

Luckily x86 does provide means of querying the current effective OPP
and so a utilization value can be usefully compared to another.
