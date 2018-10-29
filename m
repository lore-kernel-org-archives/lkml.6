Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93938C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0432084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NNRQppay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0432084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbeJ2Syo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:54:44 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46312 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbeJ2Syo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:54:44 -0400
Received: by mail-yb1-f194.google.com with SMTP id f15-v6so2672291ybq.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w2RWIn01tCANsFJiceyKomFM9E7X+6lpkQBp7E0wQ1Y=;
        b=NNRQppay6NVttO+mF8JHjbaCh/ZUwJ8C/mdC5YMBbGP5r/U7E62cijGgVwcawLu7KN
         i09eeYJKMltdyrhVjH6HmibTIyW+tMK0uO6FgNk2vNymgow6cjQAmezny/+DEi1gH770
         JxEkZs5VK/1gAePJidn8YRp0B9Je+z/8evR1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w2RWIn01tCANsFJiceyKomFM9E7X+6lpkQBp7E0wQ1Y=;
        b=n0NbN6UpRUH3Sk8CLrFPn3XefAhk3gIsqQjGXss/L9ZaiH83k62Czgjso50EVzD7kj
         im2lX13libB2mMKFPjYs5fxHOTQh7D8tCOXl4FYu2eP+fltq7WhM2cM1B0cU8JpznGBJ
         6PoIER3MmNyUlYmyEXAvn+jGQKfW6g9kBjN4i6ZuuU7vRjK4Rd36WtpKLyQ8wKfYyDHG
         3mtZSmm/tt3wHrcwefW+BTlILRvoNzPF2lKlv4dfNZ5C7byCufbBC4TCkJTudDkz0x+s
         eeLSYD9l/MwPJx2/acOlyofG0bq1M7TsE6VZTTwgoUlDWxBWWME2LoV+sHv/ULN2zB9d
         /UPg==
X-Gm-Message-State: AGRZ1gJO9MhH5yM36dS+ue34NtmCqlGv2C5kS35n4nHcQJjNoQPQeCmU
        mbYuPpwCy++km3WrwNHuaCZIoQhsL1I=
X-Google-Smtp-Source: AJdET5c8a1zQYvt7nOr3IC4h8Vwd4QC5nBmprilVSxyKvS0uO96qrccis6EDT9QYhB1EZQNzBrAofg==
X-Received: by 2002:a25:2104:: with SMTP id h4-v6mr10457570ybh.220.1540807604909;
        Mon, 29 Oct 2018 03:06:44 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id v19-v6sm6970180ywv.19.2018.10.29.03.06.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 03:06:43 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id w16-v6so3171503ybp.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 03:06:43 -0700 (PDT)
X-Received: by 2002:a25:cb53:: with SMTP id b80-v6mr12945265ybg.303.1540807603143;
 Mon, 29 Oct 2018 03:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181022144901.113852-1-tfiga@chromium.org> <20181022144901.113852-2-tfiga@chromium.org>
 <31c175d6-b1e9-f8d7-0b8b-821271a59a70@linaro.org>
In-Reply-To: <31c175d6-b1e9-f8d7-0b8b-821271a59a70@linaro.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 29 Oct 2018 19:06:30 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CcFDqWDoRiESjVp2bw16Pm_aoOy44kVx5iYFve18jKSg@mail.gmail.com>
Message-ID: <CAAFQd5CcFDqWDoRiESjVp2bw16Pm_aoOy44kVx5iYFve18jKSg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>, todor.tomov@linaro.org,
        nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

On Mon, Oct 29, 2018 at 6:45 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Tomasz,
>
> On 10/22/2018 05:48 PM, Tomasz Figa wrote:
> > Due to complexity of the video decoding process, the V4L2 drivers of
> > stateful decoder hardware require specific sequences of V4L2 API calls
> > to be followed. These include capability enumeration, initialization,
> > decoding, seek, pause, dynamic resolution change, drain and end of
> > stream.
> >
> > Specifics of the above have been discussed during Media Workshops at
> > LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
> > Conference Europe 2014 in D=C3=BCsseldorf. The de facto Codec API that
> > originated at those events was later implemented by the drivers we alre=
ady
> > have merged in mainline, such as s5p-mfc or coda.
> >
> > The only thing missing was the real specification included as a part of
> > Linux Media documentation. Fix it now and document the decoder part of
> > the Codec API.
> >
> > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > ---
> >  Documentation/media/uapi/v4l/dev-decoder.rst  | 1082 +++++++++++++++++
> >  Documentation/media/uapi/v4l/devices.rst      |    1 +
> >  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |    5 +
> >  Documentation/media/uapi/v4l/v4l2.rst         |   10 +-
> >  .../media/uapi/v4l/vidioc-decoder-cmd.rst     |   40 +-
> >  Documentation/media/uapi/v4l/vidioc-g-fmt.rst |   14 +
> >  6 files changed, 1137 insertions(+), 15 deletions(-)
> >  create mode 100644 Documentation/media/uapi/v4l/dev-decoder.rst
> >
> > diff --git a/Documentation/media/uapi/v4l/dev-decoder.rst b/Documentati=
on/media/uapi/v4l/dev-decoder.rst
> > new file mode 100644
> > index 000000000000..09c7a6621b8e
> > --- /dev/null
> > +++ b/Documentation/media/uapi/v4l/dev-decoder.rst
>
> <cut>
>
> > +Capture setup
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
>
> <cut>
>
> > +
> > +2.  **Optional.** Acquire the visible resolution via
> > +    :c:func:`VIDIOC_G_SELECTION`.
> > +
> > +    * **Required fields:**
> > +
> > +      ``type``
> > +          a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``
> > +
> > +      ``target``
> > +          set to ``V4L2_SEL_TGT_COMPOSE``
> > +
> > +    * **Return fields:**
> > +
> > +      ``r.left``, ``r.top``, ``r.width``, ``r.height``
> > +          the visible rectangle; it must fit within the frame buffer r=
esolution
> > +          returned by :c:func:`VIDIOC_G_FMT` on ``CAPTURE``.
> > +
> > +    * The following selection targets are supported on ``CAPTURE``:
> > +
> > +      ``V4L2_SEL_TGT_CROP_BOUNDS``
> > +          corresponds to the coded resolution of the stream
> > +
> > +      ``V4L2_SEL_TGT_CROP_DEFAULT``
> > +          the rectangle covering the part of the ``CAPTURE`` buffer th=
at
> > +          contains meaningful picture data (visible area); width and h=
eight
> > +          will be equal to the visible resolution of the stream
> > +
> > +      ``V4L2_SEL_TGT_CROP``
> > +          the rectangle within the coded resolution to be output to
> > +          ``CAPTURE``; defaults to ``V4L2_SEL_TGT_CROP_DEFAULT``; read=
-only on
> > +          hardware without additional compose/scaling capabilities
>
> Hans should correct me if I'm wrong but V4L2_SEL_TGT_CROP_xxx are
> applicable over OUTPUT queue type?

There is no such restriction. CROP selection targets of an OUTPUT
queue apply to the video stream read from the buffers, COMPOSE targets
of an OUTPUT queue apply to the output of the queue and input to the
processing block (hardware) in case of mem2mem devices, then CROP
targets of a CAPTURE queue apply to the output of the processing and
SELECTION targets of a CAPTURE queue apply to the stream written to
the buffers.

For a decoder, the OUTPUT stream is just a sequence of bytes, so
selection API doesn't apply to it. The processing (decoding) produces
a video stream and so the necessary selection capabilities are exposed
on the CAPTURE queue.

Best regards,
Tomasz
