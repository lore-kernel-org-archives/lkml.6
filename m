Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8A6C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8126C20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bOYMZupM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8126C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeIJMKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:10:02 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46479 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbeIJMKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:10:02 -0400
Received: by mail-yw1-f67.google.com with SMTP id j131-v6so7466187ywc.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Fcb1K0IJY09GZOtLcqVMXORpPk2IKr/+86egp22Ih4=;
        b=bOYMZupMQSaregSu2e3X/rSYnqsElFT+pykoqhy9WE2olUXMsGvhWfOCwF2eoPvjoj
         TyWSByqEdrlA3x/odTRhHdBVbFIEC6bnntcQKbgd7kXg08dXYby9nKsQM70afd+xx6Op
         GC+FHULYs2/UTQF/PRGSFc+Kp6kl1lZCXqKfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Fcb1K0IJY09GZOtLcqVMXORpPk2IKr/+86egp22Ih4=;
        b=FSk063s/j+sxWT0YYwELdaDeWnzvgb3YFWGjm6G3M0vtaTwj7D+O8LB4OZiXQzu9s2
         wCXWdHzot6AAGxKR3OKAPvcrQ2sPt52YB5kpWYyG67neAuQpRw14TuIL/4cFIe2OHY0u
         SLa6UA1EGX9LVBls+pl15a3zHnzwATkE6Oc2RZ0VzRm3zBosBM/KjeQ3dUbToQela4Cs
         44wTuTqsNiSCYGGSd/M66spiiV8xHqbq+hSTNuQhRhenxp35t3xd6coc0bvy/kTtTl4i
         VxF5P5/igwf7Pn+m7UurtQaShEQUAWwOuvM9lwNeuWE9oy7fle5yrnsbMXKlg+ZVRXHx
         A/1g==
X-Gm-Message-State: APzg51Dt/URpbN9WjTGBQyPRB52w8tfHJ5LRGhjZUR9HyhVTQmyOqc1X
        hvl0KxzVmvfLV6TNGcQ+tizAFbpa9BmtXg==
X-Google-Smtp-Source: ANB0VdZx1UGj7V93oc5CWa9KHOv8mG5HBfuSyxV6SYRX0Wg6kon4N6T5g1y38ATm5PNAFWhOQVs8lg==
X-Received: by 2002:a81:6e07:: with SMTP id j7-v6mr9460055ywc.495.1536563844025;
        Mon, 10 Sep 2018 00:17:24 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id g205-v6sm5747409ywb.23.2018.09.10.00.17.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 00:17:23 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id t71-v6so7562990ybi.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:17:22 -0700 (PDT)
X-Received: by 2002:a25:18c2:: with SMTP id 185-v6mr9309900yby.204.1536563842324;
 Mon, 10 Sep 2018 00:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180831074743.235010-1-acourbot@chromium.org>
In-Reply-To: <20180831074743.235010-1-acourbot@chromium.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 10 Sep 2018 16:17:10 +0900
X-Gmail-Original-Message-ID: <CAAFQd5ALyeeru36zVYjG6P2U_JWMgxiv0WPnF2DD2OHHd+nHbQ@mail.gmail.com>
Message-ID: <CAAFQd5ALyeeru36zVYjG6P2U_JWMgxiv0WPnF2DD2OHHd+nHbQ@mail.gmail.com>
Subject: Re: [RFC PATCH] media: docs-rst: Document m2m stateless video decoder interface
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

+Maxime Ripard +Ezequiel Garcia +Nicolas Dufresne

[Not snipping intentionally.]

On Fri, Aug 31, 2018 at 4:48 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> This patch documents the protocol that user-space should follow when
> communicating with stateless video decoders. It is based on the
> following references:
>
> * The current protocol used by Chromium (converted from config store to
>   request API)
>
> * The submitted Cedrus VPU driver
>
> As such, some things may not be entirely consistent with the current
> state of drivers, so it would be great if all stakeholders could point
> out these inconsistencies. :)
>
> This patch is supposed to be applied on top of the Request API V18 as
> well as the memory-to-memory video decoder interface series by Tomasz
> Figa.
>
> It should be considered an early RFC.

