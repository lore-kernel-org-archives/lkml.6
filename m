Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6784C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D25D2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="epr1XK9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D25D2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbeKNU7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:59:33 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42282 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKNU7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:59:32 -0500
Received: by mail-yb1-f194.google.com with SMTP id o204-v6so6691642yba.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 02:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KL9x3B0Js4Sv2qULrUPmfHSLOOa6blBCFs8qkCayAIw=;
        b=epr1XK9GshKXtbG22XDU4AVDsfsSK6GhR9tZ8/OYTMgjtJ2/n4rA1/2AlrMjsF3U+S
         oGInUER7nRXpaXyi+xUG81ICplFFAc8wvfNHnxvMa4fer4GRAaqSI5mEItuCD6iInOa9
         dzUTr8z7zyzP7Xb3efj/c3VhXW9022M4pNjVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KL9x3B0Js4Sv2qULrUPmfHSLOOa6blBCFs8qkCayAIw=;
        b=J9Sw9Rq/kIKdTEsqNCZBEdWudm54oPa5m1K9dsAdq1X1PttLIG3v60VwTsfMHaPFdV
         Sz8eC8QAib3K7B4/kf9KufrpI6KpQ4hK2yY6GUL3wwokXMooHz3POaKnRhTVcuHD6Tyd
         ZeB1OwLT6L8mbViXM1JngIFI+/NKxsqN+Rej1sSP9RyfTnPsU8GdgZigKFoUoaLeV1s0
         tFN59jeJ/niWqvZOJk17bAXyBIOf+08DY9a2VPUKkykTXQ+uLTMg9JncoQL66aUklDje
         3fNFHPCLrv1SaH0hofcS5tL+pA35msbUfDQl3pV5Aoxw+rDmJPqWF7+HlGQ2maYM5pz3
         7aMA==
X-Gm-Message-State: AGRZ1gK5NEvy1cbI2l+N1NVLy6ceTv0x782+W3y9+tLr8YuLB8kOaOC2
        vaWFFTTPdsOi/BqOFU680lOqzntfCsY=
X-Google-Smtp-Source: AJdET5embI56lxGm//0o18WFEAoBKg8gXz9gPxXfiqkQrIoEgAMzmp5ZGDpmkVcmL4d1cdAkYSQLbw==
X-Received: by 2002:a5b:c8f:: with SMTP id i15-v6mr996807ybq.404.1542193006821;
        Wed, 14 Nov 2018 02:56:46 -0800 (PST)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id n38-v6sm5970701ywh.100.2018.11.14.02.56.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 02:56:46 -0800 (PST)
Received: by mail-yw1-f43.google.com with SMTP id k6-v6so7051790ywa.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 02:56:45 -0800 (PST)
X-Received: by 2002:a81:4786:: with SMTP id u128-v6mr1056471ywa.164.1542193005265;
 Wed, 14 Nov 2018 02:56:45 -0800 (PST)
