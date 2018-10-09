Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60B6C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BF4214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aC0Gy5Sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BF4214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeJIOvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:51:53 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:32899 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeJIOvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:51:53 -0400
Received: by mail-yw1-f68.google.com with SMTP id m127-v6so255448ywb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cW1dQ7JX/79viH31cfUp8J5qXmRot9g3E4BlrCvw0no=;
        b=aC0Gy5SdWX7P9DFwUvEFezQQ3ns5gO2FCEmObzffcf4mhyf/EVIdlP0uPgVAj9XztH
         o3DTjReMO9z+npRdL+J0K8AKFBSCmTDUPFrh/+beuYCeASlSy9J2T7m2L+HEjJJdjvss
         41ZUO0M0VAOLgGMmTq56MLeZM2jpq8OpjdXJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cW1dQ7JX/79viH31cfUp8J5qXmRot9g3E4BlrCvw0no=;
        b=IM3t8rDg8a2kDLD+UfI9Z/HtoIBBBwGzvDzLYk49BBEqUPigiBjYLndOPbuVCdv1nM
         CLG5p1s3iI67eJldzEuWctvrE7pcw53u3pvyeC/69NSTGiKTMgvPk7thNT5zaoqKpDaw
         N1idRL1fDTWQNOcd4cC3+UL4+l/bNszncIXV1dLxFQYYAy9ntQ08CRWE9RUYqOHzOTA4
         OwJ1kv8++/uRQKJ4TK+DYVb0rJYZ5yKec/OPC5vVYT1qgGYdKGthUoNVwSD+0obQuwWh
         4pYHWfbfhLczZuVbbGPih74s4sFLAL7jeGKFAJW9rovTMICPSVziBigbtNNPvSAxaLjq
         Ms0A==
X-Gm-Message-State: ABuFfohg5r+WtEE7f6nRTixrj0bjlvhkNg2/qhnRiYwW3EMieDxRtIRo
        8uBsdILkU/xz6quuN0Ju7uRkTfhUvzakYg==
X-Google-Smtp-Source: ACcGV606e2uzFQJjPtwlqCZqGkEmOry7JRbnI9dmU6YU0x68jiAv5HwCDDIIsE/aRfnBdnLbPGtNAA==
X-Received: by 2002:a0d:fa42:: with SMTP id k63-v6mr12541259ywf.41.1539070577151;
        Tue, 09 Oct 2018 00:36:17 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id u143-v6sm11489228ywc.28.2018.10.09.00.36.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 00:36:15 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 5-v6so246777ybf.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:36:15 -0700 (PDT)
X-Received: by 2002:a25:bd0c:: with SMTP id f12-v6mr15184090ybk.293.1539070575175;
 Tue, 09 Oct 2018 00:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181004081119.102575-1-acourbot@chromium.org>
 <f1fa989b372b514f0a7534057de80b0c453cc8a3.camel@paulk.fr> <5085f73bc44424b20f1bd0dc1332d9baabecb090.camel@ndufresne.ca>
 <dc1045e5806638d58ae5ace796541cb8a3d29481.camel@paulk.fr>
In-Reply-To: <dc1045e5806638d58ae5ace796541cb8a3d29481.camel@paulk.fr>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 9 Oct 2018 16:36:03 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cr4OxVQtzT1NyPm+-buZJHsmF0BM6wMTxOdonUpCC_NA@mail.gmail.com>
Message-ID: <CAAFQd5Cr4OxVQtzT1NyPm+-buZJHsmF0BM6wMTxOdonUpCC_NA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] media: docs-rst: Document m2m stateless video
 decoder interface
To:     contact@paulk.fr
Cc:     nicolas@ndufresne.ca, Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Pawel Osciak <posciak@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 6, 2018 at 2:09 AM Paul Kocialkowski <contact@paulk.fr> wrote:
>
> Hi,
>
> Le jeudi 04 octobre 2018 =C3=A0 14:10 -0400, Nicolas Dufresne a =C3=A9cri=
t :
> > Le jeudi 04 octobre 2018 =C3=A0 14:47 +0200, Paul Kocialkowski a =C3=A9=
crit :
> > > > +    Instance of struct v4l2_ctrl_h264_scaling_matrix, containing t=
he scaling
> > > > +    matrix to use when decoding the next queued frame. Applicable =
to the H.264
> > > > +    stateless decoder.
> > > > +
> > > > +``V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAM``
> > >
> > > Ditto with "H264_SLICE_PARAMS".
> > >
> > > > +    Array of struct v4l2_ctrl_h264_slice_param, containing at leas=
t as many
> > > > +    entries as there are slices in the corresponding ``OUTPUT`` bu=
ffer.
> > > > +    Applicable to the H.264 stateless decoder.
> > > > +
> > > > +``V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAM``
> > > > +    Instance of struct v4l2_ctrl_h264_decode_param, containing the=
 high-level
> > > > +    decoding parameters for a H.264 frame. Applicable to the H.264=
 stateless
> > > > +    decoder.
> > >
> > > Since we require all the macroblocks to decode one frame to be held i=
n
> > > the same OUTPUT buffer, it probably doesn't make sense to keep
> > > DECODE_PARAM and SLICE_PARAM distinct.
> > >
> > > I would suggest merging both in "SLICE_PARAMS", similarly to what I
> > > have proposed for H.265: https://patchwork.kernel.org/patch/10578023/
> > >
> > > What do you think?
> >
> > I don't understand why we add this arbitrary restriction of "all the
> > macroblocks to decode one frame". The bitstream may contain multiple
> > NALs per frame (e.g. slices), and stateless API shall pass each NAL
> > separately imho. The driver can then decide to combine them if needed,
> > or to keep them seperate. I would expect most decoder to decode each
> > slice independently from each other, even though they write into the
> > same frame.
>
> Well, we sort of always assumed that there is a 1:1 correspondency
> between request and output frame when implemeting the software for
> cedrus, which simplified both userspace and the driver. The approach we
> have taken is to use one of the slice parameters for the whole series
> of slices and just append the slice data.
>
> Now that you bring it up, I realize this is an unfortunate decision.
> This may have been the cause of bugs and limitations with our driver
> because the slice parameters may very well be distinct for each slice.

I might be misunderstanding something, but, at least for the H.264
API, there is no relation between the number of buffers/requests and
number of slice parameters. The V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAM
is an array, with each element describing each slice in the OUTPUT
buffer. So actually, it could be up to the userspace if it want to
have 1 OUTPUT buffer per slice or all slices in 1 OUTPUT buffer - the
former would have v4l2_ctrl_h264_decode_param::num_slices =3D 1 and only
one valid element in V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS.

> Moreover, I suppose that just appending the slices data implies that
> they are coded in the same order as the picture, which is probably
> often the case but certainly not anything guaranteed.

Again, at least in the H.264 API being proposed here, the order of
slices is not specified by the order of slice data in the buffer. Each
entry of the V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS array points to the
specific offset within the buffer.

Best regards,
Tomasz