Thanks a lot. I think this gives us a much better start already than
what we had with stateful API without any documentation. :)

Please see my comments inline.

>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  .../media/uapi/v4l/dev-stateless-decoder.rst  | 413 ++++++++++++++++++
>  Documentation/media/uapi/v4l/devices.rst      |   1 +
>  .../media/uapi/v4l/extended-controls.rst      |  23 +
>  3 files changed, 437 insertions(+)
>  create mode 100644 Documentation/media/uapi/v4l/dev-stateless-decoder.rst
>
> diff --git a/Documentation/media/uapi/v4l/dev-stateless-decoder.rst b/Documentation/media/uapi/v4l/dev-stateless-decoder.rst
> new file mode 100644
> index 000000000000..bf7b13a8ee16
> --- /dev/null
> +++ b/Documentation/media/uapi/v4l/dev-stateless-decoder.rst
> @@ -0,0 +1,413 @@
> +.. -*- coding: utf-8; mode: rst -*-
> +
> +.. _stateless_decoder:
> +
> +**************************************************
> +Memory-to-memory Stateless Video Decoder Interface
> +**************************************************
> +
> +A stateless decoder is a decoder that works without retaining any kind of state
> +between processing frames. This means that each frame is decoded independently
> +of any previous and future frames, and that the client is responsible for
> +maintaining the decoding state and providing it to the driver. This is in
> +contrast to the stateful video decoder interface, where the hardware maintains
> +the decoding state and all the client has to do is to provide the raw encoded
> +stream.
> +
> +This section describes how user-space ("the client") is expected to communicate
> +with such decoders in order to successfully decode an encoded stream. Compared
> +to stateful codecs, the driver/client protocol is simpler, but cost of this
> +simplicity is extra complexity in the client which must maintain the decoding
> +state.
> +
> +Querying capabilities
> +=====================
> +
> +1. To enumerate the set of coded formats supported by the driver, the client
> +   calls :c:func:`VIDIOC_ENUM_FMT` on the ``OUTPUT`` queue.
> +
> +   * The driver must always return the full set of supported formats for the
> +     currently set ``OUTPUT`` format, irrespective of the format currently set
> +     on the ``CAPTURE`` queue.
> +
> +2. To enumerate the set of supported raw formats, the client calls
> +   :c:func:`VIDIOC_ENUM_FMT` on the ``CAPTURE`` queue.
> +
> +   * The driver must return only the formats supported for the format currently
> +     active on the ``OUTPUT`` queue.
> +
> +   * In order to enumerate raw formats supported by a given coded format, the
> +     client must thus set that coded format on the ``OUTPUT`` queue first, and
> +     then enumerate the ``CAPTURE`` queue.

One thing that we might want to note here is that available CAPTURE
formats may depend on more factors than just current OUTPUT format.
Depending on encoding options of the stream being decoded (e.g. VP9
profile), the list of supported format might be limited to one of YUV
4:2:0, 4:2:2 or 4:4:4 family of formats, but might be any of them, if
the hardware supports conversion.

I was wondering whether we shouldn't require the client to set all the
necessary initial codec-specific controls before querying CAPTURE
formats, but since we don't have any compatibility constraints here,
as opposed to the stateful API, perhaps we could just make CAPTURE
queue completely independent and have a source change event raised if
the controls set later make existing format invalid.

I'd like to ask the userspace folks here (Nicolas?), whether:
1) we need to know the exact list of formats that are guaranteed to be
supported for playing back the whole video, or
2) we're okay with some rough approximation here, or
3) maybe we don't even need to enumerate formats on CAPTURE beforehand?

To be honest, I'm not sure 1) is even possible, since the resolution
(or some other stream parameters) could change mid-stream.

