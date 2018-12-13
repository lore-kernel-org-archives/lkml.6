Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA03C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9196C20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HLQlbIxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9196C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeLMECh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:02:37 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37832 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLMECg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:02:36 -0500
Received: by mail-yw1-f66.google.com with SMTP id h193so287518ywc.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 20:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Phc0JDWTP+BlXzj3Kszh71bBZ7MYZQCNOMeVRfWBcWI=;
        b=HLQlbIxOHqCb9ncAIbI9gdEpWTm4yvbvDJgkdqIv05dSNlf1oEsSClYmpjuiIEyVl7
         6Z4gz8wDNiIG1caWRDF/qEgsHRbnCSzCNKs+M5oIFQNAg4KJYD7Vn9+rmijQdRWQ6/VZ
         3fPWVRO7ENMhWEBQVJ99MnvOsV25NL4QDu53w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Phc0JDWTP+BlXzj3Kszh71bBZ7MYZQCNOMeVRfWBcWI=;
        b=CJkgJkYy+fNlWBn7w1qxIuUnmWjSnHPYHiwOKHh8kZChgt0BWh7SQNTK0x0Ad3WVRX
         w2bYcus8Vw/MNePILkQeunmCr/ovtMRjln2SuZ8vZ6Jv7ey09bOR3VpMk7F652nSUl0w
         vL4+3gg5WHcBxogVKnZjycgBciTnBdvkwHzmhpxwJcTpIi0ekZSnx9LEbKNrgzEjvwRu
         yw7SibD4f4pxUcMnmyMxn5eZXsKhh2h4p8Vb6KXbsmKQWorEpMRvixnhUc527Ogo2s9+
         MFsuh9+ncXucleSXDC11MoxPa/bBJIO7mcTenqw1n0Bl9W7e40VXsD/myEjUcx49CUfv
         X7kw==
X-Gm-Message-State: AA+aEWaoLuzoKiaxcTjCe28Qv7hJLqqDmtqahfbVeKSYJSbiKqIfKyrc
        St0sK+YU6MuEbNTVh1iJGhPJhZaIyQ5L9Q==
X-Google-Smtp-Source: AFSGD/UUYtmZGv0GSlfQakZ/m1jqiXnTrah3wpoT1Dg83iQzpg0PofKNH/7JI0VkcwtJ4ZGuAl161g==
X-Received: by 2002:a81:8806:: with SMTP id y6mr23790315ywf.140.1544673755097;
        Wed, 12 Dec 2018 20:02:35 -0800 (PST)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id w2sm576268ywl.10.2018.12.12.20.02.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 20:02:33 -0800 (PST)
Received: by mail-yw1-f46.google.com with SMTP id i22so271417ywa.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 20:02:32 -0800 (PST)
X-Received: by 2002:a0d:e0c5:: with SMTP id j188mr24396784ywe.164.1544673751936;
 Wed, 12 Dec 2018 20:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20181123215326.14274-1-helen.koike@collabora.com>
 <20181127133418.GT9144@intel.com> <6aa39654-6949-88b3-b949-b338d915ffd2@collabora.com>
In-Reply-To: <6aa39654-6949-88b3-b949-b338d915ffd2@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 13 Dec 2018 13:02:20 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BczTNdwUNcx42hC=OKkgZTV9JevHetYOjfDCnEz29LpA@mail.gmail.com>
Message-ID: <CAAFQd5BczTNdwUNcx42hC=OKkgZTV9JevHetYOjfDCnEz29LpA@mail.gmail.com>
Subject: Re: [PATCH] drm: add capability DRM_CAP_ASYNC_UPDATE
To:     helen.koike@collabora.com
Cc:     ville.syrjala@linux.intel.com, David Airlie <airlied@linux.ie>,
        dnicoara@chromium.org,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        Alexandros Frantzis <alexandros.frantzis@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 1:12 AM Helen Koike <helen.koike@collabora.com> wrot=
