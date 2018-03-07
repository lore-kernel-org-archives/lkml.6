Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbeCGMYz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:24:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43600 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbeCGMYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:24:53 -0500
Date: Wed, 7 Mar 2018 13:24:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v5 1/4] sched/fair: add util_est on top of PELT
Message-ID: <20180307122437.GM25181@hirez.programming.kicks-ass.net>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-2-patrick.bellasi@arm.com>
 <20180306185851.GG25201@hirez.programming.kicks-ass.net>
 <20180307113149.GA2211@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307113149.GA2211@e110439-lin>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 11:31:49AM +0000, Patrick Bellasi wrote:
> > It appears to me this isn't a stable situation and completely relies on
> > the !nr_running case to recalibrate. If we ensure that doesn't happen
> > for a significant while the sum can run-away, right?
> 
> By away you mean go over 1024 or overflow the unsigned int storage?

the later, I think you can make it arbitrarily large. Have a busy task
on CPU0, this ensure !nr_running never happens.

Start a busy task on CPU1, wait for it to hit u=1, then migrate it to
CPU0, then wait for it to hit u=.5 then kill it, this effectively adds
.5 to the enqueued value, repeat indefinitely.
