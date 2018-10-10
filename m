Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007F6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FAF214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EvDBTT7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FAF214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeJJPzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:55:12 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37671 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeJJPzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:55:12 -0400
Received: by mail-yb1-f195.google.com with SMTP id h1-v6so1867645ybm.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/D54NYkwSD4yjpNi2rPABFvSi4zTQPWtZmsvl3VrBMI=;
        b=EvDBTT7nWnL5qHpRiF/PrDWVXyj1j0geetXoRsh7RYHhZSwQUsg2hAJiP/f8eCwM1f
         NQLlOGEgQY+twva4PEamWGZy18lgU1A+L/hMcf35S/PAl78osvh+KxEkJBSYrknq4JcH
         JJ1CmGwVZZdqOxw+uDOxDGItrDLx7XeEV6SbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/D54NYkwSD4yjpNi2rPABFvSi4zTQPWtZmsvl3VrBMI=;
        b=Na0NCmgr002qp9xNl6e0ihtmj/+nuRhHiFJupupDEpTEC7yxa1+9wwmql61hmp5o2z
         5InMcUsiMaLopwFfK2xXSR5XuhmpzkQ0hddC4Ykru7v9a9EEk9OIjUXALOt+Bil8+Tdm
         vuH+hBzynHReeOPp3rU0+7w3/Rj6GrkxOx4EyXdyFcmRZkVguf40v0giQgK3l93gwoN/
         REl2ezNIU14Xwp5i4TFbez2/2MF4WLk2tNQ8VdfTuZ7bthBUO6s7AIO80iaDyAJCH6kg
         OoZgKWvAdg76bDl17O2nY7wrZFl3bIH+TkxlRw2qgFP7pJDANDV5imPXhqu3NL8JxEdy
         GBPQ==
X-Gm-Message-State: ABuFfojUM3qjCEZZ7BoliDrxfREHH3MufIkpXSxfyMTWqpdbsqexdZ/2
        ohTyMSrqGlmJOl6h/FkCSfQX+k7ixj0dzw==
X-Google-Smtp-Source: ACcGV60snkqIU6C6FULloAQAMBy6ZP+H//jceGKK7Ii/NTcCCe+1lpc41HUYPwBKWNiL2HuaC3CrkQ==
X-Received: by 2002:a25:4155:: with SMTP id o82-v6mr17318877yba.310.1539160445449;
        Wed, 10 Oct 2018 01:34:05 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id o195-v6sm8282403ywd.82.2018.10.10.01.34.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 01:34:04 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id y14-v6so1844614ywa.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:34:04 -0700 (PDT)
X-Received: by 2002:a0d:fdc6:: with SMTP id n189-v6mr17980009ywf.443.1539160443877;
 Wed, 10 Oct 2018 01:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180828080240.10982-1-paul.kocialkowski@bootlin.com> <20180828080240.10982-2-paul.kocialkowski@bootlin.com>
In-Reply-To: <20180828080240.10982-2-paul.kocialkowski@bootlin.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 10 Oct 2018 17:33:52 +0900
X-Gmail-Original-Message-ID: <CAAFQd5An1htKNpNJmwHAzw6Oz+Z=T_MuBg+T=_yMbT7SkkokBw@mail.gmail.com>
Message-ID: <CAAFQd5An1htKNpNJmwHAzw6Oz+Z=T_MuBg+T=_yMbT7SkkokBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: v4l: Add definitions for the HEVC slice format
 and controls
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, thomas.petazzoni@bootlin.com,
        linux-sunxi@googlegroups.com, ayaka <ayaka@soulik.info>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Aug 28, 2018 at 5:02 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> This introduces the required definitions for HEVC decoding support with
> stateless VPUs. The controls associated to the HEVC slice format provide
> the required meta-data for decoding slices extracted from the bitstream.
>

Sorry for being late to the party. Please see my comments inline. Only
high level, because I don't know too much about HEVC.

[snip]
> +``V4L2_CID_MPEG_VIDEO_HEVC_SPS (struct)``
> +    Specifies the Sequence Parameter Set fields (as extracted from the
> +    bitstream) for the associated HEVC slice data.
> +    The bitstream parameters are defined according to the ISO/IEC 23008-2 and
> +    ITU-T Rec. H.265 specifications.
> +
> +.. c:type:: v4l2_ctrl_hevc_sps
> +
> +.. cssclass:: longtable
> +
> +.. flat-table:: struct v4l2_ctrl_hevc_sps
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u8
> +      - ``chroma_format_idc``
> +      - Syntax description inherited from the specification.

I wonder if it wouldn't make sense to instead document this in C code
using kernel-doc and then have the kernel-doc included in the sphinx
doc. It seems to be possible, according to
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html .

Such approach would have the advantage of the person looking through C
cross reference being able to actually see the documentation of the
struct in question and also making it easier to ensure the relevant C
code and documentation are in sync. (Although this is UAPI so it would
be unlikely to change too often or at all.)

[snip]
> +``V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS (struct)``
> +    Specifies various slice-specific parameters, especially from the NAL unit
> +    header, general slice segment header and weighted prediction parameter
> +    parts of the bitstream.
> +    The bitstream parameters are defined according to the ISO/IEC 23008-2 and
> +    ITU-T Rec. H.265 specifications.

In the Chromium H.264 controls, we define this as an array control, so
that we can include multiple slices in one buffer and each entry of
the array has an offset field pointing to the part of the buffer that
contains corresponding slice data. I've mentioned this in the
discussion on Alex's stateless decoder interface documentation, so
let's keep the discussion there, though.

[snip]
> @@ -1696,6 +1708,11 @@ static int std_validate(const struct v4l2_ctrl *ctrl, u32 idx,
>         case V4L2_CTRL_TYPE_H264_DECODE_PARAMS:
>                 return 0;
>
> +       case V4L2_CTRL_TYPE_HEVC_SPS:
> +       case V4L2_CTRL_TYPE_HEVC_PPS:
> +       case V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS:
> +               return 0;
> +

I wonder to what extent we should be validating this. I can see 3 options:
1) Defer validation to drivers completely. - Potentially error prone
and leading to a lot of code duplication?
2) Validate completely. - Might need solving some interesting
problems, e.g. validating reference frame indices in DPB against
current state of respective VB2 queue...
3) Validate only what we can easily do, defer more complicated
validation to the drivers. - Potentially a good middle ground?

Best regards,
Tomasz
