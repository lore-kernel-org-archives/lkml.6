Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbeDYLtk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:49:40 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36921 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeDYLtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:49:36 -0400
X-Google-Smtp-Source: AB8JxZoWnJaLuO7r7wFa/F27uytg+YtKNVN7foLkiR1/LTg0IO+yA8vLPtpycaEvWT5S5ZWzsTRvQDCv4Ua+EEqn0lM=
MIME-Version: 1.0
X-Originating-IP: [2a02:168:5635:0:39d2:f87e:2033:9f6]
In-Reply-To: <20180425112604.GP14661@e110455-lin.cambridge.arm.com>
References: <1524593567-5559-1-git-send-email-ayan.halder@arm.com>
 <1524593567-5559-6-git-send-email-ayan.halder@arm.com> <20180425071722.GN25142@phenom.ffwll.local>
 <20180425112604.GP14661@e110455-lin.cambridge.arm.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 25 Apr 2018 13:49:35 +0200
X-Google-Sender-Auth: hx09kToJVVKKk3Iz45I-C6E4S28
Message-ID: <CAKMK7uGeptRT+oeTQQQ4U6LgAVQg2SOofTrqDo9MfFwRkKhj4A@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] drm/arm/malidp: Added the late system pm functions
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Ayan Kumar Halder <ayan.halder@arm.com>,
        Brian Starkey <brian.starkey@arm.com>, Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3PBniCD027433

On Wed, Apr 25, 2018 at 1:26 PM, Liviu Dudau <liviu.dudau@arm.com> wrote:
> On Wed, Apr 25, 2018 at 09:17:22AM +0200, Daniel Vetter wrote:
>> On Tue, Apr 24, 2018 at 07:12:47PM +0100, Ayan Kumar Halder wrote:
>> > malidp_pm_suspend_late checks if the runtime status is not suspended
>> > and if so, invokes malidp_runtime_pm_suspend which disables the
>> > display engine/core interrupts and the clocks. It sets the runtime status
>> > as suspended.
>> >
>> > The difference between suspend() and suspend_late() is as follows:-
>> > 1. suspend() makes the device quiescent. In our case, we invoke the DRM
>> > helper which disables the CRTC. This would have invoked runtime pm
>> > suspend but the system suspend process disables runtime pm.
>> > 2. suspend_late() It continues the suspend operations of the drm device
>> > which was started by suspend(). In our case, it performs the same functionality
>> > as runtime_suspend().
>> >
>> > The complimentary functions are resume() and resume_early(). In the case of
>> > resume_early(), we invoke malidp_runtime_pm_resume() which enables the clocks
>> > and the interrupts. It sets the runtime status as active. If the device was
>> > in runtime suspend mode before system suspend was called, pm_runtime_work()
>> > will put the device back in runtime suspended mode( after the complete system
>> > has been resumed).
>> >
>> > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
>> >
>>
>> Afaiui we still haven't bottomed out on the discussion on v1. Did you get
>> hold of Rafael?
>
> No, there was no reply from him. Lets try again:
>
> Rafael, we are debating on what the proper approach is for handling the
> suspend/resume callbacks for a DRM driver that is likely to not be
> runtime suspended when the power-down happens (because we are driving
> the display output). We are using in this patch the LATE_SYSTEM_SLEEP_PM_OPS
> in order to do the work that we also do during runtime suspend, which is
> turning off the output and the clocks driving it. The reason for doing
> that is because the PM core takes a runtime reference during system
> suspend for all devices that are not already runtime suspended, so our
> runtime_pm_suspend() hook is never called.
>
> Daniel's argument is that we should not be doing this from LATE hooks,
> but from the normal suspend hooks, however kernel doc seems to suggest
> otherwise.

For more context: I thought the reason behind the recommendation to
stuff the rpm callbacks into the late/early hooks was to solve
cross-device ordering issues. That way everyone shuts down the device
functionality in the normal hooks, but only powers them off in the
late hook (to allow other drivers to keep using the clock/i2c
master/whatever). But we now have device_link to solve that since a
while, so I'm not sure the recommendation to stuff the rpm hooks into
late/early callbacks is still correct.
-Daniel

>
> Best regards,
> Liviu
>
>
>
>> -Daniel
>>
>> > ---
>> > Changes in v3:-
>> > - Rebased on top of earlier v3 patches,
>> >
>> > Changes in v2:-
>> > - Removed the change id and modified the commit message
>> > ---
>> >  drivers/gpu/drm/arm/malidp_drv.c | 17 +++++++++++++++++
>> >  1 file changed, 17 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
>> > index 82221ea..c53b46a 100644
>> > --- a/drivers/gpu/drm/arm/malidp_drv.c
>> > +++ b/drivers/gpu/drm/arm/malidp_drv.c
>> > @@ -768,8 +768,25 @@ static int __maybe_unused malidp_pm_resume(struct device *dev)
>> >     return 0;
>> >  }
>> >
>> > +static int __maybe_unused malidp_pm_suspend_late(struct device *dev)
>> > +{
>> > +   if (!pm_runtime_status_suspended(dev)) {
>> > +           malidp_runtime_pm_suspend(dev);
>> > +           pm_runtime_set_suspended(dev);
>> > +   }
>> > +   return 0;
>> > +}
>> > +
>> > +static int __maybe_unused malidp_pm_resume_early(struct device *dev)
>> > +{
>> > +   malidp_runtime_pm_resume(dev);
>> > +   pm_runtime_set_active(dev);
>> > +   return 0;
>> > +}
>> > +
>> >  static const struct dev_pm_ops malidp_pm_ops = {
>> >     SET_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend, malidp_pm_resume) \
>> > +   SET_LATE_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend_late, malidp_pm_resume_early) \
>> >     SET_RUNTIME_PM_OPS(malidp_runtime_pm_suspend, malidp_runtime_pm_resume, NULL)
>> >  };
>> >
>> > --
>> > 2.7.4
>> >
>> > _______________________________________________
>> > dri-devel mailing list
>> > dri-devel@lists.freedesktop.org
>> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch
>
> --
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
