Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE72C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140FA27685
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M61REib0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140FA27685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935401AbeF1Qd3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754322AbeF1Qd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:33:28 -0400
Received: from localhost (LFbn-NCY-1-193-82.w83-194.abo.wanadoo.fr [83.194.41.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F44727682;
        Thu, 28 Jun 2018 16:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530203607;
        bh=pvUhays33svgIoSaGFH2oQmi6ONJPYPqbA1EeEZepAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M61REib0s9cxMPj+mGVA4QwCsoFErw9QDIrnXe0Si4cmUC1rN+RrjrZcqvzQigCFN
         gk8hhTmqH6aVagPsYseq6wrN5P/lWpnfvp9bKMhrpv5tj2HFEKm3mCDDgGtz/beZ3M
         iw262v72dOSXnuCUY+NRq5InCJSfoOxuvzbDNUFk=
Date:   Thu, 28 Jun 2018 18:33:24 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: sched/core warning triggers on rcu torture test
Message-ID: <20180628163323.GB19886@lerouge>
References: <alpine.DEB.2.21.1806261709001.19188@somnus>
 <20180626163255.GG2458@hirez.programming.kicks-ass.net>
 <20180626174826.GB3593@linux.vnet.ibm.com>
 <20180627104014.GB10102@lerouge>
 <20180627142529.GU3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627142529.GU3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 07:25:29AM -0700, Paul E. McKenney wrote:
> On Wed, Jun 27, 2018 at 12:40:15PM +0200, Frederic Weisbecker wrote:
> > On Tue, Jun 26, 2018 at 10:48:26AM -0700, Paul E. McKenney wrote:
> > > On Tue, Jun 26, 2018 at 06:32:55PM +0200, Peter Zijlstra wrote:
> > > > On Tue, Jun 26, 2018 at 06:16:04PM +0200, Anna-Maria Gleixner wrote:
> > > > > Hi,
> > > > > 
> > > > > during rcu torture tests (TREE04 and TREE07) I noticed, that a
> > > > > WARN_ON_ONCE() in sched core triggers on a recent 4.18-rc2 based
> > > > > kernel (6f0d349d922b ("Merge
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")) as well as
> > > > > on a 4.17.3.
> > > 
> > > First, I am very glad that I am not the only one running rcutorture!  ;-)
> > > 
> > > > > I'm running the tests on a machine with 144 cores:
> > > > > 
> > > > >   tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 144 --duration 120 --configs "9*TREE07"
> > > > >   tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 144 --duration 120 --configs "18*TREE04"
> > > > > 
> > > > > 
> > > > > The warning was introduced by commit d84b31313ef8 ("sched/isolation:
> > > > > Offload residual 1Hz scheduler tick").
> > > > > 
> > > > > 
> > > > > Output looks similar for all tests I did (this one is the output of
> > > > > the 4.18-rc2 based kernel):
> > > > > 
> > > > > WARNING: CPU: 11 PID: 906 at kernel/sched/core.c:3138 sched_tick_remote+0xb6/0xc0
> > > > 
> > > > That's nohz_full stuff, is that a normal part of rcutorture? In any
> > > > case, is the one housekeeping CPU getting seriously overloaded or
> > > > something?
> > > 
> > > Yes, nohz_full is a normal part for rcutorture because RCU has to deal
> > > differently with userspace execution in the nohz_full case.
> > > 
> > > I do see this splat (at least when I don't comment it out), but I
> > > do share my system with others, so I could easily be overloading the
> > > housekeeping vCPUs due to hypervisor preemption.  I was intending to
> > > dig into this one once I got done consolidating RCU-bh, RCU-preempt,
> > > and RCU-sched at Linus's behest.
> > > 
> > > On overloading the housekeeping CPU without outside load, let's look at
> > > TREE04 and TREE07 separately.
> > > 
> > > TREE04 uses eight CPUs, and seven of them ("nohz_full=1-7") are nohz_full
> > > CPUs, and rcutorture doesn't generate all that large of a callback load.
> > > It looks like all 144 CPUs are used in this case (18*8), though RCU
> > > enforces idle periods in order to test idle/non-idle transitions.
> > > But was there anything else running on the machine at the time?
> > > 
> > > TREE07 uses 16 CPUs, and eight of them ("nohz_full=2-9") are nohz_full
> > > CPUs.  Again, it looks like all 144 CPUs are used (9*8).
> > > 
> > > I sometimes see this on TASKS03 as well, which uses two CPUs, and one of
> > > them ("nohz_full=1") is a nohz_full CPU.
> > > 
> > > If your system is otherwise idle, would it make sense to trace context
> > > switches on CPU 0 to see what it is up to?  And to do an ftrace_dump()
> > > and turn tracing off when the warning triggers as well?
> > 
> > Yeah you guys reported me this warning a few times ago. I didn't manage to reproduce
> > it because I fought and failed with a high NR_CPUS machine. But apparently 8 CPUs
> > are enough. Let me try that with TREE04.
> 
> Looking forward to hearing what you find!

Please check "[PATCH] sched/nohz: Skip remote tick on idle task entirely" which I
just posted. In the hope that the warning didn't trigger for another reason on
your testings.

Thanks.
