Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DVhVjHAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C9CC601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932434AbeFFJRy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:17:54 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:37787 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932315AbeFFJRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:17:53 -0400
X-Google-Smtp-Source: ADUXVKIt8o2d4rK9PnMoFycmDu4udSdNaPPwcdHWZldDxNgH0aRSw8yZi+T7Xr+gzlaD2kYRMhfe3A==
MIME-Version: 1.0
References: <20180605103328.176255-1-tfiga@chromium.org> <20180605103328.176255-3-tfiga@chromium.org>
 <1528199628.4074.15.camel@pengutronix.de> <CAAFQd5DYu+Oehr1UUvvdmWk7toO0i_=NFgvZcAKQ8ZURKy51fA@mail.gmail.com>
 <1528208578.4074.19.camel@pengutronix.de>
In-Reply-To: <1528208578.4074.19.camel@pengutronix.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 6 Jun 2018 18:17:40 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DqHj65AdzfYmvHWkqHnZntiiA2AhAfgHbLA3AuWvsOTQ@mail.gmail.com>
Message-ID: <CAAFQd5DqHj65AdzfYmvHWkqHnZntiiA2AhAfgHbLA3AuWvsOTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] media: docs-rst: Add encoder UAPI specification
 to Codec Interfaces
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?=
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?=
        <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        todor.tomov@linaro.org, nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 11:23 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Tue, 2018-06-05 at 21:31 +0900, Tomasz Figa wrote:
> [...]
> > +Initialization
> > > > +--------------
> > > > +
> > > > +1. (optional) Enumerate supported formats and resolutions. See
> > > > +   capability enumeration.
> > > > +
> > > > +2. Set a coded format on the CAPTURE queue via :c:func:`VIDIOC_S_FMT`
> > > > +
> > > > +   a. Required fields:
> > > > +
> > > > +      i.  type = CAPTURE
> > > > +
> > > > +      ii. fmt.pix_mp.pixelformat set to a coded format to be produced
> > > > +
> > > > +   b. Return values:
> > > > +
> > > > +      i.  EINVAL: unsupported format.
> > > > +
> > > > +      ii. Others: per spec
> > > > +
> > > > +   c. Return fields:
> > > > +
> > > > +      i. fmt.pix_mp.width, fmt.pix_mp.height should be 0.
> > > > +
> > > > +   .. note::
> > > > +
> > > > +      After a coded format is set, the set of raw formats
> > > > +      supported as source on the OUTPUT queue may change.
> > >
> > > So setting CAPTURE potentially also changes OUTPUT format?
> >
> > Yes, but at this point userspace hasn't yet set the desired format.
> >
> > > If the encoded stream supports colorimetry information, should that
> > > information be taken from the CAPTURE queue?
> >
> > What's colorimetry? Is it something that is included in
> > v4l2_pix_format(_mplane)? Is it something that can vary between raw
> > input and encoded output?
>
> FTR, yes, I meant the colorspace, ycbcr_enc, quantization, and xfer_func
> fields of the v4l2_pix_format(_mplane) structs. GStreamer uses the term
> "colorimetry" to pull these fields together into a single parameter.
>
> The codecs usually don't care at all about this information, except some
> streams (such as h.264 in the VUI parameters section of the SPS header)
> may optionally contain a representation of these fields, so it may be
> desirable to let encoders write the configured colorimetry or to let
> decoders return the detected colorimetry via G_FMT(CAP) after a source
> change event.
>
> I think it could be useful to enforce the same colorimetry on CAPTURE
> and OUTPUT queue if the hardware doesn't do any colorspace conversion.

After thinking a bit more on this, I guess it wouldn't overly
complicate things if we require that the values from OUTPUT queue are
copied to CAPTURE queue, if the stream doesn't include such
information or the hardware just can't parse them. Also, userspace
that can't parse them wouldn't have to do anything, as the colorspace
default on OUTPUT would be V4L2_COLORSPACE_DEFAULT and if hardware
can't parse it either, it would just be propagated to CAPTURE.

>
> > > > +3. (optional) Enumerate supported OUTPUT formats (raw formats for
> > > > +   source) for the selected coded format via :c:func:`VIDIOC_ENUM_FMT`.
> > > > +
> > > > +   a. Required fields:
> > > > +
> > > > +      i.  type = OUTPUT
> > > > +
> > > > +      ii. index = per spec
> > > > +
> > > > +   b. Return values: per spec
> > > > +
> > > > +   c. Return fields:
> > > > +
> > > > +      i. pixelformat: raw format supported for the coded format
> > > > +         currently selected on the OUTPUT queue.
> > > > +
> > > > +4. Set a raw format on the OUTPUT queue and visible resolution for the
> > > > +   source raw frames via :c:func:`VIDIOC_S_FMT` on the OUTPUT queue.
> > >
> > > Isn't this optional? If S_FMT(CAP) already sets OUTPUT to a valid
> > > format, just G_FMT(OUT) should be valid here as well.
> >
> > Technically it would be valid indeed, but that would be unlikely what
> > the client needs, given that it probably already has some existing raw
> > frames (at certain resolution) to encode.
>
> Maybe add a clarifying note that G_FMT is acceptable as an alternative?
> We don't have to put this front and center if it is not the expected use
> case, but it would still be nice to have it documented as valid use.
>
> This could be part of a still ongoing negotiation process if the source
> is a scaler or some frame generator that can create frames of any size.
>