> +
> +3. The client may use :c:func:`VIDIOC_ENUM_FRAMESIZES` to detect supported
> +   resolutions for a given format, passing desired pixel format in
> +   :c:type:`v4l2_frmsizeenum` ``pixel_format``.
> +
> +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` on ``OUTPUT`` queue
> +     must include all possible coded resolutions supported by the decoder
> +     for given coded pixel format.
> +
> +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` on ``CAPTURE`` queue
> +     must include all possible frame buffer resolutions supported by the
> +     decoder for given raw pixel format and coded format currently set on
> +     ``OUTPUT`` queue.
> +
> +    .. note::
> +
> +       The client may derive the supported resolution range for a
> +       combination of coded and raw format by setting width and height of
> +       ``OUTPUT`` format to 0 and calculating the intersection of
> +       resolutions returned from calls to :c:func:`VIDIOC_ENUM_FRAMESIZES`
> +       for the given coded and raw formats.
> +
> +4. Supported profiles and levels for given format, if applicable, may be
> +   queried using their respective controls via :c:func:`VIDIOC_QUERYCTRL`.
> +
> +Initialization
> +==============
> +
> +1. *[optional]* Enumerate supported ``OUTPUT`` formats and resolutions. See
> +   capability enumeration.
> +
> +2. Set the coded format on the ``OUTPUT`` queue via :c:func:`VIDIOC_S_FMT`
> +
> +   * **Required fields:**
> +
> +     ``type``
> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> +
> +     ``pixelformat``
> +         a coded pixel format
> +
> +     ``width``, ``height``
> +         parsed width and height of the coded format

Perhaps "coded width and height parsed from the stream" could be a bit
more clear?

> +
> +     other fields
> +         follow standard semantics
> +
> +   .. note::
> +
> +      Changing ``OUTPUT`` format may change currently set ``CAPTURE``
> +      format. The driver will derive a new ``CAPTURE`` format from
> +      ``OUTPUT`` format being set, including resolution, colorimetry
> +      parameters, etc. If the client needs a specific ``CAPTURE`` format,
> +      it must adjust it afterwards.
> +
> +3. *[optional]* Get minimum number of buffers required for ``OUTPUT``
> +   queue via :c:func:`VIDIOC_G_CTRL`. This is useful if client intends to
> +   use more buffers than minimum required by hardware/format.
> +
> +   * **Required fields:**
> +
> +     ``id``
> +         set to ``V4L2_CID_MIN_BUFFERS_FOR_OUTPUT``
> +
> +   * **Return fields:**
> +
> +     ``value``
> +         required number of ``OUTPUT`` buffers for the currently set
> +         format

I'm not very sure if this is useful for stateless API, but no strong opinion.

