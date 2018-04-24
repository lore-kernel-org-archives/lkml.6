Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbeDXVkc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 17:40:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36920 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeDXVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 17:40:31 -0400
X-Google-Smtp-Source: AIpwx49q3d08+sunu8x3aBIFs0oczWDIX6h/wtqfzeXU5yYl8/dGIECs6PIJ1AJbgppVncIAmCQRvg==
Date: Tue, 24 Apr 2018 23:40:27 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, David.Panariti@amd.com,
        oleg@redhat.com, ebiederm@xmission.com, Alexander.Deucher@amd.com,
        akpm@linux-foundation.org, Christian.Koenig@amd.com
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Message-ID: <20180424214027.GG25142@phenom.ffwll.local>
Mail-Followup-To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, David.Panariti@amd.com,
        oleg@redhat.com, ebiederm@xmission.com, Alexander.Deucher@amd.com,
        akpm@linux-foundation.org, Christian.Koenig@amd.com
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
 <20180424194418.GE25142@phenom.ffwll.local>
 <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 05:02:40PM -0400, Andrey Grodzovsky wrote:
> 
> 
> On 04/24/2018 03:44 PM, Daniel Vetter wrote:
> > On Tue, Apr 24, 2018 at 05:46:52PM +0200, Michel Dänzer wrote:
> > > Adding the dri-devel list, since this is driver independent code.
> > > 
> > > 
> > > On 2018-04-24 05:30 PM, Andrey Grodzovsky wrote:
> > > > Avoid calling wait_event_killable when you are possibly being called
> > > > from get_signal routine since in that case you end up in a deadlock
> > > > where you are alreay blocked in singla processing any trying to wait
> > > Multiple typos here, "[...] already blocked in signal processing and [...]"?
> > > 
> > > 
> > > > on a new signal.
> > > > 
> > > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> > > > ---
> > > >   drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
> > > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > > > index 088ff2b..09fd258 100644
> > > > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > > > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > > > @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
> > > >   		return;
> > > >   	/**
> > > >   	 * The client will not queue more IBs during this fini, consume existing
> > > > -	 * queued IBs or discard them on SIGKILL
> > > > +	 * queued IBs or discard them when in death signal state since
> > > > +	 * wait_event_killable can't receive signals in that state.
> > > >   	*/
> > > > -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
> > > > +	if (current->flags & PF_SIGNALED)
> > You want fatal_signal_pending() here, instead of inventing your own broken
> > version.
> 
> I rely on current->flags & PF_SIGNALED because this being set from within
> get_signal,
> meaning I am within signal processing  in which case I want to avoid any
> signal based wait for that task,
> From what i see in the code, task_struct.pending.signal is being set for
> other threads in same
> group (zap_other_threads) or for other scenarios, those task are still able
> to receive signals
> so calling wait_event_killable there will not have problem.
> > > >   		entity->fini_status = -ERESTARTSYS;
> > > >   	else
> > > >   		entity->fini_status = wait_event_killable(sched->job_scheduled,
> > But really this smells like a bug in wait_event_killable, since
> > wait_event_interruptible does not suffer from the same bug. It will return
> > immediately when there's a signal pending.
> 
> Even when wait_event_interruptible is called as following -
> ...->do_signal->get_signal->....->wait_event_interruptible ?
> I haven't tried it but wait_event_interruptible is very much alike to
> wait_event_killable so I would assume it will also
> not be interrupted if called like that. (Will give it a try just out of
> curiosity anyway)

wait_event_killabel doesn't check for fatal_signal_pending before calling
schedule, so definitely has a nice race there.

But if you're sure that you really need to check PF_SIGNALED, then I'm
honestly not clear on what you're trying to pull off here. Your sparse
explanation of what happens isn't enough, since I have no idea how you can
get from get_signal() to the above wait_event_killable callsite.
-Daniel

> 
> Andrey
> 
> > 
> > I think this should be fixed in core code, not papered over in some
> > subsystem.
> > -Daniel
> > 
> > > 
> > > -- 
> > > Earthling Michel Dänzer               |               http://www.amd.com
> > > Libre software enthusiast             |             Mesa and X developer
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