I guess it wouldn't hurt to say so, with a clear annotation that there
is no expectation that the default values are practically usable. For
example the input resolution could be set to minimum supported by
default.

> > > > +
> > > > +   a. Required fields:
> > > > +
> > > > +      i.   type = OUTPUT
> > > > +
> > > > +      ii.  fmt.pix_mp.pixelformat = raw format to be used as source of
> > > > +           encode
> > > > +
> > > > +      iii. fmt.pix_mp.width, fmt.pix_mp.height = input resolution
> > > > +           for the source raw frames
> > >
> > > These are specific to multiplanar drivers. The same should apply to
> > > singleplanar drivers.
> >
> > Right. In general I'd be interested in getting some suggestions in how
> > to write this kind of descriptions nicely and consistent with other
> > kernel documentation.
>
> Maybe just:
>
>         a. Required fields:
>
>            i.   type = OUTPUT or OUTPUT_MPLANE
>
>            ii.  fmt.pix.pixelformat or fmt.pix_mp.pixelformat = ...
>
>            iii. fmt.pix.width, fmt.pix_mp.height or fmt.pix_mp.width,
>                 fmt.pix_mp.height = ...
>

Ack.

>
> [...]
> > > > +7. Begin streaming on both OUTPUT and CAPTURE queues via
> > > > +   :c:func:`VIDIOC_STREAMON`. This may be performed in any order.
> > >
> > > Actual encoding starts once both queues are streaming
> >
> > I think that's the only thing possible with vb2, since it gives
> > buffers to the driver when streaming starts on given queue.
> >
> > > and stops as soon
> > > as the first queue receives STREAMOFF?
> >
> > Given that STREAMOFF is supposed to drop all the buffers from the
> > queue, it should be so +/- finishing what's already queued to the
> > hardware, if it cannot be cancelled.
>
> Oh, right.
>
> > I guess we should say this more explicitly.
> >
> [...]
> > > > +Encoding parameter changes
> > > > +--------------------------
> > > > +
> > > > +The client is allowed to use :c:func:`VIDIOC_S_CTRL` to change encoder
> > > > +parameters at any time. The driver must apply the new setting starting
> > > > +at the next frame queued to it.
> > > > +
> > > > +This specifically means that if the driver maintains a queue of buffers
> > > > +to be encoded and at the time of the call to :c:func:`VIDIOC_S_CTRL` not all the
> > > > +buffers in the queue are processed yet, the driver must not apply the
> > > > +change immediately, but schedule it for when the next buffer queued
> > > > +after the :c:func:`VIDIOC_S_CTRL` starts being processed.
> > >
> > > Does this mean that hardware that doesn't support changing parameters at
> > > runtime at all must stop streaming and restart streaming internally with
> > > every parameter change? Or is it acceptable to not allow the controls to
> > > be changed during streaming?
> >
> > That's a good question. I'd be leaning towards the latter (not allow),
> > as to keep kernel code simple, but maybe we could have others
> > (especially Pawel) comment on this.
>
> Same here.

Same as where? :)

>
> [...]
> > > > +2. Enumerating formats on OUTPUT queue must only return OUTPUT formats
> > > > +   supported for the CAPTURE format currently set.
> > > > +
> > > > +3. Setting/changing format on OUTPUT queue does not change formats
> > > > +   available on CAPTURE queue. An attempt to set OUTPUT format that
> > > > +   is not supported for the currently selected CAPTURE format must
> > > > +   result in an error (-EINVAL) from :c:func:`VIDIOC_S_FMT`.
> > >
> > > Same as for decoding, is this limited to pixel format? Why isn't the
> > > pixel format corrected to a supported choice? What about
> > > width/height/colorimetry?
> >
> > Width/height/colorimetry(Do you mean color space?) is a part of
> > v4l2_pix_format(_mplane). I believe that's what this point was about.
>
> Yes. My question was more about whether this should return -EINVAL or
> whether TRY_FMT/S_FMT should change the parameters to valid values.

As per the standard semantics of TRY_/S_FMT, they should adjust the
format on given queue. We only require that the state on other queue
is left intact.

Best regards,
Tomasz