> +
> +4. Call :c:func:`VIDIOC_G_FMT` for ``CAPTURE`` queue to get format for the
> +   destination buffers parsed/decoded from the bitstream.
> +
> +   * **Required fields:**
> +
> +     ``type``
> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``
> +
> +   * **Return fields:**
> +
> +     ``width``, ``height``
> +         frame buffer resolution for the decoded frames
> +
> +     ``pixelformat``
> +         pixel format for decoded frames
> +
> +     ``num_planes`` (for _MPLANE ``type`` only)
> +         number of planes for pixelformat
> +
> +     ``sizeimage``, ``bytesperline``
> +         as per standard semantics; matching frame buffer format
> +
> +   .. note::
> +
> +      The value of ``pixelformat`` may be any pixel format supported for the
> +      ``OUTPUT`` format, based on the hardware capabilities. It is suggested
> +      that driver chooses the preferred/optimal format for given configuration.
> +      For example, a YUV format may be preferred over an RGB format, if
> +      additional conversion step would be required.
> +
> +5. *[optional]* Enumerate ``CAPTURE`` formats via :c:func:`VIDIOC_ENUM_FMT` on
> +   ``CAPTURE`` queue. The client may use this ioctl to discover which
> +   alternative raw formats are supported for the current ``OUTPUT`` format and
> +   select one of them via :c:func:`VIDIOC_S_FMT`.
> +
> +   .. note::
> +
> +      The driver will return only formats supported for the currently selected
> +      ``OUTPUT`` format, even if more formats may be supported by the driver in
> +      general.
> +
> +      For example, a driver/hardware may support YUV and RGB formats for
> +      resolutions 1920x1088 and lower, but only YUV for higher resolutions (due
> +      to hardware limitations). After setting a resolution of 1920x1088 or lower
> +      as the ``OUTPUT`` format, :c:func:`VIDIOC_ENUM_FMT` may return a set of
> +      YUV and RGB pixel formats, but after setting a resolution higher than
> +      1920x1088, the driver will not return RGB, unsupported for this
> +      resolution.
> +
> +6. *[optional]* Choose a different ``CAPTURE`` format than suggested via
> +   :c:func:`VIDIOC_S_FMT` on ``CAPTURE`` queue. It is possible for the client to
> +   choose a different format than selected/suggested by the driver in
> +   :c:func:`VIDIOC_G_FMT`.
> +
> +    * **Required fields:**
> +
> +      ``type``
> +          a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``
> +
> +      ``pixelformat``
> +          a raw pixel format
> +
> +    .. note::
> +
> +       Calling :c:func:`VIDIOC_ENUM_FMT` to discover currently available
> +       formats after receiving ``V4L2_EVENT_SOURCE_CHANGE`` is useful to find
> +       out a set of allowed formats for given configuration, but not required,
> +       if the client can accept the defaults.

V4L2_EVENT_SOURCE_CHANGE was not mentioned in earlier steps. I suppose
it's a leftover from the stateful API? :)

Still, I think we may eventually need source change events, because of
the reasons I mentioned above.

> +
> +7. *[optional]* Get minimum number of buffers required for ``CAPTURE`` queue via
> +   :c:func:`VIDIOC_G_CTRL`. This is useful if client intends to use more buffers
> +   than minimum required by hardware/format.
> +
> +    * **Required fields:**
> +
> +      ``id``
> +          set to ``V4L2_CID_MIN_BUFFERS_FOR_CAPTURE``
> +
> +    * **Return fields:**
> +
> +      ``value``
> +          minimum number of buffers required to decode the stream parsed in this
> +          initialization sequence.
> +
> +    .. note::
> +
> +       Note that the minimum number of buffers must be at least the number
> +       required to successfully decode the current stream. This may for example
> +       be the required DPB size for an H.264 stream given the parsed stream
> +       configuration (resolution, level).

I'm not sure if this really makes sense for stateless API, because DPB
management is done by the client, so it already has all the data to
know how many buffers would be needed/optimal.

