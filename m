Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D06C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5977521476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5977521476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJSK42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbeJSK42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:56:28 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CBE120C0E;
        Fri, 19 Oct 2018 02:52:25 +0000 (UTC)
Date:   Thu, 18 Oct 2018 22:52:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH RFC] doc: rcu: remove obsolete (non-)requirement about
 disabling preemption
Message-ID: <20181018225223.42641c73@vmware.local.home>
In-Reply-To: <20181019022529.GA155753@joelaf.mtv.corp.google.com>
References: <20181016204122.GA8176@joelaf.mtv.corp.google.com>
        <20181017161100.GP2674@linux.ibm.com>
        <20181017181505.GC107185@joelaf.mtv.corp.google.com>
        <20181017203324.GS2674@linux.ibm.com>
        <20181018020751.GB99677@joelaf.mtv.corp.google.com>
        <20181018144637.GD2674@linux.ibm.com>
        <20181019000350.GB89903@joelaf.mtv.corp.google.com>
        <20181019001932.GR2674@linux.ibm.com>
        <20181019012645.GC89903@joelaf.mtv.corp.google.com>
        <20181018215035.5e8ff553@vmware.local.home>
        <20181019022529.GA155753@joelaf.mtv.corp.google.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 19:25:29 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Thu, Oct 18, 2018 at 09:50:35PM -0400, Steven Rostedt wrote:
> > On Thu, 18 Oct 2018 18:26:45 -0700
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> >   
> > > Yes, local_irq_restore is light weight, and does not check for reschedules.
> > > 
> > > I was thinking of case where ksoftirqd is woken up, but does not run unless
> > > we set the NEED_RESCHED flag. But that should get set anyway since probably
> > > ksoftirqd is of high enough priority than the currently running task..
> > > 
> > > Roughly speaking the scenario could be something like:
> > > 
> > > rcu_read_lock();
> > >                  <-- IPI comes in for the expedited GP, sets exp_hint
> > > local_irq_disable();
> > > // do a bunch of stuff
> > > rcu_read_unlock();   <-- This calls the rcu_read_unlock_special which raises
> > >                          the soft irq, and wakesup softirqd.  
> > 
> > If softirqd is of higher priority than the current running task, then
> > the try_to_wake_up() will set NEED_RESCHED of the current task here.
> >   
> 
> Yes, only *if*. On my system, ksoftirqd is CFS nice 0. I thought expedited
> grace periods are quite important and they should complete quickly which is
> the whole reason for interrupting rcu read sections with an IPI and stuff.
> IMO there should be no harm in setting NEED_RESCHED unconditionally anyway
> for possible benefit of systems where the ksoftirqd is not of higher priority
> than the currently running task, and we need to run it soon on the CPU. But
> I'm Ok with whatever Paul and you want to do here.


Setting NEED_RESCHED unconditionally wont help. Because even if we call
schedule() ksoftirqd will not be scheduled! If it's CFS nice 0, and the
current task still has quota to run, if you call schedule, you'll just
waste time calculating that the current task should still be running.
It's equivalent to calling yield() (which is why we removed all yield()
users in the kernel, because *all* of them were buggy!). This is *why*
it only calls schedule *if* softirqd is of higher priority.

-- Steve
