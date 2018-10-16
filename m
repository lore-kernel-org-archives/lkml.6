Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BF7C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC21B20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VGJhV/kf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC21B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJPPdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:33:37 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41193 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJPPdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:33:36 -0400
Received: by mail-yb1-f194.google.com with SMTP id e16-v6so8525950ybk.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 00:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymvPUWAaP70b6eKfX2ExW8rgkKpUUtZAaP1Q67EFVRo=;
        b=VGJhV/kf12D/kpvInLaA0+MrqPPHeE7A3hTzUts0vR3zihFAGuJEtKt+mCGNXRgfCU
         xUFih1xkaoHGo6q8ADoV9HKfdTfiwviRpU3JUfJPymwVVJK+D+yXOIpHxkIu2niFjRs4
         o7hMf/1s9TNM0T2pB/YhuVjogxg3dtb7a2Vzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymvPUWAaP70b6eKfX2ExW8rgkKpUUtZAaP1Q67EFVRo=;
        b=KdMuZRGdfzqnz1iykmn3peODY9yA4a7ukMfvOWwZuPWlvgRK6ZE1/bJme8omwIZwBH
         WC8FXaxiTg8pWK1VADYKth/gv2Nq+KhbT+MCIy9b0zkH0d0yDEmL/J0XH6ifXUS4/FYq
         PN8Am37tnMKtMWqP0cnzadVr4ubTRWVXyRp5mxtxaHcqk/7SzcA2BTlJA0ABGl+m6UgY
         Jc7ryIGd/yDQZiKq8L9TT5Kq7YuwDic79e9C8jDMkEDYd/aEfvwfpdR5JunWO5VPMhuH
         VG/Cttux86rgjFEeUB/PSunH0zIsaWzje67hu8Z/Il9gapf81tpQzozpAsmy5XPl8KWT
         E6og==
X-Gm-Message-State: ABuFfohzIjdVivsDT4VB//dMHReLsG8+pI/PC+zzf/gcbSlS3BbzC3Tr
        rG/hO4VFyWMzGJmV842nJ/TQMdZlqKU=
X-Google-Smtp-Source: ACcGV61Xz0hplBivnUDIoBFulen8/y+urWOwPBsNUzmCsa71pcuqiAkEuhhTjF5zzpm/ohTVTq9cUQ==
X-Received: by 2002:a25:a40a:: with SMTP id f10-v6mr10478644ybi.266.1539675866953;
        Tue, 16 Oct 2018 00:44:26 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id v5-v6sm3581833ywc.96.2018.10.16.00.44.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 00:44:26 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id v1-v6so8547246ywv.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 00:44:26 -0700 (PDT)
X-Received: by 2002:a81:3d8d:: with SMTP id k135-v6mr11179021ywa.415.1539675387097;
 Tue, 16 Oct 2018 00:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-3-tfiga@chromium.org>
 <4168da98-fa01-ea2f-8162-385501e666be@xs4all.nl> <CAAFQd5BqtKFeJniNaqahi9h_zKR+rPrWUiyx004Z=MWDj7q++w@mail.gmail.com>
In-Reply-To: <CAAFQd5BqtKFeJniNaqahi9h_zKR+rPrWUiyx004Z=MWDj7q++w@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 16 Oct 2018 16:36:15 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Djur9y+=UHTx9ZSx310p2ShCsBTqsEA1UHCMoawuDscA@mail.gmail.com>
Message-ID: <CAAFQd5Djur9y+=UHTx9ZSx310p2ShCsBTqsEA1UHCMoawuDscA@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: docs-rst: Document memory-to-memory video
 encoder interface
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>, todor.tomov@linaro.org,
        nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 3:54 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi Hans,
>
> On Wed, Jul 25, 2018 at 10:57 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >
> > On 24/07/18 16:06, Tomasz Figa wrote:
[snip]
> > > +4. The client may set the raw source format on the ``OUTPUT`` queue via
> > > +   :c:func:`VIDIOC_S_FMT`.
> > > +
> > > +   * **Required fields:**
> > > +
> > > +     ``type``
> > > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> > > +
> > > +     ``pixelformat``
> > > +         raw format of the source
> > > +
> > > +     ``width``, ``height``
> > > +         source resolution
> > > +
> > > +     ``num_planes`` (for _MPLANE)
> > > +         set to number of planes for pixelformat
> > > +
> > > +     ``sizeimage``, ``bytesperline``
> > > +         follow standard semantics
> > > +
> > > +   * **Return fields:**
> > > +
> > > +     ``width``, ``height``
> > > +         may be adjusted by driver to match alignment requirements, as
> > > +         required by the currently selected formats
> > > +
> > > +     ``sizeimage``, ``bytesperline``
> > > +         follow standard semantics
> > > +
> > > +   * Setting the source resolution will reset visible resolution to the
> > > +     adjusted source resolution rounded up to the closest visible
> > > +     resolution supported by the driver. Similarly, coded resolution will
> >
> > coded -> the coded
>
> Ack.
>
> >
> > > +     be reset to source resolution rounded up to the closest coded
> >
> > reset -> set
> > source -> the source
>
> Ack.
>

Actually, I'd prefer to keep it at "reset", so that it signifies the
fact that the driver will actually override whatever was set by the
application before.