> +
> +8. Allocate source (bitstream) buffers via :c:func:`VIDIOC_REQBUFS` on
> +   ``OUTPUT`` queue.
> +
> +    * **Required fields:**
> +
> +      ``count``
> +          requested number of buffers to allocate; greater than zero
> +
> +      ``type``
> +          a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> +
> +      ``memory``
> +          follows standard semantics
> +
> +      ``sizeimage``
> +          follows standard semantics; the client is free to choose any
> +          suitable size, however, it may be subject to change by the
> +          driver
> +
> +    * **Return fields:**
> +
> +      ``count``
> +          actual number of buffers allocated
> +
> +    * The driver must adjust count to minimum of required number of ``OUTPUT``
> +      buffers for given format and count passed. The client must check this
> +      value after the ioctl returns to get the number of buffers allocated.
> +
> +    .. note::
> +
> +       To allocate more than minimum number of buffers (for pipeline depth), use
> +       G_CTRL(``V4L2_CID_MIN_BUFFERS_FOR_OUTPUT``) to get minimum number of
> +       buffers required by the driver/format, and pass the obtained value plus
> +       the number of additional buffers needed in count to
> +       :c:func:`VIDIOC_REQBUFS`.
> +
> +9. Allocate destination (raw format) buffers via :c:func:`VIDIOC_REQBUFS` on the
> +   ``CAPTURE`` queue.
> +
> +    * **Required fields:**
> +
> +      ``count``
> +          requested number of buffers to allocate; greater than zero
> +
> +      ``type``
> +          a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``
> +
> +      ``memory``
> +          follows standard semantics
> +
> +    * **Return fields:**
> +
> +      ``count``
> +          adjusted to allocated number of buffers
> +
> +    * The driver must adjust count to minimum of required number of
> +      destination buffers for given format and stream configuration and the
> +      count passed. The client must check this value after the ioctl
> +      returns to get the number of buffers allocated.
> +
> +    .. note::
> +
> +       To allocate more than minimum number of buffers (for pipeline
> +       depth), use G_CTRL(``V4L2_CID_MIN_BUFFERS_FOR_CAPTURE``) to
> +       get minimum number of buffers required, and pass the obtained value
> +       plus the number of additional buffers needed in count to
> +       :c:func:`VIDIOC_REQBUFS`.
> +
> +10. Allocate requests (likely one per ``OUTPUT`` buffer) via
> +    :c:func:`MEDIA_IOC_REQUEST_ALLOC` on the media device.
> +
> +11. Start streaming on both ``OUTPUT`` and ``CAPTURE`` queues via
> +    :c:func:`VIDIOC_STREAMON`.
> +
> +Decoding
> +========
> +
> +For each frame, the client is responsible for submitting a request to which the
> +following is attached:
> +
> +* Exactly one frame worth of encoded data in a buffer submitted to the
> +  ``OUTPUT`` queue,

Just to make sure, in case of H.264, that would include all the slices
of the frame in one buffer, right?

> +* All the controls relevant to the format being decoded (see below for details).
> +
> +``CAPTURE`` buffers must not be part of the request, but must be queued
> +independently. The driver will pick one of the queued ``CAPTURE`` buffers and
> +decode the frame into it. Although the client has no control over which
> +``CAPTURE`` buffer will be used with a given ``OUTPUT`` buffer, it is guaranteed
> +that ``CAPTURE`` buffers will be returned in decode order (i.e. the same order
> +as ``OUTPUT`` buffers were submitted), so it is trivial to associate a dequeued
> +``CAPTURE`` buffer to its originating request and ``OUTPUT`` buffer.
> +
> +If the request is submitted without an ``OUTPUT`` buffer or if one of the
> +required controls are missing, then :c:func:`MEDIA_REQUEST_IOC_QUEUE` will return
> +``-EINVAL``.

As per some of the other discussion threads we had before (and I
linked to in my previous reply), we might want one of the following:
1) precisely define the list of controls needed with the
fine-granularity of all possible stream feature combinations,
2) make only some very basic controls mandatory and never fail if
other controls are not specified.

IMHO 2) has a potential to lead to userspace relying on undefined
behavior with some controls not being set (for
laziness/simplicity/whatever excuse the author can think of), so I'd
personally go with 1)...

> Decoding errors are signaled by the ``CAPTURE`` buffers being
> +dequeued carrying the ``V4L2_BUF_FLAG_ERROR`` flag.
> +
> +The contents of source ``OUTPUT`` buffers, as well as the controls that must be
> +set on the request, depend on active coded pixel format and might be affected by
> +codec-specific extended controls, as stated in documentation of each format
> +individually.
> +
> +MPEG-2 buffer content and controls
> +----------------------------------
> +The following information is valid when the ``OUTPUT`` queue is set to the
> +``V4L2_PIX_FMT_MPEG2_SLICE`` format.

Perhaps we should document the controls there instead? I think that
was the conclusion from the discussions over the stateful API.

