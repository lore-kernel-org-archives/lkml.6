Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4771C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3CB20827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gqR0v/Mn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3CB20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbeJ2TBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:01:39 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37706 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbeJ2TBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:01:38 -0400
Received: by mail-yw1-f67.google.com with SMTP id v77-v6so3112202ywc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 03:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m1eha819Xo7LMAtL+qtdXUQuW+ObsunwcOkkGdiQWfQ=;
        b=gqR0v/Mn5To1bUI389UKNgs5MKlnlCBbeKgbOg+uISI22PS0L702lh45wrDvcd6Jxg
         jRIVzrumGW4rOzSvzqH8j63x+7jFHkiXWIlDvupUaJMVu7I3/oyN0pRJvaZT+A3+EVpf
         6lLSnhcwe+fOe9y1cL7K/JPshlVY7NpKKEVRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m1eha819Xo7LMAtL+qtdXUQuW+ObsunwcOkkGdiQWfQ=;
        b=O5I5bJC2FHrizESi5RSLCAO/8puOm77hYJJOBjUHFOZ+59vNbIuqaKieewqOyKGX0Z
         pzmn5gb1ULbCaGwQdCsVGsG0wXNdQYoDWLVNYiYFdsco2eNTyzl32g24oV4UcgtEju1L
         6qSee4onXDd5i1US4F9a0NahLqofFud910j2rPceapxQSO5goz7YAfPIm1mfD25OYIUa
         0CRZQb7TAGuBbg22XFHcqBRfSta1BA4RHf2MSrQVo09peCQ3DXxEUcMTfEJ8T43/sahy
         PC/fVHAXwjU5i2ErDNTFE1MGtkc76DtAB0LkG23rBVTWj7uDzYvstoAwoR5BkVT1zaSw
         /aIg==
X-Gm-Message-State: AGRZ1gKh0raDtbW3V1eBnDCT1R5yKy+pDoBrSCeVwXFfTxRYdqB5isVN
        GGGxCTvPAESgvOtODA/NxPeHuELiqH9C8w==
X-Google-Smtp-Source: AJdET5fPGepmXYdkJvIFrMw47J8wFVgarR/UYf6OapsTT02Nf2DNNrGwhb/MiP74BLr5hAcSMZF4yQ==
X-Received: by 2002:a0d:f9c5:: with SMTP id j188-v6mr13115041ywf.286.1540808016963;
        Mon, 29 Oct 2018 03:13:36 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id a189-v6sm4917262ywf.49.2018.10.29.03.13.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 03:13:36 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id v199-v6so3121000ywg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 03:13:36 -0700 (PDT)
X-Received: by 2002:a81:8144:: with SMTP id r65-v6mr12765784ywf.403.1540807651941;
 Mon, 29 Oct 2018 03:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181022144901.113852-1-tfiga@chromium.org> <20181022144901.113852-2-tfiga@chromium.org>
 <31c175d6-b1e9-f8d7-0b8b-821271a59a70@linaro.org> <CAAFQd5CcFDqWDoRiESjVp2bw16Pm_aoOy44kVx5iYFve18jKSg@mail.gmail.com>
In-Reply-To: <CAAFQd5CcFDqWDoRiESjVp2bw16Pm_aoOy44kVx5iYFve18jKSg@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 29 Oct 2018 19:07:19 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C6q4RsXWYpbeyBZR88bKa_roMh=DDTBN3NFKHod+Y2+g@mail.gmail.com>
Message-ID: <CAAFQd5C6q4RsXWYpbeyBZR88bKa_roMh=DDTBN3NFKHod+Y2+g@mail.gmail.com>
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

