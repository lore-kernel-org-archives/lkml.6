Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F2CC43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 22:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A9120843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 22:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A9120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeIBC7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 22:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeIBC7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 22:59:03 -0400
Received: from vmware.local.home (cpe-static-sunnyrestresort-rtr.cmts.tv13.ptd.net [70.15.247.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B585920837;
        Sat,  1 Sep 2018 22:45:33 +0000 (UTC)
Date:   Sat, 1 Sep 2018 18:45:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, joel@joelfernandes.org
Subject: Re: 4.19-rc1: ./include/linux/rcupdate.h:631 rcu_read_lock() used
 illegally while idle!
Message-ID: <20180901184531.72ffb792@vmware.local.home>
In-Reply-To: <20180901175442.GO4225@linux.vnet.ibm.com>
References: <20180901173559.GC26871@zn.tnic>
        <20180901175442.GO4225@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Sep 2018 10:54:42 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Sat, Sep 01, 2018 at 07:35:59PM +0200, Borislav Petkov wrote:
> > This is a huge splat! It haz some perf* and sched* in it, I guess for
> > peterz to stare at. And lemme add Paul for good measure too :)
> > 
> > Kernel is -rc1 + 3 microcode loader patches ontop which should not be
> > related.  
> 
> It really is tracing from the idle loop.  But I thought that the event
> tracing took care of that.  Adding Steve and Joel for their thoughts.
> 
> 							Thanx, Paul
> 
> > Thx.
> > 
> > ---
> > [   62.409125] =============================
> > [   62.409129] WARNING: suspicious RCU usage
> > [   62.409133] 4.19.0-rc1+ #1 Not tainted
> > [   62.409136] -----------------------------
> > [   62.409140] ./include/linux/rcupdate.h:631 rcu_read_lock() used illegally while idle!
> > [   62.409143] 
> >                other info that might help us debug this:
> > 
> > [   62.409147] 
> >                RCU used illegally from idle CPU!
> >                rcu_scheduler_active = 2, debug_locks = 1
> > [   62.409151] RCU used illegally from extended quiescent state!
> > [   62.409155] 1 lock held by swapper/0/0:
> > [   62.409158]  #0: 000000004557ee0e (rcu_read_lock){....}, at: perf_event_output_forward+0x0/0x130
> > [   62.409175] 
> >                stack backtrace:
> > [   62.409180] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0-rc1+ #1
> > [   62.409183] Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
> > [   62.409187] Call Trace:
> > [   62.409196]  dump_stack+0x85/0xcb
> > [   62.409203]  perf_event_output_forward+0xf6/0x130

I think this is because we switched the trace point code to be
protected by srcu instead of rcu_lock_sched() and a song and dance to
"make RCU watch again" if it is not, but perf is using normal
rcu_read_lock() internally even though it is hooked into the
tracepoint code. Should perf switch to SRCU, or perhaps it can do the
song and dance to make RCU watch again?

-- Steve


> > [   62.409215]  __perf_event_overflow+0x52/0xe0
> > [   62.409223]  perf_swevent_overflow+0x91/0xb0
> > [   62.409229]  perf_tp_event+0x11a/0x350
> > [   62.409235]  ? find_held_lock+0x2d/0x90
> > [   62.409251]  ? __lock_acquire+0x2ce/0x1350
> > [   62.409263]  ? __lock_acquire+0x2ce/0x1350
> > [   62.409270]  ? retint_kernel+0x2d/0x2d
> > [   62.409278]  ? find_held_lock+0x2d/0x90
> > [   62.409285]  ? tick_nohz_get_sleep_length+0x83/0xb0
> > [   62.409299]  ? perf_trace_cpu+0xbb/0xd0
> > [   62.409306]  ? perf_trace_buf_alloc+0x5a/0xa0
> > [   62.409311]  perf_trace_cpu+0xbb/0xd0
> > [   62.409323]  cpuidle_enter_state+0x185/0x340
> > [   62.409332]  do_idle+0x1eb/0x260
> > [   62.409340]  cpu_startup_entry+0x5f/0x70
> > [   62.409347]  start_kernel+0x49b/0x4a6
> > 
> > [   62.409357]  secondary_startup_64+0xa4/0xb0
