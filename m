Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCD3C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D817420693
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D817420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756561AbeFOUyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:54:16 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:47224 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1753541AbeFOUyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:54:15 -0400
Received: (qmail 5510 invoked by uid 2102); 15 Jun 2018 16:54:14 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jun 2018 16:54:14 -0400
Date:   Fri, 15 Jun 2018 16:54:14 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Sebastian Sewior <bigeasy@linutronix.de>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: High-priority softirqs [was: [PATCH] usb: don't offload isochronous
 urb completions to ksoftirq]
In-Reply-To: <20180615174012.m6rqow2sytwgxxrx@linutronix.de>
Message-ID: <Pine.LNX.4.44L0.1806151649060.1387-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018, Sebastian Sewior wrote:

> On 2018-06-15 13:34:28 [-0400], Steven Rostedt wrote:
> > On Fri, 15 Jun 2018 19:28:34 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > > One solution to that is to avoid both tasklets and kworkers and change the
> > > USB code to make use of threaded interrupt handlers. I.e. handle the fast
> > > stuff in the primary (hardirq) handler and delegate the rest to the irq
> > > thread. That thread still can offload disk type stuff to a kworker if
> > > needed. But the irq thread allows to bring the stuff under scheduler
> > > control and experiments which I did a few years ago worked out pretty good.
> > 
> > If there's any question about this, drivers can request to have their
> > interrupt handlers run as threads. This has been added to mainline
> > years ago. And it really should be the default solution before pushing
> > off to tasklets or kworkers.
> 
>  https://lkml.kernel.org/r/20180216170450.yl5owfphuvltstnt@breakpoint.cc

This is more or less independent of our original question.  Even if we 
migrate the USB stack to use threaded interrupt handlers instead of 
tasklets, we still have to face the issue of completing some 
isochronous URBs at high priority and others not in interrupt context 
(presumably at normal priority).

The URB_FAST_COMPLETION approach seems like the best solution to the
audio problem.  And if we do switch over to threaded interrupts for URB
completions in the future, it should still be compatible.

Alan Stern