e:
>
> Hi Ville
>
> On 11/27/18 11:34 AM, Ville Syrj=C3=A4l=C3=A4 wrote:
> > On Fri, Nov 23, 2018 at 07:53:26PM -0200, Helen Koike wrote:
> >> Allow userspace to identify if the driver supports async update.
> >
> > And what exactly is an "async update"?
>
> I agree we are lacking docs on this, I'll send in the next version as
> soon as we agree on a name (please see below).
>
> For reference:
> https://lists.freedesktop.org/archives/dri-devel/2017-April/138586.html
>
> >
> > I keep asking people to come up with the a better name for this, and to
> > document what it actually means. Recently I've been think we should
> > maybe just adopt the vulkan terminology (immediate/fifo/mailbox) to
> > avoid introducing yet another set of names for the same thing. We'd
> > still want to document things properly though.
>
> Another name it was suggested was "atomic amend", this feature basically
> allows userspace to complement an update previously sent (i.e. its in
> the queue and wasn't commited yet), it allows adding a plane update to
> the next commit. So what do you think in renaming it to "atomic amend"?

Note that it doesn't seem to be what the code currently is doing. For
example, for cursor updates, it doesn't seem to be working on the
currently pending commit, but just directly issues an atomic async
update call to the planes. The code actually seems to fall back to a
normal sync commit, if there is an already pending commit touching the
same plane or including a modeset.

Best regards,
Tomasz

> Or do you suggest another name? I am not familiar with vulkan terminology=
.
>
>
> Thanks
> Helen
>
> >
> >>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> [prepared for upstream]
> >> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> >>
> >> ---
> >> Hi,
> >>
> >> This patch introduces the ASYNC_UPDATE cap, which originated from the
> >> discussion regarding DRM_MODE_ATOMIC_AMEND on [1], to allow user to
> >> figure that async_update exists.
> >>
> >> This was tested using a small program that exercises the uAPI for easy
> >> sanity testing. The program was created by Alexandros and modified by
> >> Enric to test the capability flag [2].
> >>
> >> The test worked on a rockchip Ficus v1.1 board on top of mainline plus
> >> the patch to update cursors asynchronously through atomic plus the pat=
ch
> >> that introduces the ATOMIC_AMEND flag for the drm/rockchip driver.
> >>
> >> To test, just build the program and use the --atomic flag to use the c=
ursor
> >> plane with the ATOMIC_AMEND flag. E.g.
> >>
> >>   drm_cursor --atomic
> >>
> >> [1] https://patchwork.freedesktop.org/patch/243088/
> >> [2] https://gitlab.collabora.com/eballetbo/drm-cursor/commits/async-ca=
pability
> >>
> >> Thanks
> >> Helen
> >>
> >>
> >>  drivers/gpu/drm/drm_ioctl.c | 11 +++++++++++
> >>  include/uapi/drm/drm.h      |  1 +
> >>  2 files changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> >> index 94bd872d56c4..4a7e0f874171 100644
> >> --- a/drivers/gpu/drm/drm_ioctl.c
> >> +++ b/drivers/gpu/drm/drm_ioctl.c
> >> @@ -31,6 +31,7 @@
> >>  #include <drm/drm_ioctl.h>
> >>  #include <drm/drmP.h>
> >>  #include <drm/drm_auth.h>
> >> +#include <drm/drm_modeset_helper_vtables.h>
> >>  #include "drm_legacy.h"
> >>  #include "drm_internal.h"
> >>  #include "drm_crtc_internal.h"
> >> @@ -229,6 +230,7 @@ static int drm_getcap(struct drm_device *dev, void=
 *data, struct drm_file *file_
> >>  {
> >>      struct drm_get_cap *req =3D data;
> >>      struct drm_crtc *crtc;
> >> +    struct drm_plane *plane;
> >>
> >>      req->value =3D 0;
> >>
> >> @@ -292,6 +294,15 @@ static int drm_getcap(struct drm_device *dev, voi=
d *data, struct drm_file *file_
> >>      case DRM_CAP_CRTC_IN_VBLANK_EVENT:
> >>              req->value =3D 1;
> >>              break;
> >> +    case DRM_CAP_ASYNC_UPDATE:
> >> +            req->value =3D 1;
> >> +            list_for_each_entry(plane, &dev->mode_config.plane_list, =
head) {
> >> +                    if (!plane->helper_private->atomic_async_update) =
{
> >> +                            req->value =3D 0;
> >> +                            break;
> >> +                    }
> >> +            }
> >> +            break;
> >>      default:
> >>              return -EINVAL;
> >>      }
> >> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> >> index 300f336633f2..ff01540cbb1d 100644
> >> --- a/include/uapi/drm/drm.h
> >> +++ b/include/uapi/drm/drm.h
> >> @@ -649,6 +649,7 @@ struct drm_gem_open {
> >>  #define DRM_CAP_PAGE_FLIP_TARGET    0x11
> >>  #define DRM_CAP_CRTC_IN_VBLANK_EVENT        0x12
> >>  #define DRM_CAP_SYNCOBJ             0x13
> >> +#define DRM_CAP_ASYNC_UPDATE                0x14
> >>
> >>  /** DRM_IOCTL_GET_CAP ioctl argument type */
> >>  struct drm_get_cap {
> >> --
> >> 2.19.1
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
