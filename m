Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D730EC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFCB2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFCB2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeJPWgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:36:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58261 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJPWgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:36:18 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gCQai-0007Ov-Ko; Tue, 16 Oct 2018 16:45:00 +0200
Date:   Tue, 16 Oct 2018 16:45:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Juri Lelli <juri.lelli@gmail.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com,
        juri.lelli@redhat.com
Subject: Re: INFO: rcu detected stall in do_idle
In-Reply-To: <20181016144045.GF9130@localhost.localdomain>
Message-ID: <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
References: <000000000000a4ee200578172fde@google.com> <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de> <20181016140322.GB3121@hirez.programming.kicks-ass.net> <20181016144045.GF9130@localhost.localdomain>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018, Juri Lelli wrote:
> On 16/10/18 16:03, Peter Zijlstra wrote:
> > On Tue, Oct 16, 2018 at 03:24:06PM +0200, Thomas Gleixner wrote:
> > > It does reproduce here but with a kworker stall. Looking at the reproducer:
> > > 
> > >   *(uint32_t*)0x20000000 = 0;
> > >   *(uint32_t*)0x20000004 = 6;
> > >   *(uint64_t*)0x20000008 = 0;
> > >   *(uint32_t*)0x20000010 = 0;
> > >   *(uint32_t*)0x20000014 = 0;
> > >   *(uint64_t*)0x20000018 = 0x9917;
> > >   *(uint64_t*)0x20000020 = 0xffff;
> > >   *(uint64_t*)0x20000028 = 0;
> > >   syscall(__NR_sched_setattr, 0, 0x20000000, 0);
> > > 
> > > which means:
> > > 
> > >   struct sched_attr {
> > >   	 .size		= 0,
> > > 	 .policy	= 6,
> > > 	 .flags		= 0,
> > > 	 .nice		= 0,
> > > 	 .priority	= 0,
> > > 	 .deadline	= 0x9917,
> > > 	 .runtime	= 0xffff,
> > > 	 .period	= 0,
> > >   }
> > > 
> > > policy 6 is SCHED_DEADLINE
> > > 
> > > That makes the thread hog the CPU and prevents all kind of stuff to run.
> > > 
> > > Peter, is that expected behaviour?
> > 
> > Sorta, just like FIFO-99 while(1);. Except we should be rejecting the
> > above configuration, because of the rule:
> > 
> >   runtime <= deadline <= period
> > 
> > Juri, where were we supposed to check that?
> 
> Not if period == 0.
> 
> https://elixir.bootlin.com/linux/latest/source/kernel/sched/deadline.c#L2632
> https://elixir.bootlin.com/linux/latest/source/kernel/sched/deadline.c#L2515
> 
> Now, maybe we should be checking also against the default 95% cap?

If the cap is active, then yes. But you want to use the actual
configuration not the default.

Thanks,

	tglx
