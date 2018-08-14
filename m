Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BEBC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E8721733
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QFbM2IPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E8721733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeHNMPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:15:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44261 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbeHNMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:15:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id f23-v6so9736273edr.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 02:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DSxtMXoYByBAZLqI1l2hAO2vyqsPDt9wymvx5A+v7C8=;
        b=QFbM2IPucratlMweI68RPwyfjMStQ3gZgiBYR9/fO8YJtna/CT4aQ+UEQEmvmqFmZG
         wsFqLFsziRMVm5TDqtaH74YxaifVLK1BDwJYKg9s/rPL1yn7l90073rqM3jETZLwhVKh
         pFzSUuu0mZbIciQTMRjBSTyWEccKBg3eGt0nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DSxtMXoYByBAZLqI1l2hAO2vyqsPDt9wymvx5A+v7C8=;
        b=KNT55c86jEdIKd2iCaPOiHCR0cW9SLRf1kTcBqU9Voj7JBr7tT3KiLcXjVIaAAiDAo
         Wx9l+WRxj5KE0LV82HGxRDMdQO6NsY2SFPbr0xvraJ/DYP1F8ZCYg0dH23pvOsEDreTC
         G80EE+vNYkOEWDvEMc9n9VUlf9/GlXmsdOu2uy5AGYsPRacFQrRGpM0cxxC0SpVrzjyu
         Dhix5BmuZhJeVCdSA/n71hd7XClqCT+lPmvOGmfuHaKcgQsLicB/HvWJDecrDruQ7VIp
         EOBDzZasBDfdctTuGc8Dcrg71V4wFrB2JkGCSL6mUO/R3v4absjsplusQ4HO0pqyb34L
         cyLA==
X-Gm-Message-State: AOUpUlFmzL6HOwdKCyKktOYrFs264KH7tpLof/WCJy0vb/0BmE0Gj79Q
        fCLFMeVQnZyJz+E6VExvTQiFUg==
X-Google-Smtp-Source: AA+uWPztI6u/p9jH0kz5zZ7FKIbZRj03kHv1d4Cxt17jEQGZ0uulDAjKHBzjje1igW0OutPVus4QNg==
X-Received: by 2002:a50:b684:: with SMTP id d4-v6mr25914121ede.250.1534238941483;
        Tue, 14 Aug 2018 02:29:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:56fc:0:d707:d7d8:b180:96e5])
        by smtp.gmail.com with ESMTPSA id x13-v6sm30094755edx.17.2018.08.14.02.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 02:29:00 -0700 (PDT)
Date:   Tue, 14 Aug 2018 11:28:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Lowry Li <lowry.li@arm.com>, David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>, nd@arm.com
Subject: Re: [PATCH v3 1/2] drm: Add per-plane pixel blend mode property
Message-ID: <20180814092858.GJ21634@phenom.ffwll.local>
Mail-Followup-To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Lowry Li <lowry.li@arm.com>, David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>, nd@arm.com
References: <1527856871-3007-1-git-send-email-lowry.li@arm.com>
 <1527856871-3007-2-git-send-email-lowry.li@arm.com>
 <CACvgo53z9_DLXDXVgsvX6eVRr+-OXuJYu8_q2kANFTgyWCeacQ@mail.gmail.com>
 <20180605090729.GA2686@lowry.li@arm.com>
 <325674b0-d100-4e38-3963-0e458e6dec80@linux.intel.com>
 <20180814031102.GA8541@lowry.li@arm.com>
 <aab143ec-ee83-4a99-2db8-710b20783ba3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aab143ec-ee83-4a99-2db8-710b20783ba3@linux.intel.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 11:15:43AM +0200, Maarten Lankhorst wrote:
