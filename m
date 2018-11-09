Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BE0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598BA20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WSQ27YoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598BA20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeKIULv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:11:51 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44548 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeKIULv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:11:51 -0500
Received: by mail-yw1-f66.google.com with SMTP id k6-v6so1402817ywa.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFF4LJwGLa4raDTcemTqAiKKZx5qIFbJw1bPd62m7+E=;
        b=WSQ27YoGBbStVQxtoEUtlgpQbtyMp3iQWr8HU25ZXF+S9Ec6ptQL29Z30Z84B88v+0
         k6+tQ/VDnisReBSKDG1RaQ1hz0+G3xuDJC6KwNYW+QmhoX4Ep9hUl/7xVmR+HBDkQk15
         evFWnVU8GnSepX6DxUm9X0gXyKrgxwe8MLMHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFF4LJwGLa4raDTcemTqAiKKZx5qIFbJw1bPd62m7+E=;
        b=qM2jT8rxkj6wBxha2yOPzMEEj0BQU28CR1RZ5pB+QnvdkXfWeCW+qF2hUIwVCHe48m
         BCDqvYmswEmAz0Ymm8hzLLA5SHLjn6zzDzVmGCS5K+l/dOSlWueS2h5C7TgB25yNZEd2
         fpWm6Dg7pOFZlOjexeyK8dUdJ26BCLLwc2XovYeOVsIcHxWDNFUm4iWp92HVxN+1Cu/R
         4ogS/DoXIl7CF3W8EZFv3Ce66Zul4Buz6g8xdGclvSrQOVBcmHl7Wr0rCROtUKmSR+7k
         ShbdM1ZbKyBwiIzIsUxQhaTyjE2tXwMrIcm8Lp4dh0wIOEurT0FAEk/glKuK+VpfMK0e
         gt4w==
X-Gm-Message-State: AGRZ1gJ6CZ3vK4N38fB7wDOlgpq3m6YVgayRQzovuLqs1T+NlZCGBMHl
        1PssADMDpDLvH6l0oBgdOiLfZAaJPIW2nw==
X-Google-Smtp-Source: AJdET5c7Aid2GuaxhOnHDcM8jPdalbZzyJAKfBiCBJ0vPN7nrSbClxVNKJxSjcyT7Nl4qjNNwyFnYA==
X-Received: by 2002:a81:3802:: with SMTP id f2-v6mr7418499ywa.81.1541759511512;
        Fri, 09 Nov 2018 02:31:51 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id s83-v6sm3292545yws.33.2018.11.09.02.31.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 02:31:50 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id g192-v6so856312ybf.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:31:49 -0800 (PST)
X-Received: by 2002:a25:d64d:: with SMTP id n74-v6mr7966551ybg.204.1541759509040;
 Fri, 09 Nov 2018 02:31:49 -0800 (PST)
MIME-Version: 1.0
References: <1541749141-6989-1-git-send-email-mgottam@codeaurora.org>
 <CAAFQd5CwhPTmh4kF6O23Os2tihaWEez1SM=Th6BGkf_wo_LYDA@mail.gmail.com> <be2906d9d9c3f4618d21d4adef662d75@codeaurora.org>
In-Reply-To: <be2906d9d9c3f4618d21d4adef662d75@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 9 Nov 2018 19:31:35 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DE4ajq6HxHhKjYFHaqFpBXJdWNcv3Qr95B9dBP=zGsJQ@mail.gmail.com>
Message-ID: <CAAFQd5DE4ajq6HxHhKjYFHaqFpBXJdWNcv3Qr95B9dBP=zGsJQ@mail.gmail.com>
Subject: Re: [PATCH v2] media: venus: add support for selection rectangles
To:     mgottam@codeaurora.org
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

Hi Malathi,

On Fri, Nov 9, 2018 at 6:20 PM <mgottam@codeaurora.org> wrote:
>
> On 2018-11-09 07:56, Tomasz Figa wrote:
> > Hi Malathi,
> >
> > On Fri, Nov 9, 2018 at 4:39 PM Malathi Gottam <mgottam@codeaurora.org>
> > wrote:
> >>
> >> Handles target type crop by setting the new active rectangle
> >> to hardware. The new rectangle should be within YUV size.
> >>
> >> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> >> ---
> >>  drivers/media/platform/qcom/venus/venc.c | 26
> >> ++++++++++++++++++++++----
> >>  1 file changed, 22 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/venus/venc.c
> >> b/drivers/media/platform/qcom/venus/venc.c
> >> index ce85962..d26c129 100644
> >> --- a/drivers/media/platform/qcom/venus/venc.c
> >> +++ b/drivers/media/platform/qcom/venus/venc.c
> >> @@ -478,16 +478,34 @@ static int venc_g_fmt(struct file *file, void
> >> *fh, struct v4l2_format *f)
> >>  venc_s_selection(struct file *file, void *fh, struct v4l2_selection
> >> *s)
> >>  {
> >>         struct venus_inst *inst = to_inst(file);
> >> +       int ret;
> >> +       u32 buftype;
> >>
> >>         if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
> >>                 return -EINVAL;
> >>
> >>         switch (s->target) {
> >>         case V4L2_SEL_TGT_CROP:
> >> -               if (s->r.width != inst->out_width ||
> >> -                   s->r.height != inst->out_height ||
> >> -                   s->r.top != 0 || s->r.left != 0)
> >> -                       return -EINVAL;
> >> +               if (s->r.left != 0) {
> >> +                       s->r.width += s->r.left;
> >> +                       s->r.left = 0;
> >> +               }
> >> +
> >> +               if (s->r.top != 0) {
> >> +                       s->r.height += s->r.top;
> >> +                       s->r.top = 0;
> >> +               }
> >> +
> >> +               if (s->r.width > inst->width)
> >> +                       s->r.width = inst->width;
> >> +               else
> >> +                       inst->width = s->r.width;
> >> +
> >> +               if (s->r.height > inst->height)
> >> +                       s->r.height = inst->height;
> >> +               else
> >> +                       inst->height = s->r.height;
> >> +
> >
> > From semantic point of view, it looks fine, but where is the rectangle
> > actually set to the hardware?
> >
> > Best regards,
> > Tomasz
>
> As this set selection call occurs before the hfi session initialization,
> for now we are holding these values in driver.
>
> As this call is followed by VIDIOC_REQBUFS(), as a part of this
> we have venc_init_session
>
> static int venc_init_session(struct venus_inst *inst)
> {
>         int ret;
>
>         ret = hfi_session_init(inst, inst->fmt_cap->pixfmt);
>         if (ret)
>                 return ret;
>
>         ret = venus_helper_set_input_resolution(inst, inst->width,
>                                                 inst->height);
>         if (ret)
>                 goto deinit;
>
>         ret = venus_helper_set_output_resolution(inst, inst->width,
>                                                  inst->height,
>                                                  HFI_BUFFER_OUTPUT);

Something sounds not right here. Shouldn't one of the width/height be
the OUPUT format and the other the selection CROP target rectangle?

>         if (ret)
>                 goto deinit;
>
>         ret = venus_helper_set_color_format(inst, inst->fmt_out->pixfmt);
>         if (ret)
>                 goto deinit;
>
>         ret = venc_set_properties(inst);
>
>
>  From here we set these values to hardware.

Okay, thanks for the explanation. In this case, we must return -EBUSY
if selection is attempted to be set after the session is initialized.

Best regards,
Tomasz
