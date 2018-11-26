Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA28EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8505820672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lOKenlEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8505820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeKZTPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:15:21 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45688 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeKZTPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:15:20 -0500
Received: by mail-oi1-f194.google.com with SMTP id b141so14992841oii.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ULT/Aj3Zmut/IPJW9QflK8qisZnF9iE79i+We+hGGCQ=;
        b=lOKenlEJXafNg1+6oykrACkn7SW8DK+pyKbWB6ddccYJs4ZOETkPeIR44ZjbNSMj9d
         3pdX0e7s/xSZrKI25kn4ZRBIzbTdCg/QjO2o816P7saopNfEHKow6nGq2t7yiPR402uU
         0K8C0HNeUws9pulm0FHLPz3uyrCADVK1QjGn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ULT/Aj3Zmut/IPJW9QflK8qisZnF9iE79i+We+hGGCQ=;
        b=d8/+I11sgoj4CNwf60O7A4BWLNBGP8/7nAsSkeiVMHI5YBGAnojNfiA5mSoAc5iKEk
         wKeatXK5Gft/0gL6mlomSnjqoxxj7arvboirOl8uo9hZdodz6HQOWi/ZXqcP1Q3Qxz3C
         bbEtWkdPBKBFnfX+HY5j329Dt67f+9wOO+P0qBKnWCQwAiehF3P7kVE8ztLkg10grdAU
         oeYMUeoJw/H5Hf1EiNE5bnL6H0Z0eNNKOBlCcxPDFVdnbQVt69Bqc/le6K2t7FtS012x
         EPPmJQqsV4DEcS7y5PveRrVDtZ/fwLwLWqx01UIXAdYe2uXxHIQESUEXVZqTFKolVvat
         xNEA==
X-Gm-Message-State: AGRZ1gKhuXYJuLEwQUlMtZYagIkxRSJFiedB3DH9EqIin0XcqeA8wcYc
        CAbV1ytKCoiUEYjA3Gy2WITZvTHxrTTXNw==
X-Google-Smtp-Source: AJdET5fjXdm9SLcoRMNMilJxkg6Sl6lAQPsOsNH2m3s6iBRv7iDHo0fRPkne7Nt22hH6cS1vRJKxtQ==
X-Received: by 2002:aca:220b:: with SMTP id b11mr13836398oic.87.1543220519096;
        Mon, 26 Nov 2018 00:21:59 -0800 (PST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id r203sm8273830oih.11.2018.11.26.00.21.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:21:58 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id u18so14998642oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:21:57 -0800 (PST)
X-Received: by 2002:aca:a60d:: with SMTP id p13mr15214453oie.2.1543220517187;
 Mon, 26 Nov 2018 00:21:57 -0800 (PST)
MIME-Version: 1.0
References: <1542696783-23016-1-git-send-email-mgottam@codeaurora.org>
In-Reply-To: <1542696783-23016-1-git-send-email-mgottam@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 26 Nov 2018 17:21:45 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWZ146=Ri12HyBRed4QUOGqDT4m90w2W5VwRhKW4ELCHA@mail.gmail.com>
Message-ID: <CAPBb6MWZ146=Ri12HyBRed4QUOGqDT4m90w2W5VwRhKW4ELCHA@mail.gmail.com>
Subject: Re: [PATCH v2] media: venus: amend buffer size for bitstream plane
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

Hi Malathi,

On Tue, Nov 20, 2018 at 3:53 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>
> Accept the buffer size requested by client and compare it
> against driver calculated size and set the maximum to
> bitstream plane.
>
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/venc.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index ce85962..ecfdbd6 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -303,6 +303,7 @@ static int venc_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
>         struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
>         struct v4l2_plane_pix_format *pfmt = pixmp->plane_fmt;
>         const struct venus_format *fmt;
> +       __u32 sizeimage;
>
>         memset(pfmt[0].reserved, 0, sizeof(pfmt[0].reserved));
>         memset(pixmp->reserved, 0, sizeof(pixmp->reserved));
> @@ -334,9 +335,10 @@ static int venc_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
>         pixmp->num_planes = fmt->num_planes;
>         pixmp->flags = 0;
>
> -       pfmt[0].sizeimage = venus_helper_get_framesz(pixmp->pixelformat,
> -                                                    pixmp->width,
> -                                                    pixmp->height);
> +       sizeimage = venus_helper_get_framesz(pixmp->pixelformat,
> +                                            pixmp->width,
> +                                            pixmp->height);
> +       pfmt[0].sizeimage = max(ALIGN(pfmt[0].sizeimage, SZ_4K), sizeimage);
>
>         if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>                 pfmt[0].bytesperline = ALIGN(pixmp->width, 128);
> @@ -408,8 +410,10 @@ static int venc_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
>
>         if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>                 inst->fmt_out = fmt;
> -       else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> +       else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>                 inst->fmt_cap = fmt;
> +               inst->output_buf_size = pixmp->plane_fmt[0].sizeimage;
> +       }
>
>         return 0;
>  }
> @@ -908,6 +912,7 @@ static int venc_queue_setup(struct vb2_queue *q,
>                 sizes[0] = venus_helper_get_framesz(inst->fmt_cap->pixfmt,
>                                                     inst->width,
>                                                     inst->height);
> +               sizes[0] = max(sizes[0], inst->output_buf_size);
>                 inst->output_buf_size = sizes[0];
>                 break;
>         default:

I think this should work, but don't we also need to do the same thing
for the decoder's OUTPUT queue?
