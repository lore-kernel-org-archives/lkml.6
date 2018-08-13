Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1DFC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261F021759
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WUmI6lVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261F021759
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeHMKK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:10:27 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41395 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeHMKK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:10:27 -0400
Received: by mail-yw1-f66.google.com with SMTP id q129-v6so12901244ywg.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 00:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2krMhqTcFq6TjNIAKJyqgw/osdM2acvusCJDIlZzLiA=;
        b=WUmI6lVzBeU04zbhSVGAr9IJrECpc6caPnAzeImjProq9qeEhKJK2SeGtYA2S1VLAx
         Um5DxUhM+rdpRtz4R/LUrlLL9JszlhuijHxoJSWy18POSwjgENutpBtY5f4KCEUNzz0O
         KMQfAidJSnhnlWnD8WXW5j7JBvFzGQcwejyQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2krMhqTcFq6TjNIAKJyqgw/osdM2acvusCJDIlZzLiA=;
        b=RRXK1LmNO7J7IvgadkksW59qE5uNIE64q3QvL7Rk1egaJbGLznOfOucelOyV4b9MFt
         lCtnM41/ZBeUtrt+mEjyCrX/MgwAa8ItSaGENC0k1UKd3pjsDIQhQKasTREU1croA4cr
         RueOJcsgcCAukGHXgkTQk4hvrsp0T6w5Sj+PvPexLTmU1FQgdstL4T890TWyb4jlmcWP
         7UdRiTPjo/GtU2chS84+rBTcpcSWT1XClYeMJ8UgLEKPT/eKd5efsiDBlHXm0AwuozK+
         AVOArGD044gQVE6Kdo3nZZn1auuPM1lvNNX5Pq1z398JpD2A7LHOMsBO5YPyhxcAUKcI
         Zvew==
X-Gm-Message-State: AOUpUlFVXRzVW21mhosutY4RYHVYGGyIbki5TRUsnYZ+7D6NmNG69LDC
        BUQxl2Am4Il837qNiYUoI7LCmD0Tfho=
X-Google-Smtp-Source: AA+uWPzz6Pan3O04rY6dZ4IaSoKBCB1jDkZnte0+PvNyhoUIEtdyb86mznpgsXvt7AQxoY8v6cZfQw==
X-Received: by 2002:a81:c60c:: with SMTP id l12-v6mr8471830ywi.169.1534145365391;
        Mon, 13 Aug 2018 00:29:25 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id t4-v6sm8022329ywg.98.2018.08.13.00.29.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 00:29:24 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id s68-v6so12907706ywg.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 00:29:24 -0700 (PDT)
X-Received: by 2002:a0d:dcc3:: with SMTP id f186-v6mr8417000ywe.66.1534145363804;
 Mon, 13 Aug 2018 00:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180806155339.9473-1-enric.balletbo@collabora.com>
 <CAAFQd5CGhkfTRzSdTqtFh4zuQuFH0H5SVyKWtk98Ceh_izo4=A@mail.gmail.com> <1889320.MtRaPYoaVN@phil>
In-Reply-To: <1889320.MtRaPYoaVN@phil>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 13 Aug 2018 16:29:12 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B-TN7G_UBXMEExnFQT0RtSRMxF5baV98Bj8mdzMVBLvg@mail.gmail.com>
Message-ID: <CAAFQd5B-TN7G_UBXMEExnFQT0RtSRMxF5baV98Bj8mdzMVBLvg@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: update cursors asynchronously through atomic.
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
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
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 4:26 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Montag, 13. August 2018, 09:11:07 CEST schrieb Tomasz Figa:
> > Hi Enric,
> >
> > On Tue, Aug 7, 2018 at 12:53 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> > >
> > > Add support to async updates of cursors by using the new atomic
> > > interface for that.
> > >
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > ---
> > > Hi,
> > >
> > > This first version is slightly different from the RFC, note that I did
> > > not maintain the Sean reviewed tag for that reason. With this version I
> > > don't touch the atomic_update function and all is implemented in the
> > > async_check/update functions. See the changelog for a list of changes.
> > >
> > > The patch was tested on a Samsung Chromebook Plus in two ways.
> > >
> > >  1. Running all igt kms_cursor_legacy and kms_atomic@plane_cursor_legacy
> > >     tests and see that there is no regression after the patch.
> > >
> > >  2. Running weston using the atomic API.
> >
> > Thanks for the patch. This feature might look like a really minor
> > thing, but we really had hard time dealing with users complaints, so
> > having this in upstream would be a really useful thing.
> >
> > Let me post some comments inline.
> >
> > >
> > > Best regards,
> > >   Enric
> > >
> > > Changes in v1:
> > > - Rebased on top of drm-misc
> > > - In async_check call drm_atomic_helper_check_plane_state to check that
> > >   the desired plane is valid and update various bits of derived state
> > >   (clipped coordinates etc.)
> > > - In async_check allow to configure new scaling in the fast path.
> > > - In async_update force to flush all registered PSR encoders.
> > > - In async_update call atomic_update directly.
> > > - In async_update call vop_cfg_done needed to set the vop registers and take effect.
> > >
> > >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 53 +++++++++++++++++++++
> > >  1 file changed, 53 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > index e9f91278137d..dab70056ee73 100644
> > > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > @@ -811,10 +811,63 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
> > >         spin_unlock(&vop->reg_lock);
> > >  }
> > >
> > > +static int vop_plane_atomic_async_check(struct drm_plane *plane,
> > > +                                       struct drm_plane_state *state)
> > > +{
> > > +       struct vop_win *vop_win = to_vop_win(plane);
> > > +       const struct vop_win_data *win = vop_win->data;
> > > +       int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
> > > +                                       DRM_PLANE_HELPER_NO_SCALING;
> > > +       int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
> > > +                                       DRM_PLANE_HELPER_NO_SCALING;
> > > +       int ret;
> > > +
> > > +       if (plane != state->crtc->cursor)
> > > +               return -EINVAL;
> > > +
> > > +       if (!plane->state)
> > > +               return -EINVAL;
> > > +
> > > +       if (!plane->state->fb ||
> > > +           plane->state->fb != state->fb)
> > > +               return -EINVAL;
> >
> > While it covers for quite a big part of cursor movements, you may
> > still expect jumpy cursor when hoovering text boxes or hyperlinks,
> > since it changes the cursor image. Our downstream patch [1] actually
> > took care of changing the framebuffer as well, although with the added
> > complexity of referencing the old buffer at update time and releasing
> > it in a flip work.
> >
> > [1] https://chromium.git.corp.google.com/chromiumos/third_party/kernel/+/1ad887e1a1349991c9e137b48cb32086e65347fc%5E%21/
>
> [1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/394492
> for non-google people ;-)
>

Thanks, not sure how that internal link sneaked into my clipboard.
Should have checked what I pasted. :P

Best regards,
Tomasz
