Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A4CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A0D20671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A0D20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbeGTVe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:34:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53532 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbeGTVe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:34:28 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 98DDEC83;
        Fri, 20 Jul 2018 20:44:31 +0000 (UTC)
Date:   Fri, 20 Jul 2018 13:44:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH -next 0/2] fs/epoll: loosen irq safety when possible
Message-Id: <20180720134429.1ba61018934b084bb2e17bdb@linux-foundation.org>
In-Reply-To: <20180720200559.27nc7j2rrxpy5p3n@linux-r8p5>
References: <20180720172956.2883-1-dave@stgolabs.net>
        <20180720124212.7260d76d83e2b8e5e3349ea5@linux-foundation.org>
        <20180720200559.27nc7j2rrxpy5p3n@linux-r8p5>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 13:05:59 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Fri, 20 Jul 2018, Andrew Morton wrote:
> 
> >On Fri, 20 Jul 2018 10:29:54 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:
> >
> >> Hi,
> >>
> >> Both patches replace saving+restoring interrupts when taking the
> >> ep->lock (now the waitqueue lock), with just disabling local irqs.
> >> This shows immediate performance benefits in patch 1 for an epoll
> >> workload running on Xen.
> >
> >I'm surprised.  Is spin_lock_irqsave() significantly more expensive
> >than spin_lock_irq()?  Relative to all the other stuff those functions
> >are doing?  If so, how come?  Some architectural thing makes
> >local_irq_save() much more costly than local_irq_disable()?
> 
> For example, if you compare x86 native_restore_fl() to xen_restore_fl(),
> the cost of Xen is much higher.
> 
> And at least considering ep_scan_ready_list(), the lock is taken/released
> twice, to deal with the ovflist when the ep->wq.lock is not held. To the
> point that it yields measurable results (see patch 1) across incremental
> thread counts.

Did you try measuring it on bare hardware?

> >
> >> The main concern we need to have with this
> >> sort of changes in epoll is the ep_poll_callback() which is passed
> >> to the wait queue wakeup and is done very often under irq context,
> >> this patch does not touch this call.
> >
> >Yeah, these changes are scary.  For the code as it stands now, and for
> >the code as it evolves.
> 
> Yes which is why I've been throwing lots of epoll workloads at it.

I'm sure.  It's the "as it evolves" that is worrisome, and has caught
us in the past.

> >
> >I'd have more confidence if we had some warning mechanism if we run
> >spin_lock_irq() when IRQs are disabled, which is probably-a-bug.  But
> >afaict we don't have that.  Probably for good reasons - I wonder what
> >they are?

Well ignored ;)

We could open-code it locally.  Add a couple of
WARN_ON_ONCE(irqs_disabled())?  That might need re-benchmarking with
Xen but surely just reading the thing isn't too expensive?


