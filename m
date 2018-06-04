Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeFDKMx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:12:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39088 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbeFDKMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:12:52 -0400
X-Google-Smtp-Source: ADUXVKKblgbrJlMUHKYzUxvq8MybD7Qtderu/i4ZTwYh3iNRvDKfGcNpLYO/e80T7zRalb4VijMTMA==
Date: Mon, 4 Jun 2018 12:12:47 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Joel Fernandes <joelaf@google.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Alessio Balsini <alessio.balsini@santannapisa.it>
Subject: Re: [PATCH v5 05/10] cpufreq/schedutil: get max utilization
Message-ID: <20180604101247.GB2731@localhost.localdomain>
References: <CAKfTPtDCkzPMt6XrXRcURXm=53LABiwbFd3JMQkJDWpTprycRQ@mail.gmail.com>
 <20180528152243.GD1293@localhost.localdomain>
 <CAKfTPtAY26HZ00R02RuW2kvZLvZxHGvh-kbfrqv-hPumdknvWg@mail.gmail.com>
 <20180531102735.GM30654@e110439-lin>
 <CAKfTPtCeoimTehLktVk4WiTEM5h9KW_4yvuxGof8p6ZOgsRE2Q@mail.gmail.com>
 <20180601135307.GA28550@linaro.org>
 <20180601174526.GA105687@joelaf.mtv.corp.google.com>
 <CAKfTPtBu5D=P3ib6fqfVLz9yQXN19ipRQAz5L6s1+ewnVTrHmg@mail.gmail.com>
 <20180604070438.GA2731@localhost.localdomain>
 <CAKfTPtD9KQTeeP0BNyhnqh=UXL0T_jK0PcvWWBjoyj0VC8TkRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD9KQTeeP0BNyhnqh=UXL0T_jK0PcvWWBjoyj0VC8TkRg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/18 09:14, Vincent Guittot wrote:
> On 4 June 2018 at 09:04, Juri Lelli <juri.lelli@redhat.com> wrote:
> > Hi Vincent,
> >
> > On 04/06/18 08:41, Vincent Guittot wrote:
> >> On 1 June 2018 at 19:45, Joel Fernandes <joelaf@google.com> wrote:
> >> > On Fri, Jun 01, 2018 at 03:53:07PM +0200, Vincent Guittot wrote:
> >
> > [...]
> >
> >> > IMO I feel its overkill to account dl_avg when we already have DL's running
> >> > bandwidth we can use. I understand it may be too instanenous, but perhaps we
> >>
> >> We keep using dl bandwidth which is quite correct for dl needs but
> >> doesn't reflect how it has disturbed other classes
> >>
> >> > can fix CFS's problems within CFS itself and not have to do this kind of
> >> > extra external accounting ?
> >
> > I would also keep accounting for waiting time due to higher prio classes
> > all inside CFS. My impression, when discussing it with you on IRC, was
> > that we should be able to do that by not decaying cfs.util_avg when CFS
> > is preempted (creating a new signal for it). Is not this enough?
> 
> We don't just want to not decay a signal but increase the signal to
> reflect the amount of preemption

OK.

> Then, we can't do that in a current signal. So you would like to add
> another metrics in cfs_rq ?

Since it's CFS related, I'd say it should fit in CFS.

> The place doesn't really matter to be honest in cfs_rq or in dl_rq but
> you will not prevent to add call in dl class to start/stop the
> accounting of the preemption
> 
> >
> > I feel we should try to keep cross-class accounting/interaction at a
> > minimum.
> 
> accounting for cross class preemption can't be done without
> cross-class accounting

Mmm, can't we distinguish in, say, pick_next_task_fair() if prev was of
higher prio class and act accordingly?

Thanks,

- Juri
