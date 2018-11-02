Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D0CC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9229520831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h2PfQA4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9229520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeKBMWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 08:22:05 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39949 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbeKBMWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 08:22:05 -0400
Received: by mail-yb1-f193.google.com with SMTP id g9-v6so246580ybh.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 20:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pD5U9pop07iWpVyLITLK4glFK/dtNI6e/DeM9wmlbOI=;
        b=h2PfQA4sMTA+M7wtj5hxelb35dC2f1cYs840AFl28QXhW3ywiPyZUPDrQ4jRHtZz7R
         Vjh7u8+jlKZ06zt/hb97nXHKhsJFU/yObKZnivllv0sMcsV4Qy3ezKhe5TdP6a76SYt5
         ImFyGsBZRjJw+IJNAn8ScxotjTKAgCVtmP+BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pD5U9pop07iWpVyLITLK4glFK/dtNI6e/DeM9wmlbOI=;
        b=LcRqv5qz7EatcfflojejXQXWyQ/hCoZ0EeuaXUgYIJKM0tQbnLLMjhI6CFqcGKDDqZ
         wzX1fR6mYUKdHI0AtJOSlfYi04ze7bs/n8+inEMH8yQsVCIpyZBZfFDHcvquWcBD05Kq
         Sb+twqncRyfKCCttplk3LKAKKBEeC4jKREpn9z7hCWZgGRpNxfAxOKPTEXht3jYYILmb
         8j62tREKNWMuE+DZaMjGV8qtnIDlkWI5nPAEE3ac+FPONU0lvg5EO63I12z8Jub0QQXe
         G7e8nLLg57kf24m5qQ1OSkG9gTnGyWgvdi+tIKuPIUNG2cXwf7pZpPjbsdaNbnki46dx
         prxA==
X-Gm-Message-State: AGRZ1gJdOJuMLl9nG6tFiSb4ijPBdaDoHocvEP8Y/4aXMhPz/q4hZHuC
        A7V92hATiSF5tDTvrISYETTr3X5jSks=
X-Google-Smtp-Source: AJdET5fGdHFk7nMpBUkFIgIMFHN6kYy3Tenr9rDJWh2CG6Z4jgOdvgTkwphwCP9iVD0qFtczKN9XmA==
X-Received: by 2002:a25:6c08:: with SMTP id h8-v6mr7929346ybc.452.1541128590819;
        Thu, 01 Nov 2018 20:16:30 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id i189-v6sm6444117ywb.23.2018.11.01.20.16.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 20:16:29 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id j75-v6so235160ywj.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 20:16:29 -0700 (PDT)
X-Received: by 2002:a0d:ff83:: with SMTP id p125-v6mr9970016ywf.65.1541128588983;
 Thu, 01 Nov 2018 20:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <1539071603-1588-1-git-send-email-mgottam@codeaurora.org>
 <0e0f689e-f6e3-73a6-e145-deb2ef7cafc8@linaro.org> <5037ca4b0dd0de80750e35ca889d4225@codeaurora.org>
 <4ccc50dc-c819-ca49-11d2-415053c02c0a@linaro.org>
In-Reply-To: <4ccc50dc-c819-ca49-11d2-415053c02c0a@linaro.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 2 Nov 2018 12:16:17 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AgQNZpNfAf_aoZfqzpZj7iohCKaBO0t4bntL2q1SyVhg@mail.gmail.com>
Message-ID: <CAAFQd5AgQNZpNfAf_aoZfqzpZj7iohCKaBO0t4bntL2q1SyVhg@mail.gmail.com>
Subject: Re: [PATCH] media: venus: add support for selection rectangles
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     mgottam@codeaurora.org, Hans Verkuil <hverkuil@xs4all.nl>,
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

On Fri, Nov 2, 2018 at 12:02 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Malathi,
>
> On 11/1/18 3:10 PM, mgottam@codeaurora.org wrote:
> > On 2018-10-16 15:11, Stanimir Varbanov wrote:
> >> Hi Malathi,
> >>
> >> On 10/09/2018 10:53 AM, Malathi Gottam wrote:
> >>> Handles target type crop by setting the new active rectangle
> >>> to hardware. The new rectangle should be within YUV size.
> >>>
> >>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> >>> ---
> >>>  drivers/media/platform/qcom/venus/venc.c | 19 +++++++++++++++++--
> >>>  1 file changed, 17 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/media/platform/qcom/venus/venc.c
> >>> b/drivers/media/platform/qcom/venus/venc.c
> >>> index 3f50cd0..754c19a 100644
> >>> --- a/drivers/media/platform/qcom/venus/venc.c
> >>> +++ b/drivers/media/platform/qcom/venus/venc.c
> >>> @@ -478,16 +478,31 @@ static int venc_g_fmt(struct file *file, void
> >>> *fh, struct v4l2_format *f)
> >>>  venc_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
> >>>  {
> >>>      struct venus_inst *inst = to_inst(file);
> >>> +    int ret;
> >>> +    u32 buftype;
> >>>
> >>>      if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
> >>>          return -EINVAL;
> >>>
> >>>      switch (s->target) {
> >>>      case V4L2_SEL_TGT_CROP:
> >>> -        if (s->r.width != inst->out_width ||
> >>> -            s->r.height != inst->out_height ||
> >>> +        if (s->r.width > inst->out_width ||
> >>> +            s->r.height > inst->out_height ||
> >>>              s->r.top != 0 || s->r.left != 0)
> >>>              return -EINVAL;

Note that returning -EINVAL is not what VIDIOC_S_SELECTION should do here.

As per the general V4L2 spec [1], VIDIOC_S_SELECTION is expected to
adjust the crop rectangle "as close as possible to the requested one".
In this case that would likely mean something like this:

if (s->r.left != 0) {
    s->r.width += s->r.left;
    s->r.left = 0;
}

if (s->r.top != 0) {
    s->r.height += s->r.top;
    s->r.top = 0;
}

if (s->r.width > inst->out_width)
    s->r.width = inst->out_width;

if (s->r.height > inst->out_height)
    s->r.height = inst->out_height;

[1] https://www.kernel.org/doc/html/latest/media/uapi/v4l/vidioc-g-selection.html

> >>> +        if (s->r.width != inst->width ||
> >>> +            s->r.height != inst->height) {
> >>> +            buftype = HFI_BUFFER_OUTPUT;
> >>> +            ret = venus_helper_set_output_resolution(inst,
> >>> +                                 s->r.width,
> >>> +                                 s->r.height,
> >>> +                                 buftype);
> >>
> >> I'm afraid that set_output_resolution cannot be called at any time. Do
> >> you think we can set it after start_session?
> >
> > Yes Stan, we can set output_resolution after the session has been
> > initialization.
> > As per the spec, this call s_selection is an optional step under
> > Initialization
> > procedure of encoder even before we request buffers.
>
> What spec you are referring to? The spec for the encoders [1] or
> something else.

For our convenience, Hans was nice enough to host a compiled version at:
https://hverkuil.home.xs4all.nl/request-api/uapi/v4l/dev-encoder.html

Best regards,
Tomasz
