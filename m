Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EAAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA36220827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WxgBZtDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA36220827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbeKGXo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:44:59 -0500
Received: from merlin.infradead.org ([205.233.59.134]:32934 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbeKGXo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SBcT9EGd6MxKrVHTreVJ4OinKK8AXjwR0pe7meQhuE8=; b=WxgBZtDgtqmmZYWiF2h+YmOpV
        bbzpQvZo5ky7JOz7keqgAeiKFrOlvp0HYHgwtLbrMCi/qCZTAslTudJOVTJ5diTRHUSGhtA9FOEci
        Od5wwjpfKzj478DSGVVzmqlCCCztqhJwPNmvVv9Ygg6ziZKxZVECDSqcny3baYgFgLip0HEEIoOYv
        KqMgXE2MZVqXLYU8ku1h8rj7+a8ia6ZgyvVRmdOWugLjljWvJwtAuNt+VCD/JPlCxP6TWETzOlaGW
        3S+6dbvYK2aHw2Rmf/joxvxzW5kb42PFcW5+YHQTu7O5ZoCWdJm5GrgVlJ7x/15OwR3olhseiapLw
        E7AfADedQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKOb2-0006F5-PR; Wed, 07 Nov 2018 14:14:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A4C020284F98; Wed,  7 Nov 2018 15:14:14 +0100 (CET)
Date:   Wed, 7 Nov 2018 15:14:14 +0100
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
Message-ID: <20181107141414.GF9761@hirez.programming.kicks-ass.net>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
 <20181107131632.GP9781@hirez.programming.kicks-ass.net>
 <20181107135738.GE14309@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107135738.GE14309@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 01:57:38PM +0000, Patrick Bellasi wrote:
> On 07-Nov 14:16, Peter Zijlstra wrote:

> > Please write cmpxchg loops in the form:
> > 
> > 	atomic_long_t *ptr = &uclamp_maps[clamp_id][group_id].adata;
> > 	union uclamp_map old, new;
> > 
> > 	old.data = atomic_long_read(ptr);
> > 	do {
> > 		new.data = old.data;
> > 		new.se_cound--;
> > 	} while (!atomic_long_try_cmpxchg(ptr, &old.data, new.data));
> > 
> > 
> > (same for all the others of course)
> 
> Ok, I did that to save some indentation, but actually it's most
> commonly used in a while loop... will update in v6.
> 
> Out of curiosity, apart from code consistency, is that required also
> specifically for any possible compiler related (mis)behavior ?

No; it is just the 'normal' form my brain likes :-)

And the try_cmpxchg() thing is slightly more efficient on x86 vs the
traditional form:

	while (cmpxchg(ptr, old, new) != old)

