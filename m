Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B021C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB36420882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uyoff7v8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfA1Fyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 00:54:43 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43476 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfA1Fym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 00:54:42 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so12063175oie.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 21:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFcdm97ZQVqY+sV8pPGkw6BS+L2oAzaBBnHbL8dP6qY=;
        b=Uyoff7v8XzH8f5DxoBbglk0HZJLuF+9E8p7lxgKwVrvu5ZYWUGmCiADjNdzSzDki9M
         dn31m0DG6cwz/d8+NwWxZI5CL2SMMzbEKpvOXMMgXKMY14+ciHrdd9LNFavU5QXk+l0Q
         eMU36ihXXuctBaDC0u8ivl7W6QrPxSq8SdAYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFcdm97ZQVqY+sV8pPGkw6BS+L2oAzaBBnHbL8dP6qY=;
        b=pQX+Zp7qjeRFX7pWQdSRnlhIeua7mtgak4zMH4kg7+aSnhOmKGlHn/J/i8wCXmZ2dn
         SlKDT1kCVtcy4C0pyZYsyPvVI/x0oMjDDcRPj+zW59oWxZuW5ZuawgFATedrvDTMNUWu
         weM15t/4Kgy6ZpoKvineAgjxVYqSolUepExOYfJ65XOi+kizrCo5B2jmQ5qiiaeAELQX
         7uBXoHpG8p5hWHCo9LB1Q8QqvTcBKO8trvGIrtdPllAt2mIKifbuM2sxySZT54GV8JCR
         ReIqRBkp8wF8ekRi4VXoVfcsU5H2beWYOWQEkeZngmRk1NBolL2HPdrU2SrA4yzhRs8h
         f/2A==
X-Gm-Message-State: AJcUukcxOIuypbGTUwm1rKsKdRf7FsLtPibNPR8F0dQRxn8HnRklOT1N
        fI6teNfelbUTLq7j8eD+uPRCY9x110c=
X-Google-Smtp-Source: AHgI3Ia/ztUGYDoTkLFw9eLQDZ0WKk9Zp1sYyJXn67EkoXSDG0QlgCq4uUYi/vZ0OwyM4z4j2IpnDQ==
X-Received: by 2002:aca:1b13:: with SMTP id b19mr5013696oib.215.1548654881505;
        Sun, 27 Jan 2019 21:54:41 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id 21sm4439292oie.24.2019.01.27.21.54.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 21:54:40 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id t204so12073960oie.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 21:54:39 -0800 (PST)
X-Received: by 2002:a54:4486:: with SMTP id v6mr5215060oiv.233.1548654879619;
 Sun, 27 Jan 2019 21:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20181115145650.9827-1-maxime.ripard@bootlin.com> <20181115145650.9827-2-maxime.ripard@bootlin.com>
In-Reply-To: <20181115145650.9827-2-maxime.ripard@bootlin.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 28 Jan 2019 14:54:27 +0900
X-Gmail-Original-Message-ID: <CAPBb6MX9=+k=5M-w7SyCUAKUceAXN7UG_6==tFx4RhR13Etdwg@mail.gmail.com>
Message-ID: <CAPBb6MX9=+k=5M-w7SyCUAKUceAXN7UG_6==tFx4RhR13Etdwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        jenskuske@gmail.com, linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:56 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> From: Pawel Osciak <posciak@chromium.org>
>
> Stateless video codecs will require both the H264 metadata and slices in
> order to be able to decode frames.
>
> This introduces the definitions for a new pixel format for H264 slices that
> have been parsed, as well as the structures used to pass the metadata from
> the userspace to the kernel.
>
> Co-Developed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Pawel Osciak <posciak@chromium.org>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

<snip>

> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> index b854cceb19dc..e96c453208e8 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -825,6 +825,11 @@ const char *v4l2_ctrl_get_name(u32 id)
>         case V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER:return "H264 Number of HC Layers";
>         case V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER_QP:
>                                                                 return "H264 Set QP Value for HC Layers";
> +       case V4L2_CID_MPEG_VIDEO_H264_SPS:                      return "H264 SPS";
> +       case V4L2_CID_MPEG_VIDEO_H264_PPS:                      return "H264 PPS";
> +       case V4L2_CID_MPEG_VIDEO_H264_SCALING_MATRIX:           return "H264 Scaling Matrix";
> +       case V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS:             return "H264 Slice Parameters";
> +       case V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS:            return "H264 Decode Parameters";
>         case V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP:              return "MPEG4 I-Frame QP Value";
>         case V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP:              return "MPEG4 P-Frame QP Value";
>         case V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP:              return "MPEG4 B-Frame QP Value";

To make things future-proof I think it may be good to add a control
specifying the granularity of data sent with each request (see
https://lkml.org/lkml/2019/1/24/147).

Right now we have a consensus that to make things simple, we request
one frame of encoded data per request. But this will probably be
relaxed in the future, since allowing to process things at lower
granularity may improve latency. Moreover the granularity accepted by
the encoder is hardware/firmware dependent, so it is probably a good
idea to expose this from the beginning.

How about a new V4L2_CID_MPEG_VIDEO_H264_GRANULARITY control with only
one value at the moment, namely
V4L2_MPEG_VIDEO_H264_GRANULARITY_FRAME? We could extend this in the
future, and that way user-space will have no excuse for not checking
that the codec supports the input granularity it will send.

I'm wondering whether this could be made codec-independent, but I'm
afraid this would add confusion.
