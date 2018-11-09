Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FB5C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AAF20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DC638u/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AAF20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeKIRgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:36:00 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43857 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeKIRgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:36:00 -0500
Received: by mail-yw1-f67.google.com with SMTP id j75-v6so1276371ywj.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 23:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEPp+EwU9LiR+ySjrZWVA5o0UEDKTJdJ7RvMc4OtLpI=;
        b=DC638u/nz2Oouwn+qJMXqycF4jVSOEnNnm2sNTK6K+aGBXbIqL0ng1JeDKvp6z/ZCT
         joljSAlL5K4Lf/R1oY79XY1GEGJZsgCMtz0FEdeMM1ailLWDSgCSyMSdcSMeBA+LdR1q
         lWLI/GFLxeLZslngYfP7I7glYT688HyIylYig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEPp+EwU9LiR+ySjrZWVA5o0UEDKTJdJ7RvMc4OtLpI=;
        b=SOWm3g60FP97BlB8+14sAyNcnmGoTvZj8x5e14WlwLCTdPO52QYeKCLaYe0oMBOzjx
         a6dF/grqHa+lUh3RKEI9/7AwnRgbfYX9kV0VQCGTuNHY42viD/SzUM0B3BdV7CkInnkr
         Ssxwob+D/2CKvsZmyvX6yj9wRA3QIr5DS8BZ069QBWv8STgE+dDnets3il0+Lp/cLWu8
         Zr/f6qV+dl/fhLzW5S9QIpjdMYprsRoR0K3MBtkv1KIdhJ5H/vv3i6I+CBUIewB6IfKM
         2eMs3loEFaLIYo5LjbBjfEv8bB23vIx3oPfGRYBSnizATgLknb+y97q5bRRcw8E6Bp0/
         t19Q==
X-Gm-Message-State: AGRZ1gKan/XRHH2EhSxaaKdmkwIuwt3G41oyQVMIis3uAil6e8a1GKki
        jVPyxY8N3bPhv2lawepi2Q2PakEHE9E=
X-Google-Smtp-Source: AJdET5eB19MicaI2A5Pe6NrIWq1bLEzTEf8hFbIu9+p6LoQqMI/MxO9fxFu+/ZBPqCMtqaGl+CZQvg==
X-Received: by 2002:a81:4d86:: with SMTP id a128-v6mr7147071ywb.434.1541750195988;
        Thu, 08 Nov 2018 23:56:35 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 203-v6sm1858021ywz.87.2018.11.08.23.56.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 23:56:35 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id i17-v6so673125ybp.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 23:56:34 -0800 (PST)
X-Received: by 2002:a25:b3c9:: with SMTP id x9-v6mr7577418ybf.508.1541750193497;
 Thu, 08 Nov 2018 23:56:33 -0800 (PST)
MIME-Version: 1.0
References: <1541749141-6989-1-git-send-email-mgottam@codeaurora.org>
In-Reply-To: <1541749141-6989-1-git-send-email-mgottam@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 9 Nov 2018 16:56:21 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CwhPTmh4kF6O23Os2tihaWEez1SM=Th6BGkf_wo_LYDA@mail.gmail.com>
Message-ID: <CAAFQd5CwhPTmh4kF6O23Os2tihaWEez1SM=Th6BGkf_wo_LYDA@mail.gmail.com>
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

On Fri, Nov 9, 2018 at 4:39 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>
> Handles target type crop by setting the new active rectangle
> to hardware. The new rectangle should be within YUV size.
>
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/venc.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index ce85962..d26c129 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -478,16 +478,34 @@ static int venc_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
>  venc_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
>  {
>         struct venus_inst *inst = to_inst(file);
> +       int ret;
> +       u32 buftype;
>
>         if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
>                 return -EINVAL;
>
>         switch (s->target) {
>         case V4L2_SEL_TGT_CROP:
> -               if (s->r.width != inst->out_width ||
> -                   s->r.height != inst->out_height ||
> -                   s->r.top != 0 || s->r.left != 0)
> -                       return -EINVAL;
> +               if (s->r.left != 0) {
> +                       s->r.width += s->r.left;
> +                       s->r.left = 0;
> +               }
> +
> +               if (s->r.top != 0) {
> +                       s->r.height += s->r.top;
> +                       s->r.top = 0;
> +               }
> +
> +               if (s->r.width > inst->width)
> +                       s->r.width = inst->width;
> +               else
> +                       inst->width = s->r.width;
> +
> +               if (s->r.height > inst->height)
> +                       s->r.height = inst->height;
> +               else
> +                       inst->height = s->r.height;
> +

From semantic point of view, it looks fine, but where is the rectangle
actually set to the hardware?

Best regards,
Tomasz
