Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6082EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EA2207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GgFz+HGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfBVHwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:52:15 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41253 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfBVHwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:52:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id t7so1128274otk.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 23:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdwuctcJ1faOyzGzEzoq5oNjsGUxgcwpwrsME4v8/q8=;
        b=GgFz+HGOg/1nfYatJTaZyAgmoh2E1if0c6r1TJ5qpNn/CPbYvzVfLicvuMF13PhVHf
         6QnD8IS35pPmjbPcV/3ISH+9/lytogl0GlY9TsdRyvVJQ2q/UYOztxadJAXczmWPs30Q
         prKG9lzWJt0tBU+lduX1/uS6rOJmzyFaYi7C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdwuctcJ1faOyzGzEzoq5oNjsGUxgcwpwrsME4v8/q8=;
        b=rpFokfh5/TEB18ooby8ue8kxQIQC5Xa5VpcH96MLnDvoOg5K0mSMxjWTBsBjQ1ydm4
         3edbFP0vzt7Ha5iZTrjFBiTrWatg033o1baaOkAuWLJRB8/3FBDjbLuuGcjw3VMfB4wD
         T9KF+SZE2SRyj626RL+qK+Ym8eVd0SrG1NMcJ6bfEz2JrCvjkyBvgLBi/w7SXiD6yrLs
         doQOvArth63K1P+8+pYhobLiQa70taTQdjiT7vtDlehx+3a1n12MUZ0yLEBb+Xs592bi
         rj/EPraca7IQv3xqgf49zNL9eAw5EKT2Dn2aVsxXOWdZEHv4mZ+CwL7d3ZKJD0uEB4MN
         fZ5A==
X-Gm-Message-State: AHQUAuZzV0QJN3hF1Ct4OhnKGSnziA7L32fpZfr7g2kqz0EO4zsiT9c9
        p0YJKACJqE0CJ6RHjlLvXf2b1VR+JAo=
