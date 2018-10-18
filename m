Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC06C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B032083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B032083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=santannapisa.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeJRSeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:34:01 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:40778 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeJRSeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:34:01 -0400
Received: from [10.30.3.207] (account l.abeni@santannapisa.it HELO luca64)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 133795988; Thu, 18 Oct 2018 12:33:37 +0200
Date:   Thu, 18 Oct 2018 12:33:32 +0200
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
Message-ID: <20181018123332.6f33f715@luca64>
In-Reply-To: <20181018094850.GW3121@hirez.programming.kicks-ass.net>
References: <000000000000a4ee200578172fde@google.com>
        <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
        <20181016140322.GB3121@hirez.programming.kicks-ass.net>
        <20181016144045.GF9130@localhost.localdomain>
        <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
        <20181016153608.GH9130@localhost.localdomain>
        <20181018082838.GA21611@localhost.localdomain>
        <20181018094850.GW3121@hirez.programming.kicks-ass.net>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, 18 Oct 2018 11:48:50 +0200
Peter Zijlstra <peterz@infradead.org> wrote:
[...]
> > So, I tend to think that we might want to play safe and put some
> > higher minimum value for dl_runtime (it's currently at 1ULL <<
> > DL_SCALE). Guess the problem is to pick a reasonable value, though.
> > Maybe link it someway to HZ? Then we might add a sysctl (or
> > similar) thing with which knowledgeable users can do whatever they
> > think their platform/config can support?  
> 
> Yes, a HZ related limit sounds like something we'd want. But if we're
> going to do a minimum sysctl, we should also consider adding a
> maximum, if you set a massive period/deadline, you can, even with a
> relatively low u, incur significant delays.

I agree with this.


> And do we want to put the limit on runtime or on period ?

I think we should have a minimum allowed runtime, a maximum allowed
runtime, a minimum allowed period and a (per-user? per-control
group?) maximum allowed utilization.

I suspect having a maximum period is useless, if we already enforce a
maximum runtime.


> That is, something like:
> 
>   TICK_NSEC/2 < period < 10*TICK_NSEC

As written above I would not enforce a maximum period.


> 
> and/or
> 
>   TICK_NSEC/2 < runtime < 10*TICK_NSEC

I think (but I might be wrong) that "TICK_NSEC/2" is too large... I
would divide the tick for a larger number (how many time do we want to
allow the loop to run?)

And I think the maximum runtime should not be TICK-dependent... It is
the maximum amount of time for which we allow the dealdine task to
starve non-deadline tasks, so it should be an absolute time, not
something HZ-dependent... No?



> Hmm, for HZ=1000 that ends up with a max period of 10ms, that's far
> too low, 24Hz needs ~41ms. We can of course also limit the runtime by
> capping u for users (as we should anyway).

Regarding capping u for users: some time ago, with Juri we discussed
the idea of having per-cgroup limits on the deadline utilization... I
think this is a good idea (and if the userspace creates a cgroup per
user, this results in per-user capping - but it is more flexible in
general)



				Luca
