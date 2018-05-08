Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753591AbeEHLOi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 07:14:38 -0400
Received: from foss.arm.com ([217.140.101.70]:56524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752347AbeEHLOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 07:14:37 -0400
Date: Tue, 8 May 2018 12:14:31 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
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
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 4/9] arm: Split breakpoint validation into "check" and
 "commit"
Message-ID: <20180508111431.ue2zy2v2l3ob6t4h@lakrids.cambridge.arm.com>
References: <1525634395-23380-1-git-send-email-frederic@kernel.org>
 <1525634395-23380-5-git-send-email-frederic@kernel.org>
 <20180508111323.mmjo4ky4txzi4gx4@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508111323.mmjo4ky4txzi4gx4@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 12:13:23PM +0100, Mark Rutland wrote:
> Hi Frederick,

Argh, sorry for the typo -- I realise that K should not be there.

Mark.

> On Sun, May 06, 2018 at 09:19:50PM +0200, Frederic Weisbecker wrote:
> > The breakpoint code mixes up attribute check and commit into a single
> > code entity. Therefore the validation may return an error due to
> > incorrect atributes while still leaving halfway modified architecture
> > breakpoint struct.
> > 
> > Prepare fox fixing this misdesign and separate both logics.
> 
> Could you elaborate on what the problem is? I would have expected that
> when arch_build_bp_info() returns an error code, we wouldn't
> subsequently use the arch_hw_breakpoint information. Where does that
> happen?
> 
> I understand that there was a problem on x86 -- I'm just having
> difficulty figuring it out.
> 
> I also see that the check and commit hooks have to duplicate a
> reasonable amount of logic, e.g. the switch on bp->attr.type. Can we
> instead refactor the existing arch_build_bp_info() hooks to use a
> temporary arch_hw_breakpoint, and then struct assign it after all the
> error cases, e.g.
> 
> static int arch_build_bp_info(struct perf_event *bp)
> {
> 	struct arch_hw_breakpoint hbp;
> 	
> 	if (some_condition(bp))
> 		hbp->field = 0xf00;
> 
> 	switch (bp->attr.type) {
> 	case FOO:
> 		return -EINVAL;
> 	case BAR:
> 		hbp->other_field = 7;
> 		break;
> 	};
> 
> 	if (failure_case(foo))
> 		return err;
> 	
> 	*counter_arch_bp(bp) = hbp;
> }
> 
> ... or is that also problematic?
> 
> Thanks,
> Mark.
