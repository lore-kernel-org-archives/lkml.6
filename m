Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB657C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10DC223B0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RqZEQD4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10DC223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeKLS2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:28:01 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42393 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeKLS2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:28:01 -0500
Received: by mail-oi1-f194.google.com with SMTP id x63-v6so6479258oix.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 00:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXyBZnjux6qw85Gu5V+pcDhp0sZwdQ7an3DixOIjaVw=;
        b=RqZEQD4AqvUCSMmNYOny3L0fxL5niilcOjyjHxvPMciKv9FEUekYoOW0E5FKeXEYu4
         6qrxsP6hlNtAtVlE1YDkIvhq22aH2TwqRZk/K+NUEvi1OQEFqYodCOyNgZe2HOGy0rxB
         MlkqPNclrP8GLWKXm3seIrpR9zIVnW5+ei+sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXyBZnjux6qw85Gu5V+pcDhp0sZwdQ7an3DixOIjaVw=;
        b=XIBNkYrfVVCRCDaRARW18QOAQh9WsDlRZXG/oXYnqCCPwSastvhLC07pyi1047s82Z
         AbVFLTBiEHVJYhssA4c3lAtEZLZQUVb6e241WrxXGeG0A8d4Q21VUzpUKDgeTSE2J/rp
         qr+OcygIOxRwn2q95UYS7vawUMhm7qPJgyjIgxje+sLDfG3uCG2d0orKeVb+yknZxlq5
         m1KCLYSR6HbAvzCm9LEQRtz8H+O6uzpVdL3d2INlaT93d4MWhWO7iRLjx/wLKjNjqiF8
         xGTl74vWc+vTUzO4ABS5ia4pQvXAWmr6opRZEgjcBiholaKgCmZ903mzqXOFiNvcibDw
         CVkw==
X-Gm-Message-State: AGRZ1gKOu6y7HTbPbLpgEtqyD9UJxRrlx5LipdkTePMLWP3TUTIKQZ7J
        Cbz9D0oAV4l3eY5FFQd7KAgWreasnq6lbg==
