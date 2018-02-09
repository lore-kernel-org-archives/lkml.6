Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeBINZv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 08:25:51 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51226 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeBINZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 08:25:49 -0500
X-Google-Smtp-Source: AH8x226p9cx/cUW9UtTJqRJDx0xunyQoZwEtPYPat5XPoGjAnN3evZUBgwPF4jRQYuypunYN0vBe+w==
Date: Fri, 9 Feb 2018 14:25:44 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: schedutil: rate limits for SCHED_DEADLINE
Message-ID: <20180209132544.GI12979@localhost.localdomain>
References: <197c26ba-c2a6-2de7-dffa-5b884079f746@evidence.eu.com>
 <11598161.veS9VGWB8G@aspire.rjw.lan>
 <20180209105305.GD12979@localhost.localdomain>
 <CAJZ5v0h9L2mMEaV6oECk9f2ob42Nr9zyqafymwvb+UP+G1q04Q@mail.gmail.com>
 <20180209112618.GE12979@localhost.localdomain>
 <CAJZ5v0g4bgDKP96rivKPE-EMr7SuUhL9OO=M+MQuAjbdq9R45g@mail.gmail.com>
 <20180209115155.GG12979@localhost.localdomain>
 <CAJZ5v0g-ypbVT77vSpjTX5mrpedu_=eH+O3b5d6PE5ydL1=VRQ@mail.gmail.com>
 <20180209125245.GH12979@localhost.localdomain>
 <CAJZ5v0i9ZpRZKd7FNLnC6SucJnOump4xhQhf9QabXOSTf_qfyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i9ZpRZKd7FNLnC6SucJnOump4xhQhf9QabXOSTf_qfyw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/18 13:56, Rafael J. Wysocki wrote:
> On Fri, Feb 9, 2018 at 1:52 PM, Juri Lelli <juri.lelli@redhat.com> wrote:
> > On 09/02/18 13:08, Rafael J. Wysocki wrote:
> >> On Fri, Feb 9, 2018 at 12:51 PM, Juri Lelli <juri.lelli@redhat.com> wrote:

[...]

> >> > My impression is that rate limit helps a lot for CFS, where the "true"
> >> > utilization is not known in advance, and being too responsive might
> >> > actually be counterproductive.
> >> >
> >> > For DEADLINE (and RT, with differences) we should always respond as
> >> > quick as we can (and probably remember that a frequency transition was
> >> > requested if hw was already performing one, but that's another patch)
> >> > because, if we don't, a task belonging to a lower priority class might
> >> > induce deadline misses in highest priority activities. E.g., a CFS task
> >> > that happens to trigger a freq switch right before a DEADLINE task wakes
> >> > up and needs an higher frequency to meet its deadline: if we wait for
> >> > the rate limit of the CFS originated transition.. deadline miss!
> >>
> >> Fair enough, but if there's too much overhead as a result of this, you
> >> can't guarantee the deadlines to be met anyway.
> >
> > Indeed. I guess this only works if corner cases as the one above don't
> > happen too often.
> 
> Well, that's the point.
> 
> So there is a tradeoff: do we want to allow deadlines to be missed
> because of excessive overhead or do we want to allow deadlines to be
> missed because of the rate limit.

The difference between the two seems to be that while overhead is an
intrisic hw thing, rate limit is something we have mostly to cope with
the nature of certain classes of tasks and how we describe/track them
(at least IMHO). I'd say that for other classes of tasks (DL/RT) we
would be better off consciously living with the former only and accept
that real world is "seldom" not ideal.

But then again this is just another theory, experiments might easily
prove me wrong. :)
