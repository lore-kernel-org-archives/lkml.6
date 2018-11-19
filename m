Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD3DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6757D214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6757D214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbeKTC7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731717AbeKTC7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:59:48 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CA5421479;
        Mon, 19 Nov 2018 16:35:39 +0000 (UTC)
Date:   Mon, 19 Nov 2018 11:35:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Andrew Morton <akpm@osdl.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] sched: Do not bug in __sched_setscheduler() when pi is
 not used
Message-ID: <20181119113537.3aa4f05e@gandalf.local.home>
In-Reply-To: <20181119162432.GB13065@kroah.com>
References: <20170309101842.1449d49a@gandalf.local.home>
        <46a07263-3327-94b6-f6b8-a0a17ae7bfee@broadcom.com>
        <20181119151311.GA5340@kroah.com>
        <20181119104654.47623a42@gandalf.local.home>
        <20181119162432.GB13065@kroah.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018 17:24:32 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Nov 19, 2018 at 10:46:54AM -0500, Steven Rostedt wrote:
> > On Mon, 19 Nov 2018 16:13:11 +0100
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >   
> > > > Can this patch also be applied to the stable trees? The offending commit
> > > > was first introduced in 4.2.    
> > > 
> > > What is the git commit id of this patch in Linus's tree?  
> > 
> > 896bbb2522587e3b8eb2a0d204d43ccc1042a00d
> > 
> > The subject was changed when it was applied.  
> 
> Ah, that helps.
> 
> But why is this really needed in the older kernels?  You want to crash
> your machine if someone got things wrong?  Given that I doubt this is
> being hit anymore, why is it needed in 4.9.y and 4.4.y?

The problem is that it can crash when people didn't get it wrong (by
using sysrq).

The bug happened when we combined two functions into one, and where the
BUG_ON() from one was now added to the other function. The one (where
pi is true) requires the function to be called with interrupts
disabled. The other did not have this requirement (and pi happens to be
false). Thus, you can trigger the BUG_ON(in_interrupt()) with a simple
sysrq key stroke, and crash your kernel when it did nothing wrong.

> 
> Also, it doesn't apply there so someone needs to do the backport...
> 

I did the change against v4.2.8 below.

-- Steve

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6776631676e0..b2af7989eb5b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3682,7 +3682,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	int reset_on_fork;
 
 	/* may grab non-irq protected spin_locks */
-	BUG_ON(in_interrupt());
+	BUG_ON(pi && in_interrupt());
 recheck:
 	/* double check policy once rq lock held */
 	if (policy < 0) {
