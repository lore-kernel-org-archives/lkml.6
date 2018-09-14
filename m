Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED034ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929C720881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rbuasfm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929C720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeINQYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:24:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39844 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeINQYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L91hesCxwrsmspGhu6/nktd6VBuPJq4l1UYkxX5JsSg=; b=rbuasfm/+Nn1D/AbZN0hoi62C
        V0o06rAV5RKj70AFCety8B/IxzHJGrA8pezip9tHVgM7n0ZrP7s4JmDjgsq+uKYhHhsT/WxZnVzoB
        r5C05QdekJQZBGWBYaBgZ430Q+V6Vf3GFkDI/qEaoIqTcBm1OjRJ2p6Jh6+PkQuXOs0Uixe75yhuh
        5T0HAcZbFg+QlY8DTGmKnI4DX8SDPgLG8pnfEHHlZkBfn3yDP96xCo6SBUP0D9uwhQBiSCTKEEjZU
        qKj6/mnVW+vAqyoxch2Ad16N5i2f0zF0eY3v5c0fIC8+zCYyNYTF39rgmIFFXNFBTomuwKme2I/Dl
        LaqLa21sQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0lzB-00027j-SC; Fri, 14 Sep 2018 11:10:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D962202B2E3D; Fri, 14 Sep 2018 13:10:03 +0200 (CEST)
Date:   Fri, 14 Sep 2018 13:10:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Message-ID: <20180914111003.GC24082@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906144053.GD25636@e110439-lin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 03:40:53PM +0100, Patrick Bellasi wrote:
> 1) _I think_ we don't want to depend on capable(CAP_SYS_NICE) but
>    instead on capable(CAP_SYS_ADMIN)
> 
>    Does that make sense ?

Neither of them really makes sense to me.

The max clamp makes a task 'consume' less and you should always be able
to reduce yourself.

The min clamp doesn't avoid while(1); and is therefore also not a
problem.

So I think setting clamps on a task should not be subject to additional
capabilities.

Now, of course, there is a problem of clamp resources, which are
limited. Consuming those _is_ a problem.

I think the problem here is that the two are conflated in the very same
interface.

Would it make sense to move the available clamp values out to some sysfs
interface like thing and guard that with a capability, while keeping the
task interface unprivilidged?

Another thing that has me 'worried' about this interface is the direct
tie to CPU capacity (not that I have a better suggestion). But it does
raise the point of how userspace is going to discover the relevant
values of the platform.