> +
> +The ``OUTPUT`` buffer must contain all the macroblock slices of a given frame,
> +i.e. if a frame requires several macroblock slices to be entirely decoded, then
> +all these slices must be provided. In addition, the following controls must be
> +set on the request:
> +
> +V4L2_CID_MPEG_VIDEO_MPEG2_SLICE_PARAMS
> +   Slice parameters (one per slice) for the current frame.
> +

How do we know how many slices are included in current frame?

> +Optional controls:
> +
> +V4L2_CID_MPEG_VIDEO_MPEG2_QUANTIZATION
> +   Quantization matrices for the current frame.

What happens if it's not specified?

> +
> +H.264 buffer content and controls
> +---------------------------------
> +The following information is valid when the ``OUTPUT`` queue is set to the
> +``V4L2_PIX_FMT_H264_SLICE`` format.

Ditto.

> +
> +The ``OUTPUT`` buffer must contain all the macroblock slices of a given frame,
> +i.e. if a frame requires several macroblock slices to be entirely decoded, then
> +all these slices must be provided. In addition, the following controls must be
> +set on the request:
> +
> +V4L2_CID_MPEG_VIDEO_H264_SPS
> +   Instance of struct v4l2_ctrl_h264_sps, containing the SPS of to use with the
> +   frame.
> +
> +V4L2_CID_MPEG_VIDEO_H264_PPS
> +   Instance of struct v4l2_ctrl_h264_pps, containing the PPS of to use with the
> +   frame.
> +
> +V4L2_CID_MPEG_VIDEO_H264_SCALING_MATRIX
> +   Instance of struct v4l2_ctrl_h264_scaling_matrix, containing the scaling
> +   matrix to use when decoding the frame.
> +
> +V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAM
> +   Array of struct v4l2_ctrl_h264_slice_param, containing at least as many
> +   entries as there are slices in the corresponding ``OUTPUT`` buffer.
> +
> +V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAM
> +   Instance of struct v4l2_ctrl_h264_decode_param, containing the high-level
> +   decoding parameters for a H.264 frame.
> +
> +Seek
> +====
> +In order to seek, the client just needs to submit requests using input buffers
> +corresponding to the new stream position. It must however be aware that
> +resolution may have changed and follow the dynamic resolution change protocol in

nit: We tend to call it "sequence" rather than "protocol" in other documents.

> +that case. Also depending on the codec used, picture parameters (e.g. SPS/PPS
> +for H.264) may have changed and the client is responsible for making sure that
> +a valid state is sent to the kernel.
> +
> +The client is then free to ignore any returned ``CAPTURE`` buffer that comes
> +from the pre-seek position.
> +
> +Pause
> +=====
> +
> +In order to pause, the client should just cease queuing buffers onto the
> +``OUTPUT`` queue. This is different from the general V4L2 API definition of
> +pause, which involves calling :c:func:`VIDIOC_STREAMOFF` on the queue.
> +Without source bitstream data, there is no data to process and the hardware
> +remains idle.

This behavior is by design of memory-to-memory devices, so I'm not
sure we really need this section. Perhaps we could move it to a
separate document which explains m2m basics.

> +
> +Dynamic resolution change
> +=========================
> +
> +If the client detects a resolution change in the stream, it may need to
> +reallocate the ``CAPTURE`` buffers to fit the new size.
> +
> +1. Wait until all submitted requests have completed and dequeue the
> +   corresponding output buffers.
> +
> +2. Call :c:func:`VIDIOC_STREAMOFF` on the ``CAPTURE`` queue.
> +
> +3. Free all ``CAPTURE`` buffers by calling :c:func:`VIDIOC_REQBUFS` on the
> +   ``CAPTURE`` queue with a buffer count of zero.
> +
> +4. Set the new format and resolution on the ``CAPTURE`` queue.
> +
> +5. Allocate new ``CAPTURE`` buffers for the new resolution.
> +
> +6. Call :c:func:`VIDIOC_STREAMON` on the ``CAPTURE`` queue to resume the stream.
> +
> +The client can then start queueing new ``CAPTURE`` buffers and submit requests
> +to decode the next buffers at the new resolution.

