Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D371CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D1223CA7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wjf9358z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D1223CA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933953AbeGBJa1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:30:27 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:40124 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933453AbeGBJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:30:24 -0400
Received: by mail-yb0-f194.google.com with SMTP id y11-v6so1350984ybm.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 02:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QwG59Y4SyS5DN9V37rL+oOQ9FcbHkbYhl1mEdNZ+zHw=;
        b=Wjf9358z5Sl7IQdPBmtoa1bha5mA/7DLjtHkJqQ1A6I3jpL54JG7cuU4sxiEBD1dTu
         DK0pJY3M4KKHTkpP6v8JASSy9WXDNlqmmmLh/Qm1YWWFHh/OTEBBVLYqPK+tebokAgBQ
         ThUvNesBjA3mZ7UBFJyiILzml9SgA/a0bY3Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QwG59Y4SyS5DN9V37rL+oOQ9FcbHkbYhl1mEdNZ+zHw=;
        b=XZIwp+uEeJP4SO9kX/y2ur2JBOABDySuan03Ebum3yUwU99MWmAlGtjhDNcszEos5o
         Gpb4sGRdyPH016nQBAsmtraQarlXnRzdc5FnUarOnrfvZ2QM5rhXh7cBg+4pYir3PmrR
         pnyIpZi7+pFLTFgPow+OA5i+np0MMlJVZ665ipshdKYsRJAwi4hBNzqLbFjIudc9TWoS
         avlWFUskzofB5FBkiob5MZBMzFyXOZgMNXk7OgA8Colm0wG1krMVfVp5dOarNhKyYEru
         d+4zFGkjEuRu7GaS0ICV+QNwhDxFHVFpAB1HiVaQQX9a20SsUONrjcu2B0WTLb3ssZoy
         a85A==
X-Gm-Message-State: APt69E2N+R4U1Qn8vRot7Gdgaq423VKnpo+mpaRi+MqJBJVnXbkC6Wif
        RDzShHhlRZRKL7sr/wWKc+k5aUHmi/g=
X-Google-Smtp-Source: AAOMgpcYYHT7tqppfvAeUNVKpMi47yZvz42Cq99WN5HyVGfaeYEqU8fJDV/Lrib1/c4DyvXL8DD53Q==
X-Received: by 2002:a25:b6cd:: with SMTP id f13-v6mr6688714ybm.506.1530523823553;
        Mon, 02 Jul 2018 02:30:23 -0700 (PDT)
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com. [209.85.161.181])
        by smtp.gmail.com with ESMTPSA id q131-v6sm8207341ywq.8.2018.07.02.02.30.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 02:30:22 -0700 (PDT)
Received: by mail-yw0-f181.google.com with SMTP id w76-v6so4048215ywg.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 02:30:22 -0700 (PDT)
X-Received: by 2002:a81:6c04:: with SMTP id h4-v6mr8363494ywc.273.1530523821716;
 Mon, 02 Jul 2018 02:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
 <20180515075859.17217-28-stanimir.varbanov@linaro.org> <CAAFQd5Cyk2=YG+LVGt0qEcrRGdarpHJDJ73AzG1iWBbyhr+nAA@mail.gmail.com>
In-Reply-To: <CAAFQd5Cyk2=YG+LVGt0qEcrRGdarpHJDJ73AzG1iWBbyhr+nAA@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 2 Jul 2018 18:30:10 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C=__+qTXsCtr7uS+7T6Dpgpeh8m6TuNEiYe5W2K2gaSw@mail.gmail.com>
Message-ID: <CAAFQd5C=__+qTXsCtr7uS+7T6Dpgpeh8m6TuNEiYe5W2K2gaSw@mail.gmail.com>
Subject: Re: [PATCH v2 27/29] venus: implementing multi-stream support
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

