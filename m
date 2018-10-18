Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F239C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612622145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612622145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=santannapisa.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeJRUhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:37:02 -0400
Received: from mail.santannapisa.it ([193.205.80.98]:41469 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeJRUhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:37:02 -0400
Received: from [10.30.3.207] (account l.abeni@santannapisa.it HELO luca64)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 133799600; Thu, 18 Oct 2018 14:36:10 +0200
Date:   Thu, 18 Oct 2018 14:36:05 +0200
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
Message-ID: <20181018143605.6ce5f208@luca64>
In-Reply-To: <20181018122142.GF21611@localhost.localdomain>
References: <000000000000a4ee200578172fde@google.com>
        <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
        <20181016140322.GB3121@hirez.programming.kicks-ass.net>
        <20181016144045.GF9130@localhost.localdomain>
        <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
        <20181016153608.GH9130@localhost.localdomain>
        <20181018082838.GA21611@localhost.localdomain>
        <20181018122331.50ed3212@luca64>
        <20181018104713.GC21611@localhost.localdomain>
        <20181018130811.61337932@luca64>
        <20181018122142.GF21611@localhost.localdomain>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On Thu, 18 Oct 2018 14:21:42 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:
[...]
> > > > I missed the original emails, but maybe the issue is that the
> > > > task blocks before the tick, and when it wakes up again
> > > > something goes wrong with the deadline and runtime assignment?
> > > > (maybe because the deadline is in the past?)    
> > > 
> > > No, the problem is that the task won't be throttled at all,
> > > because its replenishing instant is always way in the past when
> > > tick occurs. :-/  
> > 
> > Ok, I see the issue now: the problem is that the "while
> > (dl_se->runtime <= 0)" loop is executed at replenishment time, but
> > the deadline should be postponed at enforcement time.
> > 
> > I mean: in update_curr_dl() we do:
> > 	dl_se->runtime -= scaled_delta_exec;
> > 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> > 		...
> > 		enqueue replenishment timer at dl_next_period(dl_se)
> > But dl_next_period() is based on a "wrong" deadline!
> > 
> > 
> > I think that inserting a
> >         while (dl_se->runtime <= -pi_se->dl_runtime) {
> >                 dl_se->deadline += pi_se->dl_period;
> >                 dl_se->runtime += pi_se->dl_runtime;
> >         }
> > immediately after "dl_se->runtime -= scaled_delta_exec;" would fix
> > the problem, no?  
> 
> Mmm, I also thought of letting the task "pay back" its overrunning.
> But, doesn't this get us quite far from what one would expect. I mean,
> enforcement granularity will be way different from task period, no?

Yes, the granularity will be what the kernel can provide (due to the HZ
value and to the hrtick on/off state). But at least the task will not
starve non-deadline tasks (which is bug that originated this
discussion, I think).

If I understand well, there are two different (and orthogonal) issues
here:
1) Due to a bug in the accounting / enforcement mechanisms
   (the wrong placement of the while() loop), the tasks consumes 100% of
   the CPU time, starving non-deadline tasks
2) Due to the large HZ value, the small runtime (and period) and the
   fact that hrtick is disabled, the kernel cannot provide the
   requested scheduling granularity

The second issue can be fixed by imposing limits on minimum and maximum
runtime and the first issue can be fixed by changing the code as I
suggested in my previous email.

I would suggest to address both the two issues, with separate changes
(the current replenishment code looks strange anyway).



				Luca
