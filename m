Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B7DC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C73223D9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C73223D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeHJQOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbeHJQOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:14:14 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F618223D9;
        Fri, 10 Aug 2018 13:44:14 +0000 (UTC)
Date:   Fri, 10 Aug 2018 09:44:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] uprobes: Use synchronize_rcu() not synchronize_sched()
Message-ID: <20180810094412.79d7b181@gandalf.local.home>
In-Reply-To: <20180810133608.GC3677@redhat.com>
References: <20180809160553.469e1e32@gandalf.local.home>
        <20180810113548.GA3677@redhat.com>
        <20180810084832.70b9a62a@gandalf.local.home>
        <20180810133608.GC3677@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Removing Jovi as his email is bouncing ]

On Fri, 10 Aug 2018 15:36:08 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> > > Can't we change uprobe_trace_func() and uretprobe_trace_func() to use
> > > rcu_read_lock_sched() instead? It is more cheap.  
> >
> > Is it? rcu_read_lock_sched() is a preempt_disable(),  
> 
> which is just raw_cpu_inc()
> 
> > where
> > rcu_read_lock() may just be a task counter increment.  
> 
> and  __rcu_read_unlock() is more heavy.
> 
> OK, I agree, this doesn't really matter.

Are you OK with this patch? I set it for stable and plan on pushing it
with the patches for the upcoming merge window. If you are OK, mind
giving me an Acked or Reviewed-by?

> 
> > > Hmm. probe_event_enable() does list_del + kfree on failure, this doesn't
> > > look right... Not only because kfree() can race with list_for_each_entry_rcu(),
> > > we should not put the 1st link on list until uprobe_buffer_enable().
> > >
> > > Does the patch below make sense or I am confused?  
> >
> > I guess the question is, if it isn't enabled, are there any users or
> > even past users still running.  
> 
> Note that uprobe_register() is not "atomic".
> 
> To simplify, suppose we have 2 tasks T1 and T2 running the probed binary.
> So we are going to do install_breakpoint(T1->mm) + install_breakpoint(T2->mm).
> If the 2nd install_breakpoint() fails for any reason, _register() will do
> remove_breakpoint(T1->mm) and return the error.
> 
> However, T1 can hit this bp right after install_breakpoint(T1->mm), so it
> can call uprobe_trace_func() before list_del(&link->list).
> 
> OK, even if I am right this is mostly theoretical.

Even if it is theoretical, we should make sure it can't happen. But
this is unrelated to the current patch, and if we should fix this, then
it can be a separate patch. I don't think your change hurts, and even
if it can't technically happen, it may let us sleep better at night.
Want to send a formal patch to make this change?

-- Steve
