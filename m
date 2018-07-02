Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680CDC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195E825421
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V2mgs3Mf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195E825421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeGBMwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:52:49 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36041 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbeGBMwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:52:47 -0400
Received: by mail-yb0-f195.google.com with SMTP id s1-v6so5054256ybk.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MVsneobB1lxMJvVArWZrZDl8K1tFgDtXE39PLGNJqfo=;
        b=V2mgs3Mf/SKRfvUNgHDNE6yFqw4YigWKTu8h0eJsiQPf56LcGyYQoBqFZ97TIB0Zx+
         IDZt+/33dQGjEWmbIir0K1dS1tuQ1DbzWEZY3ZufhKgVIbvIAztgajb6mOxrDvcplf/I
         1EMoJH7br79PHMENfhD1Dd/h5okWo6kfsy33M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVsneobB1lxMJvVArWZrZDl8K1tFgDtXE39PLGNJqfo=;
        b=uIIsYqoib9IeP+gsENmr0rhEkSKhw9lhSzX26dlIF8zS1KL2APrMpzglW1tbZjyVl3
         oGHpTHXJLdK/XpGAuZ8pvSmT5rZFkkfKCH1Enm2BfLCn5FPI7UkoC1pK3moe9o257yxH
         BCX0IBq2jX2uXFb0bA/O/ucOPjJOhIAINteX5NxGItOcFKS9mNm2pzssSaZCNa6v6UNZ
         MrTyuvPMVDtfOrP9XxBQGQuZRPubPN0QAFxvT/CeLrjwUUMNjHedtn93mG0RIpjfMvtQ
         jATFM+8EYU4LBqitUglbIcnaIhaiuke5TP7Q7l2zPyP+Uj36EnIGnBY2FjipbUj1yz9c
         GAHA==
X-Gm-Message-State: APt69E3AaTV6zbjkKk4HAMB6J+szKf8ZPRZYolJoo6rpoRijTT7MikFm
        PjbemfF2o12e3xsxvhc32joFDJmWEuw=
X-Google-Smtp-Source: ADUXVKI40JIas1ndEWbWM78ngQJWXFfEX4sKSnuofRkbixCLa8rv8qDu+8FQJ65EkoOj8jWQh5wgFA==
X-Received: by 2002:a25:9d92:: with SMTP id v18-v6mr13448029ybp.363.1530535966993;
        Mon, 02 Jul 2018 05:52:46 -0700 (PDT)
Received: from mail-yw0-f170.google.com (mail-yw0-f170.google.com. [209.85.161.170])
        by smtp.gmail.com with ESMTPSA id p134-v6sm618811ywe.30.2018.07.02.05.52.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 05:52:46 -0700 (PDT)
Received: by mail-yw0-f170.google.com with SMTP id 81-v6so6620834ywb.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:52:45 -0700 (PDT)
X-Received: by 2002:a0d:ddc8:: with SMTP id g191-v6mr6103477ywe.145.1530535965420;
 Mon, 02 Jul 2018 05:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
 <20180515075859.17217-28-stanimir.varbanov@linaro.org> <CAAFQd5Cyk2=YG+LVGt0qEcrRGdarpHJDJ73AzG1iWBbyhr+nAA@mail.gmail.com>
 <394e5547-9b85-604f-ee9e-fdb5ea2f4237@linaro.org>
In-Reply-To: <394e5547-9b85-604f-ee9e-fdb5ea2f4237@linaro.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 2 Jul 2018 21:52:33 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AWEL9jQu=wh_uYFSGu+re-8ZrFZx4ftKDxbpb6mMNP2g@mail.gmail.com>
Message-ID: <CAAFQd5AWEL9jQu=wh_uYFSGu+re-8ZrFZx4ftKDxbpb6mMNP2g@mail.gmail.com>
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