MIME-Version: 1.0
References: <1538222432-25894-1-git-send-email-sgorle@codeaurora.org> <1538222432-25894-3-git-send-email-sgorle@codeaurora.org>
In-Reply-To: <1538222432-25894-3-git-send-email-sgorle@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 14 Nov 2018 19:56:33 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D4p_1PGCYzeKTYJovS6PVA7rho0wj_knvr4Vm3gDOtTw@mail.gmail.com>
Message-ID: <CAAFQd5D4p_1PGCYzeKTYJovS6PVA7rho0wj_knvr4Vm3gDOtTw@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] media: venus: dynamically configure codec type
To:     sgorle@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 9:01 PM Srinu Gorle <sgorle@codeaurora.org> wrote:
>
> - currently video decoder instance is hardcoded to H.264 video format.
> - this change enables video decoder dynamically configure to
>   any supported video format.
>
> Signed-off-by: Srinu Gorle <sgorle@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 51 ++++++++++++++---------------
>  drivers/media/platform/qcom/venus/helpers.h |  1 +
>  drivers/media/platform/qcom/venus/vdec.c    |  2 ++
>  3 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 822a853..c82dbac 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -36,47 +36,44 @@ struct intbuf {
>         unsigned long attrs;
>  };
>
> -bool venus_helper_check_codec(struct venus_inst *inst, u32 v4l2_pixfmt)
> +u32 v4l2_venus_fmt(u32 pixfmt)
>  {
> -       struct venus_core *core = inst->core;
> -       u32 session_type = inst->session_type;
> -       u32 codec;
> -
> -       switch (v4l2_pixfmt) {
> +       switch (pixfmt) {
>         case V4L2_PIX_FMT_H264:
> -               codec = HFI_VIDEO_CODEC_H264;
> -               break;
> +       case V4L2_PIX_FMT_H264_NO_SC:
> +               return HFI_VIDEO_CODEC_H264;
>         case V4L2_PIX_FMT_H263:
> -               codec = HFI_VIDEO_CODEC_H263;
> -               break;
> +               return HFI_VIDEO_CODEC_H263;
>         case V4L2_PIX_FMT_MPEG1:
> -               codec = HFI_VIDEO_CODEC_MPEG1;
> -               break;
> +               return HFI_VIDEO_CODEC_MPEG1;
>         case V4L2_PIX_FMT_MPEG2:
> -               codec = HFI_VIDEO_CODEC_MPEG2;
> -               break;
> +               return HFI_VIDEO_CODEC_MPEG2;
>         case V4L2_PIX_FMT_MPEG4:
> -               codec = HFI_VIDEO_CODEC_MPEG4;
> -               break;
> +               return HFI_VIDEO_CODEC_MPEG4;
>         case V4L2_PIX_FMT_VC1_ANNEX_G:
>         case V4L2_PIX_FMT_VC1_ANNEX_L:
> -               codec = HFI_VIDEO_CODEC_VC1;
> -               break;
> +               return HFI_VIDEO_CODEC_VC1;
>         case V4L2_PIX_FMT_VP8:
> -               codec = HFI_VIDEO_CODEC_VP8;
> -               break;
> +               return HFI_VIDEO_CODEC_VP8;
>         case V4L2_PIX_FMT_VP9:
> -               codec = HFI_VIDEO_CODEC_VP9;
> -               break;
> +               return HFI_VIDEO_CODEC_VP9;
>         case V4L2_PIX_FMT_XVID:
> -               codec = HFI_VIDEO_CODEC_DIVX;
> -               break;
> +               return HFI_VIDEO_CODEC_DIVX;
>         case V4L2_PIX_FMT_HEVC:
> -               codec = HFI_VIDEO_CODEC_HEVC;
> -               break;
> +               return HFI_VIDEO_CODEC_HEVC;
>         default:
> -               return false;
> +               return 0;
>         }
> +}
> +EXPORT_SYMBOL_GPL(v4l2_venus_fmt);
> +
> +bool venus_helper_check_codec(struct venus_inst *inst, u32 v4l2_pixfmt)
> +{
> +       struct venus_core *core = inst->core;
> +       u32 session_type = inst->session_type;
> +       u32 codec;
> +
> +       codec = v4l2_venus_fmt(v4l2_pixfmt);
>
>         if (session_type == VIDC_SESSION_TYPE_ENC && core->enc_codecs & codec)
>                 return true;
> diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
> index 3de0c44..725831d 100644
> --- a/drivers/media/platform/qcom/venus/helpers.h
> +++ b/drivers/media/platform/qcom/venus/helpers.h
> @@ -19,6 +19,7 @@
>
>  struct venus_inst;
>
> +u32 v4l2_venus_fmt(u32 pixfmt);
>  bool venus_helper_check_codec(struct venus_inst *inst, u32 v4l2_pixfmt);
>  struct vb2_v4l2_buffer *venus_helper_find_buf(struct venus_inst *inst,
>                                               unsigned int type, u32 idx);
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 98675db..afe3b36 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -413,6 +413,8 @@ static int vdec_enum_framesizes(struct file *file, void *fh,
>                                   V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
>                 if (!fmt)
>                         return -EINVAL;
> +               inst->fmt_out = fmt;
> +               inst->hfi_codec = v4l2_venus_fmt(fmt->pixfmt);

That's wrong. ENUM_FRAMESIZES (and any other ENUM_* or G_* ioctl) must
not affect driver state or result in any other side effects.

Best regards,
Tomasz
