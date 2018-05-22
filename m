Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeEVRdh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:33:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40827 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeEVRdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:33:36 -0400
Date: Tue, 22 May 2018 19:33:33 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180522173333.aawadhkcekzvrswp@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180522131004.3012953c@gandalf.local.home>
 <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180522132429.6f1dcf92@gandalf.local.home>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-22 13:24:29 [-0400], Steven Rostedt wrote:
> On Tue, 22 May 2018 19:21:16 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2018-05-22 13:10:04 [-0400], Steven Rostedt wrote:
> > > On Thu, 17 May 2018 14:40:06 +0200
> > > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > >   
> > > > +static DEFINE_LOCAL_IRQ_LOCK(fpsimd_lock);
> > > >  /*
> > > >   * Update current's FPSIMD/SVE registers from thread_struct.
> > > >   *
> > > > @@ -594,6 +595,7 @@ int sve_set_vector_length(struct task_struct *task,
> > > >  	 * non-SVE thread.
> > > >  	 */
> > > >  	if (task == current) {
> > > > +		local_lock(fpsimd_lock);
> > > >  		local_bh_disable();  
> > > 
> > > I'm surprised that we don't have a "local_lock_bh()"?  
> > 
> > right. Like the last time when we introduced a global lock with no
> > locking context? 
> > 
> 
> I meant, we could have local_lock_bh(fpsimd_lock); that would turn into
> a local_bh_disable() when !PREEMPT_RT.

Oh that part. That could be possible I guess. I need to look into the
second part which disables preemption while the FPU is taken.

> -- Steve

Sebastian
