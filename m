Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934031AbeEIIXE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:23:04 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41429 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933805AbeEIIXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:23:01 -0400
X-Google-Smtp-Source: AB8JxZpBVIOihzweUKG48KDGbvYpgHkYNtbw1Ey55XNbkpRRwSsONHIpelkK8nbNPHwv535e9putfQ==
Date: Wed, 9 May 2018 01:22:59 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Joel Fernandes <joelaf@google.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/cpufreq/schedutil: handling urgent frequency
 requests
Message-ID: <20180509082259.GB76874@joelaf.mtv.corp.google.com>
References: <1525704215-8683-1-git-send-email-claudio@evidence.eu.com>
 <20180508065435.bcht6dyb3rpp6gk5@vireshk-i7>
 <20180509045425.GA158882@joelaf.mtv.corp.google.com>
 <20180509064530.GA1681@localhost.localdomain>
 <20180509065449.c5zotxqmuyatjgfd@vireshk-i7>
 <20180509070113.GB52784@joelaf.mtv.corp.google.com>
 <CAJZ5v0hNgvd=0dKstXRsbHhtrc6m+ugS5kjPOq2B8k55ioX0MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hNgvd=0dKstXRsbHhtrc6m+ugS5kjPOq2B8k55ioX0MA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 10:05:09AM +0200, Rafael J. Wysocki wrote:
> On Wed, May 9, 2018 at 9:01 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Wed, May 09, 2018 at 12:24:49PM +0530, Viresh Kumar wrote:
> >> On 09-05-18, 08:45, Juri Lelli wrote:
> >> > On 08/05/18 21:54, Joel Fernandes wrote:
> >> > Isn't this potentially introducing unneeded irq pressure (and doing the
> >> > whole wakeup the kthread thing), while the already active kthread could
> >> > simply handle multiple back-to-back requests before going to sleep?
> >>
> >> And then we may need more instances of the work item and need to store
> >> a different value of next_freq with each work item, as we can't use
> >> the common one anymore as there would be races around accessing it ?
> >
> > Exactly. I think it also doesn't make sense to over write an already
> > committed request either so better to store them separate (?). After the
> > "commit", that previous request is done..
> 
> Why is it?
> 
> In the non-fast-switch case the "commit" only means queuing up an
> irq_work.  Which BTW is one of the reasons for having work_in_progress
> even if your kthread can handle multiple work items in one go.

Ok I agree. I just thought there was something funky with the meaning of
commit from a cpufreq perspective.

In the last diff I just sent out, I actually keep work_in_progress and
consider its meaning to be what you're saying (has the kthread been kicked)
and lets such "overwriting" of the next frequency to be made possible. Also
with that we would be servicing just the latest request even if there were
multiple ones made.

thanks,

- Joel