[snip]
> > > +   * The driver must expose following selection targets on ``OUTPUT``:
> > > +
> > > +     ``V4L2_SEL_TGT_CROP_BOUNDS``
> > > +         maximum crop bounds within the source buffer supported by the
> > > +         encoder
> > > +
> > > +     ``V4L2_SEL_TGT_CROP_DEFAULT``
> > > +         suggested cropping rectangle that covers the whole source picture
> > > +
> > > +     ``V4L2_SEL_TGT_CROP``
> > > +         rectangle within the source buffer to be encoded into the
> > > +         ``CAPTURE`` stream; defaults to ``V4L2_SEL_TGT_CROP_DEFAULT``
> > > +
> > > +     ``V4L2_SEL_TGT_COMPOSE_BOUNDS``
> > > +         maximum rectangle within the coded resolution, which the cropped
> > > +         source frame can be output into; always equal to (0, 0)x(width of
> > > +         ``V4L2_SEL_TGT_CROP``, height of ``V4L2_SEL_TGT_CROP``), if the
> > > +         hardware does not support compose/scaling
> > > +
> > > +     ``V4L2_SEL_TGT_COMPOSE_DEFAULT``
> > > +         equal to ``V4L2_SEL_TGT_CROP``
> > > +
> > > +     ``V4L2_SEL_TGT_COMPOSE``
> > > +         rectangle within the coded frame, which the cropped source frame
> > > +         is to be output into; defaults to
> > > +         ``V4L2_SEL_TGT_COMPOSE_DEFAULT``; read-only on hardware without
> > > +         additional compose/scaling capabilities; resulting stream will
> > > +         have this rectangle encoded as the visible rectangle in its
> > > +         metadata
> > > +
> > > +     ``V4L2_SEL_TGT_COMPOSE_PADDED``
> > > +         always equal to coded resolution of the stream, as selected by the
> > > +         encoder based on source resolution and crop/compose rectangles
> >
> > Are there codec drivers that support composition? I can't remember seeing any.
> >
>
> Hmm, I was convinced that MFC could scale and we just lacked support
> in the driver, but I checked the documentation and it doesn't seem to
> be able to do so. I guess we could drop the COMPOSE rectangles for
> now, until we find any hardware that can do scaling or composing on
> the fly.
>

On the other hand, having them defined already wouldn't complicate
existing drivers too much either, because they would just handle all
of them in the same switch case, i.e.

case V4L2_SEL_TGT_COMPOSE_BOUNDS:
case V4L2_SEL_TGT_COMPOSE_DEFAULT:
case V4L2_SEL_TGT_COMPOSE:
case V4L2_SEL_TGT_COMPOSE_PADDED:
     return visible_rectangle;

That would need one change, though. We would define
V4L2_SEL_TGT_COMPOSE_DEFAULT to be equal to (0, 0)x(width of
V4L2_SEL_TGT_CROP - 1, height of ``V4L2_SEL_TGT_CROP - 1), which
makes more sense than current definition, since it would bypass any
compose/scaling by default.

> > > +
> > > +   .. note::
> > > +
> > > +      The driver may adjust the crop/compose rectangles to the nearest
> > > +      supported ones to meet codec and hardware requirements.
> > > +
> > > +6. Allocate buffers for both ``OUTPUT`` and ``CAPTURE`` via
> > > +   :c:func:`VIDIOC_REQBUFS`. This may be performed in any order.
> > > +
> > > +   * **Required fields:**
> > > +
> > > +     ``count``
> > > +         requested number of buffers to allocate; greater than zero
> > > +
> > > +     ``type``
> > > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT`` or
> > > +         ``CAPTURE``
> > > +
> > > +     ``memory``
> > > +         follows standard semantics
> > > +
> > > +   * **Return fields:**
> > > +
> > > +     ``count``
> > > +         adjusted to allocated number of buffers
> > > +
> > > +   * The driver must adjust count to minimum of required number of
> > > +     buffers for given format and count passed.
> >
> > I'd rephrase this:
> >
> >         The driver must adjust ``count`` to the maximum of ``count`` and
> >         the required number of buffers for the given format.
> >
> > Note that this is set to the maximum, not minimum.
> >
>
> Good catch. Will fix it.
>

Actually this is not always the maximum. Encoders may also have
constraints on the maximum number of buffers, so how about just making
it a bit less specific:

The count will be adjusted by the driver to match the hardware
requirements. The client must check the final value after the ioctl
returns to get the number of buffers allocated.

[snip]
> > One general comment:
> >
> > you often talk about 'the driver must', e.g.:
> >
> > "The driver must process and encode as normal all ``OUTPUT`` buffers
> > queued by the client before the :c:func:`VIDIOC_ENCODER_CMD` was issued."
> >
> > But this is not a driver specification, it is an API specification.
> >
> > I think it would be better to phrase it like this:
> >
> > "All ``OUTPUT`` buffers queued by the client before the :c:func:`VIDIOC_ENCODER_CMD`
> > was issued will be processed and encoded as normal."
> >
> > (or perhaps even 'shall' if you want to be really formal)
> >
> > End-users do not really care what drivers do, they want to know what the API does,
> > and that implies rules for drivers.
>
> While I see the point, I'm not fully convinced that it makes the
> documentation easier to read. We defined "client" for the purpose of
> not using the passive form too much, so possibly we could also define
> "driver" in the glossary. Maybe it's just me, but I find that
> referring directly to both sides of the API and using the active form
> is much easier to read.
>
> Possibly just replacing "driver" with "encoder" would ease your concern?

I actually went ahead and rephrased the text of both encoder and
decoder to be more userspace-centric. There are still mentions of a
driver, but only limited to the places
where it is necessary to signify the driver-specific bits, such as
alignments, capabilities, etc.

Best regards,
Tomasz
