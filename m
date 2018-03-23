Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeCWNQ5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 09:16:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:54094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751686AbeCWNQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 09:16:56 -0400
Date: Fri, 23 Mar 2018 14:16:53 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        bugzilla-daemon@bugzilla.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, wen.yang99@zte.com.cn,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [Bug 199003] console stalled, cause Hard LOCKUP.
Message-ID: <20180323131653.4bsco3v7xdb7ifvu@pathway.suse.cz>
References: <bug-199003-8243@https.bugzilla.kernel.org/>
 <bug-199003-8243-Txkdkdv5Cm@https.bugzilla.kernel.org/>
 <20180321094422.6e099480@gandalf.local.home>
 <20180322021437.GA3181@jagdpanzerIV>
 <20180322182517.511aad9d@gandalf.local.home>
 <20180323120622.GA510@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323120622.GA510@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-03-23 21:06:22, Sergey Senozhatsky wrote:
> > > Sometimes I really wish we had detached consoles. Direct printk()->console
> > > is nice and cool, but... we can't have it. I don't want to pressure for
> > > printk_kthread, but look at all those consoles. There are not so many ways
> > > out. What do you think?
> > 
> > If anything, perhaps we could have a printk thread that is triggered to
> > wake up if any print is taking a long time, or if there's a lot of
> > prints happening. And then it could try to print anything in the
> > buffer. Just the mere printk() in the thread should do the hand off.
> 
> OK. Let's think more about this. I have that "wake up printk_kthread if
> any print is taking a long time, or if there's a lot of prints happening"
> patch set: a watchdog threshold based solution. I didn't update it for a
> while, but can take a look. Detaching printouts does look to me like
> something we need to do.
> 
> Offloading does not work well enough with hand off (in its current
> form). Because the CPU that we offloaded printing from can re-take
> console_sem the very next time it calls printk().
> 
> Something like
> 
>        spin_lock(&lock)
> 	printk() -> 8250
> 	 console_unlock()
> 	 offload		printk_kthread
> 	printk() -> 8250	 console_unlock()
> 	printk() -> 8250	  hand off
> 	 console_unlock()
> 
> so if printk() -> 8250 is very slow and is under some spin_lock
> (like in case of Bug 199003) then offloading doesn't make that much
> difference here. Right? If we don't hand off from printk_kthread
> then things do look different.

If we do not offload from printk_kthread, it might cause softlockups.
This might be solved by rescheduling from printk_kthread. The question
is if it is acceptable. I believe so because we still have cond_resched()
in console_unlock().

We should just make sure to release console_sem before rescheduling.
Then any other process might eventually continue flushing the messages.
It would help to reduce loosing messages. It might be essential when
panic(), suspend, ... happen when printk_kthread is sleeping.

Sigh, I am afraid that we still might need to disable the offload
in various situations.


> > I wonder how bad it would be to wake the printk thread whenever a
> > printk() is executed. Printks really shouldn't be that common.
> 
> That didn't work quite well for me. But I must admit that my previous
> printk_kthread version had some major design problems - preemption in
> printk path [including printk_kthread preemption], the lack of any
> reliable way for any CPU to control what printk_kthread is doing, and
> so on and on. Current version, I guess, is better. But I don't do
> "vprintk_emit() -> wake_up(printk_kthread)", instead I let "direct"
> printks and wake_up(printk_kthread) only when current CPU spent too
> much time in call_console_drivers(); it's quite easy to track given
> that printk->console_unlock() is preempt_disable() now. Besides,
> offloading from console_unlock() automatically handles various cases
> for use. Like printk_deferred() -> IRQ -> console_unlock() and so on.
> 
> What do you think?

IMHO, the wakeup from console_unlock() and related to watchdog threshold
makes sense.

I am still not sure about the reliable way for CPU control. The more
scheduler code we call the more printk_deferred() calls will be
needed.

Sigh, I am afraid that the patchset will not be trivial. We might
still need some justification for all the changes. If I get it
correctly, the reporter of this bug has not tried Steven's patches
yet.

Best Regards,
Petr
