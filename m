Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965934AbeEITvm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965532AbeEITvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:51:41 -0400
X-Google-Smtp-Source: AB8JxZrLRexN9D6jSl7wQf8sIAZ4H6eOleGzNVYO4woJKFxKHgmmUgjOz8IWW3TQazpMHcxyG83fNr7kc4+LkCw2fhE=
MIME-Version: 1.0
References: <1525634395-23380-1-git-send-email-frederic@kernel.org>
 <1525634395-23380-5-git-send-email-frederic@kernel.org> <20180508111323.mmjo4ky4txzi4gx4@lakrids.cambridge.arm.com>
 <20180509113257.hl6frl424trdt2em@lakrids.cambridge.arm.com>
In-Reply-To: <20180509113257.hl6frl424trdt2em@lakrids.cambridge.arm.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 09 May 2018 19:51:28 +0000
X-Gmail-Original-Message-ID: <CALCETrVswHMf2YxqBN-EczKUcQ8ShpKgL02b9HJ9LCLycGEHOw@mail.gmail.com>
Message-ID: <CALCETrVswHMf2YxqBN-EczKUcQ8ShpKgL02b9HJ9LCLycGEHOw@mail.gmail.com>
Subject: Re: [PATCH 4/9] arm: Split breakpoint validation into "check" and "commit"
To: Mark Rutland <mark.rutland@arm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 4:33 AM Mark Rutland <mark.rutland@arm.com> wrote:

> On Tue, May 08, 2018 at 12:13:23PM +0100, Mark Rutland wrote:
> > Hi Frederick,
> >
> > On Sun, May 06, 2018 at 09:19:50PM +0200, Frederic Weisbecker wrote:
> > > The breakpoint code mixes up attribute check and commit into a single
> > > code entity. Therefore the validation may return an error due to
> > > incorrect atributes while still leaving halfway modified architecture
> > > breakpoint struct.
> > >
> > > Prepare fox fixing this misdesign and separate both logics.
> >
> > Could you elaborate on what the problem is? I would have expected that
> > when arch_build_bp_info() returns an error code, we wouldn't
> > subsequently use the arch_hw_breakpoint information. Where does that
> > happen?

>  From digging, I now see that this is a problem when
> modify_user_hw_breakpoint() is called on an existing breakpoint. It
> would be nice to mention that in the commit message.

> > I also see that the check and commit hooks have to duplicate a
> > reasonable amount of logic, e.g. the switch on bp->attr.type. Can we
> > instead refactor the existing arch_build_bp_info() hooks to use a
> > temporary arch_hw_breakpoint, and then struct assign it after all the
> > error cases, > e.g.
> >
> > static int arch_build_bp_info(struct perf_event *bp)
> > {
> >       struct arch_hw_breakpoint hbp;
> >
> >       if (some_condition(bp))
> >               hbp->field = 0xf00;
> >
> >       switch (bp->attr.type) {
> >       case FOO:
> >               return -EINVAL;
> >       case BAR:
> >               hbp->other_field = 7;
> >               break;
> >       };
> >
> >       if (failure_case(foo))
> >               return err;
> >
> >       *counter_arch_bp(bp) = hbp;
> > }
> >
> > ... or is that also problematic?

> IIUC, this *would* work, but it is a little opaque.

> Perhaps we could explicitly pass the temporary arch_hw_breakpoint in,
> and have the core code struct-assign it after checking for errors?

Hmm, maybe.  OTOH, I'm not really convinced that arch_hw_breakpoint is even
needed.  x86 at least could probably just regenerate the DRn and DR7 bits
on the fly as needed rather than caching them with basically no loss in
performance.  I completely agree that reducing duplication would be nice.
