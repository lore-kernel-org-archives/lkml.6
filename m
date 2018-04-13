Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeDMQCz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:02:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43722 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751866AbeDMQCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:02:54 -0400
Date: Fri, 13 Apr 2018 17:02:44 +0100
From: Brian Starkey <brian.starkey@arm.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ayan Halder <ayan.halder@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH 8/8] drm/arm/malidp: Added the late system pm functions
Message-ID: <20180413160244.GA33889@e107564-lin.cambridge.arm.com>
References: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
 <1522083800-30100-9-git-send-email-ayan.halder@arm.com>
 <20180327082903.GS14155@phenom.ffwll.local>
 <20180327095907.GA18146@arm.com>
 <CAKMK7uF8mmLOBQtwfQgkdpPHfoy7yM9UApWgc9YiEudoP5WEyw@mail.gmail.com>
 <20180406190216.GA18433@arm.com>
 <20180409082337.GG31310@phenom.ffwll.local>
 <20180409161226.GA6726@e107564-lin.cambridge.arm.com>
 <20180413154409.GX31310@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180413154409.GX31310@phenom.ffwll.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, Apr 13, 2018 at 05:44:09PM +0200, Daniel Vetter wrote:
>On Mon, Apr 09, 2018 at 05:15:08PM +0100, Brian Starkey wrote:
>> Hi Daniel,
>>
>> On Mon, Apr 09, 2018 at 10:23:37AM +0200, Daniel Vetter wrote:
>> > On Fri, Apr 06, 2018 at 08:02:16PM +0100, Ayan Halder wrote:
>> > > On Tue, Mar 27, 2018 at 01:09:36PM +0200, Daniel Vetter wrote:
>> > > > On Tue, Mar 27, 2018 at 11:59 AM, Ayan Halder <ayan.halder@arm.com> wrote:

[snip]

>>
>> As for why, my understanding is like so:
>>
>> For ->suspend(), we use the DRM helper, which disables the CRTC.
>> Normally disabling the CRTC would be enough to also invoke our
>> pm_runtime callback to do the final clock disable etc., however when a
>> system suspend is in-progress, the core forcibly takes a runtime
>> reference on all devices - preventing any pm_runtime paths from
>> running.
>
>I thought this was fixed. At least I remember we had to add some special
>calls to i915 to opt out of the "do runtime pm as part of suspend/resume"
>behaviour, since it doesn't match what we needed.
>
>See
>
>commit aae4518b3124b29f8dc81c829c704fd2df72e98b
>Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>Date:   Fri May 16 02:46:50 2014 +0200
>
>    PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily
>
>So I thought this stuff was supposed to work now. Adding Rafael Wyzocki,
>he's done plenty presentations recently about exactly this.

AFAIK direct-complete is a different thing - related, but not involved
here.

Ayan's patch is to deal with the case where the device is active
(runtime state = active), when a system suspend is triggered.

The core takes its reference (leaving direct-complete devices
'suspended' if possible, but our device is 'active' and so
direct-complete doesn't apply) and then we start the system suspend
and disable the CRTC.

Normally, after the CRTC is disabled, we rely on PM-core to notice we
can be runtime suspended, but it won't do this during system suspend
because of the reference PM-core took, and so we need to force the
suspend ourselves.

>
>> This means that after the CRTC is disabled in ->suspend(), our normal
>> pm_runtime path will not be invoked, and so the things done in
>> malidp_runtime_pm_suspend() will never happen.
>>
>> We were just following the advice in the kernel-doc to deal with this.
>>
>> The alternative would be to call malidp_runtime_pm_{suspend,resume}
>> from the "not late" hooks, but I'd ask why?
>>
>> > Also, you still haven't explained what exactly the dependency is.
>>
>> Because there isn't one :-)
>
>Hm, if there really isn't one, then I guess it's ok. But it's way too easy
>to screw this up, have an accidental depency on a different device. And
>then you try to fix this up. Having a suspend_late hook still smells fishy
>to me, but I might be out of the loop.
>-Daniel
>

Hopefully Rafael can set us straight. The kerneldoc doesn't make
suspend_late sound exceptional, but kernel-doc isn't perfect :-)

Thanks for the review,
-Brian

>
>
>>
>> Thanks,
>> -Brian
>>
>> > -Daniel
>> >
>> > >
>> > > > >> > ---
>> > > > >> >  drivers/gpu/drm/arm/malidp_drv.c | 17 +++++++++++++++++
>> > > > >> >  1 file changed, 17 insertions(+)
>> > > > >> >
>> > > > >> > diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
>> > > > >> > index bd44a6d..f6124d8 100644
>> > > > >> > --- a/drivers/gpu/drm/arm/malidp_drv.c
>> > > > >> > +++ b/drivers/gpu/drm/arm/malidp_drv.c
>> > > > >> > @@ -766,8 +766,25 @@ static int __maybe_unused malidp_pm_resume(struct device *dev)
>> > > > >> >     return 0;
>> > > > >> >  }
>> > > > >> >
>> > > > >> > +static int __maybe_unused malidp_pm_suspend_late(struct device *dev)
>> > > > >> > +{
>> > > > >> > +   if (!pm_runtime_status_suspended(dev)) {
>> > > > >> > +           malidp_runtime_pm_suspend(dev);
>> > > > >> > +           pm_runtime_set_suspended(dev);
>> > > > >> > +   }
>> > > > >> > +   return 0;
>> > > > >> > +}
>> > > > >> > +
>> > > > >> > +static int __maybe_unused malidp_pm_resume_early(struct device *dev)
>> > > > >> > +{
>> > > > >> > +   malidp_runtime_pm_resume(dev);
>> > > > >> > +   pm_runtime_set_active(dev);
>> > > > >> > +   return 0;
>> > > > >> > +}
>> > > > >> > +
>> > > > >> >  static const struct dev_pm_ops malidp_pm_ops = {
>> > > > >> >     SET_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend, malidp_pm_resume) \
>> > > > >> > +   SET_LATE_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend_late, malidp_pm_resume_early) \
>> > > > >> >     SET_RUNTIME_PM_OPS(malidp_runtime_pm_suspend, malidp_runtime_pm_resume, NULL)
>> > > > >> >  };
>> > > > >> >
>> > > > >> > --
>> > > > >> > 2.7.4
>> > > > >> >
>> > > > >> > _______________________________________________
>> > > > >> > dri-devel mailing list
>> > > > >> > dri-devel@lists.freedesktop.org
>> > > > >> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> > > > >>
>> > > > >> --
>> > > > >> Daniel Vetter
>> > > > >> Software Engineer, Intel Corporation
>> > > > >> http://blog.ffwll.ch
>> > > > >> _______________________________________________
>> > > > >> dri-devel mailing list
>> > > > >> dri-devel@lists.freedesktop.org
>> > > > >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> > > > > IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
>> > > > > _______________________________________________
>> > > > > dri-devel mailing list
>> > > > > dri-devel@lists.freedesktop.org
>> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> > > >
>> > > >
>> > > >
>> > > > --
>> > > > Daniel Vetter
>> > > > Software Engineer, Intel Corporation
>> > > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>> >
>> > --
>> > Daniel Vetter
>> > Software Engineer, Intel Corporation
>> > http://blog.ffwll.ch
>
>-- 
>Daniel Vetter
>Software Engineer, Intel Corporation
>http://blog.ffwll.ch
