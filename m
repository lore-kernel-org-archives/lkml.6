Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F6CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C3421761
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fIwWWPtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C3421761
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbeHCQS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:18:28 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46134 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732180AbeHCQS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:18:27 -0400
Received: by mail-io0-f193.google.com with SMTP id i18-v6so5071890ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 07:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H69ha+O/ZI8u/k1uPDSBozRELfgjE4HV6aR1r7zbleo=;
        b=fIwWWPtBihT4oWdiw12ms5mCsKh0bQZOhkSQoSVDmeeKraB32/+NivEF6ccGcbhO9A
         Kvs8xoD6RsT8NcYFyonwRpr20eTVkabyHjT+r/uYOGoFSipmzDbeZgZUzs5bRWzMMZYv
         3cFJbUsxQ84nwLGX1joUhZnrgzDphjWX/jnoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H69ha+O/ZI8u/k1uPDSBozRELfgjE4HV6aR1r7zbleo=;
        b=NGj/NN6iWSsW5OFR2xjoKPtxKkAeTuRuI4esxacVQVBbHXzEwLJU4FkpQnu8f763pd
         7qyFbQl2FOES43JXeuIFA8KF5dgnpfBrsoGxGQFePbh5HRCgD+nUah+s4isPeCrP4TF9
         z/8hXvUxH2dI0ac92r5xhwPk371wRz7bR9qDO/tKZHYT7CuCanWSr/8X3662SLL90jyv
         WQJqAyzicdG0Gt2mV+6lyPD4FK+DiZDD5IsNf2U8FJe9ycvzE4nLVcOIl2ZJI9laa3uv
         xvYScy8DiEwMOPuH7nulG3qplr7ydLG1hfwHWG+9nmjtRMMj+vmsHbtfDZQZsk984fjQ
         ZjBg==
X-Gm-Message-State: AOUpUlG8JAKjE+YnCxihEZfoIrUyj13V7RdjrVdKUVAx+HJ+9aNXDtCO
        LuSHMmCrNg8Xy1axraAuiPW45Fmic6mC6UXlnz/cVw==
X-Google-Smtp-Source: AAOMgpfvIghNOPDX/wxvtIfaWAfLljSZh1efgW1o6tNcQ86GVSEOeZLbqAqFKYMBoLvQiYmBAZE3ZwwFCtenamvo6cM=
X-Received: by 2002:a6b:ec08:: with SMTP id c8-v6mr6353957ioh.18.1533306113159;
 Fri, 03 Aug 2018 07:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180802141424.ju4jxxbk6pxw3kyq@queper01-lin> <CAKfTPtCzQZotmpt40X6uN9O0yAerq6c6bFgiFfqhhcbKsm7k4w@mail.gmail.com>
 <20180802153035.vjtmqwdwujvt7ojs@queper01-lin> <CAKfTPtCGGqykN027kxK+chvKvCpNu4bYYdvfZJ+3_7YzT3Utfg@mail.gmail.com>
 <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin> <CAKfTPtB_tWgOPCB3q2Q2rESKczTPGBDUojcXDY7uP8YTQddBMg@mail.gmail.com>
 <20180802161027.v2ctgscuc4uxbb7u@queper01-lin> <CAKfTPtDtaF9Qs4NWkKWUSr8Ryi-ScYNmPyacocPQUPxT00XAYg@mail.gmail.com>
 <20180802165924.7ywgoxj2jwftxycz@queper01-lin> <CAKfTPtDsG4FJy5xBO8+6pJzehEM668=SZ4yQ-szVTduofN3QZg@mail.gmail.com>
 <20180803081850.hj7bp5ognuywapmd@queper01-lin> <CAKfTPtDkJY=JYicZk8sM9_mJ-iq+Jwse0oVRbW=wpxXKKnEoeQ@mail.gmail.com>
In-Reply-To: <CAKfTPtDkJY=JYicZk8sM9_mJ-iq+Jwse0oVRbW=wpxXKKnEoeQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 3 Aug 2018 16:21:41 +0200
Message-ID: <CAKfTPtDckchB-CiRUzKVd906SBr1OKLuTfBqD5vsaR6CZZHu6Q@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point indicator
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com,
        "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2018 at 15:49, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Fri, 3 Aug 2018 at 10:18, Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > On Friday 03 Aug 2018 at 09:48:47 (+0200), Vincent Guittot wrote:
> > > On Thu, 2 Aug 2018 at 18:59, Quentin Perret <quentin.perret@arm.com> wrote:
> > > I'm not really concerned about re-enabling load balance but more that
> > > the effort of packing of tasks in few cpus/clusters that EAS tries to
> > > do can be broken for every new task.
> >
> > Well, re-enabling load balance immediately would break the nice placement
> > that EAS found, because it would shuffle all tasks around and break the
> > packing strategy. Letting that sole new task go in find_idlest_cpu()
>
> Sorry I was not clear in my explanation. Re enabling load balance
> would be a problem of course. I wanted to say that there is few chance
> that this will re-enable the load balance immediately and break EAS
> and I'm not worried by this case. But i'm only concerned by the new
> task being put outside EAS policy.
>
> For example, if you run on hikey960 the simple script below, which
> can't really be seen as a fork bomb IMHO, you will see threads
> scheduled on big cores every 0.5 seconds whereas everything should be
> packed on little core  :
> for i in {0..10}; do
> echo "t"$i
> sleep 0.5
> done
>
> > shouldn't impact the placement of existing tasks. That might have an energy
> > cost for that one task, yes, but it's really hard to do anything smarter
> > with new tasks IMO ... EAS simply can't work without a utilization value.
> >
> > > So I wonder what is better for EAS : Make sure to efficiently spread
> > > newly created tasks in cas of fork bomb or  try to not break EAS task
> > > placement with every newly created tasks
> >
> > That shouldn't break the placement per se, we're just making one
> > temporary exception for new tasks. What do you think 'the right thing'
> > to do is ? To just put new tasks on prev_cpu or something like that ?
>
> I think that EAS, which is about saving power, could be a bit power
> friendly when it has to make some assumptions about new task.
>
> >
> > That might help some use-cases I suppose, but will probably harm others ...
> > I'm just not too keen on making assumptions about the size of new tasks,
>
> But you are already doing some assumptions by letting the default
> mode, which use load_avg, selecting the task for you. The comment of

s/selecting the task/selecting the cpu/

> the init function of load_avg states:
>
> void init_entity_runnable_average()
> {
> ...
> /*
> * Tasks are intialized with full load to be seen as heavy tasks until
> * they get a chance to stabilize to their real load level.
> * Group entities are intialized with zero load to reflect the fact that
> * nothing has been attached to the task group yet.
> */
>
> So it means that EAS makes the assumption that new task are heavy
> tasks until they get a chance to stabilize
>
> Regards,
> Vincent
>
> > that's all. But I'm definitely open to ideas if there is something
> > smarter we can do.
> >
> > Thanks,
> > Quentin
