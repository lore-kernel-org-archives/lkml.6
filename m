Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeEQAZc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 20:25:32 -0400
Received: from foss.arm.com ([217.140.101.70]:56100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbeEQAZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 20:25:30 -0400
Date: Wed, 16 May 2018 19:25:28 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Sealey <Matt.Sealey@arm.com>, mathieu.poirier@linaro.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        suzuki.poulose@arm.com
Subject: Re: [PATCH] drivers/perf: arm-ccn: stop spamming dmesg in
 event_init
Message-Id: <20180516192528.5519d2faf59766e0544bb2ee@arm.com>
In-Reply-To: <cee9c043-3d64-56b9-4f23-e8c8370387dd@gmail.com>
References: <20180504104117.8086-1-mark.rutland@arm.com>
        <20180508184050.75c60b82ba538d0ecdeb2d78@arm.com>
        <1525882003.4199.55.camel@arm.com>
        <20180509184154.9994df2874e7a08025b56dea@arm.com>
        <cee9c043-3d64-56b9-4f23-e8c8370387dd@gmail.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding acme, LKML, linux-perf-users, and other potentially interested]

On Wed, 9 May 2018 17:22:42 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 05/09/2018 04:41 PM, Kim Phillips wrote:
> > On Wed, 9 May 2018 17:06:43 +0100
> > Pawel Moll <pawel.moll@arm.com> wrote:
> > 
> >> On Wed, 2018-05-09 at 00:40 +0100, Kim Phillips wrote:
> >>> On Fri,  4 May 2018 11:41:17 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> >>>
> >>> [adding Pawel, arm-ccn driver author]
> >>
> >> We had this discussion way too many times for my liking. As I said
> >> before - *I* will be fine with the debug messages in the CCN driver.
> >> Now, if there ever turns out to be other user of this thing and gets
> > 
> > Sure, this isn't just about Pawel using the driver he wrote - we know
> > you know how to use it because you wrote it.  No, it's about all the
> > other potential users out there, esp. first time users, as I once was.
> > 
> >> into problems with event configuration, I'd hope that he/she can count
> >> on support from the knowledgable people here... (just checked and both
> > 
> > I abhor having to suggest our users email this list in order to find out
> > how to use the PMU drivers.  First time users are going to tend to
> > steer completely away if they don't have the patience to debug a silent
> > PMU, rather than email this mailing list - sorry, but that's just
> > adding a huge usage barrier - for what - fuzzer runner's convenience?
> > 
> >> RHEL 7.5 and Ubuntu 16.04.3 kernels on AArch64 come with
> >> CONFIG_DYNAMIC_DEBUG=y, so it's a matter of explaining what has to be
> >> enabled where; sadly this information did not find its way into the
> >> commit description)
> > 
> > I can't think of a more difficult to find, more far-away, alien
> > place for end users to find help with perf, sorry.
> > 
> >>>> The ARM CCN PMU driver uses dev_warn() to complain about parameters
> >>> in
> >>>> the user-provided perf_event_attr. This means that under normal
> >>>> operation (e.g. a single invocation of the perf tool), dmesg may be
> >>>> spammed with multiple messages.
> >>
> >> Surely Mark, in his role as maintainer of drivers/perf/ (and a few
> >> other locations), meant to use much more technical and emotion-free
> >> subject, along the lines of "reduce a number of dmesg warnings at event
> >> init".
> > 
> > 'reduce a number' is the wrong word:  warnings are completely
> > eliminated. Debug-level messages occur at exactly the same
> > frequency/amount.
> > 
> > But I still object to the rationale overall - it seems this is about
> > running fuzzers?  I even offered an alternative for fuzzer runners: is
> > modifying the loglevel prior to fuzzing somehow unacceptable?
> 
> I don't have any dog in this, but maybe if providing information to the
> users is so essential to having a pleasant user experience, then
> rethinking the whole way these messages are funneled is necessary
> because the kernel log + dmesg is by no means appropriate. Take a look
> at what the networking maintainers recently did with netlink extended
> ack. You used to just get an "unsupported" error, and now you know
> exactly what is wrong when extack is available. It seems to me like
> something like this is what you might want here since you want to have
> perf be as user friendly as possible.

Thanks, Florian.

Acme & other perf people, do you foresee a problem adding netlink
extended ack support to the perf subsystem for extended error message
communication?

If not, is struct perf_event_attr amenable to having error reporting
bit(s) added?  Recall my last attempt failed because it couldn't
discriminate between the perf core and the PMU driver returning the
-Evalue:

https://patchwork.kernel.org/patch/10025555/

Thanks,

Kim