On Thu, May 31, 2018 at 6:51 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Tue, May 15, 2018 at 5:00 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
> >
> > This is implementing a multi-stream decoder support. The multi
> > stream gives an option to use the secondary decoder output
> > with different raw format (or the same in case of crop).
> >
> > Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> > ---
> >  drivers/media/platform/qcom/venus/core.h    |   1 +
> >  drivers/media/platform/qcom/venus/helpers.c | 204 +++++++++++++++++++++++++++-
> >  drivers/media/platform/qcom/venus/helpers.h |   6 +
> >  drivers/media/platform/qcom/venus/vdec.c    |  91 ++++++++++++-
> >  drivers/media/platform/qcom/venus/venc.c    |   1 +
> >  5 files changed, 299 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> > index 4d6c05f156c4..85e66e2dd672 100644
> > --- a/drivers/media/platform/qcom/venus/core.h
> > +++ b/drivers/media/platform/qcom/venus/core.h
> > @@ -259,6 +259,7 @@ struct venus_inst {
> >         struct list_head list;
> >         struct mutex lock;
> >         struct venus_core *core;
> > +       struct list_head dpbbufs;
> >         struct list_head internalbufs;
> >         struct list_head registeredbufs;
> >         struct list_head delayed_process;
> > diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> > index ed569705ecac..87dcf9973e6f 100644
> > --- a/drivers/media/platform/qcom/venus/helpers.c
> > +++ b/drivers/media/platform/qcom/venus/helpers.c
> > @@ -85,6 +85,112 @@ bool venus_helper_check_codec(struct venus_inst *inst, u32 v4l2_pixfmt)
> >  }
> >  EXPORT_SYMBOL_GPL(venus_helper_check_codec);
> >
> > +static int venus_helper_queue_dpb_bufs(struct venus_inst *inst)
> > +{
> > +       struct intbuf *buf;
> > +       int ret = 0;
> > +
> > +       if (list_empty(&inst->dpbbufs))
> > +               return 0;
>
> Does this special case give us anything other than few more source lines?
>
> > +
> > +       list_for_each_entry(buf, &inst->dpbbufs, list) {
> > +               struct hfi_frame_data fdata;
> > +
> > +               memset(&fdata, 0, sizeof(fdata));
> > +               fdata.alloc_len = buf->size;
> > +               fdata.device_addr = buf->da;
> > +               fdata.buffer_type = buf->type;
> > +
> > +               ret = hfi_session_process_buf(inst, &fdata);
> > +               if (ret)
> > +                       goto fail;
> > +       }
> > +
> > +fail:
> > +       return ret;
> > +}
> > +
> > +int venus_helper_free_dpb_bufs(struct venus_inst *inst)
> > +{
> > +       struct intbuf *buf, *n;
> > +
> > +       if (list_empty(&inst->dpbbufs))
> > +               return 0;
>
> Ditto.
>
> > +
> > +       list_for_each_entry_safe(buf, n, &inst->dpbbufs, list) {
> > +               list_del_init(&buf->list);
> > +               dma_free_attrs(inst->core->dev, buf->size, buf->va, buf->da,
> > +                              buf->attrs);
> > +               kfree(buf);
> > +       }
> > +
> > +       INIT_LIST_HEAD(&inst->dpbbufs);
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(venus_helper_free_dpb_bufs);
> [snip]
> > +int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
> > +                             u32 *out_fmt, u32 *out2_fmt, bool ubwc)
> > +{
> > +       struct venus_core *core = inst->core;
> > +       struct venus_caps *caps;
> > +       u32 ubwc_fmt, fmt = to_hfi_raw_fmt(v4l2_fmt);
> > +       bool found, found_ubwc;
> > +
> > +       *out_fmt = *out2_fmt = 0;
> > +
> > +       if (!fmt)
> > +               return -EINVAL;
> > +
> > +       caps = venus_caps_by_codec(core, inst->hfi_codec, inst->session_type);
> > +       if (!caps)
> > +               return -EINVAL;
> > +
> > +       if (ubwc) {
> > +               ubwc_fmt = fmt | HFI_COLOR_FORMAT_UBWC_BASE;
>
> Does the UBWC base format have to be the same as fmt? Looking at
> HFI_COLOR_FORMAT_* macros, UBWC variants seem to exist only for few
> selected raw formats, for example there is none for NV21.

Ping.

None of the comments I posted above have been addressed in v4.

Best regards,
Tomasz