X-Google-Smtp-Source: AHgI3IZuoZebT1BjX1HLgCWQjKcov7+reGyBya5+nzIL/uXxlcs7adyWxO/qeQ3EMZimXNbbBKNIBA==
X-Received: by 2002:a9d:2af:: with SMTP id 44mr1810760otl.181.1550821932983;
        Thu, 21 Feb 2019 23:52:12 -0800 (PST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id e138sm366973oih.27.2019.02.21.23.52.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 23:52:12 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id a81so1021715oii.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 23:52:12 -0800 (PST)
X-Received: by 2002:aca:5b06:: with SMTP id p6mr1757810oib.26.1550821587973;
 Thu, 21 Feb 2019 23:46:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1862a43851950ddee041d53669f8979aba863c38.1550672228.git-series.maxime.ripard@bootlin.com>
 <9817c9875638ed2484d61e6e128e2551cf3bda4c.1550672228.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <9817c9875638ed2484d61e6e128e2551cf3bda4c.1550672228.git-series.maxime.ripard@bootlin.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 22 Feb 2019 16:46:17 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D3CVQQDkP3uKM6dYkmfsLohXcdjG0wMMLukFf-D=TCsw@mail.gmail.com>
Message-ID: <CAAFQd5D3CVQQDkP3uKM6dYkmfsLohXcdjG0wMMLukFf-D=TCsw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        jenskuske@gmail.com, Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wed, Feb 20, 2019 at 11:17 PM Maxime Ripard
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
> Co-Developped-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Pawel Osciak <posciak@chromium.org>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks for the patch. Some comments inline.

[snip]
> +``V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS (struct)``
> +    Specifies the slice parameters (as extracted from the bitstream)
> +    for the associated H264 slice data. This includes the necessary
> +    parameters for configuring a stateless hardware decoding pipeline
> +    for H264.  The bitstream parameters are defined according to
> +    :ref:`h264`. Unless there's a specific comment, refer to the
> +    specification for the documentation of these fields, section 7.4.3
> +    "Slice Header Semantics".

Note that this is expected to be an array, with entries for all the
slices included in the bitstream buffer.

> +
> +    .. note::
> +
> +       This compound control is not yet part of the public kernel API and
> +       it is expected to change.
> +
> +.. c:type:: v4l2_ctrl_h264_slice_param
> +
> +.. cssclass:: longtable
> +
> +.. flat-table:: struct v4l2_ctrl_h264_slice_param
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u32
> +      - ``size``
> +      -
> +    * - __u32
> +      - ``header_bit_size``
> +      -
> +    * - __u16
> +      - ``first_mb_in_slice``
> +      -
> +    * - __u8
> +      - ``slice_type``
> +      -
> +    * - __u8
> +      - ``pic_parameter_set_id``
> +      -
> +    * - __u8
> +      - ``colour_plane_id``
> +      -
> +    * - __u8
> +      - ``redundant_pic_cnt``
> +      -
> +    * - __u16
> +      - ``frame_num``
> +      -
> +    * - __u16
> +      - ``idr_pic_id``
> +      -
> +    * - __u16
> +      - ``pic_order_cnt_lsb``
> +      -
> +    * - __s32
> +      - ``delta_pic_order_cnt_bottom``
> +      -
> +    * - __s32
> +      - ``delta_pic_order_cnt0``
> +      -
> +    * - __s32
> +      - ``delta_pic_order_cnt1``
> +      -
> +    * - struct :c:type:`v4l2_h264_pred_weight_table`
> +      - ``pred_weight_table``
> +      -
> +    * - __u32
> +      - ``dec_ref_pic_marking_bit_size``
> +      -
> +    * - __u32
> +      - ``pic_order_cnt_bit_size``
> +      -
> +    * - __u8
> +      - ``cabac_init_idc``
> +      -
> +    * - __s8
> +      - ``slice_qp_delta``
> +      -
> +    * - __s8
> +      - ``slice_qs_delta``
> +      -
> +    * - __u8
> +      - ``disable_deblocking_filter_idc``
> +      -
> +    * - __s8
> +      - ``slice_alpha_c0_offset_div2``
> +      -
> +    * - __s8
> +      - ``slice_beta_offset_div2``
> +      -
> +    * - __u8
> +      - ``num_ref_idx_l0_active_minus1``
> +      -
> +    * - __u8
> +      - ``num_ref_idx_l1_active_minus1``
> +      -
> +    * - __u32
> +      - ``slice_group_change_cycle``
> +      -
> +    * - __u8
> +      - ``ref_pic_list0[32]``
> +      -
> +    * - __u8
> +      - ``ref_pic_list1[32]``
> +      -

Should we explicitly document that these are the lists after applying
the per-slice modifications, as opposed to the original order from
v4l2_ctrl_h264_decode_param?

[snip]
> +    * .. _V4L2-PIX-FMT-H264-SLICE:
> +
> +      - ``V4L2_PIX_FMT_H264_SLICE``
> +      - 'S264'
> +      - H264 parsed slice data, as extracted from the H264 bitstream.
> +       This format is adapted for stateless video decoders that
> +       implement an H264 pipeline (using the :ref:`codec` and
> +       :ref:`media-request-api`).  Metadata associated with the frame
> +       to decode are required to be passed through the
> +       ``V4L2_CID_MPEG_VIDEO_H264_SPS``,
> +       ``V4L2_CID_MPEG_VIDEO_H264_PPS``,
> +       ``V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS`` and
> +       ``V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS`` controls and
> +       scaling matrices can optionally be specified through the
> +       ``V4L2_CID_MPEG_VIDEO_H264_SCALING_MATRIX`` control.  See the
> +       :ref:`associated Codec Control IDs <v4l2-mpeg-h264>`.
> +       Exactly one output and one capture buffer must be provided for
> +       use with this pixel format. The output buffer must contain the
> +       appropriate number of macroblocks to decode a full
> +       corresponding frame to the matching capture buffer.

What does it mean that a control can be optionally specified? A
control always has a value, so how do we decide that it was specified
or not? Should we have another control (or flag) that selects whether
to use the control? How is it better than just having the control
initialized with the default scaling matrix and always using it?

[snip]

> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 9a920f071ff9..6443ae53597f 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -653,6 +653,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /* H264 with start codes */
>  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /* H264 without start codes */
>  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /* H264 MVC */
> +#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */

Are we okay with adding here already, without going through staging first?

Best regards,
Tomasz
