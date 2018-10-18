Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92289C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634F72087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634F72087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=santannapisa.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeJRSif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:38:35 -0400
Received: from mail.sssup.it ([193.205.80.98]:38619 "EHLO mail.santannapisa.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbeJRSif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:38:35 -0400
Received: from [10.30.3.207] (account l.abeni@santannapisa.it HELO luca64)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 133796171; Thu, 18 Oct 2018 12:38:10 +0200
Date:   Thu, 18 Oct 2018 12:38:05 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20181018123805.0f4cadd0@luca64>
In-Reply-To: <20181018101008.GB21611@localhost.localdomain>
References: <000000000000a4ee200578172fde@google.com>
        <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
        <20181016140322.GB3121@hirez.programming.kicks-ass.net>
        <20181016144045.GF9130@localhost.localdomain>
        <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
        <20181016153608.GH9130@localhost.localdomain>
        <20181018082838.GA21611@localhost.localdomain>
        <20181018094850.GW3121@hirez.programming.kicks-ass.net>
        <20181018101008.GB21611@localhost.localdomain>
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

On Thu, 18 Oct 2018 12:10:08 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:
[...]
> > Yes, a HZ related limit sounds like something we'd want. But if
> > we're going to do a minimum sysctl, we should also consider adding
> > a maximum, if you set a massive period/deadline, you can, even with
> > a relatively low u, incur significant delays.
> > 
> > And do we want to put the limit on runtime or on period ?
> > 
> > That is, something like:
> > 
> >   TICK_NSEC/2 < period < 10*TICK_NSEC
> > 
> > and/or
> > 
> >   TICK_NSEC/2 < runtime < 10*TICK_NSEC
> > 
> > Hmm, for HZ=1000 that ends up with a max period of 10ms, that's far
> > too low, 24Hz needs ~41ms. We can of course also limit the runtime
> > by capping u for users (as we should anyway).  
> 
> I also thought of TICK_NSEC/2 as a reasonably safe lower limit

I tend to think that something larger than "2" should be used (maybe
10? I mean: even if HZ = 100, it might make sense to allow a runtime
equal to 1ms...)


> that will implicitly limit period as well since
> 
>    runtime <= deadline <= period

I agree that if we end up with TICK_NSEC/2 for the runtime limit then
explicitly enforcing a minimum period is not needed.



> Not sure about the upper limit, though. Lower limit is something
> related to the inherent granularity of the platform/config, upper
> limit is more to do with highest prio stuff with huge period delaying
> everything else; doesn't seem to be related to HZ?

I agree


			Luca
