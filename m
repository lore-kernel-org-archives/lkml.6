Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFCDC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 09:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D1824B78
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 09:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D1824B78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeFWJEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 05:04:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43175 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeFWJEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 05:04:32 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWeT3-0003dz-UG; Sat, 23 Jun 2018 11:04:26 +0200
Date:   Sat, 23 Jun 2018 11:04:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, michael-git@rodin.online,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] arch/x86/entry/vsyscall/vsyscall_gtod.c: remove
 __read_mostly from vclocks_used
In-Reply-To: <CALCETrVDuqie6WS--gyb9ohEKXmreA+iN5P-raJbnfS7Tp8nkQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806231057040.8650@nanos.tec.linutronix.de>
References: <20180604172711.18962-1-michael-git@rodin.online> <alpine.DEB.2.21.1806222333070.1589@nanos.tec.linutronix.de> <CALCETrVDuqie6WS--gyb9ohEKXmreA+iN5P-raJbnfS7Tp8nkQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018, Andy Lutomirski wrote:
> On Fri, Jun 22, 2018 at 3:47 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Mon, 4 Jun 2018, Michael Rodin wrote:
> >
> > > The variable "vclocks_used" doesn't appear to be "read mostly".
> > > Measurements of the access frequency with perf stat [1] and
> > > perf report show, that approximately half of the accesses to
> > > this variable are write accesses and happen in update_vsyscall()
> > > in the file arch/x86/entry/vsyscall/vsyscall_gtod.c.
> > > The measurements were done with the kernel 4.13.0-43-generic used by
> > > ubuntu as well as with the stable kernel 4.16.7 with a custom config.
> > > I've used "perf bench sched" and iperf3 as workloads.
> > >
> > > This was discovered during my master thesis in the CADOS project [2].
> >
> > Nice find, but ...
> >
> > The point is that the content of that variable changes once in a blue moon,
> > so the intent of marking it read_mostly is almost correct.
> 
> I would propose a rather different fix.  Add a an
> arch_change_clocksource() function.  Do:
> 
> static inline void arch_change_clocksource(struct clocksource
> *new_clocksource) { ... }
> #define arch_change_clocksource arch_change_clocksource
> 
> and
> 
> #ifndef arch_change_clocksource
> static inline void arch_change_clocksource(struct clocksource
> *new_clocksource) {}
> #endif
>
> in the generic header.  In change_clocksource(), add a call to
> arch_change_clocksource() right after tk_setup_internals().  In x86's
> arch_change_clocksource, update vclocks_used.
> 
> Now it's genuinely read_mostly, and we don't need to touch that
> cacheline at all in the normal clock tick code.  Everyone wins.
> (vclocks_used is actually rather rarely read.  It's only used to
> prevent user code from accessing a never-used clocksource through the
> vvar area, which is a hardening measure.  It's only referenced from
> the vvar fault handler code.)

Agreed.

Thanks,

	tglx
