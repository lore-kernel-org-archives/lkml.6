Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E520AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D98B20857
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D98B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeIJBEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 21:04:53 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33072 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeIJBEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 21:04:53 -0400
Received: by mail-oi0-f66.google.com with SMTP id 8-v6so36423886oip.0;
        Sun, 09 Sep 2018 13:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ia86bkJ9m8uGLpDk5aTIYJRevY0u6R3hEBOP9EZsM6k=;
        b=tdEdvnJ88GSd+cKNaAADdgfDdT/QEToBowQUWaZdk6+Bt6E0ff4HuU6rDQFXzE+CTD
         xGdmZlunYe8bGx9GTvVAgtUo0m9zx+KHjy32o2LbePpIb8n3cSb1kovt5UuDZTlaVEPs
         pW3nNiEbVRcDiFdqFLenOLOkzAklnA5fTv1MI08cfPz0ry9oHZaH5FSaezr8lIuhApZp
         bA0tCA6imV+kCz2sRR4tc31t/sexxce6DjwBYALsRSpFXMitkTkne1K53rGJ7vhLZu+b
         EJVWER5vr3H1Tt7j2Dmm8MIMW2nH/z9zOngzHd17MCO4pq34rOBbO5BJug8xSBjlbldg
         CXbA==
X-Gm-Message-State: APzg51BdRY2/J89iQka4yuSJtNlsWuXw5teuU9SLu/L5rLJk9n42GP1X
        dBcQ3+9APRSRpApswb0JppVkS52C2FBKkP3WMIw=
X-Google-Smtp-Source: ANB0VdaBIyKqYSyUpZdf9t8yuvlEaJZZara5ltc9bL+P1SRKyzgvIdsPa9fxE05bo4Z/fwH/zTwprXrlNuM8S4jMi8o=
X-Received: by 2002:aca:aa06:: with SMTP id t6-v6mr19399448oie.152.1536524043596;
 Sun, 09 Sep 2018 13:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <CAJZ5v0jL_k36RPc6e8yUHxAYGXp7HHWK+hLnBZWnu5Oi__7j3w@mail.gmail.com>
 <20180906143842.xlxcg5notwdaflww@queper01-lin> <1545744.fI5ZvP8FO0@aspire.rjw.lan>
 <20180907152923.oxsmcqciez4yhmkk@queper01-lin>
In-Reply-To: <20180907152923.oxsmcqciez4yhmkk@queper01-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 9 Sep 2018 22:13:52 +0200
Message-ID: <CAJZ5v0gs1Fb-Y1FbjmnxLNHQR=CSHFX_=KpDEkqRCYDJ9EJByQ@mail.gmail.com>
Subject: Re: [PATCH v6 13/14] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Fri, Sep 7, 2018 at 5:29 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Friday 07 Sep 2018 at 10:52:01 (+0200), Rafael J. Wysocki wrote:
> > On Thursday, September 6, 2018 4:38:44 PM CEST Quentin Perret wrote:
> > > Hi Rafael,
> > >
> > > On Thursday 06 Sep 2018 at 11:18:55 (+0200), Rafael J. Wysocki wrote:
> > > > I'm not a particular fan of notifiers to be honest and you don't need
> > > > to add an extra chain just in order to be able to register a callback
> > > > from a single user.
> > >
> > > Right. I agree there are alternatives to using notifiers. I used them
> > > because they're existing infrastructure, and because they let me do what
> > > I want without too much troubles, which are two important points.
> > >
> > > > That can be achieved with a single callback
> > > > pointer too, but also you could just call a function exported by the
> > > > scheduler directly from where in the cpufreq code it needs to be
> > > > called.
> > >
> > > Are you thinking about something comparable to what is done in
> > > cpufreq_add_update_util_hook() (kernel/sched/cpufreq.c) for example ?
> > > That would probably have the same drawback as my current implementation,
> > > that is that the scheduler is notified of _all_ governor changes, not
> > > only changes to/from sugov although this is the only thing we care about
> > > for EAS.
> >
> > Well, why don't you implement it as something like "if the governor changes
> > from sugov to something else (or the other way around), call this function
> > from the scheduler"?
>
> I just gave it a try and ended up with the diff below. It's basically
> the exact same patch with a direct function call instead of a notifier.
> (I also tried the sugov_start/stop thing I keep mentioning but it is
> more complex, so let's see if the simplest solution could work first).
>
> What do you think ?

This generally works for me from the cpufreq perspective, but I would
add "cpufreq" to the name of the new function, that is call it
something like sched_cpufreq_governor_change().

Also do you really need the extra work item?  Governor changes are
carried out in process context anyway.

Thanks,
Rafael
