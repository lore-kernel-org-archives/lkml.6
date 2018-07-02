Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8655DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3569A25B8A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NC8GZpoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3569A25B8A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965010AbeGBIqU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:46:20 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53009 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964970AbeGBIqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:46:11 -0400
Received: by mail-it0-f67.google.com with SMTP id p4-v6so11058787itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9HvIGZ8S5aIWQEVtm+htARymx1kzieSPEaosxbiN/9M=;
        b=NC8GZpoVJZbGT2W64eD+MIX95h9b8y4VxqitGX6gYTpgvpPzdNdA64NPOl1lUoiPeH
         /AqPONG02N6Ci7f7ApKypMvcF0V/hvbe/cbnPFRTevWkJCpCLRshK6mSEvAvpKvVY6rR
         V9FQ1jC/YJRPbkqToUXk3liOkLDjZpXQhZk68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HvIGZ8S5aIWQEVtm+htARymx1kzieSPEaosxbiN/9M=;
        b=Od9lFT7A+9g9AQ+MgfCp10qHq0sc4RX3dlUEKqoYC/ZCLFxycOK+8q4xzkCQVwzq31
         n2J+vOnnVGV/JLkpsb0eh+3Mq78L0RQfsU3k3OnH1d3IJkqde1A6YqQbZw9FXSIYssUG
         YjUXvcG8l41+hPfpWggxLVYdCv/adPb/5PBiXz3X+vqt7EmDuppXmhM37MaRdNPyoPCc
         s4OoZDI7RwEzmAOENstfftO8gDwGMCXvu+Iq3hCZZYvFQR7MlRTSnj2RcXp8XDcOiBrD
         vDJ7HPCUq1k3AFxF2ArxY3Ea87E38tyA8Wozwcq6vundbpcXXutgKhSZynaC5e5d1V0v
         lxXQ==
X-Gm-Message-State: APt69E0VkK7HkjgggWqYdOfyI+/btTtQUKCWLf/DpIZ8UgdbmOOTotuK
        G2P/Nkpv+kBqfn9AJXyhpubNVHmQ9X0=
X-Google-Smtp-Source: AAOMgpcmLfao7cSiZQ9y1oeSUtVqJ0+HqEznbbBP0zUKsxTtztPJRlWh5RDGokHZOuc5ZukKC/hQPA==
X-Received: by 2002:a24:5a53:: with SMTP id v80-v6mr5299475ita.34.1530521170366;
        Mon, 02 Jul 2018 01:46:10 -0700 (PDT)
Received: from mail-it0-f45.google.com (mail-it0-f45.google.com. [209.85.214.45])
        by smtp.gmail.com with ESMTPSA id h62-v6sm6877536ioa.22.2018.07.02.01.46.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 01:46:10 -0700 (PDT)
Received: by mail-it0-f45.google.com with SMTP id 16-v6so11028640itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:46:09 -0700 (PDT)
X-Received: by 2002:a24:d41:: with SMTP id 62-v6mr3168116itx.14.1530521169289;
 Mon, 02 Jul 2018 01:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org> <20180627152725.9783-16-stanimir.varbanov@linaro.org>
In-Reply-To: <20180627152725.9783-16-stanimir.varbanov@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 2 Jul 2018 17:45:58 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVitXuqka=OjjMCcJ0QQQFtehdz=B-TKHDBORabuVGitw@mail.gmail.com>
Message-ID: <CAPBb6MVitXuqka=OjjMCcJ0QQQFtehdz=B-TKHDBORabuVGitw@mail.gmail.com>
Subject: Re: [PATCH v4 15/27] venus: helpers: add helper function to set
 actual buffer size
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:30 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Add and use a helper function to set actual buffer size for
> particular buffer type. This is also preparation to use
> the second decoder output.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 12 ++++++++++++
>  drivers/media/platform/qcom/venus/helpers.h |  1 +
>  drivers/media/platform/qcom/venus/vdec.c    | 10 ++--------
>  3 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index e3dc2772946f..0cce664f093d 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -541,6 +541,18 @@ int venus_helper_set_dyn_bufmode(struct venus_inst *inst)
>  }
>  EXPORT_SYMBOL_GPL(venus_helper_set_dyn_bufmode);
>
> +int venus_helper_set_bufsize(struct venus_inst *inst, u32 bufsize, u32 buftype)
> +{
> +       u32 ptype = HFI_PROPERTY_PARAM_BUFFER_SIZE_ACTUAL;

const u32? Also valid for similar declarations in later patches.

> +       struct hfi_buffer_size_actual bufsz;
> +
> +       bufsz.type = buftype;
> +       bufsz.size = bufsize;
> +
> +       return hfi_session_set_property(inst, ptype, &bufsz);
> +}
> +EXPORT_SYMBOL_GPL(venus_helper_set_bufsize);
> +
>  static void delayed_process_buf_func(struct work_struct *work)
>  {
>         struct venus_buffer *buf, *n;
> diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
> index 52b961ed491e..cd306bd8978f 100644
> --- a/drivers/media/platform/qcom/venus/helpers.h
> +++ b/drivers/media/platform/qcom/venus/helpers.h
> @@ -41,6 +41,7 @@ int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
>                               unsigned int output_bufs);
>  int venus_helper_set_color_format(struct venus_inst *inst, u32 fmt);
>  int venus_helper_set_dyn_bufmode(struct venus_inst *inst);
> +int venus_helper_set_bufsize(struct venus_inst *inst, u32 bufsize, u32 buftype);
>  void venus_helper_acquire_buf_ref(struct vb2_v4l2_buffer *vbuf);
>  void venus_helper_release_buf_ref(struct venus_inst *inst, unsigned int idx);
>  void venus_helper_init_instance(struct venus_inst *inst);
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 92669a358a90..eae9c651ac91 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -710,7 +710,6 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
>  {
>         struct venus_inst *inst = vb2_get_drv_priv(q);
>         struct venus_core *core = inst->core;
> -       u32 ptype;
>         int ret;
>
>         mutex_lock(&inst->lock);
> @@ -740,13 +739,8 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
>                 goto deinit_sess;
>
>         if (core->res->hfi_version == HFI_VERSION_3XX) {
> -               struct hfi_buffer_size_actual buf_sz;
> -
> -               ptype = HFI_PROPERTY_PARAM_BUFFER_SIZE_ACTUAL;
> -               buf_sz.type = HFI_BUFFER_OUTPUT;
> -               buf_sz.size = inst->output_buf_size;
> -
> -               ret = hfi_session_set_property(inst, ptype, &buf_sz);
> +               ret = venus_helper_set_bufsize(inst, inst->output_buf_size,
> +                                              HFI_BUFFER_OUTPUT);
>                 if (ret)
>                         goto deinit_sess;
>         }
> --
> 2.14.1
>