X-Google-Smtp-Source: AJdET5cU8kOHWN1QdUoBF5p7t7uuBCw5rBHZt41wvfhaO9gv3XRCNNpsV50/Tf6t/WHx4ttAKSYtsA==
X-Received: by 2002:aca:4dd4:: with SMTP id a203-v6mr34031oib.168.1542011751836;
        Mon, 12 Nov 2018 00:35:51 -0800 (PST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id n64-v6sm6012701oib.17.2018.11.12.00.35.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 00:35:50 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id w25so6497811otm.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 00:35:50 -0800 (PST)
X-Received: by 2002:a9d:6287:: with SMTP id x7mr32672otk.304.1542011749888;
 Mon, 12 Nov 2018 00:35:49 -0800 (PST)
MIME-Version: 1.0
References: <1541749141-6989-1-git-send-email-mgottam@codeaurora.org>
 <CAAFQd5CwhPTmh4kF6O23Os2tihaWEez1SM=Th6BGkf_wo_LYDA@mail.gmail.com>
 <be2906d9d9c3f4618d21d4adef662d75@codeaurora.org> <CAAFQd5DE4ajq6HxHhKjYFHaqFpBXJdWNcv3Qr95B9dBP=zGsJQ@mail.gmail.com>
In-Reply-To: <CAAFQd5DE4ajq6HxHhKjYFHaqFpBXJdWNcv3Qr95B9dBP=zGsJQ@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 12 Nov 2018 17:35:37 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUWieRTvrYR_UacVe-EAD1_VjTMehL7J2P=Ni8W7ELsXw@mail.gmail.com>
Message-ID: <CAPBb6MUWieRTvrYR_UacVe-EAD1_VjTMehL7J2P=Ni8W7ELsXw@mail.gmail.com>
Subject: Re: [PATCH v2] media: venus: add support for selection rectangles
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     mgottam@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
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

On Fri, Nov 9, 2018 at 7:31 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi Malathi,
>
> On Fri, Nov 9, 2018 at 6:20 PM <mgottam@codeaurora.org> wrote:
> >
> > On 2018-11-09 07:56, Tomasz Figa wrote:
> > > Hi Malathi,
> > >
> > > On Fri, Nov 9, 2018 at 4:39 PM Malathi Gottam <mgottam@codeaurora.org>
> > > wrote:
> > >>
> > >> Handles target type crop by setting the new active rectangle
> > >> to hardware. The new rectangle should be within YUV size.
> > >>
> > >> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> > >> ---
> > >>  drivers/media/platform/qcom/venus/venc.c | 26
> > >> ++++++++++++++++++++++----
> > >>  1 file changed, 22 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/drivers/media/platform/qcom/venus/venc.c
> > >> b/drivers/media/platform/qcom/venus/venc.c
> > >> index ce85962..d26c129 100644
> > >> --- a/drivers/media/platform/qcom/venus/venc.c
> > >> +++ b/drivers/media/platform/qcom/venus/venc.c
> > >> @@ -478,16 +478,34 @@ static int venc_g_fmt(struct file *file, void
> > >> *fh, struct v4l2_format *f)
> > >>  venc_s_selection(struct file *file, void *fh, struct v4l2_selection
> > >> *s)
> > >>  {
> > >>         struct venus_inst *inst = to_inst(file);
> > >> +       int ret;
> > >> +       u32 buftype;

Looks like these two variables are not used anymore?

> > >>
> > >>         if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
> > >>                 return -EINVAL;
> > >>
> > >>         switch (s->target) {
> > >>         case V4L2_SEL_TGT_CROP:
> > >> -               if (s->r.width != inst->out_width ||
> > >> -                   s->r.height != inst->out_height ||
> > >> -                   s->r.top != 0 || s->r.left != 0)
> > >> -                       return -EINVAL;
> > >> +               if (s->r.left != 0) {
> > >> +                       s->r.width += s->r.left;
> > >> +                       s->r.left = 0;
> > >> +               }
> > >> +
> > >> +               if (s->r.top != 0) {
> > >> +                       s->r.height += s->r.top;
> > >> +                       s->r.top = 0;
> > >> +               }
> > >> +
> > >> +               if (s->r.width > inst->width)
> > >> +                       s->r.width = inst->width;
> > >> +               else
> > >> +                       inst->width = s->r.width;
> > >> +
> > >> +               if (s->r.height > inst->height)
> > >> +                       s->r.height = inst->height;
> > >> +               else
> > >> +                       inst->height = s->r.height;
> > >> +
> > >
> > > From semantic point of view, it looks fine, but where is the rectangle
> > > actually set to the hardware?
> > >
> > > Best regards,
> > > Tomasz
> >
> > As this set selection call occurs before the hfi session initialization,
> > for now we are holding these values in driver.
> >
> > As this call is followed by VIDIOC_REQBUFS(), as a part of this
> > we have venc_init_session
> >
> > static int venc_init_session(struct venus_inst *inst)
> > {
> >         int ret;
> >
> >         ret = hfi_session_init(inst, inst->fmt_cap->pixfmt);
> >         if (ret)
> >                 return ret;
> >
> >         ret = venus_helper_set_input_resolution(inst, inst->width,
> >                                                 inst->height);
> >         if (ret)
> >                 goto deinit;
> >
> >         ret = venus_helper_set_output_resolution(inst, inst->width,
> >                                                  inst->height,
> >                                                  HFI_BUFFER_OUTPUT);
>
> Something sounds not right here. Shouldn't one of the width/height be
> the OUPUT format and the other the selection CROP target rectangle?

Yeah, I don't see where the stride of the input (from HFI perspective)
buffer is set, so unless I missed something that would not capture the
correct part of the buffer.

Also doesn't Venus support non-zero left and top parameters for the
selection rectangle?
