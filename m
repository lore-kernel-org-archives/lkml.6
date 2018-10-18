Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6F5ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1842086E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1842086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=santannapisa.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeJRTIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:08:47 -0400
Received: from mail.santannapisa.it ([193.205.80.98]:32209 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeJRTIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:08:47 -0400
Received: from [10.30.3.207] (account l.abeni@santannapisa.it HELO luca64)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 133797314; Thu, 18 Oct 2018 13:08:16 +0200
Date:   Thu, 18 Oct 2018 13:08:11 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181018130811.61337932@luca64>
In-Reply-To: <20181018104713.GC21611@localhost.localdomain>
References: <000000000000a4ee200578172fde@google.com>
        <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
        <20181016140322.GB3121@hirez.programming.kicks-ass.net>
        <20181016144045.GF9130@localhost.localdomain>
        <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
        <20181016153608.GH9130@localhost.localdomain>
        <20181018082838.GA21611@localhost.localdomain>
        <20181018122331.50ed3212@luca64>
        <20181018104713.GC21611@localhost.localdomain>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 12:47:13 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> Hi,
> 
> On 18/10/18 12:23, luca abeni wrote:
> > Hi Juri,
> > 
> > On Thu, 18 Oct 2018 10:28:38 +0200
> > Juri Lelli <juri.lelli@redhat.com> wrote:
> > [...]  
> > >  struct sched_attr {
> > >     .size	= 0,
> > >     .policy	= 6,
> > >     .flags	= 0,
> > >     .nice	= 0,
> > >     .priority	= 0,
> > >     .runtime	= 0x9917,
> > >     .deadline	= 0xffff,
> > >     .period	= 0,
> > >  }
> > > 
> > > So, we seem to be correctly (in theory, see below) accepting the
> > > task.
> > > 
> > > What seems to generate the problem here is that CONFIG_HZ=100 and
> > > reproducer task has "tiny" runtime (~40us) and deadline (~66us)
> > > parameters, combination that "bypasses" the enforcing mechanism
> > > (performed at each tick).  
> > 
> > Ok, so the task can execute for at most 1 tick before being
> > throttled... Which does not look too bad.
> > 
> > I missed the original emails, but maybe the issue is that the task
> > blocks before the tick, and when it wakes up again something goes
> > wrong with the deadline and runtime assignment? (maybe because the
> > deadline is in the past?)  
> 
> No, the problem is that the task won't be throttled at all, because
> its replenishing instant is always way in the past when tick
> occurs. :-/

Ok, I see the issue now: the problem is that the "while (dl_se->runtime
<= 0)" loop is executed at replenishment time, but the deadline should
be postponed at enforcement time.

I mean: in update_curr_dl() we do:
	dl_se->runtime -= scaled_delta_exec;
	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
		...
		enqueue replenishment timer at dl_next_period(dl_se)
But dl_next_period() is based on a "wrong" deadline!


I think that inserting a
        while (dl_se->runtime <= -pi_se->dl_runtime) {
                dl_se->deadline += pi_se->dl_period;
                dl_se->runtime += pi_se->dl_runtime;
        }
immediately after "dl_se->runtime -= scaled_delta_exec;" would fix the
problem, no?
If we go this way, then we can remove the while loop from
replenish_dl_entity(), and change it in
	WARN_ON(dl_se->runtime <= -pi_se->dl_runtime);
	WARN_ON(dl_se->runtime > 0);
	dl_se->deadline += pi_se->dl_period;
        dl_se->runtime += pi_se->dl_runtime;
or something similar.


			Luca