On Mon, Oct 29, 2018 at 7:06 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi Stanimir,
>
> On Mon, Oct 29, 2018 at 6:45 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
> >
> > Hi Tomasz,
> >
> > On 10/22/2018 05:48 PM, Tomasz Figa wrote:
> > > Due to complexity of the video decoding process, the V4L2 drivers of
> > > stateful decoder hardware require specific sequences of V4L2 API call=
s
> > > to be followed. These include capability enumeration, initialization,
> > > decoding, seek, pause, dynamic resolution change, drain and end of
> > > stream.
> > >
> > > Specifics of the above have been discussed during Media Workshops at
> > > LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
> > > Conference Europe 2014 in D=C3=BCsseldorf. The de facto Codec API tha=
t
> > > originated at those events was later implemented by the drivers we al=
ready
> > > have merged in mainline, such as s5p-mfc or coda.
> > >
> > > The only thing missing was the real specification included as a part =
of
> > > Linux Media documentation. Fix it now and document the decoder part o=
f
> > > the Codec API.
> > >
> > > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > > ---
> > >  Documentation/media/uapi/v4l/dev-decoder.rst  | 1082 +++++++++++++++=
++
> > >  Documentation/media/uapi/v4l/devices.rst      |    1 +
> > >  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |    5 +
> > >  Documentation/media/uapi/v4l/v4l2.rst         |   10 +-
> > >  .../media/uapi/v4l/vidioc-decoder-cmd.rst     |   40 +-
> > >  Documentation/media/uapi/v4l/vidioc-g-fmt.rst |   14 +
> > >  6 files changed, 1137 insertions(+), 15 deletions(-)
> > >  create mode 100644 Documentation/media/uapi/v4l/dev-decoder.rst
> > >
> > > diff --git a/Documentation/media/uapi/v4l/dev-decoder.rst b/Documenta=
tion/media/uapi/v4l/dev-decoder.rst
> > > new file mode 100644
> > > index 000000000000..09c7a6621b8e
> > > --- /dev/null
> > > +++ b/Documentation/media/uapi/v4l/dev-decoder.rst
> >
> > <cut>
> >
> > > +Capture setup
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> >
> > <cut>
> >
> > > +
> > > +2.  **Optional.** Acquire the visible resolution via
> > > +    :c:func:`VIDIOC_G_SELECTION`.
> > > +
> > > +    * **Required fields:**
> > > +
> > > +      ``type``
> > > +          a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``
> > > +
> > > +      ``target``
> > > +          set to ``V4L2_SEL_TGT_COMPOSE``
> > > +
> > > +    * **Return fields:**
> > > +
> > > +      ``r.left``, ``r.top``, ``r.width``, ``r.height``
> > > +          the visible rectangle; it must fit within the frame buffer=
 resolution
> > > +          returned by :c:func:`VIDIOC_G_FMT` on ``CAPTURE``.
> > > +
> > > +    * The following selection targets are supported on ``CAPTURE``:
> > > +
> > > +      ``V4L2_SEL_TGT_CROP_BOUNDS``
> > > +          corresponds to the coded resolution of the stream
> > > +
> > > +      ``V4L2_SEL_TGT_CROP_DEFAULT``
> > > +          the rectangle covering the part of the ``CAPTURE`` buffer =
that
> > > +          contains meaningful picture data (visible area); width and=
 height
> > > +          will be equal to the visible resolution of the stream
> > > +
> > > +      ``V4L2_SEL_TGT_CROP``
> > > +          the rectangle within the coded resolution to be output to
> > > +          ``CAPTURE``; defaults to ``V4L2_SEL_TGT_CROP_DEFAULT``; re=
ad-only on
> > > +          hardware without additional compose/scaling capabilities
> >
> > Hans should correct me if I'm wrong but V4L2_SEL_TGT_CROP_xxx are
> > applicable over OUTPUT queue type?
>
> There is no such restriction. CROP selection targets of an OUTPUT
> queue apply to the video stream read from the buffers, COMPOSE targets
> of an OUTPUT queue apply to the output of the queue and input to the
> processing block (hardware) in case of mem2mem devices, then CROP
> targets of a CAPTURE queue apply to the output of the processing and
> SELECTION targets of a CAPTURE queue apply to the stream written to

I mean, COMPOSE targets. Sorry for the noise.

> the buffers.
>
> For a decoder, the OUTPUT stream is just a sequence of bytes, so
> selection API doesn't apply to it. The processing (decoding) produces
> a video stream and so the necessary selection capabilities are exposed
> on the CAPTURE queue.
>
> Best regards,
> Tomasz
