Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753470AbeEVW2m (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 18:28:42 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39536 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753406AbeEVW2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 18:28:39 -0400
X-Google-Smtp-Source: AB8JxZprvagXdHMMBRiXeWGhmdcobZFEKxEXrvyp0UWajLROJF69wxwLadQZvDNb5M7qCGe+l8KIQg==
Date: Tue, 22 May 2018 15:28:37 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        Claudio Scordino <claudio@evidence.eu.com>, kernel-team@android.com,
        Linux PM <linux-pm@vger.kernel.org>,
        "Joel Fernandes (Google.)" <joelaf@google.com>
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Message-ID: <20180522222837.GA55359@joelaf.mtv.corp.google.com>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180522113844.5rz3skjeck57arft@vireshk-i7>
 <CAJZ5v0hP+gCiLa+6YvKHaj7u-DuRfmVq_vjFRMj6CnVktJRxVg@mail.gmail.com>
 <4237890.zlzv5C60QP@aspire.rjw.lan>
 <CAJZ5v0henS+LZ64JQwrXR8LrY7xzcsnnYS7AoBuR9dNaC4mTRw@mail.gmail.com>
 <20180522213113.GA40506@joelaf.mtv.corp.google.com>
 <CAJZ5v0ir7Chz6jCZTKRNT12oMd4uyu+JgFLKmZ8RJkcRkyrzBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ir7Chz6jCZTKRNT12oMd4uyu+JgFLKmZ8RJkcRkyrzBg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 11:52:46PM +0200, Rafael J. Wysocki wrote:
> On Tue, May 22, 2018 at 11:41 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Tue, May 22, 2018 at 05:27:11PM +0200, Rafael J. Wysocki wrote:
> >> On Tue, May 22, 2018 at 2:22 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Tuesday, May 22, 2018 1:42:05 PM CEST Rafael J. Wysocki wrote:
> >> >> On Tue, May 22, 2018 at 1:38 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >> >> > On 22-05-18, 13:31, Rafael J. Wysocki wrote:
> >> >> >> So below is my (compiled-only) version of the $subject patch, obviously based
> >> >> >> on the Joel's work.
> >> >> >>
> >> >> >> Roughly, what it does is to move the fast_switch_enabled path entirely to
> >> >> >> sugov_update_single() and take the spinlock around sugov_update_commit()
> >> >> >> in the one-CPU case too.
> >> >
> >> > [cut]
> >> >
> >> >> >
> >> >> > Why do you assume that fast switch isn't possible in shared policy
> >> >> > cases ? It infact is already enabled for few drivers.
> >> >
> >> > I hope that fast_switch is not used with devfs_possible_from_any_cpu set in the
> >> > one-CPU policy case, as that looks racy even without any patching.
> >>
> >> Which would be the only case in which sugov_update_single() would run
> >> on a CPU that is not the target.
> >>
> >> And running sugov_update_single() concurrently on two different CPUs
> >> for the same target is a no-no, as we don't prevent concurrent updates
> >> from occurring in that path.
> >>
> >> Which means that the original patch from Joel will be sufficient as
> >> long as we ensure that sugov_update_single() can only run on one CPU
> >> at a time.
> >
> > Since target CPU's runqueue lock is held, I don't see how we can run
> > sugov_update_single concurrently with any other CPU for single policy, so
> > protecting such race shouldn't be necessary.
> 
> If dvfs_possible_from_any_cpu is set, any CPU can run
> sugov_update_single(), but the kthread will only run on the target
> itself.  So another CPU running sugov_update_single() for the target
> may be racing with the target's kthread.
> 
Yes, I agree. I thought you meant the case of sugov_update_single running
currently with other sugov_update_single. So just to be on the same page,
I'll fix the commit log and repost this one as is.

And then I'll post the smp_rmb() patch separately to address the memory order
issue (which I believe is in mainline as well). Basically I was thinking to
address Viresh's issue, there should be an smp_mb() after the next_freq is
read, but before the write to work_in_progress.

thanks,

 - Joel
