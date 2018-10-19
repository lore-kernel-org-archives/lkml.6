Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7467ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B292083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B292083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=santannapisa.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeJTE55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:57:57 -0400
Received: from mail.santannapisa.it ([193.205.80.98]:50412 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeJTE55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 00:57:57 -0400
Received: from [151.40.1.127] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 133834824; Fri, 19 Oct 2018 22:50:12 +0200
Date:   Fri, 19 Oct 2018 22:50:05 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181019225005.61707c64@nowhere>
In-Reply-To: <20181019113942.GH3121@hirez.programming.kicks-ass.net>
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
        <20181019113942.GH3121@hirez.programming.kicks-ass.net>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2018 13:39:42 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Oct 18, 2018 at 01:08:11PM +0200, luca abeni wrote:
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
> That certainly makes sense to me.

Good; I'll try to work on this idea in the weekend.


			Thanks,
				Luca

> The only remaining issue would then
> be placing a limit on the amount of times we can take that loop;
> which, as you propose in a later email; can be done separately as a
> limit on runtime.