> Op 14-08-18 om 05:11 schreef Lowry Li:
> > On Mon, Aug 13, 2018 at 12:49:13PM +0200, Maarten Lankhorst wrote:
> >> Op 05-06-18 om 11:07 schreef Lowry Li:
> >>> On Mon, Jun 04, 2018 at 02:49:26PM +0100, Emil Velikov wrote:
> >>>> On 1 June 2018 at 13:41, Lowry Li <lowry.li@arm.com> wrote:
> >>>>> Pixel blend modes represent the alpha blending equation
> >>>>> selection, describing how the pixels from the current
> >>>>> plane are composited with the background.
> >>>>>
> >>>>> Add a pixel_blend_mode to drm_plane_state and a
> >>>>> blend_mode_property to drm_plane, and related support
> >>>>> functions.
> >>>>>
> >>>>> Defines three blend modes in drm_blend.h.
> >>>>>
> >>>>> Signed-off-by: Lowry Li <lowry.li@arm.com>
> >>>>> ---
> >>>>>  drivers/gpu/drm/drm_atomic.c        |   4 ++
> >>>>>  drivers/gpu/drm/drm_atomic_helper.c |   1 +
> >>>>>  drivers/gpu/drm/drm_blend.c         | 126 ++++++++++++++++++++++++++++++++++++
> >>>>>  include/drm/drm_blend.h             |   6 ++
> >>>>>  include/drm/drm_plane.h             |   5 ++
> >>>>>  5 files changed, 142 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> >>>>> index 07fef42..1d18389 100644
> >>>>> --- a/drivers/gpu/drm/drm_atomic.c
> >>>>> +++ b/drivers/gpu/drm/drm_atomic.c
> >>>>> @@ -785,6 +785,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
> >>>>>                 state->src_h = val;
> >>>>>         } else if (property == plane->alpha_property) {
> >>>>>                 state->alpha = val;
> >>>>> +       } else if (property == plane->blend_mode_property) {
> >>>>> +               state->pixel_blend_mode = val;
> >>>>>         } else if (property == plane->rotation_property) {
> >>>>>                 if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK))
> >>>>>                         return -EINVAL;
> >>>>> @@ -852,6 +854,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
> >>>>>                 *val = state->src_h;
> >>>>>         } else if (property == plane->alpha_property) {
> >>>>>                 *val = state->alpha;
> >>>>> +       } else if (property == plane->blend_mode_property) {
> >>>>> +               *val = state->pixel_blend_mode;
> >>>>>         } else if (property == plane->rotation_property) {
> >>>>>                 *val = state->rotation;
> >>>>>         } else if (property == plane->zpos_property) {
> >>>>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> >>>>> index 130da51..7f5d463 100644
> >>>>> --- a/drivers/gpu/drm/drm_atomic_helper.c
> >>>>> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> >>>>> @@ -3515,6 +3515,7 @@ void drm_atomic_helper_plane_reset(struct drm_plane *plane)
> >>>>>                 /* Reset the alpha value to fully opaque if it matters */
> >>>>>                 if (plane->alpha_property)
> >>>>>                         plane->state->alpha = plane->alpha_property->values[1];
> >>>>> +               plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
> >>>>>         }
> >>>>>  }
> >>>>>  EXPORT_SYMBOL(drm_atomic_helper_plane_reset);
> >>>>> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> >>>>> index a16a74d..ac6f19c 100644
> >>>>> --- a/drivers/gpu/drm/drm_blend.c
> >>>>> +++ b/drivers/gpu/drm/drm_blend.c
> >>>>> @@ -107,6 +107,52 @@
> >>>>>   *     planes. Without this property the primary plane is always below the cursor
> >>>>>   *     plane, and ordering between all other planes is undefined.
> >>>>>   *
> >>>>> + * pixel blend mode:
> >>>>> + *     Pixel blend mode is set up with drm_plane_create_blend_mode_property().
> >>>>> + *     It adds a blend mode for alpha blending equation selection, describing
> >>>>> + *     how the pixels from the current plane are composited with the
> >>>>> + *     background.
> >>>>> + *
> >>>>> + *      Three alpha blending equations are defined:
> >>>>> + *
> >>>>> + *      "None":
> >>>>> + *              Blend formula that ignores the pixel alpha::
> >>>>> + *
> >>>>> + *                      out.rgb = plane_alpha * fg.rgb +
> >>>>> + *                              (1 - plane_alpha) * bg.rgb
> >>>>> + *
> >>>>> + *      "Pre-multiplied":
> >>>>> + *              Blend formula that assumes the pixel color values
> >>>>> + *              have been already pre-multiplied with the alpha
> >>>>> + *              channel values::
> >>>>> + *
> >>>>> + *                      out.rgb = plane_alpha * fg.rgb +
> >>>>> + *                              (1 - (plane_alpha * fg.alpha)) * bg.rgb
> >>>>> + *
> >>>>> + *      "Coverage":
> >>>>> + *              Blend formula that assumes the pixel color values have not
> >>>>> + *              been pre-multiplied and will do so when blending them to the
> >>>>> + *              background color values::
> >>>>> + *
> >>>>> + *                      out.rgb = plane_alpha * fg.alpha * fg.rgb +
> >>>>> + *                              (1 - (plane_alpha * fg.alpha)) * bg.rgb
> >>>>> + *
> >>>>> + *      Using the following symbols:
> >>>>> + *
> >>>>> + *      ``fg.rgb``:
> >>>>> + *              Each of the RGB component values from the plane's pixel
> >>>>> + *      ``fg.alpha``:
> >>>>> + *              Alpha component value from the plane's pixel. If the plane's
> >>>>> + *              pixel format has no alpha component, then this is assumed to be
> >>>>> + *              1.0. In these cases, this property has no effect, as all three
> >>>>> + *              equations become equivalent.
> >>>>> + *      ``bg.rgb``:
> >>>>> + *              Each of the RGB component values from the background
> >>>>> + *      ``plane_alpha``:
> >>>>> + *              Plane alpha value set by the plane "alpha" property. If the
> >>>>> + *              plane does not expose the "alpha" property, then this is
> >>>>> + *              assumed to be 1.0
> >>>>> + *
> >>>>>   * Note that all the property extensions described here apply either to the
> >>>>>   * plane or the CRTC (e.g. for the background color, which currently is not
> >>>>>   * exposed and assumed to be black).
> >>>>> @@ -448,3 +494,83 @@ int drm_atomic_normalize_zpos(struct drm_device *dev,
> >>>>>         return 0;
> >>>>>  }
> >>>>>  EXPORT_SYMBOL(drm_atomic_normalize_zpos);
> >>>>> +
> >>>>> +/**
> >>>>> + * drm_plane_create_blend_mode_property - create a new blend mode property
> >>>>> + * @plane: drm plane
> >>>>> + * @supported_modes: bitmask of supported modes, must include
> >>>>> + *                  BIT(DRM_MODE_BLEND_PREMULTI). Current DRM assumption is
> >>>>> + *                  that alpha is premultiplied, and old userspace can break if
> >>>>> + *                  the property defaults to coverage.
> >>>>> + *
> >>>> Thanks for the explanation Lowry.
> >>>> Sigh, old userspace :-\
> >>>>
> >>>> One pedantic suggestion s/defaults to coverage/defaults to anything else/
> >>>> Since defaulting to "none" or any future blend mode is also a no-go.
> >>>>
> >>>> I wouldn't bother resending solely for ^^. Perhaps squash locally
> >>>> before merging?
> >>>>
> >>>> With that, the patch is
> >>>> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
> >>>>
> >>>> -Emil
> >>> Hi Emil,
> >>>
> >>> Thanks a lot for your review and will change that.
> >> Ping? Any updates?
> >>
> >> ~Maarten
> > Hi Maarten,
> >
> > So far the merge request on user space patch has been verified by John
> > Stultz. The comments from Sean has been fixed and now we are waiting the
> > reviewed-tag from Sean. Once it merged, we'll send a new kernel patch to
> > review.
> >
> Hey,
> 
> In general the kernel patch should be merged first, because userspace cannot rely on the behavior until the next -rc1 that integrates it.
> However, in order to merge the kernel patch, a userspace proof of concept for validation is needed first. Since you're close to merging,
> I would say the userspace requirement is satisfied. It's safe to send the kernel patch. :)

Quick correction: Generally merged into -next is considered good enough.
-Daniel

> 
> ~Maarten
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
