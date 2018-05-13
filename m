Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeEMOMW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:12:22 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:42348 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbeEMOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:12:20 -0400
X-Google-Smtp-Source: AB8JxZo8xv/zeBC3qcI3B6NtC4zL0w9RKlKUKmA8PVEEE5Xtgsucz1fxLubiECKWmF7oYHwdIK8wulE6ADeq2jQ5ni4=
MIME-Version: 1.0
X-Originating-IP: [2a02:168:5635:0:39d2:f87e:2033:9f6]
In-Reply-To: <1525866725-16685-1-git-send-email-satendra.t@samsung.com>
References: <CGME20180509115224epcas5p1c958418bc36fd224e8d36b9511c5beea@epcas5p1.samsung.com>
 <1525777110-11378-1-git-send-email-satendra.t@samsung.com> <1525866725-16685-1-git-send-email-satendra.t@samsung.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Sun, 13 May 2018 16:12:18 +0200
X-Google-Sender-Auth: JeJb8B8F7bLfUx-CBlAdaxw2Th4
Message-ID: <CAKMK7uGb_psf+H4oWqwpWYg6OT6YV3Gm_CrjEpfzk=WtxH3MjQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] drm/kms/mode: using helper func drm_display_mode_to/from_videomode
 for calculating timing parameters
To: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-mediatek@lists.infradead.org>,
        linux-amlogic@lists.infradead.org, sst2005@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 1:52 PM, Satendra Singh Thakur
<satendra.t@samsung.com> wrote:
> On Thu, May 08, 2018 at 16:28:30 +0530, Satendra Singh Thakur wrote:
>> On Thu, May 07, 2018 at 15:46:02 +0200, Daniel Vetter wrote:
>> > On Thu, May 03, 2018 at 01:53:55PM +0530, Satendra Singh Thakur wrote:
>> > > 1.There is a function in drm-core to calculate display timing parameters:
>> > > horizontal front porch, back porch, sync length,
>> > > vertical front porch, back porch, sync length and
>> > > clock in Hz.
>> > > However, some drivers are still calculating these parameters themselves.
>> > > Therefore, there is a duplication of the code.
>> > > This patch series replaces this redundant code with the function
>> > > drm_display_mode_to_videomode.
>> > > This removes nearly 100 redundant lines from the related drivers.
>> > > 2.For some drivers (sun4i) the reverse helper
>> > > drm_display_mode_from_videomode is used.
>> > > 3.For some drivers it replaces arithmatic operators (*, /) with shifting
>> > > operators (>>, <<).
>> > > 4.For some drivers DRM_MODE_FLAG_* are replaced with DISPLAY_FLAGS_* flags.
>> > > 5.These changes apply to following crtc and encoder drivers:
>> > > atmel-hlcdc
>> > > bridge-tc358767
>> > > exynos-dsi
>> > > fsl-dcu
>> > > gma500-mdfld_dsi_dpi
>> > > hisilicon-kirin_dsi, ade
>> > > meson-encoder
>> > > pl111-display
>> > > sun4i-tv
>> > > ti lcdc
>> > > tegra dc
>> > > mediatek dpi dsi
>> > > bridge-adv7533
>> >
>> > The drm_mode_to_videomode helper is meant for interop between drm and v4l,
>> > which have different internal structures to represent modes.
>> >
>> > For drivers that only use drm I think the better option would be to add
>> > these fields to struct drm_display_mode as another set of crtc_* values
>> > (the computed values are stored in crtc_ prefixed members). And compute
>> > front/back porch in drm_mode_set_crtcinfo.
>> >
>> > Then we can use these new drm_display_mode->crtc_h|vfront|back_porch
>> > fields in all the drivers you're changing. This way you avoid having to
>> > change all the drm drivers to use v4l #defines.
>> >
>> > Thanks,
>> > Daniel
>>
>> Hi Daniel,
>> Thanks for the comments.
>> I will look into it.
>>
>> Thanks
>> -Satendra
>
> Hi Daniel,
> Thanks for the comments.
> Please find below my understanding in this direction.
>
> 1. Currently struct videomode is being used in 50 drm drivers and 14 fbdev drivers.
>    Since, it's already being used by so many drm drivers, that is the reason
>    these fbdev objects (struct videmode and func drm_display_mode_to_videomode) were used in this patch series.

The biggest contributor for that seems to be of_get_videomode. We
should probably have a of_drm_get_display_mode helper, which
automatically converts the of/dt video description into the drm
display mode structure.

And I found way less than 50 drm drivers using videomode, much less if
we ignore of.

> 2. Anyway, if fbdev related objects (struct/func) are not encouraged in drm drivers, then we may add
>    h/v front/back porches in struct drm_display_mode as adviced by you.
>
> 3. We can calculate these params in func drm_mode_set_crtcinfo at the end of it.
>    int drm_mode_set_crtcinfo ()
>    {
>    .
>    .
>    crtc_hfront_porch = crtc_hsync_start - crtc_hdisplay;
>    crtc_vfront_porch = crtc_vsync_start - crtc_vdisplay;
>    .
>    .
>    crtc_clock_hz = crtc_clock*1000;
>    };
>
> 4. Normally mode is programmed in HW in following callbacks of crtc and encoder drivers
>    -mode_set
>    -mode_set_nofb
>    -atomic_enable
>
>
>    Normally drm_mode_set_crtcinfo is used in
>    -mode_fixup callbacks (CBs)
>    of encoder and crtc drivers.
>
>    if mode_fixup CBs are called before mode_set CBs then
>    drm_mode_set_crtcinfo is right place to calculate sync/porch params.
>    We can use crtc_hfront/back_porches directly and program them to HW
>    in above mentioned callbacks.
>
>    int my_mode_set ()
>    {
>         REG_WRITE(crtc_hfront_porch);
>         REG_WRITE(crtc_hback_porch);
>         .
>         .
>    }

Agreed with your plan up to point 5 here.

>  6.  However, if these params are being modified after calling drm_set_crtcinfo as mentioned below:
>
>    bool amdgpu_atombios_encoder_mode_fixup(struct drm_encoder *encoder,
>                                  const struct drm_display_mode *mode,
>                                  struct drm_display_mode *adjusted_mode)
>    {
>         struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
>
>         /* set the active encoder to connector routing */
>         amdgpu_encoder_set_active_device(encoder);
>         ***drm_mode_set_crtcinfo(adjusted_mode, 0);****
>
>         /* hw bug */
>         if ((mode->flags & DRM_MODE_FLAG_INTERLACE)
>             && (mode->crtc_vsync_start < (mode->crtc_vdisplay + 2)))
>                 adjusted_mode->crtc_vsync_start = adjusted_mode->crtc_vdisplay + 2;
>
>   Then we may need to define new func like
>
>   void drm_calc_hv_porches_sync()
>   {
>    crtc_hfront_porch = crtc_hsync_start - crtc_hdisplay;
>    crtc_vfront_porch = crtc_vsync_start - crtc_vdisplay;
>    .
>    .
>    crtc_clock_hz = crtc_clock*1000;
>   }  and call this func in mode_set*, atomic_enable CBS before programming the HW with this mode.
>
>
>   Should I create patches around this idea ?
>   Please let me know your comments.

I'm not sure about point 6. I think we should wait with coming up with
a solution to this problem once there's a clear need for it. Most
likely I think drivers who both need to adjust computed timings and
who need v/hfront/back porch just need to adjust everything on their
own. And we won't provide any additional helpers.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
