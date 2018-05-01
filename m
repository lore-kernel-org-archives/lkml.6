Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754960AbeEALxq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 07:53:46 -0400
Received: from foss.arm.com ([217.140.101.70]:45904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754623AbeEALxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 07:53:45 -0400
Date: Tue, 1 May 2018 12:54:05 +0100
From: Will Deacon <will.deacon@arm.com>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com, gklkml16@gmail.com
Subject: Re: [PATCH v4 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
Message-ID: <20180501115405.GE25237@arm.com>
References: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
 <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com>
 <20180426170624.bfcba885431d57d0de2a3ddd@arm.com>
 <20180427093027.ngtuoezyh6mtz26p@lakrids.cambridge.arm.com>
 <20180427081525.f9dcc756678baf3bb6e6e473@arm.com>
 <20180427143719.GA5093@arm.com>
 <20180427104629.2bff4b4b683a93ddf39f8df5@arm.com>
 <20180427160914.GA5286@arm.com>
 <20180427115625.b5191d381cd41e7ee092fea1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427115625.b5191d381cd41e7ee092fea1@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kim,

On Fri, Apr 27, 2018 at 11:56:25AM -0500, Kim Phillips wrote:
> On Fri, 27 Apr 2018 17:09:14 +0100
> Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Apr 27, 2018 at 10:46:29AM -0500, Kim Phillips wrote:
> > > On Fri, 27 Apr 2018 15:37:20 +0100
> > > Will Deacon <will.deacon@arm.com> wrote:
> > > > For anything under drivers/perf/, I'd prefer not to have these prints
> > > > and instead see efforts to improve error reporting via the perf system
> > > > call interface.
> > > 
> > > We'd all prefer that, and for all PMU drivers, why should ones under
> > > drivers/perf be treated differently?
> > 
> > Because they're the ones I maintain...
> 
> You represent a minority on your opinion on this matter though.

I'm not sure that's true -- you tend to be the only one raising this issue;
I think most people don't actually care one way or the other. If you know of
others who care about it too then I suggest you work together as a group to
solve the problem in a way which is amenable to the upstream maintainers.
Then you won't have to worry about fixing it personally. You could even
propose a topic for plumbers if there is enough interest in a general
framework for propagating error messages to userspace.

> > > As you are already aware, I've personally tried to fix this problem -
> > > that has existed since before the introduction of the perf tool (I
> > > consider it a syscall-independent enhanced error interface), multiple
> > > times, and failed.
> > 
> > Why is that my problem? Try harder?
> 
> It's your problem because we're here reviewing a patch that happens to
> fall under your maintainership.  I'll be the first person to tell you
> I'm obviously incompetent and haven't been able to come up with a
> solution that is acceptable for everyone up to and including Linus
> Torvalds.  I'm just noticing a chronic usability problem that can be
> easily alleviated in the context of this patch review.

I don't see how incompetence has anything to do with it and, like most
people (lucky gits...), I doubt Torvalds cares too deeply about PMU driver
internals. No arguments on the usability problem, but this ain't the fix
you're looking for: it's a bodge. We've been over this many times before.

> > > So until someone comes up with a solution that works for everyone
> > > up to and including Linus Torvalds (who hasn't put up a problem
> > > pulling PMU drivers emitting things to dmesg so far, by the way), this
> > > keep PMU drivers' errors silent preference of yours is unnecessarily
> > > impeding people trying to measure system performance on Arm based
> > > machines - all other archs' maintainers are fine with PMU drivers using
> > > dmesg.
> > 
> > Good for them, although I'm pretty sure that at least the x86 folks are
> > against this crap too.
> 
> Unfortunately, it doesn't affect them nearly as much as it does our
> more diverse platforms, which is why I don't think they care to do
> much about it.

x86 has its fair share of PMUs too, so I don't think we're special in this
regard. The main difference seems to be that they have better support in
the perf tool for diagnosing problems.

> > > > Anyway, I think this driver has bigger problems that need addressing.
> > > 
> > > To me it represents yet another PMU driver submission - as the years go
> > > by - that is lacking in the user messaging area.  Which reminds me, can
> > > you take another look at applying this?:
> > 
> > As I said before, I'm not going to take anything that logs above pr_debug
> > for things that are directly triggerable from userspace. Spin a version
> 
> Why?  There are plenty of things that emit stuff into dmesg that are
> directly triggerable from userspace.  Is it because it upsets fuzzing
> tests?  How about those be run with a patched kernel that somehow
> mitigates the printing?

[we've been over this before]

There are two camps that might find this information useful:

  1. People writing userspace support for a new PMU using the
     perf_event_open syscall

  2. People trying to use a tool which abstracts the PMU details to some
     degree (e.g. perf tool)

Those in (1) can get by with pr_debug. Sure, they have to recompile, but
it's not like there are many people in this camp and they'll probably be
working with the PMU driver writer to some degree anyway and taking new
kernel drops.

Those in (2) may not have access to dmesg, absolutely should not be able
to spam it (since this could hide other important messages), will probably
struggle to match an internal message from the PMU driver to their
invocation of the high-level tool and may well be in a multi-user
environment so will struggle to identify the messages that they are
responsible for. What they actually want is for the perf tool to give
them more information, and dmesg is not the right channel for that, for
similar reasons.

> > using pr_debug and I'll queue it.
> 
> How about using a ratelimited dev_err variant?

Nah, I don't want dmesg being parsed by users of perf tool. pr_debug should
be sufficient for perf tool developers working with a new PMU type.

Will
