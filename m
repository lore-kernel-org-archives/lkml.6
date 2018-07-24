Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D6FECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C5C20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImlGMyCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C5C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeGXOff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:35:35 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:32818 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeGXOff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:35:35 -0400
Received: by mail-yb0-f196.google.com with SMTP id e84-v6so1614893ybb.0;
        Tue, 24 Jul 2018 06:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uwBSmxA1wcd2m2FH7B3WZCpg5K/vAn6Bi3UJX9j2gnQ=;
        b=ImlGMyCbWAUuN5pueJaj3LbJFMwurRFcCWMPGW2LExFWGcc+I0BV0AIiw7hIVTrlLA
         TQ6kjQoNJPCfZYsEjNJQol6hwr72BfwhV5jgaxDK8BWhCklnDlS9WXCgijFzq14zCLAv
         CoUubIHsaok3my/GPXWR5uTh/X1SujVLTHCLFuF2Nf1Dgs+UgYK4cH19IbIO00AZKvuQ
         c16csnq/bjzAa9LyU+/lg61XRxUxxK9POm0BNfYwDOzwEm1ingsnIlvOTk8esNJacc1/
         dvVx1ZDAOVp2SALsT7vefSVxYkJKSreOWRysG1ylD7kCasZ6wKsVsEoEaTn/XmOdJxQC
         TMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uwBSmxA1wcd2m2FH7B3WZCpg5K/vAn6Bi3UJX9j2gnQ=;
        b=CXoLfX4mPSIEJiSpJniQFVJ+L4ldp/GM9ui5MCjKtTy8L9BHUZLnTF31O8ewTSVGD+
         RJEkKe69/7MMV4RliWEJevVzgr7o/RRMTf+JWEdstjrpVuc8JrNlbZCFt1bLDmucJFBW
         ayiz7RpK8sj0ceOMACvNjj8U6eD9L1T32R3RHWqyt75gh0AyQhpsmCoe9oXUdlxGOQ6y
         9qhYXrF5Qk7/vuITTlx5P2ioep5n6jXDPJPb/8bk0kbbQnidchxgGk2XX3OJGy+7H+Ks
         juWssHxUnMiKixwvqtJxZzE2zmhsfAJHyTzISUHU6Z/vUY+ucqShoLViiQ8x+CqvsQHG
         DcZQ==
X-Gm-Message-State: AOUpUlGB2a5+ciNpPC5ypFtDACIVqqpJpoleyzQ+56c3XkJUMeJ9OcUB
        s5ZDq5fJkHQUMQWIKe3CpTo=
X-Google-Smtp-Source: AAOMgpfga1PrvoR4k1QHQF6XyRVQ4lYvMnh2UJ5wtBgXY6Fgrvg/u8boY8XTjuctgUAR93dKecZRGw==
X-Received: by 2002:a25:394a:: with SMTP id g71-v6mr8850920yba.149.1532438944579;
        Tue, 24 Jul 2018 06:29:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:c936])
        by smtp.gmail.com with ESMTPSA id r17-v6sm3997626ywa.36.2018.07.24.06.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 06:29:03 -0700 (PDT)
Date:   Tue, 24 Jul 2018 06:29:02 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 08/12] sched/core: uclamp: extend cpu's cgroup
 controller
Message-ID: <20180724132902.GI1934745@devbig577.frc2.facebook.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-9-patrick.bellasi@arm.com>
 <20180723153040.GG1934745@devbig577.frc2.facebook.com>
 <20180723172215.GG2683@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723172215.GG2683@e110439-lin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Patrick.

On Mon, Jul 23, 2018 at 06:22:15PM +0100, Patrick Bellasi wrote:
> However, the "best effort" bandwidth control we have for CFS and RT
> can be further improved if, instead of just looking at time spent on
> CPUs, we provide some more hints to the scheduler to know at which
> min/max "MIPS" we want to consume the (best effort) time we have been
> allocated on a CPU.
> 
> Such a simple extension is still quite useful to satisfy many use-case
> we have, mainly on mobile systems, like the ones I've described in the
>    "Newcomer's Short Abstract (Updated)"
> section of the cover letter:
>    https://lore.kernel.org/lkml/20180716082906.6061-1-patrick.bellasi@arm.com/T/#u

So, that's all completely fine but then let's please not give it a
name which doesn't quite match what it does.  We can just call it
e.g. cpufreq range control.

> > So, there are fundamental discrepancies between
> > description+interface vs. what it actually does.
> 
> Perhaps then I should just change the description to make it less
> generic...

I think so, along with the interface itself.

> > I really don't think that's something we can fix up later.
> 
> ... since, really, I don't think we can get to the point to extend
> later this interface to provide the strict bandwidth enforcement you
> are thinking about.

That's completley fine.  The interface just has to match what's
implemented.

...
> > and what you're describing inherently breaks the delegation model.
> 
> What I describe here is just an additional hint to the scheduler which
> enrich the above described model. Provided A and B are already
> satisfied, when a task gets a chance to run it will be executed at a
> min/max configured frequency. That's really all... there is not
> additional impact on "resources allocation".

So, if it's a cpufreq range controller.  It'd have sth like
cpu.freq.min and cpu.freq.max, where min defines the maximum minimum
cpufreq its descendants can get and max defines the maximum cpufreq
allowed in the subtree.  For an example, please refer to how
memory.min and memory.max are defined.

Thanks.

-- 
tejun
