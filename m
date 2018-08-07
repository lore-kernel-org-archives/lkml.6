Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E341C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB1B2198F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ol8KcWE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB1B2198F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388785AbeHGJV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:21:56 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40673 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388573AbeHGJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:21:55 -0400
Received: by mail-yw1-f66.google.com with SMTP id z143-v6so4563536ywa.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 00:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xThFOFDvJFyP137OHLpeAYZFjEyLRYt1/7TVRSekFlA=;
        b=Ol8KcWE8uERCGvVULHeFSa14YbGucbTiMTFbE6S9Y9ASVgfuDuafFB771mfQBda1db
         2z4/sHw/aP+FlPqDiZ0T82xByIHZ69NJVQ+tCiEgIoVxdRhXp6t/qV6SamgpsFzwvxP8
         XbtPTEx2EhZecGWywFIMpAhBfctHA/Fb6ecH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xThFOFDvJFyP137OHLpeAYZFjEyLRYt1/7TVRSekFlA=;
        b=gPGEP0ZheeSRJRJzWOarrCNgZr5GNSLDQerCyoPxUaghS1+Gpr07BWjzuyXLhxR+IX
         VBTlz4L11SlOEmWmYbVFGtZmPKy2KIUDSpUyXFxjTSKFqoxzGLmPfvqJWe71G4H4589N
         PvjYgtr3DBQ2gzeYKLFsoUh6RNRZjO27mOS8JgMTGGQ4jDs6lmZ7twm7ldXEABx5wyQT
         Wvce7gBJ+7F7AhZ1xKVuzS67upu8gGBCCwsPeKZAl167j8j6U9ABuJkdDZVDEv8iJg/y
         yqs+EZg9Z0/Nv7XPr5uRJR9J4/narL+1cptlse0h4BsSkM9j5WVvDnrUthTEQQXQJN8l
         /W1A==
X-Gm-Message-State: AOUpUlE8LtftEfygTgMDnnM0okis1vaLR4WK4iWMx+pH16+unIUVW7o5
        zn0uWjxbSkCGm27Xn1P+KT9AD2VnMhs=
X-Google-Smtp-Source: AAOMgpevLJw9c4/PbG9aKQx120kYaDVhH89JTOHeZO3QeqxQXYZhaReW2y1Rmvaq93XBlOVafQuxwA==
X-Received: by 2002:a81:7404:: with SMTP id p4-v6mr9427546ywc.407.1533625737800;
        Tue, 07 Aug 2018 00:08:57 -0700 (PDT)
Received: from mail-yb0-f173.google.com (mail-yb0-f173.google.com. [209.85.213.173])
        by smtp.gmail.com with ESMTPSA id d62-v6sm278621ywc.45.2018.08.07.00.08.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 00:08:56 -0700 (PDT)
Received: by mail-yb0-f173.google.com with SMTP id c10-v6so6254692ybf.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 00:08:56 -0700 (PDT)
X-Received: by 2002:a25:74cb:: with SMTP id p194-v6mr9060593ybc.500.1533625735970;
 Tue, 07 Aug 2018 00:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-2-tfiga@chromium.org>
 <318f609c-7a28-ef65-e8be-08107981b623@xs4all.nl>
In-Reply-To: <318f609c-7a28-ef65-e8be-08107981b623@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 7 Aug 2018 16:08:44 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DoXgMGU2wekJMM39NGkwSQqbQVbQ=XmM_pxqGEYKK9gA@mail.gmail.com>
Message-ID: <CAAFQd5DoXgMGU2wekJMM39NGkwSQqbQVbQ=XmM_pxqGEYKK9gA@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Hans Verkuil <hverkuil@xs4all.nl>, nicolas@ndufresne.ca
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>, todor.tomov@linaro.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 9:52 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 07/24/2018 04:06 PM, Tomasz Figa wrote:
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
> >  Documentation/media/uapi/v4l/dev-decoder.rst | 872 +++++++++++++++++++
> >  Documentation/media/uapi/v4l/devices.rst     |   1 +
> >  Documentation/media/uapi/v4l/v4l2.rst        |  10 +-
> >  3 files changed, 882 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/media/uapi/v4l/dev-decoder.rst
> >
> > diff --git a/Documentation/media/uapi/v4l/dev-decoder.rst b/Documentati=
on/media/uapi/v4l/dev-decoder.rst
> > new file mode 100644
> > index 000000000000..f55d34d2f860
> > --- /dev/null
> > +++ b/Documentation/media/uapi/v4l/dev-decoder.rst
> > @@ -0,0 +1,872 @@
>
> <snip>
>
> > +6.  This step only applies to coded formats that contain resolution
> > +    information in the stream. Continue queuing/dequeuing bitstream
> > +    buffers to/from the ``OUTPUT`` queue via :c:func:`VIDIOC_QBUF` and
> > +    :c:func:`VIDIOC_DQBUF`. The driver must keep processing and return=
ing
> > +    each buffer to the client until required metadata to configure the
> > +    ``CAPTURE`` queue are found. This is indicated by the driver sendi=
ng
> > +    a ``V4L2_EVENT_SOURCE_CHANGE`` event with
> > +    ``V4L2_EVENT_SRC_CH_RESOLUTION`` source change type. There is no
> > +    requirement to pass enough data for this to occur in the first buf=
fer
> > +    and the driver must be able to process any number.
> > +
> > +    * If data in a buffer that triggers the event is required to decod=
e
> > +      the first frame, the driver must not return it to the client,
> > +      but must retain it for further decoding.
> > +
> > +    * If the client set width and height of ``OUTPUT`` format to 0, ca=
lling
> > +      :c:func:`VIDIOC_G_FMT` on the ``CAPTURE`` queue will return -EPE=
RM,
> > +      until the driver configures ``CAPTURE`` format according to stre=
am
> > +      metadata.
>
> What about calling TRY/S_FMT on the capture queue: will this also return =
-EPERM?
> I assume so.

We should make it so indeed, to make things consistent.

On another note, I don't really like this -EPERM here, as one could
just see that the format is 0x0 and know that it's not valid. This is
only needed for legacy userspace that doesn't handle the source change
event in initial stream parsing and just checks whether G_FMT returns
an error instead.

Nicolas, for more insight here.

Best regards,
Tomasz
