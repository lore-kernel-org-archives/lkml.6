Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E71FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029FD2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FnBE6FhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029FD2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeJLM5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 08:57:22 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51177 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeJLM5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 08:57:21 -0400
Received: by mail-it1-f195.google.com with SMTP id k206-v6so10970598ite.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 22:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wfp4Ic1O7db9L1K4SF92HAsTLJ1MQtlNTpKyWJSa8PI=;
        b=FnBE6FhEnYBpNuyT3voMpOl+Y/itCE4E9+G3F3i9sAD93oADT21ulaBT0ENpTjWIbu
         0u589tq5Fc0zCCrVZmLVWXIeTsD/e58AEJtEb6I0jrMsATVQ8jLNUjGRQWDFiCh0AkE8
         7MUrCcaHe5UNEFil/F59p26VQV1PBf7j/WoCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wfp4Ic1O7db9L1K4SF92HAsTLJ1MQtlNTpKyWJSa8PI=;
        b=nsyPe7YBJswHPzRVXBN6pbFtvPNjbbfUbudt6bTeAAAiJrtA5/zDStZK/ZkBCQjirI
         YBxd+2u3L4ekNOx1zu0SluDcNrbeo3/eAo52OTpk+Ioksi/54eS+tS2GXBiZpz5qbUPv
         PJe7ptSZJKdvqEP9rrflBADHtmFIzqAALiPrxr/Mvb17xNdpnk/i5nd1YoOAkG8tmEOH
         BvMARvxzm61g9LH/Qk0ARsvCJPHMYe6zUAqt7bIeCZnZOaaLXgzfc1F1to4JtMJCy7i1
         /4ttk8Kiuy/DEXqXH098fxm4cAGE8FB47AU+poMAPN8aYgBIggeHjZ7Bv1/TPHsHEwyc
         LHIQ==
X-Gm-Message-State: ABuFfojQvSfKoBQQVdHCnqa2HhMc0SyTwsODLzF6BIxT0WMAbn2OTXgE
        H4Pc1XlMD5F3QUnp7FOw6kj2U7alOJyqBg==
X-Google-Smtp-Source: ACcGV6151kg4wNi5mecPDozFVv+xRznN/Mm2YCb0qEryhEnJcKP+kbvCdOV3GxOvHwavsyrKIoMhaw==
X-Received: by 2002:a24:8789:: with SMTP id f131-v6mr3684419ite.27.1539321999714;
        Thu, 11 Oct 2018 22:26:39 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id y11-v6sm25232ioa.24.2018.10.11.22.26.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 22:26:38 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id w11-v6so8389314iob.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 22:26:38 -0700 (PDT)
X-Received: by 2002:a6b:9108:: with SMTP id t8-v6mr3635679iod.112.1539321997878;
 Thu, 11 Oct 2018 22:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <1539071634-1644-1-git-send-email-mgottam@codeaurora.org>
In-Reply-To: <1539071634-1644-1-git-send-email-mgottam@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 12 Oct 2018 14:26:26 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUt_V4zEKGcRYXRXNRVdjF2uspOvEj0T-dH6dBZ9ya9CA@mail.gmail.com>
Message-ID: <CAPBb6MUt_V4zEKGcRYXRXNRVdjF2uspOvEj0T-dH6dBZ9ya9CA@mail.gmail.com>
Subject: Re: [PATCH] media: venus: add support for key frame
To:     mgottam@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 4:54 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>
> When client requests for a keyframe, set the property
> to hardware to generate the sync frame.
>
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index 45910172..f332c8e 100644
> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> @@ -81,6 +81,8 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>         struct venc_controls *ctr = &inst->controls.enc;
>         u32 bframes;
>         int ret;
> +       void *ptr;
> +       u32 ptype;
>
>         switch (ctrl->id) {
>         case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
> @@ -173,6 +175,14 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>
>                 ctr->num_b_frames = bframes;
>                 break;
> +       case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
> +               ptype = HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME;
> +               ret = hfi_session_set_property(inst, ptype, ptr);

The test bot already said it, but ptr is passed to
hfi_session_set_property() uninitialized. And as can be expected the
call returns -EINVAL on my board.

Looking at other uses of HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME I
see that the packet sent to the firmware does not have room for an
argument, so I tried to pass NULL but got the same result.

> +

This newline is unnecessary.

> +               if (ret)
> +                       return ret;
> +
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -309,6 +319,9 @@ int venc_ctrl_init(struct venus_inst *inst)
>         v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
>                 V4L2_CID_MPEG_VIDEO_H264_I_PERIOD, 0, (1 << 16) - 1, 1, 0);
>
> +       v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> +                         V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME, 0, 0, 0, 0);
> +
>         ret = inst->ctrl_handler.error;
>         if (ret)
>                 goto err;
> --
> 1.9.1
>