There is some inconsistency here. In initialization sequence, we set
OUTPUT format to coded width and height and had the driver set a sane
default CAPTURE format. What happens to OUTPUT format? It definitely
wouldn't make sense if it stayed at the initial coded size.

> +
> +Drain
> +=====
> +
> +In order to drain the stream on a stateless decoder, the client just needs to
> +wait until all the submitted requests are completed. There is no need to send a
> +``V4L2_DEC_CMD_STOP`` command since requests are processed sequentially by the
> +driver.

Is there a need to include this section? I feel like it basically says
"Drain sequence: There is no drain sequence." ;)

> +
> +End of stream
> +=============
> +
> +If the decoder encounters an end of stream marking in the stream, the
> +driver must send a ``V4L2_EVENT_EOS`` event to the client after all frames
> +are decoded and ready to be dequeued on the ``CAPTURE`` queue, with the
> +:c:type:`v4l2_buffer` ``flags`` set to ``V4L2_BUF_FLAG_LAST``. This
> +behavior is identical to the drain sequence triggered by the client via
> +``V4L2_DEC_CMD_STOP``.

The client parses the stream, so it should be also responsible for end
of stream handling. There isn't anything to be signaled by the driver
here (nor the driver could actually signal), so I'd just remove this
section completely.

> diff --git a/Documentation/media/uapi/v4l/devices.rst b/Documentation/media/uapi/v4l/devices.rst
> index 1822c66c2154..a8e568eda7d8 100644
> --- a/Documentation/media/uapi/v4l/devices.rst
> +++ b/Documentation/media/uapi/v4l/devices.rst
> @@ -16,6 +16,7 @@ Interfaces
>      dev-osd
>      dev-codec
>      dev-decoder
> +    dev-stateless-decoder
>      dev-encoder
>      dev-effect
>      dev-raw-vbi
> diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Documentation/media/uapi/v4l/extended-controls.rst
> index a9252225b63e..c0411ebf4c12 100644
> --- a/Documentation/media/uapi/v4l/extended-controls.rst
> +++ b/Documentation/media/uapi/v4l/extended-controls.rst
> @@ -810,6 +810,29 @@ enum v4l2_mpeg_video_bitrate_mode -
>      otherwise the decoder expects a single frame in per buffer.
>      Applicable to the decoder, all codecs.
>
> +``V4L2_CID_MPEG_VIDEO_H264_SPS``
> +    Instance of struct v4l2_ctrl_h264_sps, containing the SPS of to use with
> +    the next queued frame. Applicable to the H.264 stateless decoder.
> +
> +``V4L2_CID_MPEG_VIDEO_H264_PPS``
> +    Instance of struct v4l2_ctrl_h264_pps, containing the PPS of to use with
> +    the next queued frame. Applicable to the H.264 stateless decoder.
> +
> +``V4L2_CID_MPEG_VIDEO_H264_SCALING_MATRIX``
> +    Instance of struct v4l2_ctrl_h264_scaling_matrix, containing the scaling
> +    matrix to use when decoding the next queued frame. Applicable to the H.264
> +    stateless decoder.
> +
> +``V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAM``
> +    Array of struct v4l2_ctrl_h264_slice_param, containing at least as many
> +    entries as there are slices in the corresponding ``OUTPUT`` buffer.
> +    Applicable to the H.264 stateless decoder.
> +
> +``V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAM``
> +    Instance of struct v4l2_ctrl_h264_decode_param, containing the high-level
> +    decoding parameters for a H.264 frame. Applicable to the H.264 stateless
> +    decoder.
> +

This seems to be roughly the same as in "H.264 buffer content and
controls". IMHO we should just keep the controls described here and
make the other file just cross reference to these descriptions.

Also, I guess this would eventually end up in the patch that adds
those controls and is just included here for RFC purposes, right?

Best regards,
Tomasz
