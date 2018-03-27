Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeC0LJj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:09:39 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42132 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeC0LJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:09:38 -0400
X-Google-Smtp-Source: AG47ELucup3v7bbnHc4E6KZl/4MCaNyVho+HR8urYW10tK9J8aRb1ztDZta3QwAMtdgLjyv369n1UU7NVC+kRVrsWkc=
MIME-Version: 1.0
X-Originating-IP: [212.51.149.109]
In-Reply-To: <20180327095907.GA18146@arm.com>
References: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
 <1522083800-30100-9-git-send-email-ayan.halder@arm.com> <20180327082903.GS14155@phenom.ffwll.local>
 <20180327095907.GA18146@arm.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 27 Mar 2018 13:09:36 +0200
X-Google-Sender-Auth: AjIlq8idPFcPnHcfIqp-9r1u43E
Message-ID: <CAKMK7uF8mmLOBQtwfQgkdpPHfoy7yM9UApWgc9YiEudoP5WEyw@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/arm/malidp: Added the late system pm functions
To: Ayan Halder <ayan.halder@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2RB9igj002620

On Tue, Mar 27, 2018 at 11:59 AM, Ayan Halder <ayan.halder@arm.com> wrote:
> On Tue, Mar 27, 2018 at 10:29:03AM +0200, Daniel Vetter wrote:
>> On Mon, Mar 26, 2018 at 06:03:20PM +0100, Ayan Kumar Halder wrote:
>> > malidp_pm_suspend_late checks if the runtime status is not suspended
>> > and if so, invokes malidp_runtime_pm_suspend which disables the
>> > display engine/core interrupts and the clocks. It sets the runtime status
>> > as suspended. Subsequently, malidp_pm_resume_early will invoke
>> > malidp_runtime_pm_resume which enables the clocks and the interrupts
>> > (previously disabled) and sets the runtime status as active.
>> >
>> > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
>> > Change-Id: I5f8c3d28f076314a1c9da2a46760a9c37039ccda
>>
>> Why exactly do you need late/early hooks? If you have dependencies with
>> other devices, pls consider adding device_links instead. This here
>> shouldn't be necessary.
>> -Daniel
> We need to late/early hooks to disable malidp interrupts and the
> clocks.

Yes, but why this ordering constraint? Why can't you just disable the
interrupts/clocks in the normal suspend code. I see that the patch
does this, I want to understand why it does it.
-Daniel

>> > ---
>> >  drivers/gpu/drm/arm/malidp_drv.c | 17 +++++++++++++++++
>> >  1 file changed, 17 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
>> > index bd44a6d..f6124d8 100644
>> > --- a/drivers/gpu/drm/arm/malidp_drv.c
>> > +++ b/drivers/gpu/drm/arm/malidp_drv.c
>> > @@ -766,8 +766,25 @@ static int __maybe_unused malidp_pm_resume(struct device *dev)
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
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
