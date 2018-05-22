Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeEVRYe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeEVRYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:24:32 -0400
Date: Tue, 22 May 2018 13:24:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180522132429.6f1dcf92@gandalf.local.home>
In-Reply-To: <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
        <20180522131004.3012953c@gandalf.local.home>
        <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 19:21:16 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-05-22 13:10:04 [-0400], Steven Rostedt wrote:
> > On Thu, 17 May 2018 14:40:06 +0200
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >   
> > > +static DEFINE_LOCAL_IRQ_LOCK(fpsimd_lock);
> > >  /*
> > >   * Update current's FPSIMD/SVE registers from thread_struct.
> > >   *
> > > @@ -594,6 +595,7 @@ int sve_set_vector_length(struct task_struct *task,
> > >  	 * non-SVE thread.
> > >  	 */
> > >  	if (task == current) {
> > > +		local_lock(fpsimd_lock);
> > >  		local_bh_disable();  
> > 
> > I'm surprised that we don't have a "local_lock_bh()"?  
> 
> right. Like the last time when we introduced a global lock with no
> locking context? 
> 

I meant, we could have local_lock_bh(fpsimd_lock); that would turn into
a local_bh_disable() when !PREEMPT_RT.

-- Steve
