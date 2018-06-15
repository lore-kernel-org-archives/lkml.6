Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE26C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F8A205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F8A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966073AbeFOR2m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:28:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51240 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936136AbeFOR2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:28:41 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fTsWY-0004iF-SO; Fri, 15 Jun 2018 19:28:35 +0200
Date:   Fri, 15 Jun 2018 19:28:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alan Stern <stern@rowland.harvard.edu>
cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: High-priority softirqs [was: [PATCH] usb: don't offload isochronous
 urb completions to ksoftirq]
In-Reply-To: <Pine.LNX.4.44L0.1806151308310.1387-100000@iolanthe.rowland.org>
Message-ID: <alpine.DEB.2.21.1806151919130.1582@nanos.tec.linutronix.de>
References: <Pine.LNX.4.44L0.1806151308310.1387-100000@iolanthe.rowland.org>
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

On Fri, 15 Jun 2018, Alan Stern wrote:
> On Fri, 15 Jun 2018, Mikulas Patocka wrote:
> 
> > I think the major problem (in the upstream kernel) with softirq latency is 
> > this:
> > static inline void invoke_softirq(void)
> > {
> >         if (ksoftirqd_running())
> >                 return;
> > 
> > It means that if any piece of code kicks ksoftirq, no tasklets are 
> > processed in the irq context at all.
> > 
> > So, the ehci callbacks will be offloaded to ksoftirqd (no matter how small 
> > they are) and this causes audio skipping. Could this be changed, so that 
> > it processes tasklets submitted with "tasklet_hi_schedule" in irq context 
> > even if ksoftirqd is running?
> 
> That's a great question.  Basically you're asking to have the HI 
> softirq always handled in the bottom half, never in ksoftirqd, right?  
> 
> Or maybe to have more than one softirq thread, to handle different 
> softirq levels, so that they can be assigned differing priorities.
> 
> > It's not easy - __do_softirq lacks any locking - so it can't run 
> > concurrently in process context and in irq context.
> 
> I have no idea.  Maybe someone with a better understanding of this part
> of the kernel can help.

Well, yes. Similar issues have been discussed in the past, but softirqs and
especially tasklets have horrible semantics. There was an attempt to deal
with that, but that didn't end well.

There is another even worse issue with USB/audio which I looked at a few
days ago. Some USB hosts offload to kworkers, which has even worse
behaviour than the ksoftirqd case.

One solution to that is to avoid both tasklets and kworkers and change the
USB code to make use of threaded interrupt handlers. I.e. handle the fast
stuff in the primary (hardirq) handler and delegate the rest to the irq
thread. That thread still can offload disk type stuff to a kworker if
needed. But the irq thread allows to bring the stuff under scheduler
control and experiments which I did a few years ago worked out pretty good.

Thanks,

	tglx


