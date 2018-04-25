Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbeDYHOu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:14:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38080 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDYHOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:14:48 -0400
X-Google-Smtp-Source: AB8JxZoI5kBNvdKsMIME3ef+vyupZAEbApFhJ556LkxOIQ01rqKg2Q799A16R9gRjCHKFSu25D129w==
Date: Wed, 25 Apr 2018 09:14:44 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, David.Panariti@amd.com,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        oleg@redhat.com, amd-gfx@lists.freedesktop.org,
        Alexander.Deucher@amd.com, akpm@linux-foundation.org,
        Christian.Koenig@amd.com
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Message-ID: <20180425071444.GM25142@phenom.ffwll.local>
Mail-Followup-To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, David.Panariti@amd.com,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        oleg@redhat.com, amd-gfx@lists.freedesktop.org,
        Alexander.Deucher@amd.com, akpm@linux-foundation.org,
        Christian.Koenig@amd.com
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
 <20180424194418.GE25142@phenom.ffwll.local>
 <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com>
 <87tvs05mik.fsf@xmission.com>
 <27d7d15b-f7c3-2a0a-af85-eb243526ac88@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27d7d15b-f7c3-2a0a-af85-eb243526ac88@amd.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 05:37:08PM -0400, Andrey Grodzovsky wrote:
> 
> 
> On 04/24/2018 05:21 PM, Eric W. Biederman wrote:
> > Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
> > 
> > > On 04/24/2018 03:44 PM, Daniel Vetter wrote:
> > > > On Tue, Apr 24, 2018 at 05:46:52PM +0200, Michel Dänzer wrote:
> > > > > Adding the dri-devel list, since this is driver independent code.
> > > > > 
> > > > > 
> > > > > On 2018-04-24 05:30 PM, Andrey Grodzovsky wrote:
> > > > > > Avoid calling wait_event_killable when you are possibly being called
> > > > > > from get_signal routine since in that case you end up in a deadlock
> > > > > > where you are alreay blocked in singla processing any trying to wait
> > > > > Multiple typos here, "[...] already blocked in signal processing and [...]"?
> > > > > 
> > > > > 
> > > > > > on a new signal.
> > > > > > 
> > > > > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> > > > > > ---
> > > > > >    drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
> > > > > >    1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > > > > > index 088ff2b..09fd258 100644
> > > > > > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > > > > > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > > > > > @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
> > > > > >    		return;
> > > > > >    	/**
> > > > > >    	 * The client will not queue more IBs during this fini, consume existing
> > > > > > -	 * queued IBs or discard them on SIGKILL
> > > > > > +	 * queued IBs or discard them when in death signal state since
> > > > > > +	 * wait_event_killable can't receive signals in that state.
> > > > > >    	*/
> > > > > > -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
> > > > > > +	if (current->flags & PF_SIGNALED)
> > > > You want fatal_signal_pending() here, instead of inventing your own broken
> > > > version.
> > > I rely on current->flags & PF_SIGNALED because this being set from
> > > within get_signal,
> > It doesn't mean that.  Unless you are called by do_coredump (you
> > aren't).
> 
> Looking in latest code here
> https://elixir.bootlin.com/linux/v4.17-rc2/source/kernel/signal.c#L2449
> i see that current->flags |= PF_SIGNALED; is out side of
> if (sig_kernel_coredump(signr)) {...} scope

Ok I read some more about this, and I guess you go through process exit
and then eventually close. But I'm not sure.

The code in drm_sched_entity_fini also looks strange: You unpark the
scheduler thread before you remove all the IBs. At least from the comment
that doesn't sound like what you want to do.

But in general, PF_SIGNALED is really something deeply internal to the
core (used for some book-keeping and accounting). The drm scheduler is the
only thing looking at it, so smells like a layering violation. I suspect
(but without knowing what you're actually trying to achive here can't be
sure) you want to look at something else.

E.g. PF_EXITING seems to be used in a lot more places to cancel stuff
that's no longer relevant when a task exits, not PF_SIGNALED. There's the
TIF_MEMDIE flag if you're hacking around issues with the oom-killer.

This here on the other hand looks really fragile, and probably only does
what you want to do by accident.
-Daniel

> 
> Andrey
> 
> > The closing of files does not happen in do_coredump.
> > Which means you are being called from do_exit.
> > In fact you are being called after exit_files which closes
> > the files.  The actual __fput processing happens in task_work_run.
> > 
> > > meaning I am within signal processing  in which case I want to avoid
> > > any signal based wait for that task,
> > >  From what i see in the code, task_struct.pending.signal is being set
> > > for other threads in same
> > > group (zap_other_threads) or for other scenarios, those task are still
> > > able to receive signals
> > > so calling wait_event_killable there will not have problem.
> > Excpet that you are geing called after from do_exit and after exit_files
> > which is after exit_signal.  Which means that PF_EXITING has been set.
> > Which implies that the kernel signal handling machinery has already
> > started being torn down.
> > 
> > Not as much as I would like to happen at that point as we are still
> > left with some old CLONE_PTHREAD messes in the code that need to be
> > cleaned up.
> > 
> > Still given the fact you are task_work_run it is quite possible even
> > release_task has been run on that task before the f_op->release method
> > is called.  So you simply can not count on signals working.
> > 
> > Which in practice leaves a timeout for ending your wait.  That code can
> > legitimately be in a context that is neither interruptible nor killable.
> > 
> > > > > >    		entity->fini_status = -ERESTARTSYS;
> > > > > >    	else
> > > > > >    		entity->fini_status = wait_event_killable(sched->job_scheduled,
> > > > But really this smells like a bug in wait_event_killable, since
> > > > wait_event_interruptible does not suffer from the same bug. It will return
> > > > immediately when there's a signal pending.
> > > Even when wait_event_interruptible is called as following -
> > > ...->do_signal->get_signal->....->wait_event_interruptible ?
> > > I haven't tried it but wait_event_interruptible is very much alike to
> > > wait_event_killable so I would assume it will also
> > > not be interrupted if called like that. (Will give it a try just out
> > > of curiosity anyway)
> > As PF_EXITING is set want_signal should fail and the signal state of the
> > task should not be updatable by signals.
> > 
> > Eric
> > 
> > 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
