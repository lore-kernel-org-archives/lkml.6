Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbeDMPoP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:44:15 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:42432 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbeDMPoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:44:14 -0400
X-Google-Smtp-Source: AIpwx49ZZj8YsT3bwPD/5YJThzWOvz7y3RbCNVGCKUR6je3O66gfbDovn5M8heDH8ahPlIa9f6ROYA==
Date: Fri, 13 Apr 2018 17:44:09 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Brian Starkey <brian.starkey@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: daniel@ffwll.ch, Ayan Halder <ayan.halder@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH 8/8] drm/arm/malidp: Added the late system pm functions
Message-ID: <20180413154409.GX31310@phenom.ffwll.local>
Mail-Followup-To: Brian Starkey <brian.starkey@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ayan Halder <ayan.halder@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
References: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
 <1522083800-30100-9-git-send-email-ayan.halder@arm.com>
 <20180327082903.GS14155@phenom.ffwll.local>
 <20180327095907.GA18146@arm.com>
 <CAKMK7uF8mmLOBQtwfQgkdpPHfoy7yM9UApWgc9YiEudoP5WEyw@mail.gmail.com>
 <20180406190216.GA18433@arm.com>
 <20180409082337.GG31310@phenom.ffwll.local>
 <20180409161226.GA6726@e107564-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409161226.GA6726@e107564-lin.cambridge.arm.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 05:15:08PM +0100, Brian Starkey wrote:
> Hi Daniel,
> 
> On Mon, Apr 09, 2018 at 10:23:37AM +0200, Daniel Vetter wrote:
> > On Fri, Apr 06, 2018 at 08:02:16PM +0100, Ayan Halder wrote:
> > > On Tue, Mar 27, 2018 at 01:09:36PM +0200, Daniel Vetter wrote:
> > > > On Tue, Mar 27, 2018 at 11:59 AM, Ayan Halder <ayan.halder@arm.com> wrote:
> > > > > On Tue, Mar 27, 2018 at 10:29:03AM +0200, Daniel Vetter wrote:
> > > > >> On Mon, Mar 26, 2018 at 06:03:20PM +0100, Ayan Kumar Halder wrote:
> > > > >> > malidp_pm_suspend_late checks if the runtime status is not suspended
> > > > >> > and if so, invokes malidp_runtime_pm_suspend which disables the
> > > > >> > display engine/core interrupts and the clocks. It sets the runtime status
> > > > >> > as suspended. Subsequently, malidp_pm_resume_early will invoke
> > > > >> > malidp_runtime_pm_resume which enables the clocks and the interrupts
> > > > >> > (previously disabled) and sets the runtime status as active.
> > > > >> >
> > > > >> > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> > > > >> > Change-Id: I5f8c3d28f076314a1c9da2a46760a9c37039ccda
> > > > >>
> > > > >> Why exactly do you need late/early hooks? If you have dependencies with
> > > > >> other devices, pls consider adding device_links instead. This here
> > > > >> shouldn't be necessary.
> > > > >> -Daniel
> > > > > We need to late/early hooks to disable malidp interrupts and the
> > > > > clocks.
> > > >
> > > > Yes, but why this ordering constraint? Why can't you just disable the
> > > > interrupts/clocks in the normal suspend code. I see that the patch
> > > > does this, I want to understand why it does it.
> > > > -Daniel
> > > Apologies for my delayed response on this.
> > > 
> > > With reference to https://lwn.net/Articles/505683/ :-
> > > 1. "suspend() should leave the device in a quiescent state." We invoke
> > > drm_mode_config_helper_suspend() which deactivates the crtc. I
> > > understand that this is the quiescent state.
> > > 
> > > 2. "suspend_late() can often be the same as runtime_suspend()."  We
> > > invoke runtime suspend/resume calls in late/early hooks.
> > 
> > This article is from 2012. That's not really recommended best practices
> > anymore. device_links have only been added a few years ago, so ofc an
> > article from 2012 can't tell you that you should use those instead :-)
> > 
> > That's why I brought this up, we have much better ways to handle device
> > dependencies now.
> > 
> 
> We aren't trying to manage any device dependencies here, I don't know
> where that idea came from?
> 
> The kernel-doc on drm-next this afternoon says effectively the same
> thing:
> 
>   * @suspend: Executed before putting the system into a sleep state in which the
>   *      contents of main memory are preserved.  The exact action to perform
>   *      depends on the device's subsystem (PM domain, device type, class or bus
>   *      type), but generally the device must be quiescent after subsystem-level
>   *      @suspend() has returned, so that it doesn't do any I/O or DMA.
>   *      Subsystem-level @suspend() is executed for all devices after invoking
>   *      subsystem-level @prepare() for all of them.
> 
> (i.e. suspend() makes the device quiescent).
> 
>   * @suspend_late: Continue operations started by @suspend().  For a number of
>   *      devices @suspend_late() may point to the same callback routine as the
>   *      runtime suspend callback.
> 
> (suggests suspend_late() be assigned to the same function as runtime
> suspend).
> 
> As for why, my understanding is like so:
> 
> For ->suspend(), we use the DRM helper, which disables the CRTC.
> Normally disabling the CRTC would be enough to also invoke our
> pm_runtime callback to do the final clock disable etc., however when a
> system suspend is in-progress, the core forcibly takes a runtime
> reference on all devices - preventing any pm_runtime paths from
> running.

