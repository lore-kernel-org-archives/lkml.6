Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D537CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F623206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F623206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeIFNxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:53:39 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:44152 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbeIFNxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:53:38 -0400
Received: by mail-oi0-f52.google.com with SMTP id l82-v6so19144358oih.11;
        Thu, 06 Sep 2018 02:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2mJh7f1paRq/mvssm+CXE54aa2kaN5YQO6XRPuc0kw=;
        b=ZYYYitybn86kySXq0PJCbB3NcJoAMj72bLWKCW7qmiqJjzo9IXpsTc+L/CYECaFGfQ
         EbWo2UZfyeS6yRcwAnDud9NmYW2434D6Uq0g55BRS40JmEqiOttV9C0qFr5LgRSDzR5+
         sugEkGxAQW6mLhbXVUxPMO63v/r+R6uvnqA8bQsXtQnSNxkCFWKjqN3EL6N9J5BVZoQP
         E3y8RoARv6eVfZGjcGZ7k6aB1Em6gYb33ldm6iJK5OhVLQgcUoquCnuD5k+uaoYsygmf
         S3Bi+X/Y/x54Ag1WtcXUUayrLJRoAbrSPwesotUTeTOVShfNctbF6nFMS+E1NXw6hUtg
         UaDQ==
X-Gm-Message-State: APzg51CF2Stse/aDRiHwot+teMEyVQ8W941ehGZ2LWCvPI2mBw0btDn5
        l7s9mshZOw6lX4Ebwfz23vpTqa+kGwFSIaMYPms=
X-Google-Smtp-Source: ANB0Vda/8cGKjoiiseaHKWMBk7oH4UD/e5fn5qzew4yncd7WryzqmoWTG64D+MyndKdJFEIWyVCidkLSmmRdAUhXvRo=
X-Received: by 2002:aca:b844:: with SMTP id i65-v6mr1986469oif.177.1536225546363;
 Thu, 06 Sep 2018 02:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-14-quentin.perret@arm.com> <20180904105906.t5i7twyyt2omc45b@queper01-lin>
In-Reply-To: <20180904105906.t5i7twyyt2omc45b@queper01-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Sep 2018 11:18:55 +0200
Message-ID: <CAJZ5v0jL_k36RPc6e8yUHxAYGXp7HHWK+hLnBZWnu5Oi__7j3w@mail.gmail.com>
Subject: Re: [PATCH v6 13/14] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 12:59 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Monday 20 Aug 2018 at 10:44:19 (+0100), Quentin Perret wrote:
> > Energy Aware Scheduling (EAS) is designed with the assumption that
> > frequencies of CPUs follow their utilization value. When using a CPUFreq
> > governor other than schedutil, the chances of this assumption being true
> > are small, if any. When schedutil is being used, EAS' predictions are at
> > least consistent with the frequency requests. Although those requests
> > have no guarantees to be honored by the hardware, they should at least
> > guide DVFS in the right direction and provide some hope in regards to the
> > EAS model being accurate.
> >
> > To make sure EAS is only used in a sane configuration, create a strong
> > dependency on schedutil being used. Since having sugov compiled-in does
> > not provide that guarantee, extend the existing CPUFreq policy notifier
> > with a new case on governor changes. That allows the scheduler to
> > register a callback on this notifier to rebuild the scheduling domains
> > when governors are changed, and enable/disable EAS accordingly.
> >
> > cc: Ingo Molnar <mingo@redhat.com>
> > cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> >
> > ---
> > This patch could probably be squashed into another one, but I kept it
> > separate to ease the review. Also, it's probably optional as not having
> > it will not 'break' things per se.
> >
> > I went for the smallest possible solution I could find, which has the
> > good side of being simple, but it's definitely not the only one.
> >
> > Another possibility would be to hook things in sugov_start() and
> > sugov_stop(), but that requires some more work. In this case, it
> > wouldn't be possible to just re-build the sched_domains() from there,
> > because when sugov_stop() is called, the 'governor' field of the policy
> > hasn't been updated yet, so the condition (if gov == schedutil) in
> > build_freq_domains() doesn't work.
> >
> > To workaround the issue we'll need to find a way to pass a cpumask to
> > the topology code to specifically say 'sugov has been stopped on these
> > CPUs'. That would mean more code to handle that, but that would also
> > mean we don't have to mess around with the CPUFreq notifiers ...
> >
> > Not sure what's best, so all feedback is more than welcome.
>
> Hi,
>
> Does anybody have concerns with this patch ? Is it a reasonable option
> to use the CPUFreq notifiers in this case ? If there is anything I can
> do to ease the review please let me know.

I'm not a particular fan of notifiers to be honest and you don't need
to add an extra chain just in order to be able to register a callback
from a single user.  That can be achieved with a single callback
pointer too, but also you could just call a function exported by the
scheduler directly from where in the cpufreq code it needs to be
called.

> Also, is there any hope that the 12 first patches could make it in 4.20
> on their own ? Or is it already too late ?

I'm walking through them right now, albeit somewhat slowly due to
various distractions, so we'll see.

Thanks,
Rafael
