Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FD9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8BE20846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8BE20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbeGKNaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732469AbeGKNaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:30:18 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47C8F20652;
        Wed, 11 Jul 2018 13:25:57 +0000 (UTC)
Date:   Wed, 11 Jul 2018 09:25:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180711092555.268adf7f@gandalf.local.home>
In-Reply-To: <20180522173333.aawadhkcekzvrswp@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
        <20180522131004.3012953c@gandalf.local.home>
        <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
        <20180522132429.6f1dcf92@gandalf.local.home>
        <20180522173333.aawadhkcekzvrswp@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 19:33:33 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-05-22 13:24:29 [-0400], Steven Rostedt wrote:
> > On Tue, 22 May 2018 19:21:16 +0200
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >   
> > > On 2018-05-22 13:10:04 [-0400], Steven Rostedt wrote:  
> > > > On Thu, 17 May 2018 14:40:06 +0200
> > > > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > > >     
> > > > > +static DEFINE_LOCAL_IRQ_LOCK(fpsimd_lock);
> > > > >  /*
> > > > >   * Update current's FPSIMD/SVE registers from thread_struct.
> > > > >   *
> > > > > @@ -594,6 +595,7 @@ int sve_set_vector_length(struct task_struct *task,
> > > > >  	 * non-SVE thread.
> > > > >  	 */
> > > > >  	if (task == current) {
> > > > > +		local_lock(fpsimd_lock);
> > > > >  		local_bh_disable();    
> > > > 
> > > > I'm surprised that we don't have a "local_lock_bh()"?    
> > > 
> > > right. Like the last time when we introduced a global lock with no
> > > locking context? 
> > >   
> > 
> > I meant, we could have local_lock_bh(fpsimd_lock); that would turn into
> > a local_bh_disable() when !PREEMPT_RT.  
> 
> Oh that part. That could be possible I guess. I need to look into the
> second part which disables preemption while the FPU is taken.
>

Did you decide to create a local_lock_bh(lock) function? I don't see it.

And should this be backported to 4.14-rt too? You state you saw this in
4.16-rt, but did you start doing something different then, or did the
kernel change?

Thanks!

-- Steve
