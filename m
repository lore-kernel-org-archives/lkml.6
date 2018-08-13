Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E4DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427B321837
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427B321837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeHMKHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:07:15 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39644 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbeHMKHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:07:15 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fp7Ew-0000ot-0p; Mon, 13 Aug 2018 09:26:10 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>
Subject: Re: [PATCH] drm/rockchip: update cursors asynchronously through atomic.
Date:   Mon, 13 Aug 2018 09:26:08 +0200
Message-ID: <1889320.MtRaPYoaVN@phil>
In-Reply-To: <CAAFQd5CGhkfTRzSdTqtFh4zuQuFH0H5SVyKWtk98Ceh_izo4=A@mail.gmail.com>
References: <20180806155339.9473-1-enric.balletbo@collabora.com> <CAAFQd5CGhkfTRzSdTqtFh4zuQuFH0H5SVyKWtk98Ceh_izo4=A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 13. August 2018, 09:11:07 CEST schrieb Tomasz Figa:
> Hi Enric,
> 
> On Tue, Aug 7, 2018 at 12:53 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > Add support to async updates of cursors by using the new atomic
> > interface for that.
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> > Hi,
> >
> > This first version is slightly different from the RFC, note that I did
> > not maintain the Sean reviewed tag for that reason. With this version I
> > don't touch the atomic_update function and all is implemented in the
> > async_check/update functions. See the changelog for a list of changes.
> >
> > The patch was tested on a Samsung Chromebook Plus in two ways.
> >
> >  1. Running all igt kms_cursor_legacy and kms_atomic@plane_cursor_legacy
> >     tests and see that there is no regression after the patch.
> >
> >  2. Running weston using the atomic API.
> 
> Thanks for the patch. This feature might look like a really minor
> thing, but we really had hard time dealing with users complaints, so
> having this in upstream would be a really useful thing.
> 
> Let me post some comments inline.
> 
> >
> > Best regards,
> >   Enric
> >
> > Changes in v1:
> > - Rebased on top of drm-misc
> > - In async_check call drm_atomic_helper_check_plane_state to check that
> >   the desired plane is valid and update various bits of derived state
> >   (clipped coordinates etc.)
> > - In async_check allow to configure new scaling in the fast path.
> > - In async_update force to flush all registered PSR encoders.
> > - In async_update call atomic_update directly.
> > - In async_update call vop_cfg_done needed to set the vop registers and take effect.
> >
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 53 +++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > index e9f91278137d..dab70056ee73 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > @@ -811,10 +811,63 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
> >         spin_unlock(&vop->reg_lock);
> >  }
> >
> > +static int vop_plane_atomic_async_check(struct drm_plane *plane,
> > +                                       struct drm_plane_state *state)
> > +{
> > +       struct vop_win *vop_win = to_vop_win(plane);
> > +       const struct vop_win_data *win = vop_win->data;
> > +       int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
> > +                                       DRM_PLANE_HELPER_NO_SCALING;
> > +       int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
> > +                                       DRM_PLANE_HELPER_NO_SCALING;
> > +       int ret;
> > +
> > +       if (plane != state->crtc->cursor)
> > +               return -EINVAL;
> > +
> > +       if (!plane->state)
> > +               return -EINVAL;
> > +
> > +       if (!plane->state->fb ||
> > +           plane->state->fb != state->fb)
> > +               return -EINVAL;
> 
> While it covers for quite a big part of cursor movements, you may
> still expect jumpy cursor when hoovering text boxes or hyperlinks,
> since it changes the cursor image. Our downstream patch [1] actually
> took care of changing the framebuffer as well, although with the added
> complexity of referencing the old buffer at update time and releasing
> it in a flip work.
> 
> [1] https://chromium.git.corp.google.com/chromiumos/third_party/kernel/+/1ad887e1a1349991c9e137b48cb32086e65347fc%5E%21/

[1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/394492
for non-google people ;-)


Heiko

> > +
> > +       ret = drm_atomic_helper_check_plane_state(plane->state,
> > +                                                 plane->crtc->state,
> > +                                                 min_scale, max_scale,
> > +                                                 true, true);
> > +       return ret;
> > +}
> > +
> > +static void vop_plane_atomic_async_update(struct drm_plane *plane,
> > +                                         struct drm_plane_state *new_state)
> > +{
> > +       struct vop *vop = to_vop(plane->state->crtc);
> > +
> > +       plane->state->crtc_x = new_state->crtc_x;
> > +       plane->state->crtc_y = new_state->crtc_y;
> > +       plane->state->crtc_h = new_state->crtc_h;
> > +       plane->state->crtc_w = new_state->crtc_w;
> > +       plane->state->src_x = new_state->src_x;
> > +       plane->state->src_y = new_state->src_y;
> > +       plane->state->src_h = new_state->src_h;
> > +       plane->state->src_w = new_state->src_w;
> > +
> > +       if (vop->is_enabled) {
> > +               rockchip_drm_psr_flush_all(plane->dev);
> 
> We should use the inhibit mechanism when accessing VOP hardware. While
> the flush is expected to keep the PSR disabled for at least 100 ms,
> we're not in any atomic (pun not intended) context here and might get
> preempted for some unspecified time in very high load conditions.
> 
> Best regards,
> Tomasz
> 