On Mon, Jul 2, 2018 at 9:43 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Tomasz,
>
> On 05/31/2018 12:51 PM, Tomasz Figa wrote:
> > On Tue, May 15, 2018 at 5:00 PM Stanimir Varbanov
> > <stanimir.varbanov@linaro.org> wrote:
> >>
> >> This is implementing a multi-stream decoder support. The multi
> >> stream gives an option to use the secondary decoder output
> >> with different raw format (or the same in case of crop).
> >>
> >> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> >> ---
> >>  drivers/media/platform/qcom/venus/core.h    |   1 +
> >>  drivers/media/platform/qcom/venus/helpers.c | 204 +++++++++++++++++++++++++++-
> >>  drivers/media/platform/qcom/venus/helpers.h |   6 +
> >>  drivers/media/platform/qcom/venus/vdec.c    |  91 ++++++++++++-
> >>  drivers/media/platform/qcom/venus/venc.c    |   1 +
> >>  5 files changed, 299 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> >> index 4d6c05f156c4..85e66e2dd672 100644
> >> --- a/drivers/media/platform/qcom/venus/core.h
> >> +++ b/drivers/media/platform/qcom/venus/core.h
> >> @@ -259,6 +259,7 @@ struct venus_inst {
> >>         struct list_head list;
> >>         struct mutex lock;
> >>         struct venus_core *core;
> >> +       struct list_head dpbbufs;
> >>         struct list_head internalbufs;
> >>         struct list_head registeredbufs;
> >>         struct list_head delayed_process;
> >> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> >> index ed569705ecac..87dcf9973e6f 100644
> >> --- a/drivers/media/platform/qcom/venus/helpers.c
> >> +++ b/drivers/media/platform/qcom/venus/helpers.c
> >> @@ -85,6 +85,112 @@ bool venus_helper_check_codec(struct venus_inst *inst, u32 v4l2_pixfmt)
> >>  }
> >>  EXPORT_SYMBOL_GPL(venus_helper_check_codec);
> >>
> >> +static int venus_helper_queue_dpb_bufs(struct venus_inst *inst)
> >> +{
> >> +       struct intbuf *buf;
> >> +       int ret = 0;
> >> +
> >> +       if (list_empty(&inst->dpbbufs))
> >> +               return 0;
> >
> > Does this special case give us anything other than few more source lines?
>
> yes, thanks for spotting, will drop above lines here and below.
>
> >
> >> +
> >> +       list_for_each_entry(buf, &inst->dpbbufs, list) {
> >> +               struct hfi_frame_data fdata;
> >> +
> >> +               memset(&fdata, 0, sizeof(fdata));
> >> +               fdata.alloc_len = buf->size;
> >> +               fdata.device_addr = buf->da;
> >> +               fdata.buffer_type = buf->type;
> >> +
> >> +               ret = hfi_session_process_buf(inst, &fdata);
> >> +               if (ret)
> >> +                       goto fail;
> >> +       }
> >> +
> >> +fail:
> >> +       return ret;
> >> +}
> >> +
> >> +int venus_helper_free_dpb_bufs(struct venus_inst *inst)
> >> +{
> >> +       struct intbuf *buf, *n;
> >> +
> >> +       if (list_empty(&inst->dpbbufs))
> >> +               return 0;
> >
> > Ditto.
> >
> >> +
> >> +       list_for_each_entry_safe(buf, n, &inst->dpbbufs, list) {
> >> +               list_del_init(&buf->list);
> >> +               dma_free_attrs(inst->core->dev, buf->size, buf->va, buf->da,
> >> +                              buf->attrs);
> >> +               kfree(buf);
> >> +       }
> >> +
> >> +       INIT_LIST_HEAD(&inst->dpbbufs);
> >> +
> >> +       return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(venus_helper_free_dpb_bufs);
> > [snip]
> >> +int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
> >> +                             u32 *out_fmt, u32 *out2_fmt, bool ubwc)
> >> +{
> >> +       struct venus_core *core = inst->core;
> >> +       struct venus_caps *caps;
> >> +       u32 ubwc_fmt, fmt = to_hfi_raw_fmt(v4l2_fmt);
> >> +       bool found, found_ubwc;
> >> +
> >> +       *out_fmt = *out2_fmt = 0;
> >> +
> >> +       if (!fmt)
> >> +               return -EINVAL;
> >> +
> >> +       caps = venus_caps_by_codec(core, inst->hfi_codec, inst->session_type);
> >> +       if (!caps)
> >> +               return -EINVAL;
> >> +
> >> +       if (ubwc) {
> >> +               ubwc_fmt = fmt | HFI_COLOR_FORMAT_UBWC_BASE;
> >
> > Does the UBWC base format have to be the same as fmt? Looking at
> > HFI_COLOR_FORMAT_* macros, UBWC variants seem to exist only for few
> > selected raw formats, for example there is none for NV21.
>
> I think any raw format can have its UBWC variant. And yes we have only
> one macro but we are checking against parsed capabilities from firmware
> where the supported formats are stored.

Okay, thanks.

Best regards,
Tomasz