I thought this was fixed. At least I remember we had to add some special
calls to i915 to opt out of the "do runtime pm as part of suspend/resume"
behaviour, since it doesn't match what we needed.

See

commit aae4518b3124b29f8dc81c829c704fd2df72e98b
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Fri May 16 02:46:50 2014 +0200

    PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily

So I thought this stuff was supposed to work now. Adding Rafael Wyzocki,
he's done plenty presentations recently about exactly this.

> This means that after the CRTC is disabled in ->suspend(), our normal
> pm_runtime path will not be invoked, and so the things done in
> malidp_runtime_pm_suspend() will never happen.
> 
> We were just following the advice in the kernel-doc to deal with this.
> 
> The alternative would be to call malidp_runtime_pm_{suspend,resume}
> from the "not late" hooks, but I'd ask why?
> 
> > Also, you still haven't explained what exactly the dependency is.
> 
> Because there isn't one :-)

Hm, if there really isn't one, then I guess it's ok. But it's way too easy
to screw this up, have an accidental depency on a different device. And
then you try to fix this up. Having a suspend_late hook still smells fishy
to me, but I might be out of the loop.
-Daniel



> 
> Thanks,
> -Brian
> 
> > -Daniel
> > 
> > > 
> > > > >> > ---
> > > > >> >  drivers/gpu/drm/arm/malidp_drv.c | 17 +++++++++++++++++
> > > > >> >  1 file changed, 17 insertions(+)
> > > > >> >
> > > > >> > diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> > > > >> > index bd44a6d..f6124d8 100644
> > > > >> > --- a/drivers/gpu/drm/arm/malidp_drv.c
> > > > >> > +++ b/drivers/gpu/drm/arm/malidp_drv.c
> > > > >> > @@ -766,8 +766,25 @@ static int __maybe_unused malidp_pm_resume(struct device *dev)
> > > > >> >     return 0;
> > > > >> >  }
> > > > >> >
> > > > >> > +static int __maybe_unused malidp_pm_suspend_late(struct device *dev)
> > > > >> > +{
> > > > >> > +   if (!pm_runtime_status_suspended(dev)) {
> > > > >> > +           malidp_runtime_pm_suspend(dev);
> > > > >> > +           pm_runtime_set_suspended(dev);
> > > > >> > +   }
> > > > >> > +   return 0;
> > > > >> > +}
> > > > >> > +
> > > > >> > +static int __maybe_unused malidp_pm_resume_early(struct device *dev)
> > > > >> > +{
> > > > >> > +   malidp_runtime_pm_resume(dev);
> > > > >> > +   pm_runtime_set_active(dev);
> > > > >> > +   return 0;
> > > > >> > +}
> > > > >> > +
> > > > >> >  static const struct dev_pm_ops malidp_pm_ops = {
> > > > >> >     SET_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend, malidp_pm_resume) \
> > > > >> > +   SET_LATE_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend_late, malidp_pm_resume_early) \
> > > > >> >     SET_RUNTIME_PM_OPS(malidp_runtime_pm_suspend, malidp_runtime_pm_resume, NULL)
> > > > >> >  };
> > > > >> >
> > > > >> > --
> > > > >> > 2.7.4
> > > > >> >
> > > > >> > _______________________________________________
> > > > >> > dri-devel mailing list
> > > > >> > dri-devel@lists.freedesktop.org
> > > > >> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > >>
> > > > >> --
> > > > >> Daniel Vetter
> > > > >> Software Engineer, Intel Corporation
> > > > >> http://blog.ffwll.ch
> > > > >> _______________________________________________
> > > > >> dri-devel mailing list
> > > > >> dri-devel@lists.freedesktop.org
> > > > >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > > IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > >
> > > >
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
